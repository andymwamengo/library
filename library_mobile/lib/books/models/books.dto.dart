class BookDto {
  final int? id;
  final String title;
  final String description;
  final bool? public;

  BookDto({
    this.id,
    this.public,
    required this.title,
    required this.description,
  });

  factory BookDto.fromMap(Map<String, dynamic> item) {
    return BookDto(
      id: item["id"] as int,
      title: item["title"] as String,
      description: item["description"] as String,
      public: item["public"] as bool,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'public': public,
    };
  }

  @override
  String toString() {
    return 'BookDto{id: $id, title: $title, description: $description, public: $public}';
  }
}
