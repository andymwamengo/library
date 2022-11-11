class RegisterUserDto {
  final int? id;
  final String username;
  final String email;
  final String? password;

  RegisterUserDto({
     this.id,
    required this.username,
    required this.email,
    this.password,
  });

  factory RegisterUserDto.fromMap(Map<String, dynamic> map) {
    return RegisterUserDto(
      id: map['id'] as int,
      username: map['username'] as String,
      email: map['email'] as String,
      password: map['password'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'password': password,
    };
  }

  @override
  String toString() {
    return 'RegisterUserDto(id: $id, username: $username, email: $email, password: $password)';
  }
}
