import 'package:cst/models/homedata.dart';
import 'package:cst/pages/accounts/login.dart';
import 'package:cst/pages/main/home.dart';
import 'package:cst/pages/map/map.dart';
import 'package:cst/pages/tracker/profile.dart';
import 'package:cst/pages/tracker/tracker.dart';
import 'package:cst/services/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class NavigationDrawerWidget extends StatelessWidget {
  NavigationDrawerWidget({Key? key}) : super(key: key);
  late Future<Homedata> futurehome = fetchHome();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue[600],
              ),
              child: Column(
                children: [
                  SizedBox(
                      width: 100,
                      height: 100,
                      child: Image.asset('lib/assets/logo.png')),
                  Text('Covid Status Tracker',
                      style: TextStyle(
                          fontSize: 25,
                          letterSpacing: 1.0,
                          color: Colors.lightBlue[50])),
                ],
              )),
          Card(
            child: ListTile(
              title: Text(
                'Home',
                style: TextStyle(
                  fontSize: 25,
                  letterSpacing: 0.7,
                  color: Colors.blue[900],
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              title: Text(
                'Symptom Tracker',
                style: TextStyle(
                  fontSize: 25,
                  letterSpacing: 0.7,
                  color: Colors.blue[900],
                ),
              ),
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                final auth = prefs.getString('username') ?? 'none';
                if (auth == 'none') {
                  Future<void> alert() {
                    return showDialog<void>(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Access Denied!'),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: const <Widget>[
                                  Text('Please Login to access'),
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
                        });
                  }

                  alert();
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const tracker()),
                  );
                }
              },
            ),
          ),
          Card(
            child: ListTile(
              title: Text(
                'Covid Map',
                style: TextStyle(
                  fontSize: 25,
                  letterSpacing: 0.7,
                  color: Colors.blue[900],
                ),
              ),
              onTap: () {
                setMapdata() async {
                  final prefs = await SharedPreferences.getInstance();
                  prefs.setDouble('longitude', 80.70);
                  prefs.setDouble('lattitude', 7.90);
                  prefs.setDouble('zoom', 7.5);
                }

                setMapdata();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MapPage()),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              title: Text(
                'Profile',
                style: TextStyle(
                  fontSize: 25,
                  letterSpacing: 0.7,
                  color: Colors.blue[900],
                ),
              ),
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                final auth = prefs.getString('username') ?? 'none';
                if (auth == 'none') {
                  Future<void> alert() {
                    return showDialog<void>(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Access Denied!'),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: const <Widget>[
                                  Text('Please Login to access'),
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
                        });
                  }

                  alert();
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfilePage()),
                  );
                }
              },
            ),
          ),
          Card(
            child: ListTile(
              title: Text(
                'Login',
                style: TextStyle(
                  fontSize: 25,
                  letterSpacing: 0.7,
                  color: Colors.blue[900],
                ),
              ),
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                final auth = prefs.getString('username') ?? 'none';
                if (auth != 'none') {
                  Future<void> alert() {
                    return showDialog<void>(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Already Logged In'),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: const <Widget>[
                                  Text(''),
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
                        });
                  }

                  alert();
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                }
              },
            ),
          ),
          Card(
            child: ListTile(
              title: Text(
                'Logout',
                style: TextStyle(
                  fontSize: 25,
                  letterSpacing: 0.7,
                  color: Colors.red[900],
                ),
              ),
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                Future<void> _confirmDialog() async {
                  return showDialog<void>(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Logging Out'),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: const <Widget>[
                              Text('Are you sure you want to log out?'),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('No'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: const Text('Yes'),
                            onPressed: () {
                              prefs.setString('username', 'none');
                              prefs.setString('password', 'none');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomePage()),
                              );
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                }

                _confirmDialog();
              },
            ),
          ),
        ],
      ),
    );
  }
}
