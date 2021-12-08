import 'package:cst/models/homedata.dart';
import 'package:cst/services/api.dart';
import 'package:cst/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<Homedata> futurehome;
  TextEditingController filtEditingController = TextEditingController();
  final filt = ValueNotifier<String>("");

  @override
  void initState() {
    super.initState();
    futurehome = fetchHome();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[100],
      appBar: AppBar(
        title: const Text('Home'),
      ),
      drawer: NavigationDrawerWidget(),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            height: 1.5 * (MediaQuery.of(context).size.height / 20),
            width: 5 * (MediaQuery.of(context).size.width),
            margin: const EdgeInsets.only(top: 5, bottom: 15),
            decoration: BoxDecoration(
              color: Colors.blueAccent[400],
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text("Welcome to Covid Status Tracker",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height / 30,
                    letterSpacing: 1.0,
                    color: Colors.white)),
          ),
          FutureBuilder<Homedata>(
            future: futurehome,
            builder: (context, homeD) {
              if (homeD.data != null) {
                if (homeD.data!.isauth) {
                  return SizedBox(
                    child: Column(
                      children: <Widget>[
                        Text('Hello ' + homeD.data!.user + '!',
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height / 40,
                                letterSpacing: 1.0,
                                color: Colors.blue[900])),
                      ],
                    ),
                  );
                } else {
                  return SizedBox(
                    child: Column(
                      children: <Widget>[
                        Text('Please Login to access all features',
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height / 40,
                                letterSpacing: 1.0,
                                color: Colors.blue[900])),
                      ],
                    ),
                  );
                }
              } else {
                return const Text('Loading.....');
              }
            },
          ),
          Container(
            alignment: Alignment.center,
            height: 1 * (MediaQuery.of(context).size.height / 20),
            width: 3 * (MediaQuery.of(context).size.width),
            margin: const EdgeInsets.only(top: 15, left: 30, right: 30),
            decoration: BoxDecoration(
              color: Colors.blueAccent[200],
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text("Find all Covid contacts here",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height / 40,
                    letterSpacing: 1.0,
                    color: Colors.white)),
          ),
          Container(
              alignment: Alignment.center,
              height: 1.4 * (MediaQuery.of(context).size.height / 20),
              width: 5 * (MediaQuery.of(context).size.width),
              margin: const EdgeInsets.only(top: 15),
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(children: [
                Container(
                  alignment: Alignment.center,
                  height: 1.4 * (MediaQuery.of(context).size.height / 20),
                  width: 5 * (MediaQuery.of(context).size.width / 7),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextFormField(
                    controller: filtEditingController,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(
                      color: Colors.black87,
                    ),
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(top: 14),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        hintText: 'Search by City'),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => {filt.value = filtEditingController.text},
                  child: const Text('Search'),
                )
              ])),
          ValueListenableBuilder(
              valueListenable: filt,
              builder: (context, value, widget) {
                return Expanded(
                    child: FutureBuilder<Homedata>(
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
                            if (homeD.data!.contacts[index].city
                                .toLowerCase()
                                .contains(filt.value.toLowerCase())) {
                              return Card(
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      children: [
                                        Flexible(
                                          flex: 1,
                                          fit: FlexFit.tight,
                                          child: SizedBox(
                                            height: 30,
                                            child: Text(
                                              "City",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height /
                                                          50,
                                                  letterSpacing: 1.0,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          flex: 1,
                                          fit: FlexFit.tight,
                                          child: SizedBox(
                                            height: 30,
                                            child: Text(
                                              homeD.data!.contacts[index].city,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height /
                                                          50,
                                                  letterSpacing: 1.0,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Flexible(
                                          flex: 1,
                                          fit: FlexFit.tight,
                                          child: SizedBox(
                                            height: 30,
                                            child: Text(
                                              'Name of PHI',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height /
                                                          50,
                                                  letterSpacing: 1.0,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          flex: 1,
                                          fit: FlexFit.tight,
                                          child: SizedBox(
                                            height: 30,
                                            child: Text(
                                              homeD.data!.contacts[index]
                                                  .phiName,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height /
                                                          50,
                                                  letterSpacing: 1.0,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Flexible(
                                          flex: 1,
                                          fit: FlexFit.tight,
                                          child: SizedBox(
                                            height: 30,
                                            child: Text(
                                              'Contact Number of PHI',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height /
                                                          50,
                                                  letterSpacing: 1.0,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          flex: 1,
                                          fit: FlexFit.tight,
                                          child: Card(
                                            child: GestureDetector(
                                              onTap: () {
                                                launch(
                                                    "tel://${homeD.data!.contacts[index].phiNum}");
                                              },
                                              child: Text(
                                                homeD.data!.contacts[index]
                                                    .phiNum,
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            50,
                                                    letterSpacing: 1.0,
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Flexible(
                                          flex: 1,
                                          fit: FlexFit.tight,
                                          child: SizedBox(
                                            height: 30,
                                            child: Text(
                                              'Name of Police',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height /
                                                          50,
                                                  letterSpacing: 1.0,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          flex: 1,
                                          fit: FlexFit.tight,
                                          child: SizedBox(
                                            height: 30,
                                            child: Text(
                                              homeD.data!.contacts[index]
                                                  .polName,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height /
                                                          50,
                                                  letterSpacing: 1.0,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Flexible(
                                          flex: 1,
                                          fit: FlexFit.tight,
                                          child: SizedBox(
                                            height: 30,
                                            child: Text(
                                              'Contact Number of Police',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height /
                                                          50,
                                                  letterSpacing: 1.0,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          flex: 1,
                                          fit: FlexFit.tight,
                                          child: Card(
                                            child: GestureDetector(
                                              onTap: () {
                                                launch(
                                                    "tel://${homeD.data!.contacts[index].polNum}");
                                              },
                                              child: Text(
                                                homeD.data!.contacts[index]
                                                    .polNum,
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            50,
                                                    letterSpacing: 1.0,
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Flexible(
                                          flex: 1,
                                          fit: FlexFit.tight,
                                          child: SizedBox(
                                            height: 30,
                                            child: Text(
                                              'Name of Hospital',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height /
                                                          50,
                                                  letterSpacing: 1.0,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          flex: 1,
                                          fit: FlexFit.tight,
                                          child: SizedBox(
                                            height: 30,
                                            child: Text(
                                              homeD.data!.contacts[index]
                                                  .hospName,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height /
                                                          50,
                                                  letterSpacing: 1.0,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Flexible(
                                          flex: 1,
                                          fit: FlexFit.tight,
                                          child: SizedBox(
                                            height: 30,
                                            child: Text(
                                              'Contact Number of Hospital',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height /
                                                          55,
                                                  letterSpacing: 1.0,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          flex: 1,
                                          fit: FlexFit.tight,
                                          child: Card(
                                            child: GestureDetector(
                                              onTap: () {
                                                launch(
                                                    "tel://${homeD.data!.contacts[index].hospNum}");
                                              },
                                              child: Text(
                                                homeD.data!.contacts[index]
                                                    .hospNum,
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            50,
                                                    letterSpacing: 1.0,
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              return const SizedBox(width: 0.0, height: 0.0);
                            }
                          },
                        ),
                      );
                    } else {
                      return const Text('Loading.....');
                    }
                  },
                ));
              })
        ],
      ),
    );
  }

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
