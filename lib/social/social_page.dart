import 'package:fitness/untils/color.dart';
import 'package:flutter/material.dart';
import '../components/menu.dart';
import 'add_status_image.dart';


class Social extends StatefulWidget {
  const Social({super.key});

  @override
  _SocialState createState() => _SocialState();
}

class _SocialState extends State<Social> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 100),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.search,
                      size: 30,
                      color: Color(0xff262626),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Menu(),
                        ),
                      );
                    },
                  ),
                  const Image(
                    image: AssetImage('assets/images/logo_social.jpg'),
                    height: 50,
                    width: 50,
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.add_box,
                      size: 30,
                      color: Color(0xff262626),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddStatusImage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const Divider(),
            const ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://images.pexels.com/photos/2379004/pexels-photo-2379004.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
                radius: 30,
              ),
              title: Text(
                'Smith_steve',
                style: TextStyle(
                    fontFamily: 'Poppins-Black',
                    fontSize: 14,
                    color: Color(0xff262626)),
              ),
              subtitle: Text(
                'Melbourne, Australia',
                style: TextStyle(
                    fontFamily: 'Poppins-Regular',
                    fontSize: 12,
                    color: Color(0xff262626)),
              ),
              trailing: Icon(Icons.more_horiz),
            ),
            SizedBox(
              child: Image.network(
                'https://images.pexels.com/photos/70497/pexels-photo-70497.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                fit: BoxFit.fitWidth,
                height: 300,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.favorite_border_outlined,
                    size: 25,
                    color: Color(0xff262626),
                  ),
                  SizedBox(width: 20),
                  Icon(
                    Icons.messenger_outline,
                    size: 25,
                    color: Color(0xff262626),
                  ),
                  SizedBox(width: 20),
                  Icon(
                    Icons.share_outlined,
                    size: 25,
                    color: Color(0xff262626),
                  ),
                  Spacer(),
                  SizedBox(width: 150),
                  Icon(
                    Icons.bookmark_border_outlined,
                    size: 25,
                    color: Color(0xff262626),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 8.0, top: 8),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://images.pexels.com/photos/712513/pexels-photo-712513.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
                          radius: 12,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Liked by John, Lisa, and 20 others',
                          style: TextStyle(
                            fontFamily: 'Poppins-Regular',
                            fontSize: 12,
                            color: Color(0xff262626),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'The Food in Australia was amazing and I want to share some photos ❤ ',
                    style: TextStyle(
                      fontFamily: 'Poppins-Regular',
                      fontSize: 12,
                      color: Color(0xff262626),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
            const Divider(),
            const ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://images.pexels.com/photos/371985/pexels-photo-371985.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
                radius: 30,
              ),
              title: Text(
                'Meg_lanning',
                style: TextStyle(
                  fontFamily: 'Poppins-Black',
                  fontSize: 14,
                  color: Color(0xff262626),
                ),
              ),
              subtitle: Text(
                'Sydney, Australia',
                style: TextStyle(
                    fontFamily: 'Poppins-Regular',
                    fontSize: 12,
                    color: Color(0xff262626)),
              ),
              trailing: Icon(Icons.more_horiz),
            ),
            SizedBox(
              child: Image.network(
                'https://images.pexels.com/photos/5641867/pexels-photo-5641867.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                fit: BoxFit.fitWidth,
                height: 300,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.favorite_border_outlined,
                    size: 25,
                    color: Color(0xff262626),
                  ),
                  SizedBox(width: 20),
                  Icon(
                    Icons.messenger_outline,
                    size: 25,
                    color: Color(0xff262626),
                  ),
                  SizedBox(width: 20),
                  Icon(
                    Icons.share_outlined,
                    size: 25,
                    color: Color(0xff262626),
                  ),
                  Spacer(),
                  SizedBox(width: 150),
                  Icon(
                    Icons.bookmark_border_outlined,
                    size: 25,
                    color: Color(0xff262626),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 8.0, top: 8),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://images.pexels.com/photos/1681010/pexels-photo-1681010.jpeg?auto=compress&cs=tinysrgb&w=300'),
                          radius: 12,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Liked by Steve, Allen, and 40 others',
                          style: TextStyle(
                            fontFamily: 'Poppins-Regular',
                            fontSize: 12,
                            color: Color(0xff262626),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "Nature's beauty is a gentle reminder to slow down and find tranquility. 🦋",
                    style: TextStyle(
                      fontFamily: 'Poppins-Regular',
                      fontSize: 12,
                      color: Color(0xff262626),
                    ),
                  ),
                  SizedBox(height: 6),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
