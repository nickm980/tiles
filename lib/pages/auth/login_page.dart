import 'package:app2/exceptions/AuthException.dart';
import 'package:app2/pages/auth/auth_layout.dart';
import 'package:app2/services/auth_service.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool areBothTextFieldsSupplied = false;
  bool emailPasswordLoginLoading = false;
  bool googleSignInLoading = false;
  String errorMessage = "";

  @override
  initState() {
    void updateTextButtonColor() {
      if (emailController.text.isNotEmpty &&
          passwordController.text.isNotEmpty) {
        setState(() {
          areBothTextFieldsSupplied = true;
        });
      } else {
        setState(() {
          areBothTextFieldsSupplied = false;
        });
      }
    }

    emailController.addListener(updateTextButtonColor);
    passwordController.addListener(updateTextButtonColor);
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  _attemptLogin() async {
    if (emailPasswordLoginLoading) {
      return;
    }

    setState(() {
      emailPasswordLoginLoading = true;
    });

    try {
      await AuthService().signInWithEmailPassword(
          emailController.text, passwordController.text);
    } on AuthException catch (error) {
      errorMessage = "⚠ ${error.message}";
    }

    setState(() {
      emailPasswordLoginLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AuthContainer(
      header: "Log in",
      description: "Welcome back to Tiles",
      errorMessage: errorMessage,
      inputFields: [
        TextField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(hintText: 'Email'),
        ),
        TextField(
          obscureText: true,
          controller: passwordController,
          keyboardType: TextInputType.visiblePassword,
          decoration: const InputDecoration(hintText: 'Password'),
        )
      ],
      actionButton: AuthActionButton(
          text: "Log In",
          loading: emailPasswordLoginLoading,
          disabled: !areBothTextFieldsSupplied,
          action: _attemptLogin),
      extra: [
        const SizedBox(height: 15),
        RichText(
            textAlign: TextAlign.start,
            text: TextSpan(
                text: 'Forgot your password?',
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pushNamed(context, "forgot");
                  },
                style: const TextStyle(color: Colors.red)))
      ],
    );
  }
}
