import 'package:flutter/material.dart';

import 'data/post_data.dart';

class CommentScreen extends StatefulWidget {
  final String postId;
  final String postOwner;
  final String postMediaUrl;

  const CommentScreen({
    Key? key,
    required this.postId,
    required this.postOwner,
    required this.postMediaUrl,
  }) : super(key: key);

  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final TextEditingController _commentController = TextEditingController();
  List<Map<String, dynamic>> _fetchedComments = [];

  // Define your reactions with corresponding colors
  final List<Map<String, dynamic>> _reactions = [
    {"type": "like", "icon": Icons.thumb_up_outlined, "color": Colors.blue},
    {"type": "dislike", "icon": Icons.thumb_down_outlined, "color": Colors.red},
  ];

  _CommentScreenState();

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
          "Bình luận",
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
            decoration: InputDecoration(labelText: 'Bình luận của bạn...'),
            onFieldSubmitted: (_) => addComment(_commentController.text),
          ),
          trailing: IconButton(
            onPressed: () => addComment(_commentController.text),
            icon: Icon(Icons.send),
          ),
        ),
      ],
    );
  }

  Widget buildComments() {
    return ListView.builder(
      itemCount: _fetchedComments.length,
      itemBuilder: (context, index) {
        return buildCommentItem(_fetchedComments[index], index);
      },
    );
  }

  Widget buildCommentItem(Map<String, dynamic> comment, int index) {
    String username = comment['username'];
    String commentText = comment['comment'];
    String avatarUrl = comment['avatar'];
    String reaction = comment['reaction'] ?? ''; // Default empty string if reaction not set

    return ListTile(
      title: Text(username),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(commentText),
          SizedBox(height: 4),
          buildReactionRow(index, reaction),
        ],
      ),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(avatarUrl),
      ),
    );
  }

  Widget buildReactionRow(int commentIndex, String selectedReaction) {
    return Row(
      children: _reactions.map((reaction) {
        return buildReactionButton(commentIndex, reaction['type'], reaction['icon'], reaction['color'], selectedReaction);
      }).toList(),
    );
  }

  Widget buildReactionButton(int commentIndex, String reactionType, IconData iconData, Color iconColor, String selectedReaction) {
    return GestureDetector(
      onTap: () => handleReaction(commentIndex, reactionType),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Icon(iconData, color: reactionType == selectedReaction ? iconColor : Colors.grey),
      ),
    );
  }

  void handleReaction(int commentIndex, String reactionType) {
    setState(() {
      _fetchedComments[commentIndex]['reaction'] = reactionType;
    });
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
          "reaction": '', // Initialize reaction as empty string
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
    fakeFeedData.firstWhere((user) => user['username'] == currentUserId,
        orElse: () => {});
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
