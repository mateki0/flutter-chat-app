import 'package:chat_app/graphql/mutations/login.dart';
import 'package:chat_app/services/apolloClient.dart';
import 'package:chat_app/widgets/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import './screenTitle.dart';
import './inputWithLabel.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({Key? key}) : super(key: key);

  @override
  _LoginBodyState createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  validateForm() {
    _formKey.currentState!.validate();
  }

  validator(value, key) {
    if (value == null || value.isEmpty) {
      return "Please enter $key";
    }
    if (key == 'password' && value.length < 8) {
      return "Password must have 8 signs";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 46.0, top: 48.0),
              child: loginHeaderTexts(context),
            ),
            InputWithLabel(
                label: 'email',
                hintText: 'Enter Email',
                controller: _loginController,
                inputKey: 'email',
                validator: validator,
                obscureText: false),
            Expanded(
              child: InputWithLabel(
                  label: 'password',
                  hintText: 'Enter Password',
                  controller: _passwordController,
                  inputKey: 'password',
                  validator: validator,
                  obscureText: true),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30.5),
              child: Login(
                loginController: _loginController,
                passwordController: _passwordController,
                onValidate: validateForm,
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(bottom: 92.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account? "),
                    GestureDetector(
                      child: const Text(
                        ' Sign up',
                        style: TextStyle(
                            color: Colors.purple, fontWeight: FontWeight.bold),
                      ),
                      onTap: () => print('tapped'),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

class Login extends StatelessWidget {
  const Login(
      {required this.loginController,
      required this.passwordController,
      required this.onValidate,
      Key? key})
      : super(key: key);

  final TextEditingController loginController;
  final TextEditingController passwordController;
  final void Function() onValidate;

  @override
  Widget build(BuildContext context) {
    return Mutation(
        options: MutationOptions(
            document: gql(login),
            onError: (error) {
              Navigator.of(context).restorablePush(_dialogBuilder);
            },
            onCompleted: (dynamic resultData) async {
              const storage = FlutterSecureStorage();

              if (resultData != null) {
                String token = resultData['loginUser']['token'] ?? '';

                setToken(token);
                await storage.write(key: 'token', value: token);
                Navigator.pushNamed(context, '/rooms');
              }
            }),
        builder: (RunMutation runMutation, QueryResult? result) {
          return result != null && result.isLoading
              ? const CupertinoActivityIndicator(
                  color: Color(0xff5603AD),
                )
              : button(() => {
                    Future.delayed(Duration.zero, () async {
                      onValidate();
                    }),
                    runMutation({
                      'email': loginController.text,
                      'password': passwordController.text
                    })
                  });
        });
  }
}

Widget loginHeaderTexts(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        child: ScreenTitle('Welcome back'),
        width: MediaQuery.of(context).size.width,
      ),
      const Text('Log in and stay in touch\nwith everyone!',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: Color(0xffffffff))),
    ],
  );
}

Route<Object?> _dialogBuilder(BuildContext context, Object? argument) {
  return DialogRoute(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Invalid credentials'),
          content: const Text('Email or password are incorrect'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Try Again'))
          ],
        );
      });
}
