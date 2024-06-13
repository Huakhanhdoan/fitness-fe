import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
    // _loadFeed();
    _getFeed();
  }

  // Future<void> _loadFeed() async {
  //   await _getFeed();
  // }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(48, 237, 102, 1),
        title: const Text('Social Feed', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        )
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
