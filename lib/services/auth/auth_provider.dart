import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'auth_model.dart';

// Providим класс Authentication
final authenticationProvider = Provider<Authentication>((ref) {
  return Authentication();
});

//  Here I have shared the example of a provider used within a provider.
// keep in mind I am reading a provider from a provider not watching it.
//  The docs mention not to use watch in a provider. This is bad for performance
//  if the data changes conitnously your app will suck bad

final authStateProvider = StreamProvider<User?>((ref) {
  return ref.read(authenticationProvider).authStateChange;
});

//  There are different Types of Provider
//  Provider<T> is the most basic type of provider
//  FutureProvider<T> which involes a Future
//  StreamProvider<T> which involves a Stream
//  and many more. Refer to their docs for more info

//  Creating a firebaseAuthProvider to get some basic details of the loggedIn user
//  though we can store it in database but for now we will just use it to get the user
final fireBaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});