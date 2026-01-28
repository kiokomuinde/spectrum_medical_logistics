import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Existing Sign Up Logic
  Future<UserCredential> signUp({
    required String email,
    required String password,
    required String fullName,
    String? facilityName,
  }) async {
    UserCredential credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

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

  // Existing Sign In Logic
  Future<UserCredential> signIn({required String email, required String password}) async {
    return await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // --- GOOGLE SIGN IN FOR WEB ---
  Future<UserCredential> signInWithGoogle() async {
    // 1. Initialize Google Provider
    GoogleAuthProvider googleProvider = GoogleAuthProvider();
    
    // 2. Trigger the Popup (Standard for Flutter Web)
    UserCredential credential = await _auth.signInWithPopup(googleProvider);

    // 3. Check if this is a new user in Firestore
    final userDoc = await _db.collection('users').doc(credential.user!.uid).get();

    // 4. If new, save their details
    if (!userDoc.exists) {
      await _db.collection('users').doc(credential.user!.uid).set({
        'uid': credential.user!.uid,
        'fullName': credential.user!.displayName ?? 'New User',
        'email': credential.user!.email,
        'facilityName': 'Not Specified',
        'role': 'client',
        'createdAt': FieldValue.serverTimestamp(),
      });
    }

    return credential;
  }
}