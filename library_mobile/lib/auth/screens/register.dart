// ignore_for_file: no_leading_underscores_for_local_identifiers
import 'package:flutter/material.dart';
import 'package:library_mobile/auth/models/register.model.dart';
import 'package:library_mobile/auth/screens/login.dart';
import 'package:library_mobile/auth/services/auth.service.dart';
import 'package:library_mobile/shared/router/material_router.dart';
import 'package:library_mobile/shared/widgets/build_text_input.dart';
import 'package:library_mobile/users/models/user.model.dart';
import 'package:library_mobile/users/services/users.service.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool? isChecked = false;
  late final AuthService _authService = AuthService();
  late final UsersService _usersService = UsersService();

  Widget _buildSignInButton() {
    return GestureDetector(
        child: Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            color: Colors.blue,
          ),
          child: const Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              'Register',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        onTap: () async {
          final RegisterUserDto _registerData = RegisterUserDto(
            id: userId,
            username: usernameTextController.text,
            email: emailTextController.text,
            password: passwordTextController.text,
          );
          if (userId != null) {
            var _users = _registerData as Users;
            _usersService.updateUsers(_users);
          }
          var register = await _authService.registerUser(_registerData);
          // if (register.id != null) {
            if (mounted) {}
            MaterialRouter.navigateTo(context, SignUpPage());
          // }
        });
  }

  Widget _buildSignUpQuestion() {
    return Container(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Don't have an Account? ",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          InkWell(
            child: const Text(
              'Sign In',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              MaterialRouter.navigateTo(context, const SignInPage());
            },
          ),
        ],
      ),
    );
  }

  bool _passVisibility = true;
  late int? userId;
  TextEditingController usernameTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController confirmPasswordTextController = TextEditingController();

  Widget _passwordWidget({
    required bool obscureText,
    required TextEditingController controller,
    String? hintText,
    String? errorMessage,
    String? labelText,
    required String inputKey,
  }) {
    return TextField(
      key: Key(inputKey),
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.visiblePassword,
      controller: controller,
      autofocus: false,
      obscureText: _passVisibility,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        errorText: errorMessage,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        suffixIcon: IconButton(
          icon: _passVisibility
              ? const Icon(Icons.visibility_off)
              : const Icon(Icons.visibility),
          onPressed: () {
            _passVisibility = !_passVisibility;
            setState(() {});
          },
        ),
      ),
    );
  }

  generateSignUpForm(BuildContext context) {
    final user = ModalRoute.of(context)!.settings.arguments as dynamic;
    if (user != null) {
      userId = user.id!;
      usernameTextController.text = user.username!;
      emailTextController.text = user.email!;
    }else{
      userId = null;
      usernameTextController.text;
      emailTextController.text;
    }

    print('\n\n\n  $user  \n\n\n');
  }

  @override
  Widget build(BuildContext context) {
    generateSignUpForm(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SingleChildScrollView(
                  child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: <Widget>[
                    buildLabelText(
                      labelText: 'Username',
                      fontWight: FontWeight.bold,
                      alignment: Alignment.centerLeft,
                      fontSize: 16.0,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    buildTextField(
                      textEditingController: usernameTextController,
                      inputKey: 'username',
                      hintText: 'Enter your Username',
                      obscureText: false,
                      prefixedIcon: null,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    buildLabelText(
                      labelText: 'Email',
                      fontWight: FontWeight.bold,
                      alignment: Alignment.centerLeft,
                      fontSize: 16.0,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    buildTextField(
                      textEditingController: emailTextController,
                      inputKey: 'email',
                      hintText: 'Enter your email',
                      obscureText: false,
                      prefixedIcon: null,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    buildLabelText(
                      labelText: 'Password',
                      fontWight: FontWeight.bold,
                      alignment: Alignment.centerLeft,
                      fontSize: 16.0,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    _passwordWidget(
                      obscureText: false,
                      controller: passwordTextController,
                      hintText: 'Password',
                      labelText: 'Password',
                      inputKey: 'password',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    buildLabelText(
                      labelText: 'Confirm Password',
                      fontWight: FontWeight.bold,
                      alignment: Alignment.centerLeft,
                      fontSize: 16.0,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    _passwordWidget(
                      obscureText: false,
                      controller: confirmPasswordTextController,
                      hintText: 'Confirm your Password',
                      labelText: 'Confirm Password',
                      inputKey: 'confirmPassword',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    _buildSignInButton(),
                    const SizedBox(
                      height: 20,
                    ),
                    _buildSignUpQuestion()
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
