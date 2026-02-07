// lib/main.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; 

// Theme and Constants
import 'package:spectrum_medical_logistics/theme/app_theme.dart';
import 'package:spectrum_medical_logistics/constants/app_constants.dart';

// Screens
import 'package:spectrum_medical_logistics/screens/home_screen.dart';
import 'package:spectrum_medical_logistics/screens/auth_screen.dart'; 
import 'package:spectrum_medical_logistics/screens/product_catalog_screen.dart';
import 'package:spectrum_medical_logistics/screens/medical_product_detail_screen.dart'; 
import 'package:spectrum_medical_logistics/screens/product_upload_screen.dart'; // <--- IMPORTED UPLOAD SCREEN

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const SpectrumApp());
}

class SpectrumApp extends StatelessWidget {
  const SpectrumApp({super.key});

   @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppConstants.appTitle,
      theme: getAppTheme(),
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}

// --- NAVIGATION PATHS ---
const Map<String, String> _navPaths = {
  'Home': '/',
  'SignIn': '/sign-in',
  'SignUp': '/sign-up',
  'Products': '/products',
  'ProductDetail': '/product/:id',
  'Upload': '/upload', // <--- ADDED UPLOAD PATH
};

// --- GO ROUTER SETUP ---
final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: _navPaths['Home']!,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: _navPaths['SignIn']!,
      builder: (context, state) => const AuthScreen(isSignUp: false),
    ),
    GoRoute(
      path: _navPaths['SignUp']!,
      builder: (context, state) => const AuthScreen(isSignUp: true),
    ),
    GoRoute(
      path: _navPaths['Products']!,
      builder: (context, state) => const ProductCatalogScreen(),
    ),
    GoRoute(
      path: _navPaths['ProductDetail']!,
      builder: (context, state) {
        // Extract the ID from the URL parameters
        final productId = state.pathParameters['id'] ?? 'unknown';
        return MedicalProductDetailScreen(productId: productId);
      },
    ),
    // --- ADDED UPLOAD ROUTE ---
    GoRoute(
      path: _navPaths['Upload']!,
      builder: (context, state) => const ProductUploadScreen(),
    ),
  ],
);