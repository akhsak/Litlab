class UserModel {
  String? uId;
  String? name;
  String? age;
  String? email;

  UserModel({
    required this.email,
    required this.name,
    required this.age,
    required this.uId,
  });

  // Corrected 'fromJson' without the 'id' parameter
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      age: json['age'],
      name: json['name'],
      uId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'age': age,
      'userId': uId,
    };
  }
}
