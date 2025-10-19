import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Theme and Constants
import 'package:spectrum_medical_logistics/theme/app_theme.dart';
import 'package:spectrum_medical_logistics/constants/app_constants.dart';

// Screens (Your 7 total pages)
// Screens now return a full Scaffold, including their placeholder AppBar and Footer.
import 'package:spectrum_medical_logistics/screens/home_screen.dart';
import 'package:spectrum_medical_logistics/screens/products_screen.dart';
import 'package:spectrum_medical_logistics/screens/solutions_screen.dart';
import 'package:spectrum_medical_logistics/screens/services_screen.dart'; 
import 'package:spectrum_medical_logistics/screens/quality_compliance_screen.dart';
import 'package:spectrum_medical_logistics/screens/about_us_screen.dart';
import 'package:spectrum_medical_logistics/screens/contact_screen.dart';
import 'package:spectrum_medical_logistics/screens/auth_screen.dart'; 

// 🔥 REMOVED: Imports for ResponsiveNavBar and AppFooter

void main() {
  runApp(const SpectrumApp());
}

// --- 1. NAVIGATION PATHS (Includes Auth Routes) ---
const Map<String, String> _navPaths = {
  'Home': '/',
  'Products': '/products',
  'Solutions': '/solutions',
  'Services': '/services',
  'Quality & Compliance': '/quality-compliance',
  'About Us': '/about-us',
  'Contact': '/contact',
  'SignIn': '/sign-in',
  'SignUp': '/sign-up',
};


// --- 2. GO ROUTER SETUP ---

// 🔥 CRITICAL CHANGE: ShellRoute is removed. All routes are now independent GoRoutes.
final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    // --- Auth Routes ---
    GoRoute(
      path: _navPaths['SignIn']!,
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const AuthScreen(isSignUp: false),
      ),
    ),
    GoRoute(
      path: _navPaths['SignUp']!,
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const AuthScreen(isSignUp: true),
      ),
    ),

    // --- Main App Routes (Independent GoRoutes) ---
    GoRoute(
      path: _navPaths['Home']!,
      pageBuilder: (context, state) => MaterialPage(key: state.pageKey, child: const HomeScreen()),
    ),
    GoRoute(
      path: _navPaths['Products']!,
      pageBuilder: (context, state) => MaterialPage(key: state.pageKey, child: const ProductsScreen()),
    ),
    GoRoute(
      path: _navPaths['Solutions']!,
      pageBuilder: (context, state) => MaterialPage(key: state.pageKey, child: const SolutionsScreen()),
    ),
    GoRoute(
      path: _navPaths['Services']!,
      pageBuilder: (context, state) => MaterialPage(key: state.pageKey, child: const ServicesScreen()),
    ),
    GoRoute(
      path: _navPaths['Quality & Compliance']!,
      pageBuilder: (context, state) => MaterialPage(key: state.pageKey, child: const QualityComplianceScreen()),
    ),
    GoRoute(
      path: _navPaths['About Us']!,
      pageBuilder: (context, state) => MaterialPage(key: state.pageKey, child: const AboutUsScreen()),
    ),
    GoRoute(
      path: _navPaths['Contact']!,
      pageBuilder: (context, state) => MaterialPage(key: state.pageKey, child: const ContactScreen()),
    ),
  ],
);


// --- 3. CORE APP WIDGETS ---

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

// 🔥 REMOVED: AppLayout and ResponsiveDrawer widgets.
// Your individual screen files now fully control their own Scaffold, AppBar, and Footer.

// The placeholder screen definitions for the detailed pages were previously removed to allow the imports at the top to work.
// The PlaceholderAuthScreen has also been removed as you have a dedicated auth_screen.dart file.