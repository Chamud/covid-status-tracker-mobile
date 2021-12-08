import 'package:cst/models/sessiondata.dart';

class Trackerdata {
  final String msg;
  final List<Sessiondata> sessions;
  final List profile;
  final String pmsg;

  Trackerdata({
    required this.msg,
    required this.sessions,
    required this.profile,
    required this.pmsg,
  });

  factory Trackerdata.fromJson(dynamic json) {
    if (json['Message'] == 'Success') {
      var tagObjsJson = json['Sessions'] as List;
      List<Sessiondata> ses =
          tagObjsJson.map((tagJson) => Sessiondata.fromJson(tagJson)).toList();
      List pro = json['Profile'].toList();
      return Trackerdata(
        msg: json['Message'],
        sessions: ses,
        profile: pro,
        pmsg: json['patient_msg'],
      );
    } else {
      return Trackerdata(
        msg: json['Message'],
        sessions: [],
        profile: [],
        pmsg: '',
      );
    }
  }
}
