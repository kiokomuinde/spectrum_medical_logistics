// lib/screens/auth_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart'; 
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; 
import '../theme/app_theme.dart';
import '../services/auth_service.dart';

// --- REQUIRED EXTERNAL WIDGET IMPORTS ---
import '../widgets/responsive_navbar.dart'; 
import '../widgets/app_footer.dart';        

class AuthScreen extends StatefulWidget {
  final bool isSignUp;

  const AuthScreen({super.key, required this.isSignUp});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with SingleTickerProviderStateMixin {
  late bool _isSignUp;
  bool _isLoading = false; 
  bool _obscurePassword = true; 
  String? _firebaseErrorMessage; 
  
  final AuthService _authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _facilityController = TextEditingController();
  
  bool _agreedToTerms = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // NEW: Specifically to validate only the terms checkbox for social logins
  final GlobalKey<FormFieldState<bool>> _termsCheckboxKey = GlobalKey<FormFieldState<bool>>();

  @override
  void initState() {
    super.initState();
    _isSignUp = widget.isSignUp;
  }

  @override
  void didUpdateWidget(covariant AuthScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSignUp != oldWidget.isSignUp) {
      setState(() {
        _isSignUp = widget.isSignUp;
        _firebaseErrorMessage = null; 
        _agreedToTerms = false;
      });
    }
  }

  void _toggleAuthMode() {
    context.go(_isSignUp ? '/sign-in' : '/sign-up');
  }

