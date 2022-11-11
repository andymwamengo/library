import 'package:library_mobile/books/models/books.model.dart';

class Users {
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

  Users(
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

  factory Users.fromMap(Map<String, dynamic> item) {
    List<Books> booksList = [];
    if (item.containsKey('books')) {
      for (var item in item["books"]) {
        booksList.add(Books.fromMap(item));
      }
    }
    return Users(
      id: item["id"],
      password: item["password"],
      username: item["username"],
      email: item["email"],
      role: item["role"],
      createdAt: item["createdAt"] != null ? DateTime.parse(item["createdAt"]): null,
      updatedAt: item["updatedAt"] != null ? DateTime.parse(item["updatedAt"]): null,
      deletedAt: item["deletedAt"] != null ? DateTime.parse(item["deletedAt"]): null,
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
    return 'Users{id: $id, username: $username, email: $email, role: $role, password: $password, createdAt: $createdAt}, updatedAt: $updatedAt}, deletedAt: $deletedAt}, isActive: $isActive}, isDeleted: $isDeleted}, createdBy: $createdBy}, books: $books';
  }
}
