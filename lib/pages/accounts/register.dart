import 'package:cst/pages/accounts/login.dart';
import 'package:cst/pages/main/home.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late String username, email, password1, password2;

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

  Widget _buildLoginButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 1.4 * (MediaQuery.of(context).size.height / 20),
          width: 5 * (MediaQuery.of(context).size.width / 7),
          margin: const EdgeInsets.only(top: 25),
          child: ElevatedButton(
            onPressed: () {},
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
                _buildLoginButton(),
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
