import 'package:cst/models/daydata.dart';

class Sessiondata {
  final String number;
  final String stdate;
  final String fndate;
  final List<Daydata> dates;

  Sessiondata({
    required this.number,
    required this.stdate,
    required this.fndate,
    required this.dates,
  });

  factory Sessiondata.fromJson(dynamic json) {
    var tagObjsJson = json['days'] as List;
    List<Daydata> dates =
        tagObjsJson.map((tagJson) => Daydata.fromJson(tagJson)).toList();
    return Sessiondata(
      number: json['Session_Number'],
      stdate: json['Starting_Date'],
      fndate: json['Ending_date'],
      dates: dates,
    );
  }
}
