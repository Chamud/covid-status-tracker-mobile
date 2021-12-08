import 'package:cst/models/profdata.dart';
import 'package:cst/services/api.dart';
import 'package:cst/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'editprofile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<Profiledata> futureprof;

  @override
  void initState() {
    super.initState();
    futureprof = fetchProf();
  }

  Widget _buildeditButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 1.4 * (MediaQuery.of(context).size.height / 20),
          width: 4 * (MediaQuery.of(context).size.width / 7),
          margin: const EdgeInsets.only(bottom: 15),
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const EditProfilePage()),
              );
            },
            child: Text(
              "Edit profile",
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 1.5,
                fontSize: MediaQuery.of(context).size.height / 40,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildresetpasswordButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 1.4 * (MediaQuery.of(context).size.height / 20),
          width: 4 * (MediaQuery.of(context).size.width / 7),
          margin: const EdgeInsets.only(bottom: 10),
          child: ElevatedButton(
            onPressed: () {
              launch(
                  "https://covidstatustracker.herokuapp.com/reset_password/");
            },
            child: Text(
              "Reset Password",
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 1.5,
                fontSize: MediaQuery.of(context).size.height / 40,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildContainer2() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(margin: const EdgeInsets.only(top: 30)),
                ],
              ),
              _buildeditButton(),
              _buildresetpasswordButton(),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      drawer: NavigationDrawerWidget(),
      body: SingleChildScrollView(
          child: FutureBuilder<Profiledata>(
              future: futureprof,
              builder: (context, profD) {
                if (profD.data != null) {
                  if (profD.data!.msg != 'Success') {
                    return AlertDialog(
                      title: const Text('No Data'),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: const <Widget>[
                            Text('Please add profile details first'),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const EditProfilePage()),
                            );
                          },
                        ),
                      ],
                    );
                  } else {
                    return Column(children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Table(
                          textDirection: TextDirection.ltr,
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.top,
                          children: [
                            TableRow(children: [
                              Text(profD.data!.fname + ' ' + profD.data!.lname,
                                  textScaleFactor: 2,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue[900]),
                                  textAlign: TextAlign.center),
                            ]),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Table(
                          textDirection: TextDirection.ltr,
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.top,
                          border: TableBorder.all(
                            width: 1.0,
                            color: Colors.grey,
                          ),
                          children: [
                            TableRow(
                                decoration:
                                    BoxDecoration(color: Colors.grey[200]),
                                children: const [
                                  Text("Account Details",
                                      textScaleFactor: 2,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center)
                                ]),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Table(
                          textDirection: TextDirection.ltr,
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.top,
                          border: TableBorder.all(
                            width: 1.0,
                            color: Colors.grey,
                          ),
                          children: [
                            TableRow(
                                decoration:
                                    const BoxDecoration(color: Colors.white),
                                children: [
                                  const Text(" Account ID",
                                      textScaleFactor: 1.2),
                                  Text(profD.data!.id.toString(),
                                      textScaleFactor: 1.2),
                                ]),
                            TableRow(
                                decoration:
                                    const BoxDecoration(color: Colors.white),
                                children: [
                                  const Text(" Username", textScaleFactor: 1.2),
                                  Text(profD.data!.username,
                                      textScaleFactor: 1.2),
                                ]),
                            TableRow(
                                decoration:
                                    const BoxDecoration(color: Colors.white),
                                children: [
                                  const Text(" Email", textScaleFactor: 1.2),
                                  Text(profD.data!.email, textScaleFactor: 1.2),
                                ]),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20.0, top: 30.0),
                        child: Table(
                          textDirection: TextDirection.ltr,
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.top,
                          border: TableBorder.all(
                            width: 1.0,
                            color: Colors.grey,
                          ),
                          children: [
                            TableRow(
                                decoration:
                                    BoxDecoration(color: Colors.grey[200]),
                                children: const [
                                  Text("Personal Details",
                                      textScaleFactor: 2,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center)
                                ]),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Table(
                          textDirection: TextDirection.ltr,
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.top,
                          border: TableBorder.all(
                            width: 1.0,
                            color: Colors.grey,
                          ),
                          children: [
                            TableRow(
                                decoration:
                                    const BoxDecoration(color: Colors.white),
                                children: [
                                  const Text(" ID Number",
                                      textScaleFactor: 1.2),
                                  Text(profD.data!.idNum, textScaleFactor: 1.2),
                                ]),
                            TableRow(
                                decoration:
                                    const BoxDecoration(color: Colors.white),
                                children: [
                                  const Text(" Address", textScaleFactor: 1.2),
                                  Text(profD.data!.address,
                                      textScaleFactor: 1.2),
                                ]),
                            TableRow(
                                decoration:
                                    const BoxDecoration(color: Colors.white),
                                children: [
                                  const Text(" Date of Birth",
                                      textScaleFactor: 1.2),
                                  Text(profD.data!.dob, textScaleFactor: 1.2),
                                ]),
                            TableRow(
                                decoration:
                                    const BoxDecoration(color: Colors.white),
                                children: [
                                  const Text(" Contact Number",
                                      textScaleFactor: 1.2),
                                  Text(profD.data!.phoneNum,
                                      textScaleFactor: 1.2),
                                ]),
                            TableRow(
                                decoration:
                                    const BoxDecoration(color: Colors.white),
                                children: [
                                  const Text(" Vaccinated?",
                                      textScaleFactor: 1.2),
                                  Text(profD.data!.vaccinated,
                                      textScaleFactor: 1.2),
                                ]),
                            TableRow(
                                decoration:
                                    const BoxDecoration(color: Colors.white),
                                children: [
                                  const Text(" Corona patient?",
                                      textScaleFactor: 1.2),
                                  Text(profD.data!.covidPatient,
                                      textScaleFactor: 1.2),
                                ]),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20.0, top: 30.0),
                        child: Table(
                          textDirection: TextDirection.ltr,
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.top,
                          border: TableBorder.all(
                            width: 0,
                            color: Colors.grey,
                          ),
                          children: [
                            TableRow(
                                decoration:
                                    BoxDecoration(color: Colors.grey[200]),
                                children: const [
                                  Text(" Cardiovascular Disease",
                                      textScaleFactor: 1.2,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center)
                                ]),
                            TableRow(
                                decoration:
                                    const BoxDecoration(color: Colors.white),
                                children: [
                                  Text(
                                      profD.data!.cardD == ""
                                          ? 'Null'
                                          : profD.data!.cardD,
                                      textScaleFactor: 1.2),
                                ]),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20.0, top: 30.0),
                        child: Table(
                          textDirection: TextDirection.ltr,
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.top,
                          border: TableBorder.all(
                            width: 0,
                            color: Colors.grey,
                          ),
                          children: [
                            TableRow(
                                decoration:
                                    BoxDecoration(color: Colors.grey[200]),
                                children: const [
                                  Text(" Diabetes",
                                      textScaleFactor: 1.2,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center)
                                ]),
                            TableRow(
                                decoration:
                                    const BoxDecoration(color: Colors.white),
                                children: [
                                  Text(
                                      profD.data!.diab == ""
                                          ? 'Null'
                                          : profD.data!.diab,
                                      textScaleFactor: 1.2),
                                ]),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20.0, top: 30.0),
                        child: Table(
                          textDirection: TextDirection.ltr,
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.top,
                          border: TableBorder.all(
                            width: 0,
                            color: Colors.grey,
                          ),
                          children: [
                            TableRow(
                                decoration:
                                    BoxDecoration(color: Colors.grey[200]),
                                children: const [
                                  Text(" Chronic Respiratory Disease",
                                      textScaleFactor: 1.2,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center)
                                ]),
                            TableRow(
                                decoration:
                                    const BoxDecoration(color: Colors.white),
                                children: [
                                  Text(
                                      profD.data!.chronicRD == ""
                                          ? 'Null'
                                          : profD.data!.chronicRD,
                                      textScaleFactor: 1.2),
                                ]),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20.0, top: 30.0),
                        child: Table(
                          textDirection: TextDirection.ltr,
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.top,
                          border: TableBorder.all(
                            width: 0,
                            color: Colors.grey,
                          ),
                          children: [
                            TableRow(
                                decoration:
                                    BoxDecoration(color: Colors.grey[200]),
                                children: const [
                                  Text(" Cancer",
                                      textScaleFactor: 1.2,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center)
                                ]),
                            TableRow(
                                decoration:
                                    const BoxDecoration(color: Colors.white),
                                children: [
                                  Text(
                                      profD.data!.cancer == ""
                                          ? 'Null'
                                          : profD.data!.cancer,
                                      textScaleFactor: 1.2),
                                ]),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20.0, top: 30.0),
                        child: Table(
                          textDirection: TextDirection.ltr,
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.top,
                          border: TableBorder.all(
                            width: 0,
                            color: Colors.grey,
                          ),
                          children: [
                            TableRow(
                                decoration:
                                    BoxDecoration(color: Colors.grey[200]),
                                children: const [
                                  Text(" Other Diseases",
                                      textScaleFactor: 1.2,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center)
                                ]),
                            TableRow(
                                decoration:
                                    const BoxDecoration(color: Colors.white),
                                children: [
                                  Text(
                                      profD.data!.otherD == ""
                                          ? 'Null'
                                          : profD.data!.otherD,
                                      textScaleFactor: 1.2),
                                ]),
                          ],
                        ),
                      ),
                      _buildContainer2(),
                    ]);
                  }
                } else {
                  return const Text("Loading...",
                      textScaleFactor: 2,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center);
                }
              })),
    );
  }
}
