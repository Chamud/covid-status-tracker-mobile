import 'dart:convert';

import 'package:cst/pages/accounts/login.dart';
import 'package:cst/pages/main/home.dart';
import 'package:cst/pages/tracker/editprofile.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key, cent, zoom}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late String username, email, password1, password2;

  TextEditingController usernameEditingController = TextEditingController();
  TextEditingController emilEditingController = TextEditingController();
  TextEditingController password1EditingController = TextEditingController();
  TextEditingController password2EditingController = TextEditingController();

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

  Widget _buildEmailRow() {
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
              controller: emilEditingController,
              keyboardType: TextInputType.text,
              style: const TextStyle(
                color: Colors.black87,
              ),
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14),
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.white,
                  ),
                  hintText: 'Enter the email address'),
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
              controller: password1EditingController,
              keyboardType: TextInputType.text,
              obscureText: true,
              style: const TextStyle(
                color: Colors.black87,
              ),
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14),
                  prefixIcon: Icon(
                    Icons.lock_open,
                    color: Colors.white,
                  ),
                  hintText: 'Enter the password'),
            ),
          ),
        ]);
  }

  Widget _buildReenterPasswordRow() {
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
              controller: password2EditingController,
              keyboardType: TextInputType.text,
              obscureText: true,
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
                  hintText: 'Re-enter the password'),
            ),
          ),
        ]);
  }

  Widget _buildRegButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 1.4 * (MediaQuery.of(context).size.height / 20),
          width: 5 * (MediaQuery.of(context).size.width / 7),
          margin: const EdgeInsets.only(top: 25),
          child: ElevatedButton(
            onPressed: () {
              username = usernameEditingController.text;
              email = emilEditingController.text;
              password1 = password1EditingController.text;
              password2 = password2EditingController.text;

              regUser(un, em, pw, pw2) async {
                const String mainURL =
                    'https://covidstatustracker.herokuapp.com/api/';
                final prefs = await SharedPreferences.getInstance();
                const url = mainURL + 'register';
                var reqBody = {
                  'username': un,
                  'email': em,
                  'password1': pw,
                  'password2': pw2,
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
                      MaterialPageRoute(
                          builder: (context) => const EditProfilePage()),
                    );
                  } else {
                    prefs.setString('username', 'none');
                    prefs.setString('password', 'none');
                    Future<void> _showMyDialog() async {
                      return showDialog<void>(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Registraion Error'),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  Text(responseJson['errors']),
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

              regUser(username, email, password1, password2);
            },
            child: Text(
              "REGISTER",
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

  Widget _buildAlreadyButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(margin: const EdgeInsets.only(top: 5)),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            );
          },
          child: const Text("Already have an account? Login"),
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
            // ignore: prefer_const_constructors
            child: Icon(
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
            height: MediaQuery.of(context).size.height * 0.8,
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
                      "Registration",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height / 20,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ],
                ),
                _buildusernameRow(),
                _buildEmailRow(),
                _buildPasswordRow(),
                _buildReenterPasswordRow(),
                _buildRegButton(),
                _buildAlreadyButton(),
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
