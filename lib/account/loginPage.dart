import 'package:fitness/components/menu.dart';
import 'package:fitness/home/homePage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../onboarding/onboarding_screen.dart';
import 'registerPage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
              const SizedBox(
                height: 140,
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 40, 0, 6),
                child: Text(
                  'Welcome back!',
                  style: TextStyle(fontSize: 22, color: Color(0xff333333)),
                ),
              ),
              const Text(
                'Login to continue using FitnessPro',
                style: TextStyle(fontSize: 16, color: Color(0xff606470)),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 80, 0, 20),
                child: TextField(
                  style: TextStyle(fontSize: 18, color: Colors.black),
                  decoration: InputDecoration(
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
              const TextField(
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black
                ),
                obscureText: true,
                decoration: InputDecoration(
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
                    onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => OnBoardingScreen()));},
                    child: const Text(
                      'Log In',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    color: const Color(0xff3277D8),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6))
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
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));
                                },
                              text: 'Sign up for a new account',
                              style: const TextStyle(
                                  color: Color(0xff3277D8), fontSize: 16
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