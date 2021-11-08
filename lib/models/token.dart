class Token {
  final String msg;
  final String token;

  Token({
    required this.token,
    required this.msg,
  });
  factory Token.fromJson(Map<String, dynamic> json) {
    if (json['Message'] == 'Success') {
      return Token(msg: json['Message'], token: json['form_token']);
    }
    return Token(msg: json['Message'], token: 'none');
  }
}
