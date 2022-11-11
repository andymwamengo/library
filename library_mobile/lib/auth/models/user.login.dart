import 'package:library_mobile/books/models/books.model.dart';

class UserLogin {
  final int? id;
  final String? username;
  final String? email;
  final String? password;
  final String? role;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  final bool? isActive;
  final bool? isDeleted;
  final int? createdBy;
  final List<Books>? books;

  UserLogin(
      {this.id,
      this.password,
      this.username,
      this.email,
      this.role,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.isActive,
      this.isDeleted,
      this.createdBy,
      this.books});

  factory UserLogin.fromMap(Map<String, dynamic> item) {
    List<Books> booksList = [];
    if (item.containsKey('books')) {
      for (var item in item["books"]) {
        booksList.add(Books.fromMap(item));
      }
    }
    return UserLogin(
      id: item["id"],
      password: item["password"],
      username: item["username"],
      email: item["email"],
      role: item["role"],
      createdAt: DateTime.tryParse(item["createdAt"]),
      updatedAt: DateTime.tryParse(item["updatedAt"]),
      deletedAt: DateTime.tryParse(item["deletedAt"]),
      isActive: item["isActive"],
      isDeleted: item["isDeleted"],
      createdBy: item["createdBy"],
      books: booksList,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'role': role,
      'password': password,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'deletedAt': deletedAt,
      'isActive': isActive,
      'isDeleted': isDeleted,
      'createdBy': createdBy,
      'books': books,
    };
  }

  @override
  String toString() {
    return 'UserLogin{id: $id, username: $username, email: $email, role: $role, password: $password, createdAt: $createdAt}, updatedAt: $updatedAt}, deletedAt: $deletedAt}, isActive: $isActive}, isDeleted: $isDeleted}, createdBy: $createdBy}, books: $books';
  }
}
