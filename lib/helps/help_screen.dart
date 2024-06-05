import 'package:flutter/material.dart';
import 'package:fitness/untils/color.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: const Text(
          "HƯỚNG DẪN",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
            color: Color.fromRGBO(48, 237, 102, 1),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
              bottom: 20,
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade500,
                    offset: const Offset(1.2, 1.2),
                    blurRadius: 5,
                    spreadRadius: 0.5,
                  ),
                  const BoxShadow(
                    color: Colors.white,
                    offset: const Offset(-2.0, -2.0),
                    spreadRadius: 0.5,
                  ),
                ]
              ),
              child: InkWell(
                child: ListTile(
                  title: Text(
                    "Làm thế nào để sử dụng?",
                    style: TextStyle(
                      color: Color.fromRGBO(48, 237, 102, 1),
                      fontSize: 18,
                    ),
                  ),
                  trailing: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.grey.withOpacity(0.1),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.red),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.add,
                          color: Colors.red,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ),
                onTap: () {},
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: 20,
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade500,
                    offset: const Offset(1.2, 1.2),
                    blurRadius: 5,
                    spreadRadius: 0.5,
                  ),
                  const BoxShadow(
                    color: Colors.white,
                    offset: const Offset(-2.0, -2.0),
                    spreadRadius: 0.5,
                  ),
                ]
              ),
              child: InkWell(
                child: ListTile(
                  title: Text(
                    "Đếm khi lắc điện thoại?",
                    style: TextStyle(
                      color: Color.fromRGBO(48, 237, 102, 1),
                      fontSize: 18,
                    ),
                  ),
                  trailing: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.grey.withOpacity(0.1),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.red),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.add,
                          color: Colors.red,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ),
                onTap: () {},
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: 20,
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade500,
                    offset: const Offset(1.2, 1.2),
                    blurRadius: 5,
                    spreadRadius: 0.5,
                  ),
                  const BoxShadow(
                    color: Colors.white,
                    offset: const Offset(-2.0, -2.0),
                    spreadRadius: 0.5,
                  ),
                ]
              ),
              child: InkWell(
                child: ListTile(
                  title: Text(
                    "Đếm khi lái xe?",
                    style: TextStyle(
                      color: Color.fromRGBO(48, 237, 102, 1),
                      fontSize: 18,
                    ),
                  ),
                  trailing: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.grey.withOpacity(0.1),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.red),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.add,
                          color: Colors.red,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ),
                onTap: () {},
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: 20,
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade500,
                    offset: const Offset(1.2, 1.2),
                    blurRadius: 5,
                    spreadRadius: 0.5,
                  ),
                  const BoxShadow(
                    color: Colors.white,
                    offset: const Offset(-2.0, -2.0),
                    spreadRadius: 0.5,
                  ),
                ]
              ),
              child: InkWell(
                child: ListTile(
                  title: Text(
                    "Sự chính xác",
                    style: TextStyle(
                      color: Color.fromRGBO(48, 237, 102, 1),
                      fontSize: 18,
                    ),
                  ),
                  trailing: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.grey.withOpacity(0.1),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.red),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.add,
                          color: Colors.red,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ),
                onTap: () {},
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: 20,
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade500,
                    offset: const Offset(1.2, 1.2),
                    blurRadius: 5,
                    spreadRadius: 0.5,
                  ),
                  const BoxShadow(
                    color: Colors.white,
                    offset: const Offset(-2.0, -2.0),
                    spreadRadius: 0.5,
                  ),
                ]
              ),
              child: InkWell(
                child: ListTile(
                  title: Text(
                    "Đề xuất vị trí",
                    style: TextStyle(
                      color: Color.fromRGBO(48, 237, 102, 1),
                      fontSize: 18,
                    ),
                  ),
                  trailing: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.grey.withOpacity(0.1),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.red),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.add,
                          color: Colors.red,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ),
                onTap: () {},
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: 20,
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade500,
                    offset: const Offset(1.2, 1.2),
                    blurRadius: 5,
                    spreadRadius: 0.5,
                  ),
                  const BoxShadow(
                    color: Colors.white,
                    offset: const Offset(-2.0, -2.0),
                    spreadRadius: 0.5,
                  ),
                ]
              ),
              child: InkWell(
                child: ListTile(
                  title: Text(
                    "Tiết kiệm pin",
                    style: TextStyle(
                      color: Color.fromRGBO(48, 237, 102, 1),
                      fontSize: 18,
                    ),
                  ),
                  trailing: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.grey.withOpacity(0.1),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.red),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.add,
                          color: Colors.red,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ),
                onTap: () {},
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: 20,
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade500,
                    offset: const Offset(1.2, 1.2),
                    blurRadius: 5,
                    spreadRadius: 0.5,
                  ),
                  const BoxShadow(
                    color: Colors.white,
                    offset: const Offset(-2.0, -2.0),
                    spreadRadius: 0.5,
                  ),
                ]
              ),
              child: InkWell(
                child: ListTile(
                  title: Text(
                    "Sự riêng tư",
                    style: TextStyle(
                      color: Color.fromRGBO(48, 237, 102, 1),
                      fontSize: 18,
                    ),
                  ),
                  trailing: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.grey.withOpacity(0.1),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.red),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.add,
                          color: Colors.red,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ),
                onTap: () {},
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: 20,
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade500,
                    offset: const Offset(1.2, 1.2),
                    blurRadius: 5,
                    spreadRadius: 0.5,
                  ),
                  const BoxShadow(
                    color: Colors.white,
                    offset: const Offset(-2.0, -2.0),
                    spreadRadius: 0.5,
                  ),
                ]
              ),
              child: InkWell(
                child: ListTile(
                  title: Text(
                    "Calo & Khoảng cách",
                    style: TextStyle(
                      color: Color.fromRGBO(48, 237, 102, 1),
                      fontSize: 18,
                    ),
                  ),
                  trailing: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.grey.withOpacity(0.1),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.red),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.add,
                          color: Colors.red,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ),
                onTap: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
