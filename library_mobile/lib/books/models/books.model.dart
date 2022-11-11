// ignore_for_file: non_constant_identifier_names

import 'package:library_mobile/users/models/user.model.dart';

class Books {
  final int? id;
  final String title;
  final String description;
  final bool? public;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  final bool? isActive;
  final bool? isDeleted;
  final int? createdBy;
  final Users? author;

  Books({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.isActive,
    this.isDeleted,
    this.createdBy,
    this.public,
    required this.title,
    required this.description,
    this.author,
  });

  factory Books.fromMap(Map<String, dynamic> item) {
    return Books(
      id: item["id"],
      title: item["title"] as String,
      description: item["description"] as String,
      public: item["public"],
      createdAt: DateTime.tryParse(item["createdAt"]),
      updatedAt: DateTime.tryParse(item["updatedAt"]),
      deletedAt: DateTime.tryParse(item["deletedAt"]),
      isActive: item["isActive"],
      isDeleted: item["isDeleted"],
      createdBy: item["createdBy"],
      author: Users.fromMap(item['author'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'public': public,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'deletedAt': deletedAt,
      'isActive': isActive,
      'isDeleted': isDeleted,
      'createdBy': createdBy,
      'author': author,
    };
  }

  @override
  String toString() {
    return 'Books{id: $id, title: $title, description: $description, public: $public, createdAt: $createdAt}, updatedAt: $updatedAt}, deletedAt: $deletedAt}, isActive: $isActive}, isDeleted: $isDeleted}, createdBy: $createdBy}, author: $author}';
  }
}
