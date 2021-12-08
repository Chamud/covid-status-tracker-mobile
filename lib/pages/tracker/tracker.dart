import 'dart:convert';
import 'package:cst/models/trackerdata.dart';
import 'package:cst/pages/tracker/dailysession.dart';
import 'package:http/http.dart' as http;
import 'package:cst/services/api.dart';
import 'package:cst/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:url_launcher/url_launcher.dart';

// ignore: camel_case_types
class tracker extends StatefulWidget {
  const tracker({Key? key}) : super(key: key);

  @override
  Trackerstate createState() => Trackerstate();
}

class Trackerstate extends State<tracker> {
  String mainURL = 'https://covidstatustracker.herokuapp.com/api/';
  late Future<Trackerdata> session;
  @override
  void initState() {
    super.initState();
    session = fetchTracker();
  }

  Widget _buildcard1(data) {
    return Center(
      child: SizedBox(
        width: 350,
        child: Card(
          color: Colors.green[100],
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                subtitle: Text(
                  data.pmsg,
                  style: const TextStyle(
                    fontSize: 17,
                    letterSpacing: 0.7,
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton() {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: <
        Widget>[
      Container(
        alignment: Alignment.center,
        height: 3 * (MediaQuery.of(context).size.height / 40),
        width: 5 * (MediaQuery.of(context).size.width / 6),
        margin: const EdgeInsets.only(bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Container(margin: const EdgeInsets.only(top: 30)),
              ElevatedButton(
                onPressed: () {
                  fetchSession() async {
                    const String mainURL =
                        'https://covidstatustracker.herokuapp.com/api/';
                    final prefs = await SharedPreferences.getInstance();
                    final un = prefs.getString('username') ?? 'none';
                    final pw = prefs.getString('password') ?? 'none';
                    var url = mainURL +
                        'daily_session?username=' +
                        un +
                        '&password=' +
                        pw;
                    http.Response response = await http.get(
                      Uri.parse(url),
                    );
                    if (response.statusCode == 200) {
                      Map<String, dynamic> responseJson =
                          json.decode(response.body);
                      if (responseJson['Message'] == 'Success') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DailySession()),
                        );
                      } else {
                        Future<void> _showMyDialog() async {
                          return showDialog<void>(
                            context: context,
                            barrierDismissible: true,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Access Denied!'),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: <Widget>[
                                      Text(responseJson['Message']),
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

                  fetchSession();
                },
                child: const Text('Add Daily Session'),
                style: ElevatedButton.styleFrom(primary: Colors.green),
              ),
            ]),
          ],
        ),
      ),
    ]);
  }

  Widget _buildtitle2(data) {
    var rses = List.from(data.sessions.reversed);
    var title = '';
    return ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        shrinkWrap: true,
        itemCount: rses.length,
        itemBuilder: (context, index) {
          if (rses[index].fndate == "") {
            title = 'Ongoing Session :\nSession Number ' + rses[index].number;
          } else {
            title = 'Past Session :\nSession Number ' + rses[index].number;
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      title,
                      style: const TextStyle(
                          fontSize: 20,
                          letterSpacing: 1.0,
                          color: Colors.green),
                    ),
                  ],
                ),
              ),
              _buildcard2(rses[index].dates),
              _buildButton1(rses[index].fndate),
            ],
          );
        });
  }

  Widget _buildcard2(date) {
    return ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        shrinkWrap: true,
        itemCount: date.length,
        itemBuilder: (context, index) {
          var symptoms =
              'Body Temperature : ' + date[index].inputs[9].toString() + '°C';
          var sore = date[index].inputs[7];
          if (sore > 1) {
            symptoms += '\nSore Throat : ';
            if (sore > 7) {
              symptoms += 'Severe';
            } else if (sore > 4) {
              symptoms += 'Painful';
            } else {
              symptoms += 'Mild';
            }
          }
          var head = date[index].inputs[8];
          if (head > 1) {
            symptoms += '\nHeadache : ';
            if (head > 7) {
              symptoms += 'Severe';
            } else if (head > 4) {
              symptoms += 'Painful';
            } else {
              symptoms += 'Mild';
            }
          }
          var cold = date[index].inputs[2];
          if (cold > 1) {
            symptoms += '\nCold : ';
            if (cold > 6) {
              symptoms += 'Severe';
            } else {
              symptoms += 'Mild';
            }
          }
          var pain = date[index].inputs[3];
          if (pain > 1) {
            symptoms += '\nPain in Joints : ';
            if (pain > 7) {
              symptoms += 'Severe';
            } else if (pain > 4) {
              symptoms += 'Painful';
            } else {
              symptoms += 'Mild';
            }
          }
          var weak = date[index].inputs[4];
          if (weak > 1) {
            symptoms += '\nFeeling weak : ';
            if (weak > 6) {
              symptoms += 'Often';
            } else {
              symptoms += 'Occasional';
            }
          }
          var app = date[index].inputs[5];
          if (app > 1) {
            symptoms += '\nLoss of Appetite : ';
            if (app > 6) {
              symptoms += 'Always';
            } else {
              symptoms += 'Occasional';
            }
          }
          var cough = date[index].inputs[10];
          if (cough > 1) {
            symptoms += '\nDry Cough : ';
            if (cough > 7) {
              symptoms += 'Severe';
            } else if (cough > 4) {
              symptoms += 'Painful';
            } else {
              symptoms += 'Mild';
            }
          }
          var dysp = date[index].inputs[11];
          if (dysp > 1) {
            symptoms += '\nDyspnea : ';
            if (dysp > 7) {
              symptoms += 'Severe';
            } else if (dysp > 4) {
              symptoms += 'Often';
            } else {
              symptoms += 'Occasional';
            }
          }
          var abd = date[index].inputs[6];
          if (abd > 1) {
            symptoms += '\nAbdominal Pain : ';
            if (abd > 7) {
              symptoms += 'Severe';
            } else if (abd > 4) {
              symptoms += 'Painful';
            } else {
              symptoms += 'Mild';
            }
          }
          var ns = date[index].inputs[12];
          if (ns > 1) {
            symptoms += '\nNausea : ';
            if (ns > 6) {
              symptoms += 'Severe';
            } else {
              symptoms += 'Mild';
            }
          }
          var vmt = date[index].inputs[13];
          if (vmt > 1) {
            symptoms += '\nVomiting : ';
            if (vmt > 6) {
              symptoms += 'Often';
            } else {
              symptoms += 'Occasional';
            }
          }
          var dr = date[index].inputs[14];
          if (dr > 1) {
            symptoms += '\nDiarrhea : ';
            if (dr > 6) {
              symptoms += 'Severe';
            } else {
              symptoms += 'Mild';
            }
          }
          var conc = date[index].results[11];
          return Center(
            child: SizedBox(
              width: 300,
              child: Card(
                shape: const RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black, width: 1),
                ),
                color: Colors.white,
                child:
                    Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(children: [
                        Text(
                          "Recorded Date",
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height / 40,
                              letterSpacing: 1.0,
                              color: Colors.grey),
                        ),
                        Text(
                          date[index].inputs[0],
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height / 40,
                              letterSpacing: 1.0,
                              color: Colors.black),
                        ),
                      ])),
                  Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(children: [
                        Text(
                          "Recorded Time",
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height / 40,
                              letterSpacing: 1.0,
                              color: Colors.grey),
                        ),
                        Text(
                          date[index].inputs[1],
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height / 40,
                              letterSpacing: 1.0,
                              color: Colors.black),
                        ),
                      ])),
                  Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(children: [
                        Text(
                          "Recorded Symptoms",
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height / 40,
                              letterSpacing: 1.0,
                              color: Colors.grey),
                        ),
                      ])),
                  Padding(
                      padding:
                          const EdgeInsets.only(top: 0.0, bottom: 10, left: 30),
                      child: Row(children: [
                        Text(
                          symptoms,
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height / 45,
                              letterSpacing: 1.0,
                              color: Colors.black),
                        ),
                      ])),
                  Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(children: [
                        Text(
                          "Conclusion",
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height / 40,
                              letterSpacing: 1.0,
                              color: Colors.grey),
                        ),
                        Text(
                          conc,
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height / 40,
                              letterSpacing: 1.0,
                              color: Colors.black),
                        ),
                      ])),
                ]),
              ),
            ),
          );
        });
  }

  Widget _buildButton1(fndate) {
    if (fndate == '') {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              height: 8 * (MediaQuery.of(context).size.height / 40),
              width: 5 * (MediaQuery.of(context).size.width / 6),
              margin: const EdgeInsets.only(bottom: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(margin: const EdgeInsets.only(top: 30)),
                        ElevatedButton(
                          onPressed: () {
                            endses() async {
                              const String mainURL =
                                  'https://covidstatustracker.herokuapp.com/api/';
                              final prefs =
                                  await SharedPreferences.getInstance();
                              final un = prefs.getString('username') ?? 'none';
                              final pw = prefs.getString('password') ?? 'none';
                              var url = mainURL +
                                  'tracker?username=' +
                                  un +
                                  '&password=' +
                                  pw;
                              var reqBody = {
                                'EndSession': 'End this session',
                              };
                              http.Response response = await http.post(
                                Uri.parse(url),
                                body: reqBody,
                              );
                              if (response.statusCode == 200) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const tracker()),
                                );
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
                                              Text(
                                                  'Failed to connect to the server.'),
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

                            Future<void> _confirmDialog() async {
                              return showDialog<void>(
                                context: context,
                                barrierDismissible: true,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Ending Session'),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: const <Widget>[
                                          Text(
                                              'Are you sure you want to end this session?'),
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
                                          endses();
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
                          child: const Text('End this Session'),
                          style: ElevatedButton.styleFrom(primary: Colors.red),
                        ),
                      ]),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "End this session only if you are fully recovered or under proper treatements",
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height / 40,
                            letterSpacing: 0.6,
                            color: Colors.red,
                          ),
                        ),
                      ])
                ],
              ),
            ),
          ]);
    } else {
      return const SizedBox(width: 0.0, height: 0.0);
    }
  }

  Widget _buildButton2() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            height: 3 * (MediaQuery.of(context).size.height / 40),
            width: 5 * (MediaQuery.of(context).size.width / 6),
            margin: const EdgeInsets.only(bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(margin: const EdgeInsets.only(top: 30)),
                      ElevatedButton(
                        onPressed: () async {
                          final prefs = await SharedPreferences.getInstance();
                          final un = prefs.getString('username') ?? 'none';
                          final pw = prefs.getString('password') ?? 'none';
                          launch(
                              'http://covidstatustracker.herokuapp.com/api/print_report?username=' +
                                  un +
                                  '&password=' +
                                  pw);
                        },
                        child: Text(
                          "Download report",
                          style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 1.5,
                            fontSize: MediaQuery.of(context).size.height / 40,
                          ),
                        ),
                      ),
                    ]),
              ],
            ),
          ),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.lightBlue[50],
        appBar: AppBar(
          title: const Text('Symptom Tracker'),
        ),
        drawer: NavigationDrawerWidget(),
        body: SingleChildScrollView(
          child: FutureBuilder<Trackerdata>(
              future: session,
              builder: (context, profD) {
                if (profD.data != null) {
                  return Column(children: <Widget>[
                    _buildcard1(profD.data!),
                    _buildButton(),
                    FractionallySizedBox(
                        widthFactor: 0.8, child: _buildtitle2(profD.data!)),
                    _buildButton2(),
                  ]);
                } else {
                  return const Text("Loading...",
                      textScaleFactor: 2,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center);
                }
              }),
        ),
      ),
    );
  }
}
