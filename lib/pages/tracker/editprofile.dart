import 'dart:convert';
import 'package:cst/models/profdata.dart';
import 'package:cst/pages/main/home.dart';
import 'package:cst/services/api.dart';
import 'package:cst/widgets/drawer.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late Future<Profiledata> futureprof;
  String idType = 'Other';
  String vacc = 'No';
  String covidPat = 'No';
  TextEditingController fnameEditingController = TextEditingController();
  TextEditingController lnameEditingController = TextEditingController();
  TextEditingController idNumEditingController = TextEditingController();
  TextEditingController addEditingController = TextEditingController();
  TextEditingController dobEditingController = TextEditingController();
  TextEditingController contEditingController = TextEditingController();
  TextEditingController cardDEditingController = TextEditingController();
  TextEditingController diabEditingController = TextEditingController();
  TextEditingController chronicResEditingController = TextEditingController();
  TextEditingController cancEditingController = TextEditingController();
  TextEditingController otherEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    futureprof = fetchProf();
    futureprof.then((result) {
      idType = result.idType;
      vacc = result.vaccinated;
      covidPat = result.covidPatient;

      fnameEditingController.text = result.fname;
      lnameEditingController.text = result.lname;
      idNumEditingController.text = result.idNum;
      addEditingController.text = result.address;
      dobEditingController.text = result.dob;
      contEditingController.text = result.phoneNum;
      cardDEditingController.text = result.cardD;
      diabEditingController.text = result.diab;
      chronicResEditingController.text = result.chronicRD;
      cancEditingController.text = result.cancer;
      otherEditingController.text = result.otherD;
    });
  }

  Widget _buildContainer2() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(0),
            ),
            child: FutureBuilder<Profiledata>(
                future: futureprof,
                builder: (context, profD) {
                  if (profD.data != null) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(margin: const EdgeInsets.only(top: 70)),
                            Text(
                              "Personal Details",
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height / 20,
                                letterSpacing: 0.8,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(0),
                                ),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                              margin: const EdgeInsets.only(
                                                  top: 0, bottom: 30)),
                                          Card(
                                            color: Colors.blue[200],
                                            child: Text(
                                              "Please complete the following form",
                                              style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    35,
                                                letterSpacing: 1.0,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ]),
                              ),
                            ]),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text("First Name"),
                              const SizedBox(
                                height: 10,
                                width: 5,
                              ),
                              Container(
                                alignment: Alignment.center,
                                height: 1.4 *
                                    (MediaQuery.of(context).size.height / 21),
                                width:
                                    5 * (MediaQuery.of(context).size.width / 7),
                                margin: const EdgeInsets.only(bottom: 20),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: TextFormField(
                                  minLines: 1,
                                  maxLines: 5,
                                  autocorrect: false,
                                  controller: fnameEditingController,
                                  keyboardType: TextInputType.text,
                                  style: const TextStyle(
                                    color: Colors.black87,
                                  ),
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(top: 5),
                                      hintText: 'First Name'),
                                ),
                              ),
                            ]),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text("Last Name"),
                              const SizedBox(height: 10, width: 5),
                              Container(
                                alignment: Alignment.center,
                                height: 1.4 *
                                    (MediaQuery.of(context).size.height / 21),
                                width:
                                    5 * (MediaQuery.of(context).size.width / 7),
                                margin: const EdgeInsets.only(bottom: 20),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: TextFormField(
                                  minLines: 1,
                                  maxLines: 5,
                                  autocorrect: false,
                                  controller: lnameEditingController,
                                  keyboardType: TextInputType.text,
                                  style: const TextStyle(
                                    color: Colors.black87,
                                  ),
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(top: 5),
                                      hintText: 'Last Name'),
                                ),
                              ),
                            ]),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text("Identity Number"),
                              const SizedBox(height: 10, width: 5),
                              Container(
                                alignment: Alignment.center,
                                height: 1.4 *
                                    (MediaQuery.of(context).size.height / 21),
                                width:
                                    5 * (MediaQuery.of(context).size.width / 7),
                                margin: const EdgeInsets.only(bottom: 20),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: TextFormField(
                                  autocorrect: false,
                                  controller: idNumEditingController,
                                  keyboardType: TextInputType.text,
                                  style: const TextStyle(
                                    color: Colors.black87,
                                  ),
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(top: 5),
                                      hintText: 'Identity Number'),
                                ),
                              ),
                            ]),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const SizedBox(height: 10, width: 5),
                              Container(
                                alignment: Alignment.center,
                                height: 1.4 *
                                    (MediaQuery.of(context).size.height / 21),
                                width:
                                    3 * (MediaQuery.of(context).size.width / 7),
                                margin:
                                    const EdgeInsets.only(bottom: 20, top: 0.5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    elevation: 16,
                                    value: idType,
                                    icon: const Icon(
                                        Icons.arrow_drop_down_circle),
                                    isExpanded: true,
                                    items: <String>[
                                      'Other',
                                      'NIC',
                                      'Passport',
                                    ].map((e) {
                                      return DropdownMenuItem(
                                        value: e,
                                        child: Text(e),
                                      );
                                    }).toList(),
                                    onChanged: (String? newvalue) {
                                      setState(() {
                                        idType = newvalue!;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ]),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text("Address"),
                              const SizedBox(height: 10, width: 5),
                              Container(
                                alignment: Alignment.center,
                                height: 1.4 *
                                    (MediaQuery.of(context).size.height / 21),
                                width:
                                    5 * (MediaQuery.of(context).size.width / 7),
                                margin: const EdgeInsets.only(bottom: 20),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: TextFormField(
                                  minLines: 1,
                                  maxLines: 5,
                                  autocorrect: false,
                                  controller: addEditingController,
                                  keyboardType: TextInputType.text,
                                  style: const TextStyle(
                                    color: Colors.black87,
                                  ),
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(top: 5),
                                      hintText: 'Address'),
                                ),
                              ),
                            ]),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text("Date-of-Birth"),
                              const SizedBox(height: 10, width: 5),
                              Container(
                                alignment: Alignment.center,
                                height: 1.4 *
                                    (MediaQuery.of(context).size.height / 21),
                                width:
                                    5 * (MediaQuery.of(context).size.width / 7),
                                margin: const EdgeInsets.only(bottom: 20),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: TextFormField(
                                  autocorrect: false,
                                  controller: dobEditingController,
                                  keyboardType: TextInputType.text,
                                  style: const TextStyle(
                                    color: Colors.black87,
                                  ),
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(top: 5),
                                      hintText: 'Date-of-Birth'),
                                ),
                              ),
                            ]),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text("Contact Number"),
                              const SizedBox(height: 10, width: 5),
                              Container(
                                alignment: Alignment.center,
                                height: 1.4 *
                                    (MediaQuery.of(context).size.height / 21),
                                width:
                                    5 * (MediaQuery.of(context).size.width / 7),
                                margin: const EdgeInsets.only(bottom: 20),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: TextFormField(
                                  autocorrect: false,
                                  controller: contEditingController,
                                  keyboardType: TextInputType.text,
                                  style: const TextStyle(
                                    color: Colors.black87,
                                  ),
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(top: 5),
                                      hintText: 'Contact Number'),
                                ),
                              ),
                            ]),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text("Vaccinated?"),
                              const SizedBox(height: 10, width: 5),
                              Container(
                                alignment: Alignment.center,
                                height: 1.4 *
                                    (MediaQuery.of(context).size.height / 21),
                                width:
                                    5 * (MediaQuery.of(context).size.width / 7),
                                margin: const EdgeInsets.only(bottom: 20),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    value: vacc,
                                    elevation: 16,
                                    icon: const Icon(
                                        Icons.arrow_drop_down_circle),
                                    isExpanded: true,
                                    items: <String>['No', 'Dose1', 'Dose2']
                                        .map((e) {
                                      return DropdownMenuItem(
                                        value: e,
                                        child: Text(e),
                                      );
                                    }).toList(),
                                    onChanged: (String? value) {
                                      setState(() {
                                        vacc = value!;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ]),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text("Have you been affected by Covid?"),
                              const SizedBox(height: 10, width: 5),
                              Container(
                                alignment: Alignment.center,
                                height: 1.4 *
                                    (MediaQuery.of(context).size.height / 21),
                                width:
                                    5 * (MediaQuery.of(context).size.width / 7),
                                margin: const EdgeInsets.only(bottom: 20),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    value: covidPat,
                                    elevation: 16,
                                    icon: const Icon(
                                        Icons.arrow_drop_down_circle),
                                    isExpanded: true,
                                    items: <String>[
                                      'No',
                                      'Suspect',
                                      'Patient',
                                      'Recovered'
                                    ].map((e) {
                                      return DropdownMenuItem(
                                        value: e,
                                        child: Text(e),
                                      );
                                    }).toList(),
                                    onChanged: (String? value) {
                                      setState(() {
                                        covidPat = value!;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(0),
                                ),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.2,
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white24),
                                    color: Colors.white70,
                                  ),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                                margin: const EdgeInsets.only(
                                                    top: 30)),
                                            Text(
                                              "If you have any major health conditions",
                                              style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    45,
                                                letterSpacing: 1.0,
                                                color: Colors.blue,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "please state them below.",
                                          style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                45,
                                            letterSpacing: 1.0,
                                            color: Colors.blue,
                                          ),
                                        ),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(0),
                                                ),
                                                child: Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.07,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.6,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.white24),
                                                    color: Colors.white,
                                                  ),
                                                  child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: <Widget>[
                                                              Container(
                                                                  margin: const EdgeInsets
                                                                          .only(
                                                                      top: 30)),
                                                              Text(
                                                                "Leave blank if none.",
                                                                style: TextStyle(
                                                                    fontSize: MediaQuery.of(context)
                                                                            .size
                                                                            .height /
                                                                        45,
                                                                    letterSpacing:
                                                                        1.0,
                                                                    color: Colors
                                                                        .orange),
                                                              ),
                                                            ]),
                                                      ]),
                                                ),
                                              ),
                                            ]),
                                      ]),
                                ),
                              ),
                            ]),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: const EdgeInsets.only(top: 20),
                              ),
                              const Text("Cardiovascular Disease"),
                            ]),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const SizedBox(height: 10, width: 5),
                              Container(
                                alignment: Alignment.center,
                                height: 1.4 *
                                    (MediaQuery.of(context).size.height / 21),
                                width:
                                    5 * (MediaQuery.of(context).size.width / 7),
                                margin: const EdgeInsets.only(bottom: 20),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: TextFormField(
                                  minLines: 1,
                                  maxLines: 5,
                                  autocorrect: false,
                                  controller: cardDEditingController,
                                  keyboardType: TextInputType.text,
                                  style: const TextStyle(
                                    color: Colors.black87,
                                  ),
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(top: 5),
                                      hintText: 'Description'),
                                ),
                              ),
                            ]),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: const EdgeInsets.only(top: 20),
                              ),
                              const Text("Diabetes"),
                            ]),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const SizedBox(height: 10, width: 5),
                              Container(
                                alignment: Alignment.center,
                                height: 1.4 *
                                    (MediaQuery.of(context).size.height / 21),
                                width:
                                    5 * (MediaQuery.of(context).size.width / 7),
                                margin: const EdgeInsets.only(bottom: 20),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: TextFormField(
                                  minLines: 1,
                                  maxLines: 5,
                                  autocorrect: false,
                                  controller: diabEditingController,
                                  keyboardType: TextInputType.text,
                                  style: const TextStyle(
                                    color: Colors.black87,
                                  ),
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(top: 5),
                                      hintText: 'Description'),
                                ),
                              ),
                            ]),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: const EdgeInsets.only(top: 20),
                              ),
                              const Text("Chronic Respiratory Disease"),
                            ]),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const SizedBox(height: 10, width: 5),
                              Container(
                                alignment: Alignment.center,
                                height: 1.4 *
                                    (MediaQuery.of(context).size.height / 21),
                                width:
                                    5 * (MediaQuery.of(context).size.width / 7),
                                margin: const EdgeInsets.only(bottom: 20),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: TextFormField(
                                  minLines: 1,
                                  maxLines: 5,
                                  autocorrect: false,
                                  controller: chronicResEditingController,
                                  keyboardType: TextInputType.text,
                                  style: const TextStyle(
                                    color: Colors.black87,
                                  ),
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(top: 5),
                                      hintText: 'Description'),
                                ),
                              ),
                            ]),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: const EdgeInsets.only(top: 20),
                              ),
                              const Text("Cancer"),
                            ]),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const SizedBox(height: 10, width: 5),
                              Container(
                                alignment: Alignment.center,
                                height: 1.4 *
                                    (MediaQuery.of(context).size.height / 21),
                                width:
                                    5 * (MediaQuery.of(context).size.width / 7),
                                margin: const EdgeInsets.only(bottom: 20),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: TextFormField(
                                  minLines: 1,
                                  maxLines: 5,
                                  autocorrect: false,
                                  controller: cancEditingController,
                                  keyboardType: TextInputType.text,
                                  style: const TextStyle(
                                    color: Colors.black87,
                                  ),
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(top: 5),
                                      hintText: 'Description'),
                                ),
                              ),
                            ]),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: const EdgeInsets.only(top: 20),
                              ),
                              const Text("Other Diseases/Special Conditions"),
                            ]),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const SizedBox(height: 10, width: 5),
                              Container(
                                alignment: Alignment.center,
                                height: 1.4 *
                                    (MediaQuery.of(context).size.height / 21),
                                width:
                                    5 * (MediaQuery.of(context).size.width / 7),
                                margin: const EdgeInsets.only(bottom: 20),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: TextFormField(
                                  minLines: 1,
                                  maxLines: 5,
                                  autocorrect: false,
                                  controller: otherEditingController,
                                  keyboardType: TextInputType.text,
                                  style: const TextStyle(
                                    color: Colors.black87,
                                  ),
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(top: 5),
                                      hintText: 'Description'),
                                ),
                              ),
                            ]),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.only(bottom: 10),
                              height: 1.4 *
                                  (MediaQuery.of(context).size.height / 20),
                              width:
                                  3 * (MediaQuery.of(context).size.width / 7),
                              margin: const EdgeInsets.only(top: 20),
                              child: ElevatedButton(
                                onPressed: () {
                                  var prof = [
                                    fnameEditingController.text,
                                    lnameEditingController.text,
                                    idNumEditingController.text,
                                    idType,
                                    addEditingController.text,
                                    dobEditingController.text,
                                    contEditingController.text,
                                    vacc,
                                    covidPat,
                                    cardDEditingController.text,
                                    diabEditingController.text,
                                    chronicResEditingController.text,
                                    cancEditingController.text,
                                    otherEditingController.text,
                                  ];
                                  editProf(prof) async {
                                    const String mainURL =
                                        'https://covidstatustracker.herokuapp.com/api/';
                                    final prefs =
                                        await SharedPreferences.getInstance();
                                    final un =
                                        prefs.getString('username') ?? 'none';
                                    final pw =
                                        prefs.getString('password') ?? 'none';
                                    var url = mainURL +
                                        'edit_profile?username=' +
                                        un +
                                        '&password=' +
                                        pw;
                                    var reqBody = {
                                      'firstname': prof[0],
                                      'lastname': prof[1],
                                      'IDvalue': prof[2],
                                      'idtype': prof[3],
                                      'homeadd': prof[4],
                                      'dob': prof[5],
                                      'phone': prof[6],
                                      'vaccinated': prof[7],
                                      'covidstatus': prof[8],
                                      'carddis': prof[9],
                                      'diabdis': prof[10],
                                      'crddis': prof[11],
                                      'cancdis': prof[12],
                                      'othdis': prof[13],
                                    };
                                    http.Response response = await http.post(
                                      Uri.parse(url),
                                      body: reqBody,
                                    );
                                    if (response.statusCode == 200) {
                                      Map<String, dynamic> responseJson =
                                          json.decode(response.body);
                                      if (responseJson['Message'] ==
                                          'Success') {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const HomePage()),
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
                                                    children: <Widget>[
                                                      Text(responseJson[
                                                          'Message']),
                                                      const Text(
                                                          'Please try again later'),
                                                    ],
                                                  ),
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: const Text('OK'),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
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
                                                    Text(
                                                        'Failed to connect to the server.'),
                                                    Text(
                                                        'Please try again later'),
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

                                  editProf(prof);
                                },
                                child: Text(
                                  "save",
                                  style: TextStyle(
                                    color: Colors.white,
                                    letterSpacing: 1.5,
                                    fontSize:
                                        MediaQuery.of(context).size.height / 40,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    );
                  } else {
                    return const Text("Loading...",
                        textScaleFactor: 2,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center);
                  }
                })),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.lightBlueAccent,
        appBar: AppBar(
          title: const Text('Edit Profile'),
        ),
        drawer: NavigationDrawerWidget(),
        body: SingleChildScrollView(
          child: Column(children: <Widget>[
            _buildContainer2(),
          ]),
        ),
      ),
    );
  }
}
