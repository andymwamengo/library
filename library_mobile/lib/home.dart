import 'package:flutter/material.dart';
import 'package:library_mobile/auth/screens/login.dart';
import 'package:library_mobile/auth/services/auth.service.dart';
import 'package:library_mobile/books/screens/books_page.dart';
import 'package:library_mobile/shared/constants/server.constant.dart';
import 'package:library_mobile/shared/router/material_router.dart';
import 'package:library_mobile/shared/secure_storage.service.dart';
import 'package:library_mobile/users/screens/account_page.dart';
import 'package:library_mobile/users/screens/users_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  final AuthService authService = AuthService();
  final SecureStorageService _storageService = SecureStorageService();
  String accessToken = '';
  int _selectedIndex = 0;

  late final List<Widget> _pages = const <Widget>[
    BooksPage(),
    UsersPage(),
    AccountPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> getAccessToken() async {
    accessToken = await _storageService.readSecureData(SECURE_KEY);
    if (accessToken == '') {
      accessToken = '';
    } else {
      setState(() {
        accessToken = accessToken;
      });
    }
  }

  @override
  void initState() {
    getAccessToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Library"),
        actions: [
          accessToken.length > 5
              ? IconButton(
                  icon: const Icon(Icons.logout_outlined),
                  tooltip: 'Logout',
                  onPressed: () async {
                    await authService.logoutUser();
                    setState(() {
                      initState();
                      MaterialRouter.navigateTo(context, const SignInPage());
                    });
                  },
                )
              : IconButton(
                  icon: const Icon(Icons.account_circle),
                  tooltip: 'Login',
                  onPressed: () {
                    MaterialRouter.navigateTo(context, const SignInPage());
                  },
                ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: _pages.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.white, width: 0.1),
          ),
        ),
        child: BottomNavigationBar(
          mouseCursor: SystemMouseCursors.grab,
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.library_add),
              label: 'Books',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people_outline),
              label: 'Users',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_box_rounded),
              label: 'Account',
            ),
          ],
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
