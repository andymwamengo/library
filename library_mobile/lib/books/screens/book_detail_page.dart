import 'package:flutter/material.dart';
import 'package:library_mobile/auth/services/auth.service.dart';
import 'package:library_mobile/books/models/books.model.dart';
import 'package:library_mobile/books/services/books.service.dart';

class BookDetailPage extends StatefulWidget {
  const BookDetailPage({super.key});

  @override
  State<StatefulWidget> createState() => _BookDetailPage();
}

class _BookDetailPage extends State<BookDetailPage> {
  final BooksService booksService = BooksService();
  final authService = AuthService();
  Books? book;
  bool isLoading = false;
  int currentBook = 0;
  late int currentUserId = 0;

  void getBooksById(int id) async {
    book = await booksService.getBooksById(id);
    if (book != null) {
      setState(() {
        book = book;
        currentBook = book!.id!;
      });
    } else {
      isLoading = true;
    }
  }

  getCurrentBookPreview(BuildContext context) {
    final book = ModalRoute.of(context)!.settings.arguments as dynamic;
    if (book != null) {
      getBooksById(book.id!);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getCurrentBookPreview(context);
    return book != null
        ? Scaffold(
            appBar: currentBook > 0
                ? AppBar(
                    title: Text(book!.title),
                  )
                : null,
            body: SafeArea(
              child: ListView(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      child: Text(book!.title[0]),
                    ),
                    title: Text(book!.title),
                  ),
                  Column(
                    children: [
                      Text(book!.description),
                      Text(
                        book!.author!.username!,
                        textAlign: TextAlign.start,
                      ),
                      Text(
                        book!.createdAt.toString(),
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }
}
