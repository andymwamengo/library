import 'package:flutter/material.dart';
import 'package:library_mobile/auth/screens/register.dart';
import 'package:library_mobile/shared/router/material_router.dart';

Widget buildTextField({
  required bool obscureText,
  Widget? prefixedIcon,
  String? hintText,
  String? errorMessage,
  String? labelText,
  required String inputKey,
  required TextEditingController textEditingController
}) {
  return TextFormField(
    controller: textEditingController,
    key: Key(inputKey),
    obscureText: obscureText,
    decoration: InputDecoration(
      labelText: labelText,
      errorText: errorMessage,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      suffixIcon: prefixedIcon,
      hintText: hintText,
    ),
  );
}

Widget buildSignUpQuestion(BuildContext context) {
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
            MaterialRouter.navigateTo(context, SignUpPage());
          },
        ),
      ],
    ),
  );
}

Widget buildLabelText({
  required String labelText,
  FontWeight? fontWight,
  Alignment? alignment,
  double? fontSize,
}) {
  return Container(
    alignment: alignment,
    child: Text(
      labelText,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWight,
      ),
    ),
  );
}

bool _passVisibility = true;
Widget passwordWidget({
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

          // setState(() {});
        },
      ),
    ),
  );
}
