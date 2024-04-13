import 'package:fitness/untils/color.dart';
import 'package:flutter/material.dart';



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
        const SizedBox(height: 70,),
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
              getOptions(Icons.male, "Giới tính", "Nam"),
              Container(
                width: MediaQuery.of(context).size.width - 40,
                height: 1,
                color: Colors.grey,
              ),
              getOptions(Icons.monitor_weight, "Khối lượng", "75kg"),
              Container(
                width: MediaQuery.of(context).size.width - 40,
                height: 1,
                color: Colors.grey,
              ),
              getOptions(Icons.expand_outlined, "Chiều cao", "170cm"),
              Container(
                width: MediaQuery.of(context).size.width - 40,
                height: 1,
                color: Colors.grey,
              ),
              getOptions(Icons.cake, "Ngày sinh", "16/01/2003"),
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
              getOptions(Icons.my_location_outlined, "Số bước", "4000"),
              Container(
                width: MediaQuery.of(context).size.width - 40,
                height: 1,
                color: Colors.grey,
              ),
              getOptions(Icons.add_alert, "Nhắc nhở", "8:30 Am"),
              Container(
                width: MediaQuery.of(context).size.width - 40,
                height: 1,
                color: Colors.grey,
              ),
              getOptions(
                  Icons.local_fire_department_rounded, "Calories", "500Kcal"),
            ]),
          ),
        ),
        const SizedBox(height: 100,)
      ]),
    );
  }

  Widget getOptions(
      IconData _icon,
      String _nameCard,
      String _data,
      ) {
    return GestureDetector(
      onTap: () {},
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
                child: Text(_nameCard, style: TextStyle(color: AppColors.textColor),),
              ),
              const Spacer(),
              Text(
                _data,
                style:  TextStyle(
                    fontWeight: FontWeight.bold, color: AppColors.colorTheme),
              ),
              const Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
      ),
    );
  }
}