  // --- GOOGLE SIGN IN HANDLER (UPDATED VALIDATION) ---
  Future<void> _handleGoogleSignIn() async {
    // Check Terms & Conditions ONLY if on Sign Up screen
    if (_isSignUp) {
      final bool isTermsValidated = _termsCheckboxKey.currentState?.validate() ?? false;
      if (!isTermsValidated) {
        setState(() => _firebaseErrorMessage = "Please accept the terms and conditions.");
        return; 
      }
    }

    setState(() {
      _isLoading = true;
      _firebaseErrorMessage = null;
    });

    try {
      await _authService.signInWithGoogle();
      if (mounted) context.go('/'); 
    } on FirebaseAuthException catch (e) {
      setState(() => _firebaseErrorMessage = e.message ?? "Google Sign-In failed.");
    } catch (e) {
      setState(() => _firebaseErrorMessage = "An unexpected error occurred.");
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _submitAuthForm() async {
    setState(() => _firebaseErrorMessage = null);

    // Standard Form Validation (Validates all fields)
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      try {
        if (_isSignUp) {
          await _authService.signUp(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
            fullName: _nameController.text.trim(),
            facilityName: _facilityController.text.trim(),
          );
        } else {
          await _authService.signIn(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          );
        }

        if (mounted) context.go('/'); 

      } on FirebaseAuthException catch (e) {
        setState(() {
          switch (e.code) {
            case 'user-not-found':
              _firebaseErrorMessage = "No account exists for this email.";
              break;
            case 'wrong-password':
              _firebaseErrorMessage = "Incorrect password. Please try again.";
              break;
            case 'email-already-in-use':
              _firebaseErrorMessage = "This email is already registered.";
              break;
            case 'weak-password':
              _firebaseErrorMessage = "Password is too weak.";
              break;
            default:
              _firebaseErrorMessage = e.message ?? "An error occurred.";
          }
        });
      } catch (e) {
        setState(() => _firebaseErrorMessage = "Connection error.");
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDesktop = MediaQuery.of(context).size.width > 800;
    
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const ResponsiveNavBar(),
            Container(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height * 0.8,
              ),
              padding: const EdgeInsets.symmetric(vertical: 60.0, horizontal: 20.0),
              child: Center(
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
                              _isSignUp 
                                ? 'Join Spectrum for a seamless logistics experience.' 
                                : 'Sign in to access your dashboard and services.',
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: AppColors.textMuted),
                            ),
                            
                            if (_firebaseErrorMessage != null) ...[
                              const SizedBox(height: 20),
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.red.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.red.withOpacity(0.3)),
                                ),
                                child: Text(
                                  _firebaseErrorMessage!,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                            
                            const SizedBox(height: 30),

                            if (_isSignUp) ...[
                              _AuthTextFormField(
                                controller: _nameController,
                                labelText: 'Full Name',
                                icon: Icons.person_outline,
                                validator: (val) => (val == null || val.isEmpty) ? 'Name is required' : null,
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

                            _AuthTextFormField(
                              controller: _emailController,
                              labelText: 'Email Address',
                              icon: Icons.email_outlined,
                              keyboardType: TextInputType.emailAddress,
                              validator: (val) {
                                if (val == null || val.isEmpty) return 'Email is required';
                                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(val)) {
                                  return 'Enter a valid email address';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            _AuthTextFormField(
                              controller: _passwordController,
                              labelText: 'Password',
                              icon: Icons.lock_outline,
                              obscureText: _obscurePassword,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword ? Icons.visibility_off : Icons.visibility,
                                  color: AppColors.primaryBlue,
                                ),
                                onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                              ),
                              validator: (val) {
                                if (val == null || val.isEmpty) return 'Password is required';
                                if (val.length < 8) return 'Password must be at least 8 characters';
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),

                            if (_isSignUp) ...[
                              FormField<bool>(
                                key: _termsCheckboxKey, 
                                initialValue: _agreedToTerms,
                                validator: (value) {
                                  if (value == null || value == false) {
                                    return 'You must accept the terms and conditions';
                                  }
                                  return null;
                                },
                                builder: (FormFieldState<bool> state) {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Checkbox(
                                            value: state.value,
                                            onChanged: (bool? value) {
                                              state.didChange(value);
                                              setState(() => _agreedToTerms = value ?? false);
                                            },
                                            activeColor: AppColors.primaryGreen,
                                            side: state.hasError 
                                              ? const BorderSide(color: Colors.red, width: 2) 
                                              : BorderSide(color: AppColors.textMuted.withOpacity(0.5)),
                                          ),
                                          Expanded(
                                            child: Text(
                                              'I agree to the Terms of Service and Privacy Policy.',
                                              style: TextStyle(
                                                color: state.hasError ? Colors.red : AppColors.textMuted, 
                                                fontSize: 13,
                                                fontWeight: state.hasError ? FontWeight.bold : FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      if (state.hasError)
                                        Padding(
                                          padding: const EdgeInsets.only(left: 12.0, top: 4.0),
                                          child: Text(
                                            state.errorText!,
                                            style: const TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                    ],
                                  );
                                },
                              ),
                              const SizedBox(height: 20),
                            ],

                            _isLoading 
                              ? const Center(child: CircularProgressIndicator(color: AppColors.primaryGreen))
                              : _GradientButton(
                                  text: _isSignUp ? 'Sign Up' : 'Sign In',
                                  onPressed: _submitAuthForm,
                                  gradient: AppColors.gentleHighlightGradient,
                                ),
                            
                            const SizedBox(height: 20),
                            const _Separator(),
                            const SizedBox(height: 20),

                            // --- GOOGLE SIGN IN BUTTON (SPANNING FULL WIDTH) ---
                            _SocialLoginButton(
                              label: 'Continue with Google', 
                              onTap: _isLoading ? () {} : _handleGoogleSignIn
                            ),
                            
                            const SizedBox(height: 30),

                            GestureDetector(
                              onTap: _toggleAuthMode,
                              child: Text(
                                _isSignUp ? 'Already have an account? Sign In' : 'Need an account? Sign Up',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
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
            const AppFooter(),
          ],
        ),
      ),
    );
  }
}

// --- SUB-WIDGETS ---

class _AuthTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData icon;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextInputType keyboardType;
  final bool isRequired;
  final String? Function(String?)? validator;

  const _AuthTextFormField({
    required this.controller,
    required this.labelText,
    required this.icon,
    this.obscureText = false,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.isRequired = true,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon, color: AppColors.primaryBlue),
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: AppColors.textMuted.withOpacity(0.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: AppColors.primaryGreen, width: 2.0),
        ),
        errorStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
      validator: validator ?? (value) {
        if (isRequired && (value == null || value.isEmpty)) {
          return 'Please enter your $labelText';
        }
        return null;
      },
    );
  }
}

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

class _SocialLoginButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _SocialLoginButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        // Removed fixed width so it spans the Form width
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: BoxDecoration(
          color: AppColors.lightBackground,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.textMuted.withOpacity(0.3)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const FaIcon(
              FontAwesomeIcons.google, 
              size: 20, 
              color: Colors.redAccent,
            ),
            const SizedBox(width: 12),
            Text(
              label, 
              style: const TextStyle(
                color: AppColors.darkBlue, 
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Separator extends StatelessWidget {
  const _Separator();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(color: AppColors.textMuted)),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Text('OR', style: TextStyle(color: AppColors.textMuted)),
        ),
        const Expanded(child: Divider(color: AppColors.textMuted)),
      ],
    );
  }
}
