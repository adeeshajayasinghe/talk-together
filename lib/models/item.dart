class Item {
  final String fullName;
  final String mobile;
  final String email;
  final dynamic password;

  Item(
      {required this.fullName,
      required this.mobile,
      required this.email,
      required this.password});

  // Convert to JSON for API request
  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      "email": email,
      "mobile": mobile,
      "password": password
    };
  }
}
