class Daydata {
  final List inputs;
  final List results;

  Daydata({
    required this.inputs,
    required this.results,
  });
  factory Daydata.fromJson(dynamic json) {
    return Daydata(
      inputs: json['Input_Data'],
      results: json['Results'],
    );
  }
}
