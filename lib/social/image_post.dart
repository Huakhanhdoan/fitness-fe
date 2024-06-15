import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import '../components/menu.dart';
import 'comment.dart';
import 'profile.dart';

class ImagePost extends StatefulWidget {
  final String mediaUrl;
  final String username;
  final String location;
  final String description;
  final Map<dynamic, dynamic> likes;
  final String postId;
  final String ownerId;
  final String avatarUrl;

  const ImagePost({
    super.key,
    required this.mediaUrl,
    required this.username,
    required this.location,
    required this.description,
    required this.likes,
    required this.postId,
    required this.ownerId,
    required this.avatarUrl,
  });

  factory ImagePost.fromJSON(Map<String, dynamic> data) {
    String mediaUrl = data['mediaUrl'] ?? '';
    if (!mediaUrl.startsWith('http')) {
      mediaUrl = 'file://$mediaUrl';
    }

    return ImagePost(
      username: data['user_id']['name'] ?? '',
      location: data['user_id']['location'] ?? '',
      mediaUrl: mediaUrl,
      likes: data['likes'] ?? {},
      description: data['description'] ?? '',
      ownerId: data['user_id']['_id'] ?? '',
      postId: data['_id'] ?? '',
      avatarUrl: data['user_id']['avatarUrl'] ?? '',
    );
  }


  int getLikeCount(Map<dynamic, dynamic> likes) {
    if (likes == null) {
      return 0;
    }
    return likes.values.where((value) => value == true).length;
  }

  @override
  _ImagePostState createState() => _ImagePostState();
}

class _ImagePostState extends State<ImagePost> {
  int likeCount = 0;
  bool liked = false;
  bool showHeart = false;

  @override
  void initState() {
    super.initState();
    likeCount = widget.getLikeCount(widget.likes);
    liked = widget.likes['user1'] == true; // Assuming user1 is logged in
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          buildPostHeader(),
          buildLikeableImage(),
          buildLikeAndCommentIcons(),
          buildLikeCount(),
          buildPostDescription(),
        ],
      ),
    );
  }

  Future<void> deletePost() async {
    final url = Uri.parse('https://fitness-be.onrender.com/post/${widget.postId}');

    try {
      final response = await http.delete(url);

      if (response.statusCode == 200) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Menu(index: 2)));
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Post deleted successfully'))
        );
      } else {
        throw Exception('Failed to delete post');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error deleting post: $e'))
      );
    }
  }

  Widget buildPostHeader() {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(widget.avatarUrl),
        backgroundColor: Colors.grey,
      ),
      title: GestureDetector(
        child: Text(
          widget.username,
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        onTap: () {
          openProfile(context);
        },
      ),
      subtitle: Text(widget.location),
      trailing: PopupMenuButton<String>(
        onSelected: (String result) {
          if (result == 'delete') {
            deletePost();
          }
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          const PopupMenuItem<String>(
            value: 'delete',
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }

  Widget buildLikeableImage() {
    return GestureDetector(
      onDoubleTap: () => _likePost(widget.postId),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          if (widget.mediaUrl.startsWith('http'))
            CachedNetworkImage(
              imageUrl: widget.mediaUrl,
              fit: BoxFit.fitWidth,
              placeholder: (context, url) => loadingPlaceHolder,
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          if (widget.mediaUrl.startsWith('file'))
            Image.file(
              File(widget.mediaUrl.replaceAll('file://', '')),
              fit: BoxFit.fitWidth,
            ),
          if (showHeart)
            Positioned(
              child: Container(
                width: 100,
                height: 100,
                child: const Opacity(
                  opacity: 0.85,
                  child: Icon(
                    Icons.favorite,
                    size: 100,
                    color: Colors.pink,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget buildLikeAndCommentIcons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        const Padding(padding: EdgeInsets.only(left: 20.0, top: 40.0)),
        buildLikeIcon(),
        const Padding(padding: EdgeInsets.only(right: 20.0)),
        GestureDetector(
          child: const Icon(
            Icons.chat_bubble_outline_rounded,
            size: 25.0,
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CommentScreen(
                  postId: widget.postId,
                  postOwner: widget.ownerId,
                  postMediaUrl: widget.mediaUrl,
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  GestureDetector buildLikeIcon() {
    Color color = liked ? Colors.pink : Colors.black;
    IconData icon = liked ? Icons.favorite_outlined : Icons.favorite_border_outlined;

    return GestureDetector(
      child: Icon(
        icon,
        size: 25.0,
        color: color,
      ),
      onTap: () {
        _likePost(widget.postId);
      },
    );
  }

  Widget buildLikeCount() {
    return Row(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(left: 20.0),
          child: Text(
            "$likeCount likes",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget buildPostDescription() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(left: 20.0),
          child: Text(
            "${widget.username} ",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(child: Text(widget.description)),
      ],
    );
  }

  void openProfile(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfilePage(
          userId: widget.ownerId,
          postId: widget.postId,
          description: widget.description,
          location: widget.location,
        )
      ),
    );
  }

  void _likePost(String postId) {
    bool _liked = widget.likes['user1'] == true; // Assuming user1 is logged in

    setState(() {
      if (_liked) {
        likeCount--;
        liked = false;
        widget.likes['user1'] = false;
      } else {
        likeCount++;
        liked = true;
        widget.likes['user1'] = true;
        showHeart = true;
        Timer(const Duration(milliseconds: 2000), () {
          setState(() {
            showHeart = false;
          });
        });
      }
    });
  }

  Container loadingPlaceHolder = Container(
    height: 400.0,
    child: const Center(child: CircularProgressIndicator()),
  );

  // Function to fetch posts from API
  Future<List<ImagePost>> fetchPosts() async {
    final response = await http.get(Uri.parse('https://fitness-be.onrender.com/post'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => ImagePost.fromJSON(item)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }
}
