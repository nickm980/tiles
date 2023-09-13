import 'package:app2/common/auth_button.dart';
import 'package:app2/pages/auth/auth_layout.dart';
import 'package:app2/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AuthPageLoginHome extends StatelessWidget {
  AuthService authService = AuthService();

  AuthPageLoginHome({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthContainer(
        header: "Log In",
        description: "Welcome back to Tiles",
        errorMessage: "",
        inputFields: [
          AuthBaseButton(
              onPressed: () => {Navigator.pushNamed(context, "/login/details")},
              iconData: FontAwesomeIcons.user,
              text: "Continue with email / password",
              loading: false),
          AuthBaseButton(
              onPressed: () => {authService.signInWithGoogle()},
              iconData: FontAwesomeIcons.google,
              text: "Continue with Google",
              loading: false),
        ],
        footer: const AuthFooter(
            leadingText: "Need an account?",
            actionText: "Sign up",
            route: "/signup"));
  }
}

class AuthPageSignupHome extends StatelessWidget {
  AuthService authService = AuthService();

  AuthPageSignupHome({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthContainer(
        header: "Create an account",
        description: "Signup to get started",
        errorMessage: "",
        inputFields: [
          AuthBaseButton(
              onPressed: () => {Navigator.of(context).pushNamed("/signup/details")},
              iconData: FontAwesomeIcons.user,
              text: "Sign up with email / password",
              loading: false),
          AuthBaseButton(
              onPressed: () => {authService.signInWithGoogle()},
              iconData: FontAwesomeIcons.google,
              text: "Sign up with Google",
              loading: false),
        ],
        footer: const AuthFooter(
            leadingText: "Already have an account?",
            actionText: "Log in instead",
            route: "/login"));
  }
}

