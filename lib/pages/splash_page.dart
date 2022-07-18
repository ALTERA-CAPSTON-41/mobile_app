import 'package:capston_project/common/const.dart';
import 'package:capston_project/pages/auth/sign_in.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  _init() {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const SignInPage()),
          (route) => false);
    });
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhite,
      body: Center(
        child: Image.asset(
          "assets/images/logo.png",
          width: 150,
        ),
      ),
    );
  }
}
