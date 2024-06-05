import 'package:fitness/components/menu.dart';
import 'package:fitness/home/homePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../onboarding/onboarding_screen.dart';
import '../service/auth.dart';
import 'registerPage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  Future<void> _login() async {
    try {
      final token = await login(_emailController.text, _passwordController.text);
      if (token != null) {
        // Chuyển hướng đến màn hình chính khi đăng nhập thành công
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => OnBoardingScreen()),
        );
      }
    } catch (e) {
      // Xử lý lỗi đăng nhập
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Đăng nhập thất bại'),
          content: const Text("Sai tên đăng nhập hoặc mật khẩu"),
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
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              const SizedBox(
                height: 140,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                child: Container(
                    width: 70,
                    height: 70,
                    padding: const EdgeInsets.all(15),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Color(0xffd8d8d8)),
                    child: const FlutterLogo()
                ),
              ),

              const Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: Text(
                    'Hello\nWelcome back!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xff333333),
                      fontSize: 30,)
                ),
              ),
              const Text(
                'Login to continue using FitnessPro',
                style: TextStyle(fontSize: 16, color: Color(0xff606470)),
              ),
               Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 20),
                child: TextField(
                  controller: _emailController,
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                  decoration: const InputDecoration(
                      labelText: 'Email',

                      // prefixIcon: Container(
                      //   width: 10,
                      //
                      // ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(0xffCED0D2),
                              width: 1
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(6))
                      )
                  ),
                ),
              ),
               TextField(
                controller: _passwordController,
                style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black
                ),
                obscureText: true,
                decoration: const InputDecoration(
                    labelText: 'Password',

                    // prefixIcon: Container(
                    //   width: 50,
                    // ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color(0xffCED0D2),
                            width: 1
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(6))
                    )
                ),
              ),
              Container(
                constraints: BoxConstraints.loose(const Size(double.infinity, 30)),
                alignment: AlignmentDirectional.centerEnd,
                child: const Text(
                  'Forgot password?',
                  style: TextStyle(fontSize: 16, color: Color(0xff606470)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 40),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: MaterialButton(
                    onPressed: () { _login();},
                    color: const Color(0xff50d832),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6))
                    ),
                    child: const Text(
                      'Log In',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                child: RichText(
                    text: TextSpan(
                        text: 'New user? ',
                        style: const TextStyle(color: Color(0xff606470), fontSize: 16),
                        children: <TextSpan>[
                          TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RegisterPage()));
                                },
                              text: 'Sign up for a new account',
                              style: const TextStyle(
                                  color: Color(0xff50d832), fontSize: 16
                              )
                          )
                        ]
                    )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}