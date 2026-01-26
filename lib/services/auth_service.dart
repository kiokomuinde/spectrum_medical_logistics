import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Sign Up Logic
  Future<UserCredential> signUp({
    required String email,
    required String password,
    required String fullName,
    String? facilityName,
  }) async {
    // 1. Create account
    UserCredential credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // 2. Save medical facility details to Firestore
    await _db.collection('users').doc(credential.user!.uid).set({
      'uid': credential.user!.uid,
      'fullName': fullName,
      'email': email,
      'facilityName': facilityName ?? 'Not Specified',
      'role': 'client',
      'createdAt': FieldValue.serverTimestamp(),
    });

    return credential;
  }

  // Sign In Logic
  Future<UserCredential> signIn({required String email, required String password}) async {
    return await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}