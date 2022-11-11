// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:library_mobile/auth/services/auth.service.dart';
import 'package:library_mobile/shared/snackbar/snackbar.dart';
import 'package:library_mobile/users/models/user.model.dart';
import 'package:library_mobile/users/screens/account_page.dart';
import 'package:library_mobile/users/services/users.service.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final usersService = UsersService();
  final authService = AuthService();
  late Future<List<Users>> users;
  late Future<Users> user;
  late int currentUserId = 0;

  void getUsers() {
    users = usersService.getAllUsers();
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
    currentUser();
    getUsers();
  }

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _showForm(int? id) async {
    if (id != null) {
      final existingUsers = await users
          .then((value) => value.firstWhere((element) => element.id == id));
      _usernameController.text = existingUsers.username!;
      _emailController.text = existingUsers.email!;
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
              controller: _usernameController,
              decoration: InputDecoration(
                hintText: 'Username',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                hintText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                if (id != null) {
                  await _updateUser(id);
                }
                _usernameController.text = '';
                _emailController.text = '';
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

  // Update an existing post
  Future<Users?> _updateUser(int id) async {
    final post = Users(
      id: id,
      username: _usernameController.text,
      email: _emailController.text,
      password: _passwordController.text,
    );
    await usersService.updateUsers(post);
    if (!mounted) {}
    CustomSnackBar.show(context, 'Successfully updated post', 'OK');
  }

  // Delete an item
  void _deleteUser(int id) async {
    await usersService.deleteUsers(id);
    if (!mounted) return;
    CustomSnackBar.show(context, 'Successfully deleted post', 'OK');
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Users>>(
        future: users,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(1.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(snapshot.data[index].username.toString()[0]),
                    ),
                    title: Text(
                      snapshot.data[index].username,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: Text(
                      snapshot.data[index].email,
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    trailing: IconButton(
                      icon: ((currentUserId != 0) &&
                              (currentUserId == snapshot.data[index].id))
                          ? const Icon(Icons.edit)
                          : const Icon(Icons.navigate_next),
                      onPressed: () {
                        ((currentUserId != 0) &&
                                (currentUserId == snapshot.data[index].id))
                            ? _showForm(snapshot.data[index].id)
                            : Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      const AccountPage(),
                                  settings: RouteSettings(
                                    arguments: snapshot.data[index],
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
                _deleteUser(id);
              },
            ),
          ],
        );
      },
    );
  }
}
