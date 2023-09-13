import 'package:app2/exceptions/AuthException.dart';
import 'package:app2/pages/auth/auth_layout.dart';
import 'package:app2/services/auth_service.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
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

  _attemptAccountCreation() async {
    if (emailPasswordLoginLoading) {
      return;
    }

    setState(() {
      emailPasswordLoginLoading = true;
    });

    try {
      await AuthService()
          .createAccount(emailController.text, passwordController.text);
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
      header: "Sign up",
      description: "Create a new Tiles account",
      errorMessage: errorMessage,
      inputFields: [
        TextField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(hintText: 'Enter your email'),
        ),
        TextField(
          obscureText: true,
          controller: passwordController,
          keyboardType: TextInputType.visiblePassword,
          decoration: const InputDecoration(hintText: 'Create a password'),
        )
      ],
      actionButton: AuthActionButton(
          text: "Sign up",
          loading: emailPasswordLoginLoading,
          disabled: !areBothTextFieldsSupplied,
          action: _attemptAccountCreation),
    );
  }
}
