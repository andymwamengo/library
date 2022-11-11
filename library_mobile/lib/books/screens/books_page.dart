// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:library_mobile/auth/services/auth.service.dart';
import 'package:library_mobile/books/models/books.dto.dart';
import 'package:library_mobile/books/models/books.model.dart';
import 'package:library_mobile/books/screens/book_detail_page.dart';
import 'package:library_mobile/books/services/books.service.dart';
import 'package:library_mobile/shared/snackbar/snackbar.dart';

class BooksPage extends StatefulWidget {
  const BooksPage({Key? key}) : super(key: key);

  @override
  _BooksPageState createState() => _BooksPageState();
}

class _BooksPageState extends State<BooksPage> {
  final booksService = BooksService();
  final authService = AuthService();
  late Future<List<Books>> books;
  late bool _public = true;
  late int currentUserId = 0;

  void getBooks() {
    books = booksService.getAllBooks();
  }

  void currentUser() async {
    final currentUser = await authService.getCurrentUser();
    if (currentUser != null) {
      currentUserId = currentUser;
    } else {
      currentUserId = 0;
    }
  }

  @override
  void initState() {
    super.initState();
    getBooks();
  }

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  void _showForm(int? id) async {
    if (id != null) {
      final existingBooks = await books
          .then((value) => value.firstWhere((element) => element.id == id));
      _titleController.text = existingBooks.title;
      _descriptionController.text = existingBooks.description;
      _public = existingBooks.public!;
    }

    showModalBottomSheet(
      context: context,
      elevation: 5,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10.0),
        ),
      ),
      builder: (_) => Container(
        padding: EdgeInsets.only(
          top: 15,
          left: 15,
          right: 15,
          bottom: MediaQuery.of(context).viewInsets.bottom + 50,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: 'Title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                hintText: 'Description',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SwitchListTile(
              title: const Text('Public'),
              value: _public,
              onChanged: (bool value) {
                setState(() {
                  _public = value;
                });
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                if (id == null) {
                  await _addBook();
                }

                if (id != null) {
                  await _updateBook(id);
                }
                _titleController.text = '';
                _descriptionController.text = '';
                if (!mounted) return;
                Navigator.of(context).pop();
              },
              child: Text(id == null ? 'Create' : 'Update'),
            )
          ],
        ),
      ),
    );
  }

  Future<Books?> _addBook() async {
    BookDto book = BookDto(
      title: _titleController.text,
      description: _descriptionController.text,
      public: true,
    );
    final _data = await booksService.createBook(book);
  }

  Future<Books?> _updateBook(int id) async {
    final book = BookDto(
      id: id,
      title: _titleController.text,
      description: _descriptionController.text,
      public: _public,
    );
    await booksService.updateBooks(book);
    if (!mounted) {}
    CustomSnackBar.show(context, 'Successfully updated book', 'OK');
  }

  // Delete an item
  void _deleteBook(int id) async {
    await booksService.deleteBooks(id);
    if (!mounted) return;
    CustomSnackBar.show(context, 'Successfully deleted book', 'OK');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Books>>(
        future: books,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                List<Books> books = snapshot.data;
                return Container(
                  margin: const EdgeInsets.all(1.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(books[index].title.toString()[0]),
                    ),
                    title: Text(
                      books[index].title,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: Column(
                      children: [
                        Text(books[index].description),
                        Text(
                          books[index].author!.username!,
                          textAlign: TextAlign.start,
                        ),
                        Text(
                          books[index].createdAt.toString(),
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: ((currentUserId != 0) &&
                              (currentUserId == books[index].author!.id))
                          ? const Icon(Icons.edit)
                          : const Icon(Icons.navigate_next),
                      onPressed: () {
                        ((currentUserId != 0) &&
                                (currentUserId == books[index].author!.id))
                            ? _showForm(books[index].id)
                            : Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      const BookDetailPage(),
                                  settings: RouteSettings(
                                    arguments: books[index],
                                  ),
                                ),
                              );
                      },
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error Occurred '),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _showForm(null),
      ),
    );
  }

  void confirmDelete(BuildContext context, int id) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: const Text(
            'Confirm To Delete',
            textAlign: TextAlign.center,
          ),
          content: SingleChildScrollView(
            child: Column(
              children: const <Widget>[
                Text('Are you sure you want to delete'),
                Text('Would you like to confirm this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            const Expanded(
                child: SizedBox(
              width: 30.0,
            )),
            TextButton(
              child: const Text('Confirm'),
              onPressed: () {
                Navigator.of(context).pop();
                _deleteBook(id);
              },
            ),
          ],
        );
      },
    );
  }
}
