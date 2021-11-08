import 'package:cst/models/contacts.dart';

class Homedata {
  final String msg;
  final String render;
  final String user;
  final bool isauth;
  final bool isstaff;
  final bool isadmin;
  final String mediaurl;
  final List<Contact> contacts;

  Homedata({
    required this.msg,
    required this.render,
    required this.user,
    required this.isauth,
    required this.isstaff,
    required this.isadmin,
    required this.mediaurl,
    required this.contacts,
  });

  factory Homedata.fromJson(Map<String, dynamic> json) {
    var tagObjsJson = json['contacts'] as List;
    List<Contact> cont =
        tagObjsJson.map((tagJson) => Contact.fromJson(tagJson)).toList();
    return Homedata(
      msg: json['Message'],
      render: json['render'],
      user: json['user'],
      isauth: json['is_authenticated'],
      isstaff: json['is_staff'],
      isadmin: json['is_admin'],
      mediaurl: json['media'],
      contacts: cont,
    );
  }
}
