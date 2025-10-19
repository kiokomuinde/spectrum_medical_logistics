// lib/screens/auth_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';

// --- MAIN AUTH SCREEN WIDGET (Handles both Sign In and Sign Up) ---
class AuthScreen extends StatefulWidget {
  final bool isSignUp;

  // Constructor determines initial state based on the route
  const AuthScreen({super.key, required this.isSignUp});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with SingleTickerProviderStateMixin {
  late bool _isSignUp;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _facilityController = TextEditingController();
  bool _agreedToTerms = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _isSignUp = widget.isSignUp;
  }

  @override
  void didUpdateWidget(covariant AuthScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update state if the route changes (e.g., from /sign-in to /sign-up)
    if (widget.isSignUp != oldWidget.isSignUp) {
      setState(() {
        _isSignUp = widget.isSignUp;
      });
    }
  }

  // Smoothly toggles between Sign In and Sign Up states
  void _toggleAuthMode() {
    // Use GoRouter to update the URL for deep linking/browser history
    context.go(_isSignUp ? '/sign-in' : '/sign-up');
  }

  // Placeholder for authentication logic
  void _submitAuthForm() {
    if (_formKey.currentState!.validate()) {
      if (_isSignUp && !_agreedToTerms) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('You must agree to the Terms of Service to sign up.')),
        );
        return;
      }
      
      // Placeholder logic
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${_isSignUp ? 'Signing Up' : 'Signing In'} as ${_emailController.text}'),
        ),
      );
      // Navigate to home after successful auth (placeholder)
      context.go('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDesktop = MediaQuery.of(context).size.width > 800;
    
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(40.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: EdgeInsets.all(isDesktop ? 50.0 : 30.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      // --- Title ---
                      Text(
                        _isSignUp ? 'Create Your Account' : 'Welcome Back',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          color: AppColors.darkBlue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        _isSignUp ? 'Join Spectrum for a seamless logistics experience.' : 'Sign in to access your dashboard and services.',
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: AppColors.textMuted),
                      ),
                      const SizedBox(height: 30),

                      // --- Sign Up Specific Fields ---
                      if (_isSignUp) ...[
                        _AuthTextFormField(
                          controller: _nameController,
                          labelText: 'Full Name',
                          icon: Icons.person_outline,
                        ),
                        const SizedBox(height: 20),
                        _AuthTextFormField(
                          controller: _facilityController,
                          labelText: 'Facility/Company Name',
                          icon: Icons.business_outlined,
                          isRequired: false,
                        ),
                        const SizedBox(height: 20),
                      ],

                      // --- Common Fields ---
                      _AuthTextFormField(
                        controller: _emailController,
                        labelText: 'Email Address',
                        icon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 20),
                      _AuthTextFormField(
                        controller: _passwordController,
                        labelText: 'Password',
                        icon: Icons.lock_outline,
                        isPassword: true,
                      ),
                      const SizedBox(height: 30),

                      // --- Terms Checkbox (Sign Up Only) ---
                      if (_isSignUp) ...[
                        Row(
                          children: [
                            Checkbox(
                              value: _agreedToTerms,
                              onChanged: (bool? value) {
                                setState(() {
                                  _agreedToTerms = value ?? false;
                                });
                              },
                              activeColor: AppColors.primaryGreen,
                            ),
                            const Expanded(
                              child: Text(
                                'I agree to the Terms of Service and Privacy Policy.',
                                style: TextStyle(color: AppColors.textMuted, fontSize: 13),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],

                      // --- Submit Button ---
                      _GradientButton(
                        text: _isSignUp ? 'Sign Up' : 'Sign In',
                        onPressed: _submitAuthForm,
                        gradient: AppColors.gentleHighlightGradient,
                      ),
                      
                      const SizedBox(height: 20),
                      
                      // --- Separator ---
                      const _Separator(),
                      
                      const SizedBox(height: 20),

                      // --- Social Logins ---
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _SocialLoginButton(label: 'Google', onTap: () {}),
                          const SizedBox(width: 20),
                          _SocialLoginButton(label: 'Office365', onTap: () {}),
                        ],
                      ),
                      
                      const SizedBox(height: 30),

                      // --- Switch Auth Mode ---
                      GestureDetector(
                        onTap: _toggleAuthMode,
                        child: Text(
                          _isSignUp ? 'Already have an account? Sign In' : 'Need an account? Sign Up',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.primaryBlue,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


// --- Reusable Form Field ---
class _AuthTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData icon;
  final bool isPassword;
  final TextInputType keyboardType;
  final bool isRequired;

  const _AuthTextFormField({
    required this.controller,
    required this.labelText,
    required this.icon,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.isRequired = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon, color: AppColors.primaryBlue),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: AppColors.textMuted),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: AppColors.textMuted.withOpacity(0.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: AppColors.primaryGreen, width: 2.0),
        ),
        labelStyle: const TextStyle(color: AppColors.textMuted),
      ),
      validator: (value) {
        if (isRequired && (value == null || value.isEmpty)) {
          return 'Please enter your $labelText';
        }
        return null;
      },
    );
  }
}


// --- Reusable Gradient Button ---
class _GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final LinearGradient gradient;

  const _GradientButton({required this.text, required this.onPressed, required this.gradient});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryGreen.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 18),
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: AppColors.darkBlue,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}

// --- Reusable Social Login Button (Placeholder) ---
class _SocialLoginButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _SocialLoginButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 150,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: AppColors.lightBackground,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.textMuted.withOpacity(0.3)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Using placeholder Icons
            Icon(label == 'Google' ? Icons.mail_outline : Icons.laptop_windows, size: 20, color: AppColors.darkBlue),
            const SizedBox(width: 8),
            Text(label, style: const TextStyle(color: AppColors.darkBlue, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

// --- Separator Widget ---
class _Separator extends StatelessWidget {
  const _Separator();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(color: AppColors.textMuted)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text('OR', style: TextStyle(color: AppColors.textMuted)),
        ),
        const Expanded(child: Divider(color: AppColors.textMuted)),
      ],
    );
  }
}