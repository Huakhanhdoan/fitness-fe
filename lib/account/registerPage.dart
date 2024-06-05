import 'package:fitness/onboarding/onboarding_screen.dart';
import 'package:fitness/service/auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'loginPage.dart';


class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  Future<void> _register() async {
    try {
      final token = await register(
        _nameController.text,
        _emailController.text,
        _passController.text,
        _phoneController.text,
        _locationController.text,
      );
      if (token != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => OnBoardingScreen()),
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Registration Failed'),
          content: Text(e.toString()),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
        constraints: const BoxConstraints.expand(),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 80),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 40, 0, 6),
                child: Text(
                  'Welcome FitnessPro!',
                  style: TextStyle(fontSize: 22, color: Color(0xff333333)),
                ),
              ),
              const Text(
                'Signup with simple steps',
                style: TextStyle(fontSize: 16, color: Color(0xff606470)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 80, 0, 20),
                child: TextField(
                  controller: _nameController,
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                  decoration: const InputDecoration(

                      labelText: 'Name',
                      // prefixIcon: Container(
                      //   width: 50,
                      // ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffCED0D2), width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(6))
                      )
                  ),

                ),
              ),
              TextField(
                controller: _phoneController,
                style: const TextStyle(fontSize: 18, color: Colors.black),
                decoration: const InputDecoration(

                    labelText: 'Phone Number',
                    // prefixIcon: Container(
                    //   width: 50,
                    // ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffCED0D2), width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(6))
                    )
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: TextField(
                  controller: _locationController,
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                  decoration: const InputDecoration(

                      labelText: 'Location',
                      // prefixIcon: Container(
                      //   width: 50,
                      // ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffCED0D2), width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(6))
                      )
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: TextField(
                  controller: _emailController,
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                  decoration: const InputDecoration(

                      labelText: 'Email',
                      // prefixIcon: Container(
                      //   width: 50,
                      // ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffCED0D2), width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(6))
                      )
                  ),
                ),
              ),

              TextField(
                controller: _passController,
                style: const TextStyle(fontSize: 18, color: Colors.black),
                decoration: const InputDecoration(

                    labelText: 'Password',
                    // prefixIcon: Container(
                    //   width: 50,
                    // ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffCED0D2), width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(6))
                    )
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 40),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: MaterialButton(
                    onPressed: _register,
                    color: const Color(0xff3277D8),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6))
                    ),
                    child: const Text(
                      'Signup',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                  child: RichText(
                      text: TextSpan(
                          text: 'Already a user? ',
                          style: const TextStyle(
                              fontSize: 16,
                              color: Color(0xff606470)
                          ),
                          children: <TextSpan>[
                            TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                                  },
                                text: 'Login now',
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Color(0xff3277D8)
                                )
                            )
                          ]
                      )
                  )
              )
            ],
          ),
        ),
      ),
    );
  }


}