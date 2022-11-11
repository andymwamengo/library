import 'package:library_mobile/users/models/user.model.dart';

class LoginResponseDto {
  final String accessToken;
  final String expireAt;
  final String tokenType;
  final Users user;

  LoginResponseDto({
    required this.accessToken,
    required this.expireAt,
    required this.tokenType,
    required this.user,
  });

  factory LoginResponseDto.fromMap(Map<String, dynamic> map) {
    return LoginResponseDto(
      accessToken: map['accessToken'] as String,
      expireAt: map['expireAt'] as String,
      tokenType: map['tokenType'] as String,
      user: Users.fromMap(map['user'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'expireAt': expireAt,
      'tokenType': tokenType,
      'user': user,
    };
  }

  @override
  String toString() {
    return 'LoginResponseDto(accessToken: $accessToken, expireAt: $expireAt, tokenType: $tokenType, user: $user)';
  }
}
