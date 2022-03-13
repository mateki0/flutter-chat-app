import 'package:flutter/material.dart';
import '../widgets/loginBody.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xffB6DEFD),
      body: LoginBody(),
    );
  }
}
