class User {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String picture;
  final int age;
  final String city;
  final String country;
  bool isLiked;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.picture,
    required this.age,
    required this.city,
    required this.country,
    this.isLiked = false,
  });

  String get fullName => '$firstName $lastName';

  User copyWith({
    bool? isLiked,
  }) {
    return User(
      id: id,
      firstName: firstName,
      lastName: lastName,
      email: email,
      picture: picture,
      age: age,
      city: city,
      country: country,
      isLiked: isLiked ?? this.isLiked,
    );
  }
}