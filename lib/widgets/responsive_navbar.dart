// lib/widgets/responsive_navbar.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // REQUIRED IMPORT for navigation
import '../theme/app_theme.dart';
import '../constants/app_constants.dart';

// --- HELPER WIDGETS FOR STYLING ---

// Helper for general gradient text links (e.g., Nav Links)
class _GradientTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final LinearGradient gradient; 
  final double fontSize;
  final FontWeight fontWeight;

  const _GradientTextButton({
    required this.text,
    required this.onPressed,
    required this.gradient,
    this.fontSize = 18.0, 
    this.fontWeight = FontWeight.w700,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: ShaderMask(
        shaderCallback: (bounds) => gradient.createShader(bounds),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white, // Dummy color for ShaderMask
            fontWeight: fontWeight,
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}

// Helper for solid gradient buttons (Sign In, Sign Up)
class _SolidGradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final LinearGradient gradient; 
  final double fontSize;

  const _SolidGradientButton({
    required this.text,
    required this.onPressed,
    required this.gradient,
    this.fontSize = 18.0, 
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent, // To show the gradient
          shadowColor: Colors.transparent,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: AppColors.textLight,
            fontWeight: FontWeight.w700,
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}

// --- LOGO WIDGET FOR NAVBAR (FINAL UPDATED WITH FULL GRADIENT AND INCREASED SIZE) ---
class _NavBarLogo extends StatelessWidget {
  // Define a new Green-Blue Gradient for the logo text
  final LinearGradient _logoTextGradient = const LinearGradient(
    colors: [
      AppColors.primaryGreen, 
      AppColors.primaryBlue, 
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  const _NavBarLogo();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go('/'),
      child: Row( // Horizontal Row for Logo and Text
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 1. The Logo Icon (NOW USES GRADIENT and is LARGER)
          ShaderMask(
            shaderCallback: (bounds) => _logoTextGradient.createShader(bounds),
            child: Image.asset(
              'assets/images/spectrum_logo.png', // Logo path
              height: 60.0, // *** INCREASED SIZE AGAIN ***
              color: Colors.white, // Dummy color to act as a mask for the gradient
            ),
          ),
          const SizedBox(width: 10), // Spacing
          // 2. The Stacked Text (Both lines now use the Gradient)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // SPECTRUM - Gradient Text
              ShaderMask(
                shaderCallback: (bounds) => _logoTextGradient.createShader(bounds),
                child: Text(
                  'SPECTRUM',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontSize: 28,
                    color: Colors.white, // Dummy color for ShaderMask
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              // MEDICAL LOGISTICS - NOW USES GRADIENT
              ShaderMask(
                shaderCallback: (bounds) => _logoTextGradient.createShader(bounds),
                child: const Text(
                  'MEDICAL LOGISTICS', 
                  style: TextStyle(
                    color: Colors.white, // Dummy color for ShaderMask
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2.0, 
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
// ----------------------------------------


// --- MAIN WIDGET: ResponsiveNavBar ---
class ResponsiveNavBar extends StatelessWidget implements PreferredSizeWidget {
  const ResponsiveNavBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(80.0);

  @override
  Widget build(BuildContext context) {
    bool isDesktop = MediaQuery.of(context).size.width > 900;
    final LinearGradient _textGradient = AppColors.gentleHighlightGradient;
    
    // 🔥 FIX: Reference AppConstants.navPaths directly for use in the widget
    final Map<String, String> _navPaths = AppConstants.navPaths;

    return Container(
      height: preferredSize.height,
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        boxShadow: [
          BoxShadow(color: AppColors.textMuted.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 2)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 1. Logo/App Title (Using the new logo widget)
          const _NavBarLogo(),
          
          const Spacer(), // Separates logo from navigation
          
          // 2. Desktop Navigation Links
          if (isDesktop)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: AppConstants.navLinks.map((linkText) {
                // FIX: Use the fixed _navPaths map
                final path = _navPaths[linkText] ?? '/';
                
                return Padding(
                  padding: const EdgeInsets.only(left: 10.0), // Changed to `only` for consistency
                  child: _GradientTextButton(
                    text: linkText,
                    onPressed: () => context.go(path),
                    gradient: _textGradient,
                    fontSize: 16.0,
                  ),
                );
              }).toList(),
            ),

          const SizedBox(width: 30),

          // 3. Desktop CTAs
          if (isDesktop)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Sign In Button
                TextButton(
                  // FIX: Use _navPaths for navigation
                  onPressed: () => context.go(_navPaths['SignIn']!),
                  child: Text('Sign In', style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.primaryBlue, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(width: 10.0), // Space between buttons

                // Sign Up Button (Solid Gradient CTA)
                _SolidGradientButton(
                  text: 'Sign Up',
                  // FIX: Use _navPaths for navigation
                  onPressed: () => context.go(_navPaths['SignUp']!), 
                  gradient: _textGradient,
                ),
              ],
            ),

          // --- Mobile CTAs ---
          if (!isDesktop)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Primary Mobile CTA (Solid Gradient Button)
                _SolidGradientButton(
                  text: 'Sign Up',
                  onPressed: () => context.go(_navPaths['SignUp']!), 
                  gradient: _textGradient,
                ),
                const SizedBox(width: 10),
                // Menu Button (Gradient Icon)
                ShaderMask(
                  shaderCallback: (bounds) => _textGradient.createShader(bounds),
                  child: IconButton(
                    icon: const Icon(Icons.menu, color: Colors.white), 
                    onPressed: () {
                      // Open the EndDrawer defined in main.dart's AppLayout
                      Scaffold.of(context).openEndDrawer(); 
                    },
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}