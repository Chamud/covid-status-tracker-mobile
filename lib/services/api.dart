import 'dart:convert';
import 'package:cst/models/homedata.dart';
import 'package:cst/models/location.dart';
import 'package:cst/models/profdata.dart';
import 'package:cst/models/trackerdata.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

const String mainURL = 'https://covidstatustracker.herokuapp.com/api/';

//get data for the home page
Future<Homedata> fetchHome() async {
  final prefs = await SharedPreferences.getInstance(); //getting username and passwword saved in local storage
  final un = prefs.getString('username') ?? 'none';
  final pw = prefs.getString('password') ?? 'none';
  var url = mainURL + 'home?username=' + un + '&password=' + pw; 
  final response = await http.get(Uri.parse(url)); //calling the url
  if (response.statusCode == 200) {
    return Homedata.fromJson(jsonDecode(response.body)); 
  } else {
    throw Exception('Failed to load');
  }
}

//get data for the profile page
Future<Profiledata> fetchProf() async {
  final prefs = await SharedPreferences.getInstance(); //getting username and passwword saved in local storage
  final un = prefs.getString('username') ?? 'none';
  final pw = prefs.getString('password') ?? 'none';
  var url = mainURL + 'profile?username=' + un + '&password=' + pw;
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return Profiledata.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load');
  }
}

//get data for the symptom tracker
Future<Trackerdata> fetchTracker() async {
  final prefs = await SharedPreferences.getInstance();
  final un = prefs.getString('username') ?? 'none';
  final pw = prefs.getString('password') ?? 'none';
  var url = mainURL + 'tracker?username=' + un + '&password=' + pw;
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return Trackerdata.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load');
  }
}

Future<List<Location>> fetchMap() async {
  var url = mainURL + 'map';
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    var tagObjsJson = jsonDecode(response.body)['locations'] as List;
    List<Location> loc =
        tagObjsJson.map((tagJson) => Location.fromJson(tagJson)).toList();
    return loc;
  } else {
    throw Exception('Failed to load');
  }
}
