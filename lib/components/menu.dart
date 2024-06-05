import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:fitness/history/history.dart';
import 'package:fitness/home/homePage.dart';
import 'package:fitness/map/my_map.dart';
import 'package:fitness/profile/profile.dart';
import 'package:fitness/setting/setting.dart';
import 'package:fitness/untils/color.dart';
import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  final int? index;
  const Menu({Key? key, this.index}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  var map =  MyMap();
  int _index = 0;
  String title = "HOME";

  @override
  void initState() {
    super.initState();
    if (widget.index != null) {
      _index = widget.index!;
      switch (_index) {
        case 0:
          title = 'TRANG CHỦ';
          break;
        case 1:
          title = "LỊCH SỬ";
          break;
        case 2:
          title = "HỒ SƠ";
          break;
        case 3:
          title = "CÀI ĐẶT";
          break;
        case 4:
          title = "LỘ TRÌNH";
        default:
          title = "Lỗi";
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
            color: AppColors.backgroundColor,
            child: (_index == 0)
                ? const HomePage()
                : (_index == 2)
                    ? const Profile()
                    : (_index == 1)
                        ? const History()
                        : (_index == 3)
                            ? const Setting()
                            :  map),
        Column(
          children: [
            Container(
              height: 90,
              decoration: BoxDecoration(
                color: AppColors.colorTheme,
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(40.0), // Adjust corner radius here
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 36),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.person_pin,
                          color: Colors.white,
                          size: 40,
                        ))
                  ],
                ),
              ),
            ),
            const Spacer(),
            CurvedNavigationBar(
              index: _index,
              color: AppColors.colorTheme,
              backgroundColor: Colors.transparent,
              items: const [
                CurvedNavigationBarItem(
                  child: Icon(
                    Icons.home,
                    color: Colors.white,
                    size: 35,
                  ),
                ),
                CurvedNavigationBarItem(
                  child: Icon(
                    Icons.calendar_month,
                    color: Colors.white,
                    size: 35,
                  ),
                ),
                CurvedNavigationBarItem(
                  child: Icon(
                    Icons.perm_identity,
                    color: Colors.white,
                    size: 35,
                  ),
                ),
                CurvedNavigationBarItem(
                  child: Icon(
                    Icons.settings,
                    color: Colors.white,
                    size: 35,
                  ),
                ),
                CurvedNavigationBarItem(
                  child: Icon(
                    Icons.location_on_outlined,
                    color: Colors.white,
                    size: 35,
                  ),
                ),
              ],
              onTap: (index) {
                setState(() {
                  switch (index) {
                    case 0:
                      title = 'TRANG CHỦ';
                      break;
                    case 1:
                      title = "LỊCH SỬ";
                      break;
                    case 2:
                      title = "HỒ SƠ";
                      break;
                    case 3:
                      title = "CÀI ĐẶT";
                      break;
                    case 4:
                      title = "LỘ TRÌNH";
                      break;
                    default:
                      title = "Lỗi";
                  }
                  _index = index;
                });
              },
            ),
          ],
        ),
      ],
    ));
  }
}
