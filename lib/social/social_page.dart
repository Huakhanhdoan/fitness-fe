import 'package:fitness/social/upload_post.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'dart:io';
import 'image_post.dart';

class Social extends StatefulWidget {
  // final Map<String, dynamic> newPost;
  // const Social({super.key, required this.newPost});
  const Social({super.key});
  @override
  _SocialState createState() => _SocialState();
}

class _SocialState extends State<Social> {
  List<ImagePost> feedData = [];

  @override
  void initState() {
    super.initState();
    _loadFeed();
    _getFeed();
  }

  Future<void> _loadFeed() async {
    await _getFeed();
  }

  Future<void> _getFeed() async {
    try {
      final response = await http.get(Uri.parse('https://fitness-be.onrender.com/post'));
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<ImagePost> listOfPosts = _generateFeed(data.cast<Map<String, dynamic>>());
        setState(() {
          feedData = listOfPosts;
        });
      } else {
        throw Exception('Failed to load feed');
      }
    } catch (e) {
      print('Error loading feed: $e');
    }
  }

  List<ImagePost> _generateFeed(List<Map<String, dynamic>> feedData) {
    List<ImagePost> listOfPosts = [];

    // Add new post to the beginning of the list
    // if (widget.newPost.isNotEmpty) {
    //   listOfPosts.add(ImagePost.fromJSON(widget.newPost));
    // }

    // Add existing posts
    for (var postData in feedData) {
      listOfPosts.add(ImagePost.fromJSON(postData));
    }

    return listOfPosts.reversed.toList();
  }

  Future<void> _refresh() async {
    await _getFeed();
    setState(() {});
  }

  File? file;

  Future<File?> _selectImage(BuildContext parentContext) async {
    File? selectedFile;
    await showDialog<Null>(
      context: parentContext,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Tạo bài đăng'),
          children: <Widget>[
            SimpleDialogOption(
              child: const Text('Chụp ảnh'),
              onPressed: () async {
                final pickedFile = await ImagePicker().pickImage(
                  source: ImageSource.camera,
                  maxWidth: 1920,
                  maxHeight: 1200,
                  imageQuality: 80,
                );
                if (pickedFile != null) {
                  setState(() {
                    selectedFile = File(pickedFile.path);
                  });
                }
                Navigator.pop(context);
              },
            ),
            SimpleDialogOption(
              child: const Text('Thư viện ảnh'),
              onPressed: () async {
                final pickedFile = await ImagePicker().pickImage(
                  source: ImageSource.gallery,
                  maxWidth: 1920,
                  maxHeight: 1200,
                  imageQuality: 80,
                );
                if (pickedFile != null) {
                  setState(() {
                    selectedFile = File(pickedFile.path);
                  });
                }
                Navigator.pop(context); // Close the dialog after picking image
              },
            ),
            SimpleDialogOption(
              child: const Text("Hủy"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );

    return selectedFile;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Social Feed', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ),
      body: Stack(
        children: [
          RefreshIndicator(
          onRefresh: _refresh,
          child: feedData.isNotEmpty
              ? ListView.builder(
            itemCount: feedData.length,
            itemBuilder: (context, index) {
              return feedData[index];
            },
          )
              : const Center(
            child: CircularProgressIndicator(),
          ),
        ),
          Positioned(
              bottom: 100,
              right: 20,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(48, 237, 102,1),
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 2),
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                child: IconButton(
                  onPressed: () async {
                    File? selectedFile = await _selectImage(context);
                    if (selectedFile != null) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Uploader(file: selectedFile),
                        ),
                      );
                    }
                  },
                  icon: const Icon(
                    Icons.add,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
              ),
          ),
        ],
      ),
    );
  }
}
