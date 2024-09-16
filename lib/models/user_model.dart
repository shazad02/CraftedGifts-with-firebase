class UserModel {
  late final String email;
  late final String name;
  late final String phone;
  late String? userid;

  UserModel({
    required this.email,
    required this.name,
    required this.phone,
    this.userid,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'name': name,
        'phone': phone,
        'userid': userid,
      };

  static UserModel fromJson(Map<String, dynamic> json) => UserModel(
        email: json['email'] ?? '',
        name: json['name'] ?? '',
        phone: json['phone'] ?? '',
        userid: json['userid'] ?? '',
      );
}
