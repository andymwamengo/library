// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:library_mobile/auth/models/login.model.dart';
import 'package:library_mobile/auth/screens/register.dart';
import 'package:library_mobile/auth/services/auth.service.dart';
import 'package:library_mobile/home.dart';
import 'package:library_mobile/shared/router/material_router.dart';
import 'package:library_mobile/shared/widgets/build_text_input.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool? isChecked = false;
  late final AuthService _authService = AuthService();

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
              'Login',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        onTap: () async {
          final LoginUserDto _loginData = LoginUserDto(
            email: emailTextController.text,
            password: passwordTextController.text,
          );
          var _login = await _authService.loginUser(_loginData);
          if (_login.user.id != null ) {
            if (mounted) {}
            MaterialRouter.navigateTo(context, const HomePage());
          }
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
              'Sign Up',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              MaterialRouter.navigateTo(context,  SignUpPage());
            },
          ),
        ],
      ),
    );
  }

  bool _passVisibility = true;
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
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
                      height: 20.0,
                    ),
                    _buildSignInButton(),
                    const SizedBox(
                      height: 20,
                    ),
                    _buildSignUpQuestion()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
