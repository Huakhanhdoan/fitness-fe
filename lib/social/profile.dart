import 'package:fitness/social/upload_post.dart';
import 'package:flutter/material.dart';
import 'data/post_data.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({required this.userId});

  final String userId;

  @override
  _ProfilePageState createState() => _ProfilePageState(userId);
}

class _ProfilePageState extends State<ProfilePage>
    with AutomaticKeepAliveClientMixin<ProfilePage> {
  final String profileId;
  String view = "grid";
  bool isFollowing = false;
  int postCount = 0;
  int followerCount = 0;
  int followingCount = 0;
  _ProfilePageState(this.profileId);

  @override
  void initState() {
    super.initState();
    // Initialize counts from user data
    var userPosts =
    fakeFeedData.where((post) => post['ownerId'] == profileId).toList();
    var userData = userPosts.isNotEmpty ? userPosts.first : null;
    if (userData != null) {
      postCount = userPosts.length;
      followerCount = userData['followerCount'] ?? 0;
      followingCount = userData['followingCount'] ?? 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var userPosts = fakeFeedData.where((post) => post['ownerId'] == profileId).toList();
    var userData = userPosts.isNotEmpty ? userPosts.first : null;
    String avatarUrl = userData != null ? userData['avatarUrl'] : '';
    String username = userData != null ? userData['username'] : '';
    postCount = userPosts.length;

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

    // Function to build user profile header
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
                      buildStatColumn("Posts", postCount),
                      buildStatColumn("Followers", followerCount),
                      buildStatColumn("Following", followingCount),
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
                          isFollowing ? "Following" : "Follow",
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

    // Function to build user posts
    Widget buildUserPosts() {
      List userPostMediaUrls =
      userPosts.map((post) => post['mediaUrl']).toList();

      if (view == "grid") {
        return GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: userPostMediaUrls
              .map((url) => Image.network(url))
              .toList()
              .cast<Widget>(),
        );
      } else {
        return Column(
          children: userPostMediaUrls
              .map((url) => Image.network(url))
              .toList()
              .cast<Widget>(),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          username,
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Uploader(),
                ),
              );
            },
            icon: const Icon(Icons.add),
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
