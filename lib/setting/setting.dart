import 'package:fitness/setting_device/achivement.dart';
import 'package:fitness/untils/color.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../account/loginPage.dart';
import '../components/menu.dart';
import '../helps/help_screen.dart';
import '../setting_device/setting_device.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {

  double calories = 88.76;
  double step = 2210;
  double distance = 2.12;
  bool isWater = true;
  late bool isDarkMode = false ;

  @override
  void initState() {
    super.initState();
    loadDarkMode();
  }

  void loadDarkMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = prefs.getBool('isDarkMode') ?? false;
    });
  }

  void saveDarkMode(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', value);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.colorTheme,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) =>
                      const Menu(),
                  )
              );
            },
          ),
          title: Text("Cài Đặt", style: TextStyle(color: AppColors.textColor, fontWeight: FontWeight.bold),),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: ListView(children: <Widget>[
              const SizedBox(height: 70,),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "BƯỚC THEO DÕI VÀ THÀNH TÍCH",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.containerColor,
                  border: Border.all(
                    color: Colors.grey, // Màu sắc của viền
                    width: 1, // Độ dày của viền
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5), // Màu của bóng
                      spreadRadius: 1, // Độ lan rộng của bóng
                      blurRadius: 7, // Độ mờ của bóng
                      offset: const Offset(-3, 3), // Độ lệch của bóng
                    ),
                  ],
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              '$calories',
                              style: TextStyle(
                                  color: AppColors.colorTheme,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17),
                            ),
                            Text('Kcal', style: TextStyle(color: AppColors.textColor),),
                          ],
                        ),
                        Container(
                          width: 1,
                          height: 50,
                          color: Colors.grey,
                        ),
                        Column(
                          children: [
                            Text(
                              '$step',
                              style: TextStyle(
                                  color: AppColors.colorTheme,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17),
                            ),
                            Text('Các bước',style: TextStyle(color: AppColors.textColor)),
                          ],
                        ),
                        Container(
                          width: 1,
                          height: 50,
                          color: Colors.grey,
                        ),
                        Column(
                          children: [
                            Text(
                              '$distance',
                              style: TextStyle(
                                  color: AppColors.colorTheme,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17 /**/),
                            ),
                            Text('Km', style: TextStyle(color: AppColors.textColor)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 40,
                    height: 1,
                    color: Colors.grey,
                  ),
                  getOptions(Icons.history, "Lịch sử", "history"),
                  Container(
                    width: MediaQuery.of(context).size.width - 40,
                    height: 1,
                    color: Colors.grey,
                  ),
                  getOptions(Icons.school_sharp, "Thành tích", "achivement"),
                ]),

              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "CÀI ĐẶT TÀI KHOẢN",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.containerColor,
                  border: Border.all(
                    color: Colors.grey, // Màu sắc của viền
                    width: 1, // Độ dày của viền
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5), // Màu của bóng
                      spreadRadius: 1, // Độ lan rộng của bóng
                      blurRadius: 7, // Độ mờ của bóng
                      offset: const Offset(-3, 3), // Độ lệch của bóng
                    ),
                  ],
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  children: [
                    getOptions(Icons.g_mobiledata, 'Phục hồi dữ liệu đã sao lưu', "restore"),
                    Container(
                      width: MediaQuery.of(context).size.width - 40,
                      height: 1,
                      color: Colors.grey,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: const Row(
                          children: [
                            Icon(Icons.settings, color: Colors.orange,size: 45,),
                            Text(
                              ' Chế độ tối',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        trailing: Switch(
                          // This bool value toggles the switch.
                          value: isDarkMode,
                          activeColor: AppColors.colorTheme,
                          onChanged: (bool value) {
                            saveDarkMode(value);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) =>
                                    const Setting(),
                                )
                            );
                            // This is called when the user toggles the switch.
                            setState(() {

                              isDarkMode = value;
                              if(isDarkMode) {
                                AppColors.colorTheme = Colors.redAccent;
                                AppColors.backgroundColor = Colors.black45;
                                AppColors.containerColor = Colors.black38;
                                AppColors.textColor = Colors.white;
                              }
                              else {
                                AppColors.colorTheme =  const Color.fromRGBO(48, 237, 102,1);
                                AppColors.backgroundColor = Colors.white;
                                AppColors.containerColor = Colors.white70;
                                AppColors.textColor = Colors.black;
                              }

                            });
                          },
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 40,
                      height: 1,
                      color: Colors.grey,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: const Row(
                          children: [
                            Icon(Icons.water_drop, color: Colors.blue,size: 45,),
                            Text(
                              ' Uống nước',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        trailing: Switch(
                          // This bool value toggles the switch.
                          value: isWater,
                          activeColor: AppColors.colorTheme,
                          onChanged: (bool value) {
                            // This is called when the user toggles the switch.
                            setState(() {
                              isWater = value;
                            });
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "ĐIỀU KHOẢN VÀ HỖ TRỢ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
              ),
              Container(
                  decoration: BoxDecoration(
                    color: AppColors.containerColor,
                    border: Border.all(
                      color: Colors.grey, // Màu sắc của viền
                      width: 1, // Độ dày của viền
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), // Màu của bóng
                        spreadRadius: 1, // Độ lan rộng của bóng
                        blurRadius: 7, // Độ mờ của bóng
                        offset: const Offset(-3, 3), // Độ lệch của bóng
                      ),
                    ],
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                      children: [
                        getOptions(Icons.mobile_friendly, 'Thiết lập thiết bị', "setting_device"),
                        Container(
                          width: MediaQuery.of(context).size.width - 40,
                          height: 1,
                          color: Colors.grey,
                        ),
                        getOptions(Icons.help, 'Hướng dẫn', "help"),
                        Container(
                          width: MediaQuery.of(context).size.width - 40,
                          height: 1,
                          color: Colors.grey,
                        ),
                        getOptions(Icons.message, 'Nhận xét', "message"),
                        Container(
                          width: MediaQuery.of(context).size.width - 40,
                          height: 1,
                          color: Colors.grey,
                        ),
                        getOptions(Icons.lock_clock_rounded, 'Chính sách bảo mật', "lock"),
                        Container(
                          width: MediaQuery.of(context).size.width - 40,
                          height: 1,
                          color: Colors.grey,
                        ),
                        getOptions(Icons.error, 'Giới thiệu', "present"),
                        Container(
                          width: MediaQuery.of(context).size.width - 40,
                          height: 1,
                          color: Colors.grey,
                        ),
                        getOptionsLogout(Icons.logout_outlined, 'Đăng xuất'),
                      ]
                  )
              ), const SizedBox(height: 100,)
            ]),
          ),
        )
    );
  }

  Widget getOptionsLogout(IconData _icon, String _nameCard) {
    return GestureDetector(
      onTap: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('id', '') ;
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          height: 35,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                _icon,
                size: 40,
                color: Colors.blue,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(_nameCard, style: TextStyle(color: AppColors.textColor)),
              ),
              const Spacer(),
              const Icon(Icons.keyboard_arrow_right_sharp),
            ],
          ),
        ),
      ),
    );
  }

  Widget getOptions(IconData _icon, String _nameCard, String tag) {
    return GestureDetector(
      onTap: () {
        if(tag == "history"){
          Navigator.push(context, MaterialPageRoute(builder: (context) => const Menu(index: 1)));
        } else if(tag == "achivement"){
          Navigator.push(context, MaterialPageRoute(builder: (context) => const Achivement()));
        } else if(tag == "help"){
          Navigator.push(context, MaterialPageRoute(builder: (context) => const HelpScreen()));
        } else if(tag == "setting_device"){
          Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingDevice()));
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          height: 35,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                _icon,
                size: 40,
                color: Colors.blue,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(_nameCard, style: TextStyle(color: AppColors.textColor)),
              ),
              const Spacer(),
              const Icon(Icons.keyboard_arrow_right_sharp),
            ],
          ),
        ),
      ),
    );
  }
}
