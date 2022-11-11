// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:library_mobile/auth/screens/register.dart';
import 'package:library_mobile/auth/services/auth.service.dart';
import 'package:library_mobile/books/models/books.model.dart';
import 'package:library_mobile/books/screens/book_detail_page.dart';
import 'package:library_mobile/books/services/books.service.dart';
import 'package:library_mobile/users/models/user.model.dart';
import 'package:library_mobile/users/services/users.service.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<StatefulWidget> createState() => _AccountPage();
}

class _AccountPage extends State<AccountPage> {
  final UsersService usersService = UsersService();
  final BooksService booksService = BooksService();
  final authService = AuthService();
  Users? user;
  List<Books>? books;
  bool isLoading = false;
  int currentUser = 0;
  late int currentUserId = 0;

  void currentUserProfile() async {
    final currentUser = await authService.getCurrentUser();
    if (currentUser != null) {
      setState(() {
        currentUserId = currentUser;
      });
    } else {
      currentUserId = 0;
    }
  }

  void getUserProfile() async {
    user = await usersService.getUsersProfile();
    if (user == null) {
      isLoading = true;
    } else {
      setState(() {
        user = user;
      });
    }
  }

  void getUsersById(int id) async {
    user = await usersService.getUsersById(id);
    if (user != null) {
      setState(() {
        user = user;
        currentUser = user!.id!;
      });
    } else {
      isLoading = true;
    }
  }

  getCurrentUserPreview(BuildContext context) {
    final user = ModalRoute.of(context)!.settings.arguments as dynamic;
    if (user != null) {
      getUsersById(user.id!);
      getUserByIdBooks(user.id);
    } else {
      getUserProfile();
      getCurrentUserBooks();
    }
  }

  getCurrentUserBooks() async {
    books = await booksService.getCurrentUserBooks();
    if (books!.isNotEmpty) {
      setState(() {
        books = books;
      });
    }
  }

  getUserByIdBooks(int id) async {
    books = await booksService.getUserBooksById(id);
    if (books!.isNotEmpty) {
      setState(() {
        books = books;
      });
    }
  }

  @override
  void initState() {
    currentUserProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getCurrentUserPreview(context);
    return user != null
        ? Scaffold(
            appBar: currentUser > 0
                ? AppBar(
                    title: Text(user!.username!),
                  )
                : null,
            body: SafeArea(
              child: Stack(
                alignment: Alignment.topCenter,
                fit: StackFit.expand,
                children: [
                  Container(
                    padding: EdgeInsets.zero,
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(user!.username![0]),
                      ),
                      title: Text(user!.username!),
                      subtitle: Text(user!.email!),
                      trailing: (currentUserId == user!.id)
                          ? IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        SignUpPage(),
                                    fullscreenDialog: true,
                                    settings: RouteSettings(
                                      arguments: user,
                                    ),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.edit_outlined),
                            )
                          : null,
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.only(top: 60, left: 15, right: 15),
                    child: ListTile(
                      title: Text("${books!.length} Books"),
                      trailing: const Icon(Icons.move_down),
                    ),
                  ),
                  books!.isNotEmpty
                      ? Container(
                          padding: const EdgeInsets.only(top: 130),
                          child: ListView.builder(
                            itemCount: books?.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.all(1.0),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    child:
                                        Text(books![index].title.toString()[0]),
                                  ),
                                  title: Text(
                                    books![index].title,
                                    style: const TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  subtitle: Column(
                                    children: [
                                      Text(books![index].description),
                                      Text(
                                        books![index].author!.username!,
                                        textAlign: TextAlign.start,
                                      ),
                                      Text(
                                        books![index].createdAt.toString(),
                                        textAlign: TextAlign.right,
                                      ),
                                    ],
                                  ),
                                  trailing: IconButton(
                                    icon: ((currentUserId != 0) &&
                                            (currentUserId == books![index]!.author!.id))
                                        ? const Icon(Icons.edit)
                                        : const Icon(Icons.navigate_next),
                                    onPressed: () {
                                      ((currentUserId != 0) &&
                                              (currentUserId ==
                                                  books![index].id))
                                          ? deleteBook(books![index].id)
                                          : Navigator.push(
                                              context,
                                              MaterialPageRoute<void>(
                                                builder:
                                                    (BuildContext context) =>
                                                        const BookDetailPage(),
                                                settings: RouteSettings(
                                                  arguments: books![index],
                                                ),
                                              ),
                                            );
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : const Center(
                          child: Text("No Books"),
                        ),
                ],
              ),
            ),
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }

  deleteBook(id) async {
    await booksService.deleteBooks(id);
  }
}
