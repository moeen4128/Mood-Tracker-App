class UserModel {
  final String name;
  final String email;
  final String age;
  final String feelingEmoji;
  final String userFeeling;

  UserModel({
    required this.age,
    required this.name,
    required this.email,
    required this.feelingEmoji,
    required this.userFeeling,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      feelingEmoji: map['feelingEmoji'] ?? '',
      userFeeling: map['userFeeling'] ?? '',
      email: map['email'] ?? '',
      age: map['age'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'userFeeling': userFeeling,
      'feelingEmoji': feelingEmoji,
      'email': email,
      'age': age,
    };
  }
}
