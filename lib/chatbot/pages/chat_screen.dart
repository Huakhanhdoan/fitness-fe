import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/menu.dart';
import '../../model/user.dart';
import '../../service/auth.dart';
import '../models/message.dart';
import '../models/messages.dart';
import '../utils/size.dart';
import '../utils/style.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _userMessage = TextEditingController();
  bool isLoading = false;

  static const apiKey = "AIzaSyAcyBQw9AVgeeIIVe99npntalN9MHBvxnQ";

  final List<Message> _messages = [];

  final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);

  void sendMessage() async {
    final message = _userMessage.text;
    _userMessage.clear();

    setState(() {
      _messages.add(Message(
        isUser: true,
        message: message,
        date: DateTime.now(),
      ));
      isLoading = true;
    });

    final content = [Content.text(message)];
    final response = await model.generateContent(content);

    setState(() {
      _messages.add(Message(
        isUser: false,
        message: response.text ?? "",
        date: DateTime.now(),
      ));
    });
  }

  void onAnimatedTextFinished() {
    setState(() {
      isLoading = false;
    });
  }

  User? user;
  String id = "";

  @override
  void initState() {
    //  loadData();

    // TODO: implement initState
    super.initState();
  }

  // Future<void> loadData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() async {
  //     id = prefs.getString('id') ?? "0";
  //     user = await getUserInfo(id)  ;
  //
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Menu()));
          },
        ),
        title:
        Text('Fitness Bot', style: TextStyle(color: black, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return Row(
                  children: [
                    if (!message.isUser) // Hiển thị avatar bên phải cho user
                      const CircleAvatar(
                        backgroundImage: AssetImage('assets/images/chatbot.gif'),
                      ),

                    Expanded(
                      child: Messages(
                        isUser: message.isUser,
                        message: message.message,
                        date: DateFormat('HH:mm').format(message.date),
                        onAnimatedTextFinished: onAnimatedTextFinished,
                      ),
                    ),
                    if (message.isUser) // Hiển thị avatar bên trái cho non-user
                      const CircleAvatar(
                        backgroundImage: AssetImage('assets/images/user.png'),
                      ),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: medium, vertical: small),
            child: TextFormField(
              maxLines: 6,
              minLines: 1,
              controller: _userMessage,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(medium, 0, small, 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(xlarge),
                ),
                hintText: 'Enter prompt',
                hintStyle: hintText,
                suffixIcon: GestureDetector(
                  onTap: () {
                    if (!isLoading && _userMessage.text.isNotEmpty) {
                      sendMessage();
                    }
                  },
                  child: isLoading
                      ? Container(
                    width: medium,
                    height: medium,
                    margin: const EdgeInsets.all(xsmall),
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(black),
                      strokeWidth: 3,
                    ),
                  )
                      : Icon(
                    Icons.arrow_upward,
                    color: _userMessage.text.isNotEmpty ? Colors.black : const Color(0x5A6C6C65),
                  ),
                ),
              ),
              style: promptText,
              onChanged: (value) {
                setState(() {});
              },
            ),
          )
        ],
      ),
    );
  }
}
