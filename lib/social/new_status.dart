import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../components/menu.dart';

class Status extends StatefulWidget {
  const Status({super.key});

  @override
  _StatusState createState() => _StatusState();
}

class _StatusState extends State<Status> {
  final ImagePicker _picker = ImagePicker();
  List<File> _selectedPics = [];
  File? _currentSelectedPic; // Initialize to null initially

  Future<void> _pickImage() async {
    final List<XFile>? images = await _picker.pickMultiImage();
    if (images != null) {
      setState(() {
        _selectedPics = images.map((image) => File(image.path)).toList();
        _currentSelectedPic = _selectedPics.isNotEmpty ? _selectedPics.last : null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'New post',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Menu(index: 2)),
            );
          },
          icon: const Icon(
            Icons.close,
            size: 30,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Handle the forward action (e.g., upload photo)
            },
            icon: const Icon(
              size: 30,
              Icons.arrow_forward,
              color: Colors.black,
            ),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Theme.of(context).colorScheme.onSecondary,
              height: 315,
              child: _currentSelectedPic != null
                  ? Image.file(
                _currentSelectedPic!,
                fit: BoxFit.cover,
              )
                  : Image.network(
                'https://i.pinimg.com/550x/c4/ab/eb/c4abebfe8f0682058c29d4ab28308648.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Container(
              height: 0.4,
              color: Colors.white,
            ),
            Container(
              height: 50,
              color: Theme.of(context).colorScheme.background,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      Text('Recents'),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(Icons.keyboard_arrow_down)
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(Icons.copy, size: 15),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'SELECT MULTIPLE',
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: _pickImage,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(6.0),
                            child: Icon(
                              Icons.camera_alt_outlined,
                              size: 19,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: 658,
              color: Theme.of(context).colorScheme.background,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                      itemCount: _selectedPics.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(), // Disable GridView scrolling
                      itemBuilder: (context, index) {
                        final pic = _selectedPics[index];
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _currentSelectedPic = pic;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Container(
                              color: Theme.of(context).colorScheme.onSecondary,
                              child: Image.file(
                                pic,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
