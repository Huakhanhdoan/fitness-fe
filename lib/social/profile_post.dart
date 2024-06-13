import 'dart:async';
import 'dart:io';
import 'package:fitness/social/profile_comment.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';


class Post extends StatefulWidget {
  final String mediaUrl;
  final String username;
  final String location;
  final String description;
  final Map<dynamic, dynamic> likes;
  final String postId;
  final String ownerId;
  final String avatarUrl;
  final File? localFile;

  const Post({
    Key? key,
    required this.mediaUrl,
    required this.username,
    required this.location,
    required this.description,
    required this.likes,
    required this.postId,
    required this.ownerId,
    required this.avatarUrl,
    this.localFile,
  }) : super(key: key);

  factory Post.fromJSON(Map<String, dynamic> data) {
    return Post(
      username: data['username'] ?? '',
      location: data['location'] ?? '',
      mediaUrl: data['mediaUrl'] ?? '',
      likes: data['likes'] ?? {},
      description: data['description'] ?? '',
      ownerId: data['ownerId'] ?? '',
      postId: data['postId'] ?? '',
      avatarUrl: data['avatarUrl'] ?? '',
    );
  }

  int getLikeCount(Map<dynamic, dynamic> likes) {
    if (likes == null) {
      return 0;
    }
    return likes.values.where((value) => value == true).length;
  }

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          buildLikeableImage(),
          buildLikeAndCommentIcons(),
          buildLikeCount(),
          buildPostDescription(),
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
          if (widget.localFile != null)
            Image.file(
              widget.localFile!,
              fit: BoxFit.fitWidth,
            )
          else
            CachedNetworkImage(
              imageUrl: widget.mediaUrl,
              fit: BoxFit.fitWidth,
              placeholder: (context, url) => loadingPlaceHolder,
              errorWidget: (context, url, error) => const Icon(Icons.error),
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
                builder: (context) => ProfileCommentScreen(
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
    IconData icon =
    liked ? Icons.favorite_outlined : Icons.favorite_border_outlined;

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
}

