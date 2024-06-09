import 'package:fitness/social/social_page.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'data/post_data.dart';
import 'dart:io';
import 'package:uuid/uuid.dart';

class Uploader extends StatefulWidget {
  const Uploader({Key? key}) : super(key: key);

  @override
  _UploaderState createState() => _UploaderState();
}

class _UploaderState extends State<Uploader> {
  File? file;
  TextEditingController descriptionController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  bool uploading = false;

  Future<void> _selectImage(BuildContext parentContext) async {
    return showDialog<Null>(
      context: parentContext,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Create a Post'),
          children: <Widget>[
            SimpleDialogOption(
              child: const Text('Take a photo'),
              onPressed: () async {
                Navigator.pop(context);
                final pickedFile = await _picker.pickImage(
                  source: ImageSource.camera,
                  maxWidth: 1920,
                  maxHeight: 1200,
                  imageQuality: 80,
                );
                if (pickedFile != null) {
                  setState(() {
                    file = File(pickedFile.path);
                  });
                }
              },
            ),
            SimpleDialogOption(
              child: const Text('Choose from Gallery'),
              onPressed: () async {
                Navigator.of(context).pop();
                final pickedFile = await _picker.pickImage(
                  source: ImageSource.gallery,
                  maxWidth: 1920,
                  maxHeight: 1200,
                  imageQuality: 80,
                );
                if (pickedFile != null) {
                  setState(() {
                    file = File(pickedFile.path);
                  });
                }
              },
            ),
            SimpleDialogOption(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void clearImage() {
    setState(() {
      file = null;
    });
  }

  void postImage() {
    setState(() {
      uploading = true;
    });

    // Generate a unique ID for the new post
    String postId = const Uuid().v1();

    // Create a new user
    UserModel currentUserModel = UserModel(
      id: '1',
      username: 'Doan',
    );

    // Create a new post object
    var newPost = {
      "postId": postId,
      "ownerId": currentUserModel.id,
      "username": currentUserModel.username,
      "mediaUrl": file!.path, // cannot use local url!!!
      "description": descriptionController.text,
      "location": locationController.text,
      "timestamp": DateTime.now(),
      "likes": {},
      // "avatarUrl": currentUserModel.photoUrl,
    };

    // Add the new post to the beginning of fakeFeedData
    setState(() {
      fakeFeedData.insert(0, newPost); // Add newPost at the beginning of the list
      file = null;
      uploading = false;
    });

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Social(newPost: newPost)),
    );
  }


  @override
  Widget build(BuildContext context) {
    return file == null
        ? IconButton(
      icon: const Icon(Icons.file_upload, color: Colors.white),
      onPressed: () => _selectImage(context),
    )
        : Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white70,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: clearImage,
        ),
        title: const Text(
          'New Post',
          style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: postImage,
            child: const Text(
              'Post',
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
          ),
          const Divider(),
        ],
      ),
    );
  }
}

class UserModel {
  final String id;
  final String username;
  // final String photoUrl;

  UserModel({
    required this.id,
    required this.username,
    // required this.photoUrl,
  });
}

class PostForm extends StatelessWidget {
  final File imageFile;
  final TextEditingController descriptionController;
  final TextEditingController locationController;
  final bool loading;

  const PostForm({
    Key? key,
    required this.imageFile,
    required this.descriptionController,
    required this.loading,
    required this.locationController,
  }) : super(key: key);

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
            const CircleAvatar(
              backgroundImage: NetworkImage('https://www.pngall.com/wp-content/uploads/5/Profile-Avatar-PNG.png'),
            ),
            SizedBox(
              width: 250.0,
              child: TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                    hintText: "Write a caption...", border: InputBorder.none),
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
                  hintText: "Where was this photo taken?",
                  border: InputBorder.none),
            ),
          ),
        )
      ],
    );
  }
}
