class Contact {
  String city;
  String phiName;
  String phiNum;
  String polName;
  String polNum;
  String hospName;
  String hospNum;

  Contact(this.city, this.phiName, this.phiNum, this.polName, this.polNum,
      this.hospName, this.hospNum);

  factory Contact.fromJson(dynamic json) {
    return Contact(
      json['city'] as String,
      json['PHI']['name'] as String,
      json['PHI']['number'] as String,
      json['Police']['name'] as String,
      json['Police']['number'] as String,
      json['Hospital']['name'] as String,
      json['Hospital']['number'] as String,
    );
  }
  @override
  String toString() {
    return '{$city, $phiName, $phiNum, $polName, $polNum, $hospName, $hospNum}';
  }
}
