class User {
  String id;
  String name;
  String email;
  String password;
  String phone;
  String location;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  DateTime birthday;
  String gender;
  int height;
  int weight;
  String avatarUrl;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.location,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.birthday,
    required this.gender,
    required this.height,
    required this.weight,
    required this.avatarUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      phone: json['phone'],
      location: json['location'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
      birthday: DateTime.parse(json['birthday']),
      gender: json['gender'],
      height: json['height'],
      weight: json['weight'],
      avatarUrl: json['avatarUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
      'location': location,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': v,
      'birthday': birthday.toIso8601String(),
      'gender': gender,
      'height': height,
      'weight': weight,
      'avatarUrl': avatarUrl,
    };
  }
}
