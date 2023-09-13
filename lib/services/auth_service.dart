/// This file defines the `AuthService` class, which provides methods for
/// handling user authentication using Firebase Authentication and Google Sign-In.
///
/// The `AuthService` class includes methods for creating a new user account,
/// signing in with email and password, checking if a user is logged in,
/// retrieving the current user, and signing in with Google.
///
/// It also handles Firebase Authentication exceptions by converting them into
/// custom `AuthException` errors
///
import 'package:app2/exceptions/AuthException.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  /// Creates a new user account with the given [email] and [password].
  createAccount(String email, String password) async {
    if (email.isEmpty || password.isEmpty){
      throw AuthException("Email and password must not be empty");
    }
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
  }

  /// Signs in a user with the provided [email] and [password].
  ///
  /// If sign-in fails, it handles Firebase Authentication exceptions and
  /// throws `AuthException` errors with user-friendly messages.
  signInWithEmailPassword(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case "invalid-email":
          throw AuthException("Invalid email");
        case "wrong-password":
          throw AuthException("Email and password do not match");
        case "user-not-found":
          throw AuthException("The user does not exist");
        case "user-disabled":
          throw AuthException("User account has been disabled");
        case "too-many-requests":
          throw AuthException("Too many attempts. Try again later.");
        default:
          throw AuthException("An error has occured. Please try again.");
      }
    }
  }

  /// Checks if a user is currently logged in.
  ///
  /// Returns `true` if a user is logged in, otherwise `false`.
  bool isLoggedIn() {
    return getCurrentUser() != null;
  }

  /// Retrieves the current user, if available.
  ///
  /// Returns the current user's information as a [User] object or `null` if
  /// no user is currently logged in.
  User? getCurrentUser() {
    return FirebaseAuth.instance.currentUser;
  }

  /// Signs in a user with their Google account.
  ///
  /// This method initiates the Google Sign-In process, and if successful,
  /// it signs in the user using Firebase Authentication.
  ///
  /// Throws `AuthException` if the Google Sign-In or Firebase Authentication
  /// fails or if the required authentication data is missing.
  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? gAuth = await gUser?.authentication;

    if (gUser == null) {
      throw AuthException("User not found");
    }

    if (gAuth == null) {
      throw AuthException("authentication not found for user");
    }

    final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken, idToken: gAuth.idToken);

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}

class GridSocket {
  
}
