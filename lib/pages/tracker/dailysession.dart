import 'dart:convert';

import 'package:cst/pages/tracker/tracker.dart';
import 'package:cst/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DailySession extends StatefulWidget {
  const DailySession({Key? key}) : super(key: key);

  @override
  _DailySessionState createState() => _DailySessionState();
}

class _DailySessionState extends State<DailySession> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController tempEditingController = TextEditingController();
  double valueBottom = 0;
  double valueBottom1 = 0;
  double valueBottom2 = 0;
  double valueBottom3 = 0;
  double valueBottom4 = 0;
  double valueBottom5 = 0;
  double valueBottom6 = 0;
  double valueBottom7 = 0;
  double valueBottom8 = 0;
  double valueBottom9 = 0;
  double valueBottom10 = 0;
  double valueBottom11 = 0;

  Widget _buildRow() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const <Widget>[
          Card(
            child: Text(
              "Enter Your Daily Symptom Data",
              style: TextStyle(
                fontSize: 25,
                letterSpacing: 0.6,
                color: Colors.blue,
              ),
            ),
          ),
        ]);
  }

  Widget _build0Row() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 10, width: 5),
          Container(
            alignment: Alignment.center,
            height: 3 * (MediaQuery.of(context).size.height / 21),
            width: 5 * (MediaQuery.of(context).size.width / 6),
            margin: const EdgeInsets.only(
              bottom: 20,
              top: 20,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey),
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(margin: const EdgeInsets.only(top: 30)),
                        Text(
                          "Temperature (35°C～40°C)",
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height / 40,
                              letterSpacing: 1.0,
                              color: Colors.black),
                        ),
                      ]),
                  Container(
                    alignment: Alignment.center,
                    height: 1.4 * (MediaQuery.of(context).size.height / 21),
                    width: 3 * (MediaQuery.of(context).size.width / 7),
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        controller: tempEditingController,
                        keyboardType: TextInputType.text,
                        style: const TextStyle(
                          color: Colors.black87,
                        ),
                        validator: (text) {
                          if (double.parse(text.toString()) >= 40.0 ||
                              double.parse(text.toString()) <= 35.0) {
                            return 'Invalid temperature';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(top: 5),
                        ),
                      ),
                    ),
                  )
                ]),
          ),
        ]);
  }

  Widget _build1Row() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 10, width: 5),
          Container(
            alignment: Alignment.center,
            height: 3 * (MediaQuery.of(context).size.height / 18),
            width: 5 * (MediaQuery.of(context).size.width / 6),
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey),
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(margin: const EdgeInsets.only(top: 30)),
                        Text(
                          "Headache",
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height / 40,
                              letterSpacing: 1.0,
                              color: Colors.black),
                        ),
                      ]),
                  Container(
                    margin:
                        const EdgeInsets.only(bottom: 0.2, left: 15, right: 15),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Container(
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(80),
                                color: Colors.grey[50],
                              ),
                              child: Text(
                                "No",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height / 40,
                                    letterSpacing: 1.0,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 3,
                            fit: FlexFit.tight,
                            child: Container(
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(80),
                                color: Colors.grey[50],
                                border: Border.all(
                                  color: Colors.green,
                                ),
                              ),
                              child: Text(
                                "Mild",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height / 40,
                                    letterSpacing: 1.0,
                                    color: Colors.green),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 3,
                            fit: FlexFit.tight,
                            child: Container(
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(80),
                                color: Colors.grey[50],
                                border: Border.all(
                                  color: Colors.yellow,
                                ),
                              ),
                              child: Text(
                                "Painful",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height / 40,
                                    letterSpacing: 1.0,
                                    color: Colors.yellow),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 3,
                            fit: FlexFit.tight,
                            child: Container(
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(80),
                                color: Colors.grey[50],
                                border: Border.all(
                                  color: Colors.red,
                                ),
                              ),
                              child: Text(
                                "Severe",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height / 40,
                                    letterSpacing: 1.0,
                                    color: Colors.red),
                              ),
                            ),
                          ),
                        ]),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 1),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Slider(
                              value: valueBottom,
                              min: 0,
                              max: 100,
                              divisions: 1000,
                              onChanged: (values) =>
                                  setState(() => valueBottom = values),
                            ),
                          ),
                        ]),
                  ),
                ]),
          ),
        ]);
  }

  Widget _build2Row() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            height: 3 * (MediaQuery.of(context).size.height / 18),
            width: 5 * (MediaQuery.of(context).size.width / 6),
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey),
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(margin: const EdgeInsets.only(top: 30)),
                        Text(
                          "Pain in Joints",
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height / 40,
                              letterSpacing: 1.0,
                              color: Colors.black),
                        ),
                      ]),
                  Container(
                    margin:
                        const EdgeInsets.only(bottom: 0.2, left: 15, right: 15),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Container(
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(80),
                                color: Colors.grey[50],
                              ),
                              child: Text(
                                "No",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height / 40,
                                    letterSpacing: 1.0,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 3,
                            fit: FlexFit.tight,
                            child: Container(
                              height: 30,
                              width: 10,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(80),
                                color: Colors.grey[50],
                                border: Border.all(
                                  color: Colors.green,
                                ),
                              ),
                              child: Text(
                                "Mild",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height / 40,
                                    letterSpacing: 1.0,
                                    color: Colors.green),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 3,
                            fit: FlexFit.tight,
                            child: Container(
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(80),
                                color: Colors.grey[50],
                                border: Border.all(
                                  color: Colors.yellow,
                                ),
                              ),
                              child: Text(
                                "Painful",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height / 40,
                                    letterSpacing: 1.0,
                                    color: Colors.yellow),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 3,
                            fit: FlexFit.tight,
                            child: Container(
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(80),
                                color: Colors.grey[50],
                                border: Border.all(
                                  color: Colors.red,
                                ),
                              ),
                              child: Text(
                                "Severe",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height / 40,
                                    letterSpacing: 1.0,
                                    color: Colors.red),
                              ),
                            ),
                          ),
                        ]),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 1),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Slider(
                              value: valueBottom1,
                              min: 0,
                              max: 100,
                              divisions: 1000,
                              onChanged: (values) =>
                                  setState(() => valueBottom1 = values),
                            ),
                          ),
                        ]),
                  ),
                ]),
          ),
        ]);
  }

  Widget _build3Row() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 10, width: 5),
          Container(
            alignment: Alignment.center,
            height: 3 * (MediaQuery.of(context).size.height / 18),
            width: 5 * (MediaQuery.of(context).size.width / 6),
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey),
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(margin: const EdgeInsets.only(top: 30)),
                        Text(
                          "Abdominal Pain",
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height / 40,
                              letterSpacing: 1.0,
                              color: Colors.black),
                        ),
                      ]),
                  Container(
                    margin:
                        const EdgeInsets.only(bottom: 0.2, left: 15, right: 15),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Container(
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(80),
                                color: Colors.grey[50],
                              ),
                              child: Text(
                                "No",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height / 40,
                                    letterSpacing: 1.0,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 3,
                            fit: FlexFit.tight,
                            child: Container(
                              height: 30,
                              width: 10,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(80),
                                color: Colors.grey[50],
                                border: Border.all(
                                  color: Colors.green,
                                ),
                              ),
                              child: Text(
                                "Mild",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height / 40,
                                    letterSpacing: 1.0,
                                    color: Colors.green),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 3,
                            fit: FlexFit.tight,
                            child: Container(
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(80),
                                color: Colors.grey[50],
                                border: Border.all(
                                  color: Colors.yellow,
                                ),
                              ),
                              child: Text(
                                "Painful",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height / 40,
                                    letterSpacing: 1.0,
                                    color: Colors.yellow),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 3,
                            fit: FlexFit.tight,
                            child: Container(
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(80),
                                color: Colors.grey[50],
                                border: Border.all(
                                  color: Colors.red,
                                ),
                              ),
                              child: Text(
                                "Severe",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height / 40,
                                    letterSpacing: 1.0,
                                    color: Colors.red),
                              ),
                            ),
                          ),
                        ]),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 1),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Slider(
                              value: valueBottom2,
                              min: 0,
                              max: 100,
                              divisions: 1000,
                              onChanged: (values) =>
                                  setState(() => valueBottom2 = values),
                            ),
                          ),
                        ]),
                  ),
                ]),
          ),
        ]);
  }

  Widget _build4Row() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 10, width: 5),
          Container(
            alignment: Alignment.center,
            height: 3 * (MediaQuery.of(context).size.height / 18),
            width: 5 * (MediaQuery.of(context).size.width / 6),
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey),
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(margin: const EdgeInsets.only(top: 30)),
                        Text(
                          "Sore Throat",
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height / 40,
                              letterSpacing: 1.0,
                              color: Colors.black),
                        ),
                      ]),
                  Container(
                    margin:
                        const EdgeInsets.only(bottom: 0.2, left: 15, right: 15),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Container(
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(80),
                                color: Colors.grey[50],
                              ),
                              child: Text(
                                "No",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height / 40,
                                    letterSpacing: 1.0,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 3,
                            fit: FlexFit.tight,
                            child: Container(
                              height: 30,
                              width: 10,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(80),
                                color: Colors.grey[50],
                                border: Border.all(
                                  color: Colors.green,
                                ),
                              ),
                              child: Text(
                                "Mild",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height / 40,
                                    letterSpacing: 1.0,
                                    color: Colors.green),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 3,
                            fit: FlexFit.tight,
                            child: Container(
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(80),
                                color: Colors.grey[50],
                                border: Border.all(
                                  color: Colors.yellow,
                                ),
                              ),
                              child: Text(
                                "Painful",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height / 40,
                                    letterSpacing: 1.0,
                                    color: Colors.yellow),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 3,
                            fit: FlexFit.tight,
                            child: Container(
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(80),
                                color: Colors.grey[50],
                                border: Border.all(
                                  color: Colors.red,
                                ),
                              ),
                              child: Text(
                                "Severe",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height / 40,
                                    letterSpacing: 1.0,
                                    color: Colors.red),
                              ),
                            ),
                          ),
                        ]),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 1),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Slider(
                              value: valueBottom3,
                              min: 0,
                              max: 100,
                              divisions: 1000,
                              onChanged: (values) =>
                                  setState(() => valueBottom3 = values),
                            ),
                          ),
                        ]),
                  ),
                ]),
          ),
        ]);
  }

  Widget _build5Row() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 10, width: 5),
          Container(
            alignment: Alignment.center,
            height: 3 * (MediaQuery.of(context).size.height / 18),
            width: 5 * (MediaQuery.of(context).size.width / 6),
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey),
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(margin: const EdgeInsets.only(top: 30)),
                        Text(
                          "Dry Cough",
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height / 40,
                              letterSpacing: 1.0,
                              color: Colors.black),
                        ),
                      ]),
                  Container(
                    margin:
                        const EdgeInsets.only(bottom: 0.2, left: 15, right: 15),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Container(
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(80),
                                color: Colors.grey[50],
                              ),
                              child: Text(
                                "No",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height / 40,
                                    letterSpacing: 1.0,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 3,
                            fit: FlexFit.tight,
                            child: Container(
                              height: 30,
                              width: 10,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(80),
                                color: Colors.grey[50],
                                border: Border.all(
                                  color: Colors.green,
                                ),
                              ),
                              child: Text(
                                "Mild",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height / 40,
                                    letterSpacing: 1.0,
                                    color: Colors.green),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 3,
                            fit: FlexFit.tight,
                            child: Container(
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(80),
                                color: Colors.grey[50],
                                border: Border.all(
                                  color: Colors.yellow,
                                ),
                              ),
                              child: Text(
                                "Painful",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height / 40,
                                    letterSpacing: 1.0,
                                    color: Colors.yellow),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 3,
                            fit: FlexFit.tight,
                            child: Container(
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(80),
                                color: Colors.grey[50],
                                border: Border.all(
                                  color: Colors.red,
                                ),
                              ),
                              child: Text(
                                "Severe",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height / 40,
                                    letterSpacing: 1.0,
                                    color: Colors.red),
                              ),
                            ),
                          ),
                        ]),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 1),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Slider(
                              value: valueBottom4,
                              min: 0,
                              max: 100,
                              divisions: 1000,
                              onChanged: (values) =>
                                  setState(() => valueBottom4 = values),
                            ),
                          ),
                        ]),
                  ),
                ]),
          ),
        ]);
  }

  Widget _build6Row() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 10, width: 5),
          Container(
            alignment: Alignment.center,
            height: 3 * (MediaQuery.of(context).size.height / 18),
            width: 5 * (MediaQuery.of(context).size.width / 6),
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey),
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(margin: const EdgeInsets.only(top: 30)),
                        Text(
                          "Dyspnea (Difficulty in breathing)",
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height / 40,
                              letterSpacing: 1.0,
                              color: Colors.black),
                        ),
                      ]),
                  Container(
                    margin:
                        const EdgeInsets.only(bottom: 0.2, left: 15, right: 15),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Container(
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(80),
                                color: Colors.grey[50],
                              ),
                              child: Text(
                                "No",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height / 40,
                                    letterSpacing: 1.0,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 3,
                            fit: FlexFit.tight,
                            child: Container(
                              height: 30,
                              width: 10,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(80),
                                color: Colors.grey[50],
                                border: Border.all(
                                  color: Colors.green,
                                ),
                              ),
                              child: Text(
                                "Occasional",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height / 50,
                                    letterSpacing: 1.0,
                                    color: Colors.green),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 3,
                            fit: FlexFit.tight,
                            child: Container(
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(80),
                                color: Colors.grey[50],
                                border: Border.all(
                                  color: Colors.yellow,
                                ),
                              ),
                              child: Text(
                                "Often",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height / 40,
                                    letterSpacing: 1.0,
                                    color: Colors.yellow),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 3,
                            fit: FlexFit.tight,
                            child: Container(
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(80),
                                color: Colors.grey[50],
                                border: Border.all(
                                  color: Colors.red,
                                ),
                              ),
                              child: Text(
                                "Severe",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height / 40,
                                    letterSpacing: 1.0,
                                    color: Colors.red),
                              ),
                            ),
                          ),
                        ]),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 1),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Slider(
                              value: valueBottom5,
                              min: 0,
                              max: 100,
                              divisions: 1000,
                              onChanged: (values) =>
                                  setState(() => valueBottom5 = values),
                            ),
                          ),
                        ]),
                  ),
                ]),
          ),
        ]);
  }

  Widget _build7Row() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 10, width: 5),
          Container(
            alignment: Alignment.center,
            height: 3 * (MediaQuery.of(context).size.height / 18),
            width: 5 * (MediaQuery.of(context).size.width / 6),
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey),
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(margin: const EdgeInsets.only(top: 30)),
                        Text(
                          "Cold",
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height / 40,
                              letterSpacing: 1.0,
                              color: Colors.black),
                        ),
                      ]),
                  Container(
                    margin:
                        const EdgeInsets.only(bottom: 0.2, left: 15, right: 15),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Container(
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(80),
                                color: Colors.grey[50],
                              ),
                              child: Text(
                                "No",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height / 40,
                                    letterSpacing: 1.0,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 5,
                            fit: FlexFit.tight,
                            child: Container(
                              height: 30,
                              width: 10,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(80),
                                color: Colors.grey[50],
                                border: Border.all(
                                  color: Colors.green,
                                ),
                              ),
                              child: Text(
                                "Mild",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height / 40,
                                    letterSpacing: 1.0,
                                    color: Colors.green),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 4,
                            fit: FlexFit.tight,
                            child: Container(
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(80),
                                color: Colors.grey[50],
                                border: Border.all(
                                  color: Colors.red,
                                ),
                              ),
                              child: Text(
                                "Severe",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height / 40,
                                    letterSpacing: 1.0,
                                    color: Colors.red),
                              ),
                            ),
                          ),
                        ]),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 1),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Slider(
                              value: valueBottom6,
                              min: 0,
                              max: 100,
                              divisions: 1000,
                              onChanged: (values) =>
                                  setState(() => valueBottom6 = values),
                            ),
                          ),
                        ]),
                  ),
                ]),
          ),
        ]);
  }

  Widget _build8Row() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 10, width: 5),
          Container(
            alignment: Alignment.center,
            height: 3 * (MediaQuery.of(context).size.height / 18),
            width: 5 * (MediaQuery.of(context).size.width / 6),
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey),
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(margin: const EdgeInsets.only(top: 30)),
                        Text(
                          "Feeling Week",
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height / 40,
                              letterSpacing: 1.0,
                              color: Colors.black),
                        ),
                      ]),
                  Container(
                    margin:
                        const EdgeInsets.only(bottom: 0.2, left: 15, right: 15),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Container(
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(80),
                                color: Colors.grey[50],
                              ),
                              child: Text(
                                "No",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height / 40,
                                    letterSpacing: 1.0,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 5,
                            fit: FlexFit.tight,
                            child: Container(
                              height: 30,
                              width: 10,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(80),
                                color: Colors.grey[50],
                                border: Border.all(
                                  color: Colors.green,
                                ),
                              ),
                              child: Text(
                                "Occasional",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height / 40,
                                    letterSpacing: 1.0,
                                    color: Colors.green),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 4,
                            fit: FlexFit.tight,
                            child: Container(
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(80),
                                color: Colors.grey[50],
                                border: Border.all(
                                  color: Colors.red,
                                ),
                              ),
                              child: Text(
                                "Often",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height / 40,
                                    letterSpacing: 1.0,
                                    color: Colors.red),
                              ),
                            ),
                          ),
                        ]),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 1),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Slider(
                              value: valueBottom7,
                              min: 0,
                              max: 100,
                              divisions: 1000,
                              onChanged: (values) =>
                                  setState(() => valueBottom7 = values),
                            ),
                          ),
                        ]),
                  ),
                ]),
          ),
        ]);
  }

  Widget _build9Row() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 10, width: 5),
          Container(
            alignment: Alignment.center,
            height: 3 * (MediaQuery.of(context).size.height / 18),
            width: 5 * (MediaQuery.of(context).size.width / 6),
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey),
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(margin: const EdgeInsets.only(top: 30)),
                        Text(
                          "Loss of Appetite",
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height / 40,
                              letterSpacing: 1.0,
                              color: Colors.black),
                        ),
                      ]),
                  Container(
                    margin:
                        const EdgeInsets.only(bottom: 0.2, left: 15, right: 15),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Container(
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(80),
                                color: Colors.grey[50],
                              ),
                              child: Text(
                                "No",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height / 40,
                                    letterSpacing: 1.0,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 5,
                            fit: FlexFit.tight,
                            child: Container(
                              height: 30,
                              width: 10,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(80),
                                color: Colors.grey[50],
                                border: Border.all(
                                  color: Colors.green,
                                ),
                              ),
                              child: Text(
                                "Occasional",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height / 40,
                                    letterSpacing: 1.0,
                                    color: Colors.green),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 4,
                            fit: FlexFit.tight,
                            child: Container(
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(80),
                                color: Colors.grey[50],
                                border: Border.all(
                                  color: Colors.red,
                                ),
                              ),
                              child: Text(
                                "Always",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height / 40,
                                    letterSpacing: 1.0,
                                    color: Colors.red),
                              ),
                            ),
                          ),
                        ]),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 1),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Slider(
                              value: valueBottom8,
                              min: 0,
                              max: 100,
                              divisions: 1000,
                              onChanged: (values) =>
                                  setState(() => valueBottom8 = values),
                            ),
                          ),
                        ]),
                  ),
                ]),
          ),
        ]);
  }

  Widget _build10Row() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 10, width: 5),
          Container(
            alignment: Alignment.center,
            height: 3 * (MediaQuery.of(context).size.height / 18),
            width: 5 * (MediaQuery.of(context).size.width / 6),
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey),
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(margin: const EdgeInsets.only(top: 30)),
                        Text(
                          "Nausea (Sensation of the urge to vomit)",
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height / 43,
                              letterSpacing: 1.0,
                              color: Colors.black),
                        ),
                      ]),
                  Container(
                    margin:
                        const EdgeInsets.only(bottom: 0.2, left: 15, right: 15),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Container(
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(80),
                                color: Colors.grey[50],
                              ),
                              child: Text(
                                "No",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height / 40,
                                    letterSpacing: 1.0,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 5,
                            fit: FlexFit.tight,
                            child: Container(
                              height: 30,
                              width: 10,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(80),
                                color: Colors.grey[50],
                                border: Border.all(
                                  color: Colors.green,
                                ),
                              ),
                              child: Text(
                                "Mild",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height / 40,
                                    letterSpacing: 1.0,
                                    color: Colors.green),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 4,
                            fit: FlexFit.tight,
                            child: Container(
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(80),
                                color: Colors.grey[50],
                                border: Border.all(
                                  color: Colors.red,
                                ),
                              ),
                              child: Text(
                                "Severe",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height / 40,
                                    letterSpacing: 1.0,
                                    color: Colors.red),
                              ),
                            ),
                          ),
                        ]),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 1),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Slider(
                              value: valueBottom9,
                              min: 0,
                              max: 100,
                              divisions: 1000,
                              onChanged: (values) =>
                                  setState(() => valueBottom9 = values),
                            ),
                          ),
                        ]),
                  ),
                ]),
          ),
        ]);
  }

  Widget _build11Row() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 10, width: 5),
          Container(
            alignment: Alignment.center,
            height: 3 * (MediaQuery.of(context).size.height / 18),
            width: 5 * (MediaQuery.of(context).size.width / 6),
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey),
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(margin: const EdgeInsets.only(top: 30)),
                        Text(
                          "Vomiting",
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height / 40,
                              letterSpacing: 1.0,
                              color: Colors.black),
                        ),
                      ]),
                  Container(
                    margin:
                        const EdgeInsets.only(bottom: 0.2, left: 15, right: 15),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Container(
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(80),
                                color: Colors.grey[50],
                              ),
                              child: Text(
                                "No",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height / 40,
                                    letterSpacing: 1.0,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 5,
                            fit: FlexFit.tight,
                            child: Container(
                              height: 30,
                              width: 10,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(80),
                                color: Colors.grey[50],
                                border: Border.all(
                                  color: Colors.green,
                                ),
                              ),
                              child: Text(
                                "Occasional",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height / 40,
                                    letterSpacing: 1.0,
                                    color: Colors.green),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 4,
                            fit: FlexFit.tight,
                            child: Container(
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(80),
                                color: Colors.grey[50],
                                border: Border.all(
                                  color: Colors.red,
                                ),
                              ),
                              child: Text(
                                "Often",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height / 40,
                                    letterSpacing: 1.0,
                                    color: Colors.red),
                              ),
                            ),
                          ),
                        ]),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 1),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Slider(
                              value: valueBottom10,
                              min: 0,
                              max: 100,
                              divisions: 1000,
                              onChanged: (values) =>
                                  setState(() => valueBottom10 = values),
                            ),
                          ),
                        ]),
                  ),
                ]),
          ),
        ]);
  }

  Widget _build12Row() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 10, width: 5),
          Container(
            alignment: Alignment.center,
            height: 3 * (MediaQuery.of(context).size.height / 18),
            width: 5 * (MediaQuery.of(context).size.width / 6),
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey),
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(margin: const EdgeInsets.only(top: 30)),
                        Text(
                          "Diarrhea",
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height / 40,
                              letterSpacing: 1.0,
                              color: Colors.black),
                        ),
                      ]),
                  Container(
                    margin:
                        const EdgeInsets.only(bottom: 0.2, left: 15, right: 15),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Container(
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(80),
                                color: Colors.grey[50],
                              ),
                              child: Text(
                                "No",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height / 40,
                                    letterSpacing: 1.0,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 5,
                            fit: FlexFit.tight,
                            child: Container(
                              height: 30,
                              width: 10,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(80),
                                color: Colors.grey[50],
                                border: Border.all(
                                  color: Colors.green,
                                ),
                              ),
                              child: Text(
                                "Mild",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height / 40,
                                    letterSpacing: 1.0,
                                    color: Colors.green),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 4,
                            fit: FlexFit.tight,
                            child: Container(
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(80),
                                color: Colors.grey[50],
                                border: Border.all(
                                  color: Colors.red,
                                ),
                              ),
                              child: Text(
                                "Severe",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height / 40,
                                    letterSpacing: 1.0,
                                    color: Colors.red),
                              ),
                            ),
                          ),
                        ]),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 1),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Slider(
                              value: valueBottom11,
                              min: 0,
                              max: 100,
                              divisions: 1000,
                              onChanged: (values) =>
                                  setState(() => valueBottom11 = values),
                            ),
                          ),
                        ]),
                  ),
                ]),
          ),
        ]);
  }

  Widget _buildButton() {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: <
        Widget>[
      Container(
        alignment: Alignment.center,
        height: 3 * (MediaQuery.of(context).size.height / 40),
        width: 5 * (MediaQuery.of(context).size.width / 6),
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Container(width: 1, margin: const EdgeInsets.only(top: 30)),
              ElevatedButton(
                onPressed: () {
                  {
                    if (_formKey.currentState!.validate()) {
                      var values = [
                        double.parse(tempEditingController.text),
                        valueBottom / 10,
                        valueBottom1 / 10,
                        valueBottom2 / 10,
                        valueBottom3 / 10,
                        valueBottom4 / 10,
                        valueBottom5 / 10,
                        valueBottom6 / 10,
                        valueBottom7 / 10,
                        valueBottom8 / 10,
                        valueBottom9 / 10,
                        valueBottom10 / 10,
                        valueBottom11 / 10,
                      ];

                      addSess(prof) async {
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
                        var reqBody = {
                          'bTempInput': prof[0].toString(),
                          'headacheSlider': prof[1].toString(),
                          'JointPainSlider': prof[2].toString(),
                          'AbdPainSlider': prof[3].toString(),
                          'ThroatSlider': prof[4].toString(),
                          'drychSlider': prof[5].toString(),
                          'DyspSlider': prof[6].toString(),
                          'ColdSlider': prof[7].toString(),
                          'WeakSlider': prof[8].toString(),
                          'AppSlider': prof[9].toString(),
                          'NausSlider': prof[10].toString(),
                          'vomitSlider': prof[11].toString(),
                          'DiarSlider': prof[12].toString(),
                        };
                        http.Response response = await http.post(
                          Uri.parse(url),
                          body: reqBody,
                        );
                        if (response.statusCode == 200) {
                          Map<String, dynamic> responseJson =
                              json.decode(response.body);
                          if (responseJson['Message'] == 'Success') {
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

                      addSess(values);
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
                                    Text('Check the temperature value!'),
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
                },
                child: Text(
                  "submit",
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
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd\nkk:mm').format(now);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Daily Session'),
        ),
        drawer: NavigationDrawerWidget(),
        body: SingleChildScrollView(
          child: Column(children: <Widget>[
            _buildRow(),
            Center(
                child: Text(
              formattedDate,
              textAlign: TextAlign.center,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
            )),
            _build0Row(),
            _build1Row(),
            _build2Row(),
            _build3Row(),
            _build4Row(),
            _build5Row(),
            _build6Row(),
            _build7Row(),
            _build8Row(),
            _build9Row(),
            _build10Row(),
            _build11Row(),
            _build12Row(),
            _buildButton(),
          ]),
        ),
      ),
    );
  }
}
