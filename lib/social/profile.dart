import 'package:fitness/social/profile_post.dart';
import 'package:fitness/social/upload_post.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ProfilePage extends StatefulWidget {
  final String postId;
  final String description;
  final String userId;
  final String location;

  const ProfilePage({super.key, required this.userId, required this.postId, required this.description, required this.location});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with AutomaticKeepAliveClientMixin<ProfilePage> {
  String view = "grid";
  bool isFollowing = false;
  int postCount = 0;
  int followerCount = 0;
  int followingCount = 0;
  String avatarUrl = '';
  String name = '';
  List<Map<String, dynamic>> userPosts = [];

  @override
  void initState() {
    super.initState();
    fetchUserData();
    fetchUserPosts();
  }

  Future<void> fetchUserData() async {
    try {
      final response = await http.get(Uri.parse('https://fitness-be.onrender.com/user/${widget.userId}'));
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        setState(() {
          avatarUrl = data['user']['avatarUrl'] ?? '';
          name = data['user']['name'] ?? '';
        });
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (e) {
      print('Error loading user data: $e');
    }
  }

  Future<void> fetchUserPosts() async {
    try {
      final response = await http.get(Uri.parse('https://fitness-be.onrender.com/post/user/${widget.userId}'));
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        setState(() {
          userPosts = data.map((post) {
            String mediaUrl = post['mediaUrl'];
            String type = mediaUrl.startsWith('http') ? 'network' : 'local';
            return {
              "mediaUrl": mediaUrl,
              "type": type,
            };
          }).toList();
          postCount = userPosts.length;
        });
      } else {
        throw Exception('Failed to load user posts');
      }
    } catch (e) {
      print('Error loading user posts: $e');
    }
  }

  Column buildStatColumn(String label, int number) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          number.toString(),
          style: const TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
        ),
        Container(
          margin: const EdgeInsets.only(top: 4.0),
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 15.0,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildProfileHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            radius: 50.0,
            backgroundImage: NetworkImage(avatarUrl),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    buildStatColumn("Bài viết", postCount),
                    buildStatColumn("Người theo dõi", followerCount),
                    buildStatColumn("Đang theo dõi", followingCount),
                  ],
                ),
                const SizedBox(height: 16.0),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (isFollowing) {
                            followerCount--;
                          } else {
                            followerCount++;
                          }
                          isFollowing = !isFollowing;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                        isFollowing ? Colors.grey[400] : Colors.blue,
                      ),
                      child: Text(
                        isFollowing ? "Đang theo dõi" : "Theo dõi",
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row buildImageViewButtonBar() {
    Color isActiveButtonColor(String viewName) {
      return view == viewName ? Colors.blueAccent : Colors.black26;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.grid_on),
          color: isActiveButtonColor("grid"),
          onPressed: () {
            setState(() {
              view = "grid";
            });
          },
        ),
        IconButton(
          icon: const Icon(Icons.format_list_bulleted),
          color: isActiveButtonColor("feed"),
          onPressed: () {
            setState(() {
              view = "feed";
            });
          },
        ),
      ],
    );
  }

  Widget buildUserPosts() {
    List<Widget> postWidgets = userPosts.map((post) {
      print('Post ID: ${widget.postId}');
      if (post['type'] == 'local') {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Post(
                  localFile: File(post['mediaUrl']),
                  mediaUrl: post['mediaUrl'],
                  username: name,
                  location: widget.location,
                  description: widget.description,
                  likes: {},
                  postId: widget.postId,
                  ownerId: widget.userId,
                  avatarUrl: avatarUrl,
                ),
              ),
            );
          },
          child: Image.file(
            File(post['mediaUrl']),
            fit: BoxFit.cover,
          ),
        );
      } else {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Post(
                  mediaUrl: post['mediaUrl'],
                  username: name,
                  location: widget.location,
                  description: widget.description,
                  likes: {},
                  postId: widget.postId,
                  ownerId: widget.userId,
                  avatarUrl: avatarUrl,
                ),
              ),
            );
          },
          child: Image.network(
            post['mediaUrl'],
            fit: BoxFit.cover,
          ),
        );
      }
    }).toList();

    return view == "grid"
        ? GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: postWidgets,
    )
        : Column(
      children: postWidgets,
    );
  }

  File? file;
  // final ImagePicker _picker = ImagePicker();

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
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          name,
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () async {
              File? selectedFile = await _selectImage(context);
              if (selectedFile != null) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Uploader(file: selectedFile, avatarUrl: avatarUrl,),
                  ),
                );
              }
            },
            icon: const Icon(
              Icons.add,
              size: 25,
            ),
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          buildProfileHeader(),
          const Divider(),
          buildImageViewButtonBar(),
          const Divider(),
          buildUserPosts(),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
