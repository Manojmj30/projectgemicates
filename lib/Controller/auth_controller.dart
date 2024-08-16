import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? get currentUser => _auth.currentUser;

  Future<void> signUp(String email, String password, String name) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'name': name,
          'email': email,
          'createdAt': Timestamp.now(),
        });

        print('User details saved to Firestore');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'network-request-failed') {
        print('Network error occurred. Please check your connection.');
      } else {
        print('Error: ${e.message}');
      }
    } catch (e) {
      print('An unexpected error occurred: $e');
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {

      throw Exception('Failed to sign out');
    }
  }
}
