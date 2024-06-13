import 'dart:convert';
import 'package:fitness/social/social_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class Uploader extends StatefulWidget {
  final File file;
  final String? avatarUrl;
  const Uploader({super.key, required this.file, this.avatarUrl});

  @override
  _UploaderState createState() => _UploaderState();
}

class _UploaderState extends State<Uploader> {
  File? file;
  TextEditingController descriptionController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  bool uploading = false;

  @override
  void initState() {
    super.initState();
    file = widget.file;
  }

  void clearImage() {
    setState(() {
      file = null;
    });
    Navigator.pop(context);
  }

  Future<String?> getCurrentUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('id');
    return userId;
  }

  void postImage() async {
    setState(() {
      uploading = true;
    });

    try {
      var userId = await getCurrentUserId();
      if (userId == null) {
        throw Exception('User id not found');
      }

      var url = Uri.parse('https://fitness-be.onrender.com/post');
      var response = await http.post(
        url,
        body: {
          'user_id': userId,
          'description': descriptionController.text,
          'mediaUrl': file!.path,
        },
      );

      if (response.statusCode == 201) { // Check for 201 Created status
        var responseData = jsonDecode(response.body);
        print('Post successful: $responseData');

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Social()),
        );
      } else {
        print('Failed to post: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error posting: $e');
    } finally {
      setState(() {
        uploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white70,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: clearImage,
        ),
        title: const Text(
          'Bài đăng mới',
          style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: postImage,
            child: const Text(
              'Đăng',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          PostForm(
            imageFile: file!,
            descriptionController: descriptionController,
            locationController: locationController,
            loading: uploading,
            avatarUrl: widget.avatarUrl,
          ),
          const Divider(),
        ],
      ),
    );
  }
}

class PostForm extends StatelessWidget {
  final File imageFile;
  final TextEditingController descriptionController;
  final TextEditingController locationController;
  final bool loading;
  final String? avatarUrl;

  const PostForm({
    super.key,
    required this.imageFile,
    required this.descriptionController,
    required this.loading,
    required this.locationController,
    required this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        loading
            ? const LinearProgressIndicator()
            : const Padding(padding: EdgeInsets.only(top: 0.0)),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            CircleAvatar(
              backgroundImage: NetworkImage(avatarUrl ?? ''),
            ),
            SizedBox(
              width: 250.0,
              child: TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                    hintText: "Viết trạng thái...", border: InputBorder.none),
              ),
            ),
            SizedBox(
              height: 45.0,
              width: 45.0,
              child: AspectRatio(
                aspectRatio: 487 / 451,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      alignment: FractionalOffset.topCenter,
                      image: FileImage(imageFile),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.pin_drop),
          title: SizedBox(
            width: 250.0,
            child: TextField(
              controller: locationController,
              decoration: const InputDecoration(
                  hintText: "Vị trí của bạn...",
                  border: InputBorder.none),
            ),
          ),
        )
      ],
    );
  }
}
