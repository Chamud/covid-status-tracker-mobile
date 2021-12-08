class Profiledata {
  final String msg;
  final int id;
  final String username;
  final String email;

  final String fname;
  final String lname;
  final String idNum;
  final String idType;
  final String address;
  final String dob;
  final String phoneNum;
  final String vaccinated;
  final String covidPatient;

  final String cardD;
  final String diab;
  final String chronicRD;
  final String cancer;
  final String otherD;

  Profiledata(
      {required this.msg,
      required this.id,
      required this.username,
      required this.email,
      required this.fname,
      required this.lname,
      required this.idNum,
      required this.idType,
      required this.address,
      required this.dob,
      required this.phoneNum,
      required this.vaccinated,
      required this.covidPatient,
      required this.cardD,
      required this.diab,
      required this.chronicRD,
      required this.cancer,
      required this.otherD});

  factory Profiledata.fromJson(dynamic json) {
    if (json['Message'] == 'Success') {
      return Profiledata(
        msg: json['Message'],
        id: json['account_data']['Account_ID'],
        username: json['account_data']['Username'],
        email: json['account_data']['Email'],
        fname: json['user_data'][0],
        lname: json['user_data'][1],
        idNum: json['user_data'][2],
        idType: json['user_data'][3],
        address: json['user_data'][4],
        dob: json['user_data'][5],
        phoneNum: json['user_data'][6],
        vaccinated: json['user_data'][7],
        covidPatient: json['user_data'][8],
        cardD: json['user_data'][9],
        diab: json['user_data'][10],
        chronicRD: json['user_data'][11],
        cancer: json['user_data'][12],
        otherD: json['user_data'][13],
      );
    } else {
      return Profiledata(
        msg: json['Message'],
        id: 0,
        username: '',
        email: '',
        fname: '',
        lname: '',
        idNum: '',
        idType: 'Other',
        address: '',
        dob: '',
        phoneNum: '',
        vaccinated: 'No',
        covidPatient: 'No',
        cardD: '',
        diab: '',
        chronicRD: '',
        cancer: '',
        otherD: '',
      );
    }
  }
}
