import 'package:cst/models/homedata.dart';
import 'package:cst/services/api.dart';
import 'package:cst/widges/drawer.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<Homedata> futurehome;
  @override
  void initState() {
    super.initState();
    futurehome = fetchHome();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      drawer: const NavigationDrawerWidget(),
      body: Column(
        children: <Widget>[
          const Text('Welcome to Covid Status Tracker'),
          FutureBuilder<Homedata>(
            future: futurehome,
            builder: (context, homeD) {
              if (homeD.data != null) {
                if (homeD.data!.isauth) {
                  return Card(
                    child: Column(
                      children: <Widget>[
                        Text('Hello' + homeD.data!.user),
                      ],
                    ),
                  );
                } else {
                  return Card(
                    child: Column(
                      children: const <Widget>[
                        Text('Please Login to access all features'),
                      ],
                    ),
                  );
                }
              } else {
                return const Text('Loading.....');
              }
            },
          ),
          SizedBox(
            height: 200,
            child: Card(
              semanticContainer: true,
              child: Column(
                children: const <Widget>[
                  Text('How to use'),
                ],
              ),
            ),
          ),
          FutureBuilder<Homedata>(
            future: futurehome,
            builder: (context, homeD) {
              if (homeD.data != null) {
                return SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: homeD.data!.contacts.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: [
                                const Card(
                                  child: Text('City'),
                                ),
                                Card(
                                  child: Text(homeD.data!.contacts[index].city),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Card(
                                  child: Text('Name of PHI'),
                                ),
                                Card(
                                  child:
                                      Text(homeD.data!.contacts[index].phiName),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Card(
                                  child: Text('Contact Number of PHI'),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    launch(
                                        "tel://${homeD.data!.contacts[index].phiNum}");
                                  },
                                  child: Card(
                                    child: Text(
                                        homeD.data!.contacts[index].phiNum),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Card(
                                  child: Text('Name of Police'),
                                ),
                                Card(
                                  child:
                                      Text(homeD.data!.contacts[index].polName),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Card(
                                  child: Text('Contact Number of Police'),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    launch(
                                        "tel://${homeD.data!.contacts[index].polNum}");
                                  },
                                  child: Card(
                                    child: Text(
                                        homeD.data!.contacts[index].polNum),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Card(
                                  child: Text('Name of Hopital'),
                                ),
                                Card(
                                  child: Text(
                                      homeD.data!.contacts[index].hospName),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Card(
                                  child: Text('Contact Number of Hospital'),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    launch(
                                        "tel://${homeD.data!.contacts[index].hospNum}");
                                  },
                                  child: Card(
                                    child: Text(
                                        homeD.data!.contacts[index].hospNum),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              } else {
                return const Text('Loading.....');
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
