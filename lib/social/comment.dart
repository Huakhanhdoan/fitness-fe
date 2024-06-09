import 'package:flutter/material.dart';

import 'data/post_data.dart';

class CommentScreen extends StatefulWidget {
  final String postId;
  final String postOwner;
  final String postMediaUrl;

  const CommentScreen({Key? key, required this.postId, required this.postOwner, required this.postMediaUrl});

  @override
  _CommentScreenState createState() => _CommentScreenState(
    postId: this.postId,
    postOwner: this.postOwner,
    postMediaUrl: this.postMediaUrl,
  );
}

class _CommentScreenState extends State<CommentScreen> {
  final String postId;
  final String postOwner;
  final String postMediaUrl;
  final TextEditingController _commentController = TextEditingController();
  List<Map<String, dynamic>> _fetchedComments = [];

  _CommentScreenState({
    required this.postId,
    required this.postOwner,
    required this.postMediaUrl,
  });

  @override
  void initState() {
    super.initState();
    getComments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Comments",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: buildPage(),
    );
  }

  Widget buildPage() {
    return Column(
      children: [
        Expanded(
          child: buildComments(),
        ),
        Divider(),
        ListTile(
          title: TextFormField(
            controller: _commentController,
            decoration: InputDecoration(labelText: 'Write a comment...'),
            onFieldSubmitted: addComment,
          ),
          trailing: OutlinedButton(
            onPressed: () {
              addComment(_commentController.text);
            },
            child: Text("Post"),
          ),
        ),
      ],
    );
  }

  Widget buildComments() {
    return ListView.builder(
      itemCount: _fetchedComments.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(_fetchedComments[index]['username']),
          subtitle: Text(_fetchedComments[index]['comment']),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(_fetchedComments[index]['avatar']),
          ),
        );
      },
    );
  }

  void addComment(String comment) {
    _commentController.clear();
    CurrentUserModel? currentUserModel = getCurrentUserModel('Doan');
    if (currentUserModel != null) {
      setState(() {
        _fetchedComments.add({
          "username": currentUserModel.username,
          "comment": comment,
          "avatar": currentUserModel.photoUrl,
        });
      });
    }
  }

  void getComments() {
    List<Map<String, dynamic>>? comments = fakeFeedData
        .firstWhere((post) => post['postId'] == widget.postId)['comments'];
    if (comments != null) {
      setState(() {
        _fetchedComments = List.from(comments);
      });
    }
  }

  CurrentUserModel? getCurrentUserModel(String currentUserId) {
    Map<String, dynamic>? currentUserData =
      fakeFeedData.firstWhere((user) => user['username'] == currentUserId, orElse: () => {});
    if (currentUserData != null && currentUserData.isNotEmpty) {
      return CurrentUserModel(
        username: currentUserData['username'],
        photoUrl: currentUserData['avatarUrl'],
      );
    } else {
      return null;
    }
  }
}

typedef UserLookup = Map<String, dynamic> Function(String userId);

class CurrentUserModel {
  final String username;
  final String photoUrl;

  CurrentUserModel({required this.username, required this.photoUrl});
}
