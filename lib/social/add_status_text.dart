import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// class AddStatusText extends StatefulWidget {
//   File _file;
//   AddStatusText(this._file, {super.key});
//
//   @override
//   State<AddStatusText> createState() => _AddStatusTextState();
// }
//
// class _AddStatusTextState extends State<AddStatusText> {
//   final caption = TextEditingController();
//   final location = TextEditingController();
//   bool islooding = false;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: const IconThemeData(color: Colors.black),
//         backgroundColor: Colors.white,
//         elevation: 0,
//         title: const Text(
//           'New post',
//           style: TextStyle(color: Colors.black),
//         ),
//         centerTitle: false,
//         actions: [
//           Center(
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 10.w),
//               child: GestureDetector(
//                 onTap: () async {
//                   setState(() {
//                     islooding = true;
//                   });
//                   // String post_url = await StorageMethod()
//                   //     .uploadImageToStorage('post', widget._file);
//                   // await Firebase_Firestor().CreatePost(
//                   //   postImage: post_url,
//                   //   caption: caption.text,
//                   //   location: location.text,
//                   // );
//                   setState(() {
//                     islooding = false;
//                   });
//                   // ignore: use_build_context_synchronously
//                   Navigator.of(context).pop();
//                 },
//                 child: Text(
//                   'Share',
//                   style: TextStyle(color: Colors.blue, fontSize: 15.sp),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//       body: SafeArea(
//           child: islooding
//               ? const Center(
//               child: CircularProgressIndicator(
//                 color: Colors.black,
//               ))
//               : Padding(
//             padding: EdgeInsets.only(top: 10.h),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: EdgeInsets.symmetric(
//                       horizontal: 10.w, vertical: 5.h),
//                   child: Row(
//                     children: [
//                       Container(
//                         width: 65.w,
//                         height: 65.h,
//                         decoration: const BoxDecoration(
//                           color: Colors.amber,
//                           image: DecorationImage(
//                             image: FileImage(widget._file),
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                       SizedBox(width: 10.w),
//                       SizedBox(
//                         width: 280.w,
//                         height: 60.h,
//                         child: TextField(
//                           controller: caption,
//                           decoration: const InputDecoration(
//                             hintText: 'Write a caption ...',
//                             border: InputBorder.none,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const Divider(),
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 10.w),
//                   child: SizedBox(
//                     width: 280.w,
//                     height: 30.h,
//                     child: TextField(
//                       controller: location,
//                       decoration: const InputDecoration(
//                         hintText: 'Add location',
//                         border: InputBorder.none,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           )),
//     );
//   }
// }

class AddStatusText extends StatefulWidget {
  final File? file;

  const AddStatusText({Key? key, this.file}) : super(key: key);

  @override
  State<AddStatusText> createState() => _AddStatusTextState();
}

class _AddStatusTextState extends State<AddStatusText> {
  late TextEditingController caption;
  late TextEditingController location;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    caption = TextEditingController();
    location = TextEditingController();
  }

  @override
  void dispose() {
    caption.dispose();
    location.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'New post',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        actions: [
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: GestureDetector(
                onTap: () async {
                  setState(() {
                    isLoading = true;
                  });

                  // Simulate upload process
                  await Future.delayed(const Duration(seconds: 2));

                  setState(() {
                    isLoading = false;
                  });

                  Navigator.pop(context);
                },
                child: const Text(
                  'Share',
                  style: TextStyle(color: Colors.blue, fontSize: 15),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.file != null)
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: FileImage(widget.file!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              TextField(
                controller: caption,
                decoration: const InputDecoration(
                  hintText: 'Write a caption ...',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: location,
                decoration: const InputDecoration(
                  hintText: 'Add location',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}






