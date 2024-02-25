import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'auth_model.dart';

// Providим класс Authentication
final authenticationProvider = Provider<Authentication>((ref) {
  return Authentication();
});


final authStateProvider = StreamProvider<User?>((ref) {
  return ref.read(authenticationProvider).authStateChange;
});


//  Creating a firebaseAuthProvider to get some basic details of the loggedIn user
//  though we can store it in database but for now we will just use it to get the user
final fireBaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});