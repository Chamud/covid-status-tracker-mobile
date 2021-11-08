import 'package:cst/models/homedata.dart';
import 'package:cst/services/api.dart';
import 'package:flutter/material.dart';
//import 'dart:convert';

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
      body: Column(
        children: <Widget>[
          const Text('Welcome to Covid Status Tracker'),
          FutureBuilder<Homedata>(
            future: futurehome,
            builder: (context, homeD) {
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
                          Text('City : ' + homeD.data!.contacts[index].city),
                          Text('Name of PHI : ' +
                              homeD.data!.contacts[index].phiName),
                          Text('Contact Number of PHI : ' +
                              homeD.data!.contacts[index].phiNum),
                          Text('Name of Hopital : ' +
                              homeD.data!.contacts[index].hospName),
                          Text('Contact Number of Hospital : ' +
                              homeD.data!.contacts[index].hospNum),
                          Text('Name of Police : ' +
                              homeD.data!.contacts[index].polName),
                          Text('Contact Number of Police : ' +
                              homeD.data!.contacts[index].polNum),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
