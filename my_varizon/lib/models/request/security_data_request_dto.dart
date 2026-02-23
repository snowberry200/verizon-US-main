class UserSecurityDataRequestDTO {
  String securityQuestion;
  String securityAnswer;

  UserSecurityDataRequestDTO({
    required this.securityQuestion,
    required this.securityAnswer,
  });
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['securityQuestion'] = securityQuestion;
    data['securityAnswer'] = securityAnswer;
    return data;
  }
}
