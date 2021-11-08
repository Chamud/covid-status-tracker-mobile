import 'dart:convert';
import 'package:cst/models/homedata.dart';
import 'package:cst/models/token.dart';
import 'package:http/http.dart' as http;

const String mainURL = 'https://covidstatustracker.herokuapp.com/api/';

Future<Homedata> fetchHome() async {
  var url = mainURL + 'home';
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return Homedata.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load');
  }
}

Future<Token> fetchLogin() async {
  var url = mainURL + 'login';
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return Token.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load');
  }
}
