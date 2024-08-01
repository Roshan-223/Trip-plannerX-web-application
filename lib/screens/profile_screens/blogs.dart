import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:trip_plannerx/db/database_file/blog_db_functions.dart';
import 'package:trip_plannerx/model/images_blogs_db.dart';

class BlogsPage extends StatefulWidget {
  final int tripId;

  const BlogsPage({Key? key, required this.tripId}) : super(key: key);

  @override
  State<BlogsPage> createState() => _BlogsPageState();
}

class _BlogsPageState extends State<BlogsPage> {
  late Box<ImageBlog>? blogBox;
  List<String> blogs = [];

  @override
  void initState() {
    super.initState();
    initDbAndLoadBlogs();
  }

  Future<void> initDbAndLoadBlogs() async {
    await BlogDbService.init();
    setState(() {
      if (widget.tripId == -1) {
        blogs = BlogDbService.getAllBlogsFromAllTrips();
      } else {
        blogs = BlogDbService.getBlogs(widget.tripId.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blogs'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: blogs.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(blogs[index]),
              onLongPress: () {
                if (widget.tripId != -1) {
                  _showBlogOptionsDialog(index);
                }
              },
            );
          },
        ),
      ),
      floatingActionButton: widget.tripId == -1
          ? null
          : FloatingActionButton(
              onPressed: _addBlog,
              child: const Icon(Icons.add),
            ),
    );
  }

  Future<void> _addBlog() async {
    final TextEditingController blogController = TextEditingController();
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Add Blog"),
          content: TextField(
            controller: blogController,
            decoration: const InputDecoration(hintText: 'Enter your blog here'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                final String blogText = blogController.text.trim();
                if (blogText.isNotEmpty) {
                  await BlogDbService.addBlog(blogText, widget.tripId.toString());
                  setState(() {
                    blogs = BlogDbService.getBlogs(widget.tripId.toString());
                  });
                }
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _showBlogOptionsDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Blog Options'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Edit Blog'),
                onTap: () {
                  Navigator.pop(context);
                  _editBlog(index);
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text('Delete Blog'),
                onTap: () {
                  Navigator.pop(context);
                  _deleteBlog(index);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _editBlog(int index) async {
    final TextEditingController blogController =
        TextEditingController(text: blogs[index]);
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Edit Blog"),
          content: TextField(
            controller: blogController,
            decoration:
                const InputDecoration(hintText: 'Enter your edited blog here'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                final String editedBlog = blogController.text.trim();
                if (editedBlog.isNotEmpty) {
                  await BlogDbService.editBlog(index, editedBlog, widget.tripId.toString());
                  setState(() {
                    blogs = BlogDbService.getBlogs(widget.tripId.toString());
                  });
                }
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _deleteBlog(int index) async {
    await BlogDbService.deleteBlog(index, widget.tripId.toString());
    setState(() {
      blogs = BlogDbService.getBlogs(widget.tripId.toString());
    });
  }
}
