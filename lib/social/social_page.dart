import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'data/post_data.dart';
import 'image_post.dart';

class Social extends StatefulWidget {
  final Map<String, dynamic> newPost;

  const Social({Key? key, required this.newPost}) : super(key: key);

  @override
  _SocialState createState() => _SocialState();
}

class _SocialState extends State<Social> {
  List<ImagePost> feedData = [];

  @override
  void initState() {
    super.initState();
    _loadFeed();
  }

  _loadFeed() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? json = prefs.getString("fakeFeedData");

    if (json != null) {
      List<Map<String, dynamic>> data = jsonDecode(json).cast<Map<String, dynamic>>();
      List<ImagePost> listOfPosts = _generateFeed(data);
      setState(() {
        feedData = listOfPosts;
      });
    } else {
      _getFeed();
    }
  }

  _getFeed() async {
    String json = jsonEncode(fakeFeedData.toList());

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("fakeFeedData", json);

    List<Map<String, dynamic>> data = jsonDecode(json).cast<Map<String, dynamic>>();
    List<ImagePost> listOfPosts = _generateFeed(data);

    setState(() {
      feedData = listOfPosts;
    });
  }


  List<ImagePost> _generateFeed(List<Map<String, dynamic>> feedData) {
    List<ImagePost> listOfPosts = [];

    for (var postData in feedData) {
      listOfPosts.add(ImagePost.fromJSON(postData));
    }

    // Add new post to the beginning of the list
    if (widget.newPost.isNotEmpty) {
      listOfPosts.insert(0, ImagePost.fromJSON(widget.newPost));
    }

    return listOfPosts;
  }

  Future<void> _refresh() async {
    await _getFeed();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: feedData.isNotEmpty
            ? ListView.builder(
          itemCount: feedData.length,
          itemBuilder: (context, index) {
            return feedData[index];
          },
        )
            : Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
