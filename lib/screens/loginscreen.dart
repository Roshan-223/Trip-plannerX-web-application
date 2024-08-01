import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trip_plannerx/db/db_function.dart';
import 'package:trip_plannerx/screens/nav_page.dart';
import 'package:trip_plannerx/screens/signup_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> { 
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> checkLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool isLoggedIn = prefs.getBool('loggedIn') ?? false;
    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const NavPage()),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    checkLoggedIn();
  }

  Future<bool> isLoggedIn(String username, String password) async {
    return await DatabaseHelper.isLoggedIn(username, password);
  }
  Future<void> saveUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("loggedIn", true);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image/img.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Color.fromARGB(115, 37, 22, 22), BlendMode.darken),
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(top: 60, left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Let's go,",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Travelling around the world",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Form(
                        key: _formkey,
                        child: ConstrainedBox(
                            constraints: const BoxConstraints(
                                maxWidth: 300, // Set the maximum width here
                              ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextFormField(
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                controller: _usernameController,
                                decoration: InputDecoration(
                                  hintText: 'UserName',
                                  filled: true,
                                  fillColor:
                                      const Color.fromARGB(255, 228, 223, 223),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your username';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                controller: _passwordController,
                                decoration: InputDecoration(
                                  hintText: 'Password',
                                  filled: true,
                                  fillColor:
                                      const Color.fromARGB(255, 228, 223, 223),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                obscureText: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your Password';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  if (_formkey.currentState!.validate()) {
                                    final String username =
                                        _usernameController.text;
                                    final String password =
                                        _passwordController.text;
                                    if (await isLoggedIn(username, password)) {
                                      await saveUserData();
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const NavPage()));
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                  'Invalid username and password')));
                                    }
                                  }
                                },
                                style: ButtonStyle(
                                    backgroundColor:
                                        const MaterialStatePropertyAll(
                                      Color.fromARGB(255, 228, 223, 223),
                                    ),
                                    foregroundColor:
                                        const MaterialStatePropertyAll(
                                      Color.fromARGB(255, 102, 98, 98),
                                    ),
                                    fixedSize: const MaterialStatePropertyAll(
                                      Size(140, 40),
                                    ),
                                    shape: MaterialStatePropertyAll(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)))),
                                child: const Text('Login'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Dont have an account?',
                  style: TextStyle(color: Colors.white),
                ),
                TextButton(
                  onPressed: () async {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const CreateAccount()));
                  },
                  child: const Text(
                    'Create Account',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
