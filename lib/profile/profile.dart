import 'package:fitness/untils/color.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:numberpicker/numberpicker.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(children: <Widget>[
        const SizedBox(
          height: 70,
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Thông tin người dùng",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Container(
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
              getOptions(
                Icons.male,
                "Giới tính",
                "Nam",
                "gender",
              ),
              Container(
                width: MediaQuery.of(context).size.width - 40,
                height: 1,
                color: Colors.grey,
              ),
              getOptions(Icons.monitor_weight, "Khối lượng", "75kg", "weight"),
              Container(
                width: MediaQuery.of(context).size.width - 40,
                height: 1,
                color: Colors.grey,
              ),
              getOptions(Icons.expand_outlined, "Chiều cao", "170cm", "height"),
              Container(
                width: MediaQuery.of(context).size.width - 40,
                height: 1,
                color: Colors.grey,
              ),
              getOptions(Icons.cake, "Ngày sinh", "16/01/2003", "date"),
              Container(
                width: MediaQuery.of(context).size.width - 40,
                height: 1,
                color: Colors.grey,
              ),
            ]),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Thiết lập mục tiêu",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Container(
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
              getOptions(Icons.my_location_outlined, "Số bước", "4000", "step"),
              Container(
                width: MediaQuery.of(context).size.width - 40,
                height: 1,
                color: Colors.grey,
              ),
              getOptions(Icons.add_alert, "Nhắc nhở", "8:30 Am", "alarm"),
              Container(
                width: MediaQuery.of(context).size.width - 40,
                height: 1,
                color: Colors.grey,
              ),
              getOptions(Icons.local_fire_department_rounded, "Calories",
                  "500Kcal", "calo"),
            ]),
          ),
        ),
        const SizedBox(
          height: 100,
        )
      ]),
    );
  }

  Widget getOptions(
    IconData _icon,
    String _nameCard,
    String _data,
    String value,
  ) {
    return GestureDetector(
      onTap: () {
        if (value == "gender") {
          _displayBottomSheetGender(context);
        } else if (value == "weight") {
          _displayBottomSheetWeight(context);
        } else if (value == "height") {
          _displayBottomSheetHeight(context);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                _icon,
                size: 40,
                color: Colors.orange,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _nameCard,
                  style: TextStyle(color: AppColors.textColor),
                ),
              ),
              const Spacer(),
              Text(
                _data,
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: AppColors.colorTheme),
              ),
              const Icon(
                Icons.arrow_drop_down,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _displayBottomSheetGender(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: 400,
        width: 500,
        child: const Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Text(
              'GIỚI TÍNH CỦA BẠN LÀ GÌ?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Future _displayBottomSheetWeight(BuildContext context) {
    int userWeight = 50;
    return showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: 400,
        width: 500,
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            const Text(
              'BẠN NẶNG BAO NHIÊU?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Slider(
                  value: userWeight.toDouble(),
                  min: 0,
                  max: 200,
                  divisions: 200, // Số bước giữa min và max
                  onChanged: (value) {
                    //  saveValues();
                    setState(() {
                      userWeight = value.round();
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    'Cân nặng của bạn: $userWeight' 'kg',
                    style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future _displayBottomSheetHeight(BuildContext context) {
    int _currentIntValue = 170;
    return showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: 400,
        width: 500,
        child: const Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Text(
              'BẠN CAO BAO NHIÊU?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
