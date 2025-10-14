// lib/widgets/responsive_navbar.dart
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../constants/app_constants.dart';

// --- HELPER WIDGETS FOR STYLING ---

// Helper for general gradient text links (e.g., Nav Links)
class _GradientTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final LinearGradient gradient;
  final double fontSize;

  const _GradientTextButton({
    required this.text,
    required this.onPressed,
    required this.gradient,
    this.fontSize = 18.0, 
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
            fontWeight: FontWeight.w700,
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

  const _SolidGradientButton({
    required this.text,
    required this.onPressed,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // Apply the gradient as the background box
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        gradient: gradient, 
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          // Set button background color to transparent to show the gradient Container
          backgroundColor: Colors.transparent, 
          elevation: 0, // Remove shadows
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          foregroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white, 
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

// --- MAIN NAVBAR WIDGET ---

class ResponsiveNavBar extends StatelessWidget implements PreferredSizeWidget {
  const ResponsiveNavBar({super.key});

  @override
  // Height remains at 110.0 to prevent overflow
  Size get preferredSize => const Size.fromHeight(110.0);

  // Define the blue-heavy gradient for the text/icons
  static const LinearGradient _textGradient = LinearGradient(
    colors: [
      AppColors.primaryGreen,
      AppColors.primaryBlue,
      AppColors.primaryBlue, // More blue emphasis
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  @override
  Widget build(BuildContext context) {
    bool isDesktop = MediaQuery.of(context).size.width > 1000;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 80.0 : 20.0, vertical: 15.0),
      // Background is fully transparent
      color: Colors.transparent, 
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo (Image + Stacked Text, all Gradiented)
          ShaderMask(
            shaderCallback: (bounds) => _textGradient.createShader(bounds),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 1. The Logo Image
                Image.asset(
                  'assets/images/spectrum_logo.png', // Logo path
                  // --- FIX: Increased height from 40.0 to 60.0 ---
                  height: 60.0, 
                  color: Colors.white, 
                ),
                const SizedBox(width: 10), // Spacing
                // 2. The Stacked Text
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'SPECTRUM',
                      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontSize: isDesktop ? 34 : 24, 
                        color: Colors.white, 
                        fontWeight: FontWeight.w900,
                        height: 1.0, 
                      ),
                    ),
                    Text(
                      'MEDICAL SOLUTIONS',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: isDesktop ? 14 : 10, 
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        letterSpacing: isDesktop ? 3.0 : 1.5, 
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          if (isDesktop)
            // Desktop Links & Auth Buttons
            Row(
              children: [
                // 1. Navigation Links (Gradient Text)
                ...AppConstants.navLinks.map((link) => Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: _GradientTextButton(
                    text: link,
                    onPressed: () {},
                    gradient: _textGradient,
                  ),
                )).toList(),

                // Spacer between Nav Links and Auth Links
                const SizedBox(width: 40.0),

                // 2. Auth Links (Solid Gradient Buttons)
                _SolidGradientButton(
                  text: 'Sign In',
                  onPressed: () {},
                  gradient: _textGradient,
                ),
                const SizedBox(width: 10.0), // Space between buttons
                _SolidGradientButton(
                  text: 'Sign Up',
                  onPressed: () {},
                  gradient: _textGradient,
                ),
              ],
            ),

          if (!isDesktop)
            // Mobile Menu Button & Primary CTA
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Primary Mobile CTA (Solid Gradient Button)
                _SolidGradientButton(
                  text: 'Sign Up',
                  onPressed: () {},
                  gradient: _textGradient,
                ),
                const SizedBox(width: 10),
                // Menu Button (Gradient Icon)
                ShaderMask(
                  shaderCallback: (bounds) => _textGradient.createShader(bounds),
                  child: IconButton(
                    icon: const Icon(Icons.menu, color: Colors.white), 
                    onPressed: () {
                      // TODO: Implement Mobile Drawer. All other links (Home, Services, Sign In) will go here.
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