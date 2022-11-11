class LoginUserDto {
  final String email;
  final String password;

  LoginUserDto({
    required this.email,
    required this.password,
  });

  factory LoginUserDto.fromMap(Map<String, dynamic> map) {
    return LoginUserDto(
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }

  @override
  String toString() {
    return 'LoginUserDto(email: $email, password: $password)';
  }
}
