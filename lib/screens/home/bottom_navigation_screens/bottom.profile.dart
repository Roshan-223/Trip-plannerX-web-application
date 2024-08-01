import 'dart:convert';
import 'dart:html' as html;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trip_plannerx/db/database_file/profile_db_function.dart';
import 'package:trip_plannerx/screens/profile_screens/about.dart';
import 'package:trip_plannerx/screens/profile_screens/blogs.dart';
import 'package:trip_plannerx/screens/profile_screens/images.dart';
import 'package:trip_plannerx/screens/profile_screens/privacy_page.dart';
import 'package:trip_plannerx/screens/profile_screens/terms_page.dart';
import 'package:trip_plannerx/widgets/alertboxprofile_edit_username.dart';
import 'package:trip_plannerx/widgets/alertboxprofile_login.dart';

class BottomProfile extends StatefulWidget {
  const BottomProfile({super.key});

  @override
  State<BottomProfile> createState() => _BottomProfileState();
}

class _BottomProfileState extends State<BottomProfile> {
  final List<IconData> items = [
    Icons.image_outlined,
    Icons.movie_edit,
    Icons.info_outline,
    Icons.lock_outline,
    Icons.description,
    Icons.logout
  ];

  final List<String> text = ['Images', 'Blogs', 'About', 'Privacy', 'Terms', 'LogOut'];

  final List<Widget> screens = [
    const ImagesPage(tripId: -1, showDeleteOption: false),
    const BlogsPage(tripId: -1,),
    const AboutPage(),
    const Privacy(),
    const Terms(),
    const SizedBox(),
  ];

  final TextEditingController _nameController = TextEditingController();
  final profileService = ProfileService();
  String user = 'User';
  Uint8List? _selectedImage;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  void _loadProfile() {
    final profile = profileService.getProfile(); // Load the profile from Hive
    if (profile != null) {
      setState(() {
        user = profile.userName;
        final imageKey = profile.profilePicturepath ?? 'profile_image';
        final imageData = html.window.localStorage[imageKey];
        if (imageData != null) {
          _selectedImage = base64.decode(imageData);
        
        } 
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: ListTile(
              leading: GestureDetector(
                onTap: _pickImageFromGallery,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: _selectedImage != null
                      ? MemoryImage(_selectedImage!)
                      : null,
                  child: _selectedImage == null
                      ? const Icon(
                          Icons.person,
                          size: 50,
                        )
                      : null,
                ),
              ),
              title: Text(user),
              trailing: IconButton(
                  onPressed: () {
                    editUserName();
                  },
                  icon: const Icon(Icons.edit)),
            ),
          ),
          const Divider(
            height: 60,
            indent: 25,
            endIndent: 25,
            color: Colors.black,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: text.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(
                    items[index],
                    color: Colors.black,
                    size: 35,
                  ),
                  title: Text(
                    text[index],
                    style: const TextStyle(color: Colors.black),
                  ),
                  onTap: index == 5
                      ? () => showLogoutDialogue()
                      : () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => screens[index],
                            ),
                          ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'App Version 1.0.0',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Future<void> _pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _selectedImage = bytes;
        final base64String = base64.encode(bytes);
        const imageKey = 'profile_image';
        html.window.localStorage[imageKey] = base64String; // Save to localStorage with a constant key
        profileService.saveProfile(user, imageKey); // Save the key to Hive
       
      });
    }
  }

  void editUserName() {
    AlertProfile(
      context: context,
      nameController: _nameController,
      onNameChanged: (newName) {
        setState(() {
          user = newName;
        });
        const imageKey = 'profile_image';
        profileService.saveProfile(newName, imageKey); // Save the key to Hive
        
      },
    ).showEditNameDialog();
  }

  Future<void> userdata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("loggedIn", false);
  }

  void logout() async {
    userdata();
  }

  void showLogoutDialogue() {
    Logout(context: context).showLogoutConfirmation(() => userdata());
  }
}
