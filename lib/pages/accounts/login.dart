import 'dart:convert';

import 'package:cst/pages/accounts/register.dart';
import 'package:cst/pages/main/home.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String username, password;

  TextEditingController usernameEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();

  Widget _buildusernameRow() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            height: 10,
            width: 5,
          ),
          Container(
            alignment: Alignment.center,
            height: 1.4 * (MediaQuery.of(context).size.height / 20),
            width: 5 * (MediaQuery.of(context).size.width / 7),
            margin: const EdgeInsets.only(top: 15),
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(30),
            ),
            child: TextFormField(
              controller: usernameEditingController,
              keyboardType: TextInputType.text,
              style: const TextStyle(
                color: Colors.black87,
              ),
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14),
                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  hintText: 'Enter the username'),
            ),
          ),
        ]);
  }

  Widget _buildPasswordRow() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 10, width: 5),
          Container(
            alignment: Alignment.center,
            height: 1.4 * (MediaQuery.of(context).size.height / 20),
            width: 5 * (MediaQuery.of(context).size.width / 7),
            margin: const EdgeInsets.only(top: 9),
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(30),
            ),
            child: TextFormField(
              controller: passwordEditingController,
              keyboardType: TextInputType.text,
              obscureText: true,
              autocorrect: false,
              style: const TextStyle(
                color: Colors.black87,
              ),
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14),
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.white,
                  ),
                  hintText: 'Enter the password'),
            ),
          ),
        ]);
  }

  Widget _buildLoginButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 1.4 * (MediaQuery.of(context).size.height / 20),
          width: 5 * (MediaQuery.of(context).size.width / 7),
          margin: const EdgeInsets.only(top: 25, bottom: 15),
          child: ElevatedButton(
            onPressed: () {
              username = usernameEditingController.text;
              password = passwordEditingController.text;
              loginUser(un, pw) async {
                const String mainURL =
                    'https://covidstatustracker.herokuapp.com/api/';
                final prefs = await SharedPreferences.getInstance();
                const url = mainURL + 'login';
                var reqBody = {
                  'username': un,
                  'password': pw,
                };

                http.Response response = await http.post(
                  Uri.parse(url),
                  body: reqBody,
                );
                if (response.statusCode == 200) {
                  Map<String, dynamic> responseJson =
                      json.decode(response.body);
                  if (responseJson['Message'] == 'Success') {
                    prefs.setString('username', un);
                    prefs.setString('password', pw);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    );
                  } else {
                    prefs.setString('username', 'none');
                    prefs.setString('password', 'none');
                    Future<void> _showErrDialog() async {
                      return showDialog<void>(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Login Error'),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  Text(responseJson['Message']),
                                  const Text('Please try again'),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('OK'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }

                    _showErrDialog();
                  }
                } else {
                  Future<void> _showMyDialog() async {
                    return showDialog<void>(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Error'),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: const <Widget>[
                                Text('Failed to connect to the server.'),
                                Text('Please try again later'),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('OK'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }

                  _showMyDialog();
                }
              }

              loginUser(username, password);
            },
            child: Text(
              "LOGIN",
              style: TextStyle(
                color: Colors.lightBlueAccent,
                letterSpacing: 1.5,
                fontSize: MediaQuery.of(context).size.height / 40,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildDontHavedButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(margin: const EdgeInsets.only(top: 5)),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const RegisterPage()),
            );
          },
          child: const Text("Don't have an account? Register"),
        ),
      ],
    );
  }

  Widget _buildForgetPasswordButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(margin: const EdgeInsets.only(top: 5)),
        TextButton(
          onPressed: () {
            launch("https://covidstatustracker.herokuapp.com/reset_password/");
          },
          child: const Text("Forgot your password? Reset"),
        ),
      ],
    );
  }

  Widget _buildSocialBtnRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: () {},
          child: Container(
            height: 25,
            width: 25,
            margin: const EdgeInsets.only(top: 10),
            child: const Icon(
              FontAwesomeIcons.home,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildhomeButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 2),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          },
          child: const Text(
            "Home",
            style: TextStyle(
              color: Colors.white,
              fontFamily: ' Trajan Pro',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContainer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.7,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white24),
              color: Colors.lightBlueAccent,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(margin: const EdgeInsets.only(bottom: 10)),
                    Text(
                      "Login",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height / 20,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ],
                ),
                _buildusernameRow(),
                _buildPasswordRow(),
                _buildLoginButton(),
                _buildDontHavedButton(),
                _buildForgetPasswordButton(),
                _buildSocialBtnRow(),
                _buildhomeButton(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xfff2f3f7),
        body: Stack(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 1.0,
              width: MediaQuery.of(context).size.width,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  color: Colors.lightBlue,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildContainer(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
