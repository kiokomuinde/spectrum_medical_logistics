import 'package:flutter/material.dart';
import 'package:spectrum_medical_logistics/screens/home_screen.dart';
import 'package:spectrum_medical_logistics/theme/app_theme.dart'; 

void main() {
  runApp(const SpectrumApp());
}

class SpectrumApp extends StatelessWidget {
  const SpectrumApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spectrum Medical Logistics',
      theme: getAppTheme(), 
      
      // Use the builder property to set up the EndDrawer for the mobile navbar
      builder: (context, child) {
        return Scaffold(
          endDrawer: const MobileDrawer(), 
          body: child,
        );
      },
      home: const HomeScreen(),
    );
  }
}

// Placeholder for the Mobile Drawer widget - Now correctly uses Text widgets
class MobileDrawer extends StatelessWidget {
  const MobileDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: AppColors.darkBlue,
            ),
            child: Text(
              'Spectrum Menu',
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: AppColors.textLight),
            ),
          ),
          ListTile(
            title: const Text('Home', style: TextStyle(color: AppColors.darkBlue, fontWeight: FontWeight.bold)),
            onTap: () => Navigator.pop(context), 
          ),
          ListTile(
            title: const Text('Services'),
            onTap: () => Navigator.pop(context), 
          ),
          ListTile(
            title: const Text('Quality'),
            onTap: () => Navigator.pop(context), 
          ),
          ListTile(
            // **FIXED**: Wrapped 'Technology' in a Text widget
            title: const Text('Technology'), 
            onTap: () => Navigator.pop(context), 
          ),
          ListTile(
            // **FIXED**: Wrapped 'Careers' in a Text widget
            title: const Text('Careers'), 
            onTap: () => Navigator.pop(context), 
          ),
          ListTile(
            // **FIXED**: Wrapped 'Contact' in a Text widget
            title: const Text('Contact'), 
            onTap: () => Navigator.pop(context), 
          ),
        ],
      ),
    );
  }
}
