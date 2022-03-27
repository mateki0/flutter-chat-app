import 'package:chat_app/graphql/mutations/login.dart';
import 'package:chat_app/widgets/button.dart';
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
            InputWithLabel('email', 'Enter Email', _loginController, 'email',
                validator, false),
            Expanded(
              child: InputWithLabel('password', 'Enter Password',
                  _passwordController, 'password', validator, true),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30.5),
              child: Login(
                loginControllerText: _loginController.text,
                passwordControllerText: _passwordController.text,
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
      {required this.loginControllerText,
      required this.passwordControllerText,
      required this.onValidate,
      Key? key})
      : super(key: key);

  final String loginControllerText;
  final String passwordControllerText;
  final void Function() onValidate;

  @override
  Widget build(BuildContext context) {
    return Mutation(
        options: MutationOptions(
            document: gql(login),
            // ignore: void_checks
            update: (GraphQLDataProxy cache, QueryResult? result) {
              return cache;
            },
            onCompleted: (dynamic resultData) async {
              const storage = FlutterSecureStorage();

              if (resultData != null) {
                String token = resultData['loginUser']['token'] ?? '';

                await storage.write(key: 'token', value: token);
                // await storage.write(key: 'firstName', value: resultData['loginUser']['user']['firstName']);
                // await storage.write(key: 'id', value: resultData['loginUser']['user']['id']);
              }
              Navigator.pushNamed(context, '/rooms');
            }),
        builder: (RunMutation runMutation, QueryResult? result) {
          return button(() => {
                // Future.delayed(Duration.zero, () async {
                //   onValidate();
                // }),
                runMutation({
                  'email': loginControllerText,
                  'password': passwordControllerText
                })
              });
        });
  }
}

Widget loginHeaderTexts(context) {
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
