// lib/widgets/app_footer.dart
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../constants/app_constants.dart';

// --- PRODUCT CATEGORIES FROM PRICELIST ---
const List<String> _labCategoryLinks = [
  'Lab Consumables', 
  'Rapid Test Strips', 
  'Endoscopy Consumables', 
  'Radiology Consumables', 
];

const List<String> _imagingDevicesLinks = [
  'X-Ray, CT & MRI Films', 
  'CT Injector Supplies', 
  'Radiation Safety Gear', 
  'Printers & Diagnostics Devices', 
  'Maintenance Services', 
];
// ---------------------------------------------

// Define the Green to White Gradient for Text
const LinearGradient _footerTextGradient = LinearGradient(
  colors: [
    AppColors.primaryGreen, // Brighter color start
    Colors.white,           // White color end
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

// --- HELPER WIDGET FOR GRADIENT TEXT (Restored) ---
class _FooterGradientText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final LinearGradient gradient;

  const _FooterGradientText({
    required this.text,
    required this.gradient,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      // Apply the gradient to the text bounds
      shaderCallback: (bounds) => gradient.createShader(bounds),
      child: Text(
        text,
        // Set the base text color to white so the ShaderMask has something to color
        style: style?.copyWith(color: Colors.white) ?? const TextStyle(color: Colors.white, fontSize: 15),
      ),
    );
  }
}
// ------------------------------------------

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDesktop = MediaQuery.of(context).size.width > 1000;

    return Container(
      // 1. Set the standard base background color
      color: AppColors.darkBlue, 
      child: Center(
        // 2. Apply a Radial Gradient for a subtle, beautiful glow effect
        child: Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.center,
              radius: 1.5, 
              colors: [
                AppColors.darkBlue.withOpacity(0.9), 
                AppColors.primaryGreen.withOpacity(0.05), 
                AppColors.darkBlue, 
              ],
              stops: const [0.0, 0.4, 1.0],
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: isDesktop ? 80.0 : 20.0, vertical: 40.0),
          constraints: const BoxConstraints(maxWidth: 1400), 

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isDesktop
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // 1. Company Logo & Info 
                        const Expanded(flex: 2, child: _FooterCompanyInfo()),
                        // 2. Navigation Links
                        Expanded(flex: 2, child: FooterLinks(title: 'NAVIGATION', links: AppConstants.navLinks.sublist(0, 4))),
                        // 3. Product Links 1
                        Expanded(flex: 2, child: FooterLinks(title: 'LAB & DIAGNOSTICS', links: _labCategoryLinks)),
                        // 4. Product Links 2
                        Expanded(flex: 2, child: FooterLinks(title: 'IMAGING & DEVICES', links: _imagingDevicesLinks)),
                        // 5. Contact Info
                        const Expanded(flex: 1, child: ContactInfo()),
                      ],
                    )
                  : Column(
                      // Mobile structure: stacked sections
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const _FooterCompanyInfo(),
                        const SizedBox(height: 30),
                        FooterLinks(title: 'NAVIGATION', links: AppConstants.navLinks.sublist(0, 4)),
                        const SizedBox(height: 30),
                        FooterLinks(title: 'LAB & DIAGNOSTICS', links: _labCategoryLinks),
                        const SizedBox(height: 30),
                        FooterLinks(title: 'IMAGING & DEVICES', links: _imagingDevicesLinks),
                        const SizedBox(height: 30),
                        const ContactInfo(),
                      ],
                    ),
              const Divider(color: AppColors.cardBackground, height: 40),
              // Copyright Text now uses the gradient
              Center(
                child: _FooterGradientText(
                  text: '© ${DateTime.now().year} Spectrum Medical Logistics. All Rights Reserved.',
                  gradient: _footerTextGradient,
                  style: const TextStyle(fontSize: 14),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// Custom widget for the combined logo and description
class _FooterCompanyInfo extends StatelessWidget {
  const _FooterCompanyInfo();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row( // Horizontal Row for Logo and Text
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 1. The Logo (Pure White)
            Image.asset(
              'assets/images/spectrum_logo.png', // Logo path
              height: 40.0, 
              color: Colors.white, // Pure white color
            ),
            const SizedBox(width: 10), // Spacing
            // 2. The Stacked Text (All Pure White)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'SPECTRUM',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontSize: 28,
                    color: Colors.white, // Pure white
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  'MEDICAL SOLUTIONS',
                  style: const TextStyle(
                    color: Colors.white, // Pure white
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2.0, 
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
        // Description Text uses the gradient
        SizedBox(
          child: _FooterGradientText(
            text: "Specialized Medical Supply Chain Solutions for Diagnostics and Treatment.", 
            gradient: _footerTextGradient,
            style: const TextStyle(fontSize: 15),
          ),
        ),
      ],
    );
  }
}

class FooterLinks extends StatelessWidget {
  final String title;
  final List<String> links;
  const FooterLinks({required this.title, required this.links, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title uses primaryGreen for emphasis
        Text(title, style: const TextStyle(color: AppColors.primaryGreen, fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 15),
        ...links.map((link) => Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          // Link text uses the gradient
          child: _FooterGradientText(
            text: link, 
            gradient: _footerTextGradient, 
            style: const TextStyle(fontSize: 15),
          ),
        )).toList(),
      ],
    );
  }
}

class ContactInfo extends StatelessWidget {
  const ContactInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text('CONTACT US', style: TextStyle(color: AppColors.primaryGreen, fontWeight: FontWeight.bold, fontSize: 16)),
        SizedBox(height: 15),
        // Contact details use the gradient
        FooterContactDetail(icon: Icons.email_outlined, text: 'info@spectrum.com'),
        FooterContactDetail(icon: Icons.phone_outlined, text: '+1 234 567 8900'),
        FooterContactDetail(icon: Icons.location_on_outlined, text: 'Global Hub, Logistics District'),
      ],
    );
  }
}

class FooterContactDetail extends StatelessWidget {
  final IconData icon;
  final String text;
  const FooterContactDetail({required this.icon, required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          // Icon uses primaryBlue for a touch of accent color
          Icon(icon, color: AppColors.primaryBlue, size: 20),
          const SizedBox(width: 10),
          // FIX: Wrap the text in Expanded to prevent overflow
          Expanded(
            child: _FooterGradientText(
              text: text, 
              gradient: _footerTextGradient, 
              style: const TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}