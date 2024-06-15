import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CommentScreen extends StatefulWidget {
  final String postId;
  final String postOwner;
  final String postMediaUrl;

  const CommentScreen({
    Key? key,
    required this.postId,
    required this.postOwner,
    required this.postMediaUrl,
  });

  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final TextEditingController _commentController = TextEditingController();
  List<Map<String, dynamic>> _fetchedComments = [];
  String? _selectedReactionType;

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
        return buildCommentItem(_fetchedComments[index]);
      },
    );
  }

  Widget buildCommentItem(Map<String, dynamic> comment) {
    String username = comment['username'] ?? 'Unknown User';
    String avatarUrl =
        comment['avatarUrl'] ?? 'https://th.bing.com/th/id/OIP.GHGGLYe7gDfZUzF_tElxiQHaHa?rs=1&pid=ImgDetMain';
    String commentText = comment['comment'] ?? 'No comment text';

    return ListTile(
      title: Text(username),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(commentText),
          SizedBox(height: 4),
          buildReactionRow(comment),
        ],
      ),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(avatarUrl),
      ),
    );
  }

  Widget buildReactionRow(Map<String, dynamic> comment) {
    List<Map<String, dynamic>> reactions = List<Map<String, dynamic>>.from(comment['reactions'] ?? []);
    return Row(
      children: reactions.map((reaction) {
        return buildReactionButton(comment, reaction);
      }).toList(),
    );
  }

  Widget buildReactionButton(Map<String, dynamic> comment, Map<String, dynamic> reaction) {
    bool isSelected = reaction['isSelected'] ?? false;
    IconData selectedIcon = reaction['selectedIcon'] ?? Icons.thumb_up;
    IconData unselectedIcon = reaction['unselectedIcon'] ?? Icons.thumb_up_outlined;
    IconData iconData = isSelected ? selectedIcon : unselectedIcon;
    Color iconColor = reaction['color'] ?? Colors.blue; // Default color if null

    // Ensure iconColor is not null before calling withOpacity
    if (iconColor != null) {
      iconColor = isSelected ? iconColor : iconColor.withOpacity(0.5);
    }

    return GestureDetector(
      onTap: () => handleReaction(comment, reaction),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Icon(iconData, color: iconColor),
      ),
    );
  }

  void handleReaction(Map<String, dynamic> comment, Map<String, dynamic> selectedReaction) {
    setState(() {
      comment['reactions'].forEach((reaction) {
        reaction['isSelected'] = false;
      });
      selectedReaction['isSelected'] = !selectedReaction['isSelected'];
    });
  }

  Future<String?> getCurrentUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('id');
  }

  void addComment(String commentText) async {
    _commentController.clear();
    String? currentUserId = await getCurrentUserId();
    if (currentUserId == null) {
      print('Current user id is null');
      return;
    }

    String selectedReactionType = _selectedReactionType ?? 'default';

    Map<String, dynamic> newComment = {
      "user_id": currentUserId,
      "comment": commentText,
      "reactions": [
        {"user_id": currentUserId, "reactionType": selectedReactionType}
      ],
    };

    try {
      final response = await http.post(
        Uri.parse('https://fitness-be.onrender.com/post/${widget.postId}/comments/create'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(newComment),
      );

      if (response.statusCode == 201) {
        List<dynamic> responseData = jsonDecode(response.body);

        setState(() {
          _fetchedComments = responseData.cast<Map<String, dynamic>>();
        });
      } else {
        print('Failed to add comment. Server responded with status code ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to add comment');
      }
    } catch (e) {
      print('Error adding comment: $e');
    }
  }

  void getComments() async {
    try {
      final response = await http.get(
        Uri.parse('https://fitness-be.onrender.com/post/${widget.postId}/comments'),
      );
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<Map<String, dynamic>> parsedComments = data.cast<Map<String, dynamic>>();
        setState(() {
          _fetchedComments = parsedComments;
        });
      } else {
        throw Exception('Failed to load comments: ${response.statusCode}');
      }
    } catch (e) {
      print('Error loading comments: $e');
    }
  }
}
