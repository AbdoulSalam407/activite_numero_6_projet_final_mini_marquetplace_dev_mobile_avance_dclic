class User {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String role;
  final String avatar;

  const User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.role,
    this.avatar = '',
  });

  String get fullName => '$firstName $lastName'.trim();

  factory User.fromJson(Map<String, dynamic> json) {
    final nameParts = (json['name'] as String? ?? '').split(' ');
    return User(
      id: json['id'] ?? '',
      firstName: json['firstName'] ?? (nameParts.isNotEmpty ? nameParts.first : ''),
      lastName: json['lastName'] ?? (nameParts.length > 1 ? nameParts.last : ''),
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      role: json['role'] ?? 'buyer',
      avatar: json['avatar'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'phone': phone,
        'role': role,
        'avatar': avatar,
      };
}
