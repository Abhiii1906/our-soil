import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/network/api_connection.dart';
import '../../../core/widgets/common_loading.dart';
import '../../../core/widgets/common_toast.dart';
import '../bloc/auth_bloc.dart';
import '../repository/auth.repository.dart';

// Sign-Up Screen
class SignUpScreen extends StatefulWidget {
  static const route = '/SignUp';
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isLoading = false;
  XFile? _photo;

  late AuthBloc _authBloc;

  @override
  void initState() {
    _authBloc = AuthBloc(
      AuthRepository(
          api: ApiConnection()
      ),
    );
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _authBloc.close();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    });
  }

  Future<void> _pickPhoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _photo = pickedFile;
      });
    }
  }

  void _signUp() {
    if (_formKey.currentState!.validate()) {
      File? fileToSend;

      // Only convert to File if platform is not web and photo is picked
      if (_photo != null && !kIsWeb) {
        fileToSend = File(_photo!.path);
      }

      _authBloc.add(
        AuthRegisterEvent(
          name: _nameController.text.trim(),
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          rePassword:_confirmPasswordController.text.trim(),
          photo: fileToSend, // This will be null if photo is not selected
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFFF5F1E3),
      body: BlocProvider<AuthBloc>(
        create: (context) => _authBloc,
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            // TODO: implement listener
            if (state is AuthLoadingState) {
              showLoading(context);
            } else if (state is AuthRegisterState) {
              hideLoading(context);
              showNotification(context, message: 'Registration successful',status: Status.success);
              // Navigate or do whatever next
            } else if (state is AuthErrorState) {
              hideLoading(context);
              showNotification(context, message: state.data.message.toString(),status: Status.failed);
            }
          },
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 32.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: screenWidth > 600 ? 400 : screenWidth * 0.9,
                  ),
                  child: Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Logo
                            SvgPicture.string(
                              '''
                      <svg width="48" height="48" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M12 2C6.48 2 2 6.48 2 12C2 17.52 6.48 22 12 22C17.52 22 22 17.52 22 12C22 6.48 17.52 2 12 2ZM12 20C7.58 20 4 16.42 4 12C4 7.58 7.58 4 12 4C16.42 4 20 7.58 20 12C20 16.42 16.42 20 12 20ZM12 6C10.34 6 9 7.34 9 9C9 10.66 10.34 12 12 12C13.66 12 15 10.66 15 9C15 7.34 13.66 6 12 6ZM12 14C9.24 14 7 16.24 7 19H17C17 16.24 14.76 14 12 14Z" fill="#5C4033"/>
                      </svg>
                      ''',
                              width: 48,
                              height: 48,
                            ).animate().fadeIn(duration: 600.ms).scale(),
                            const SizedBox(height: 8),
                            Text(
                              'OUR SOIL',
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF4E944F),
                              ),
                            )
                                .animate()
                                .fadeIn(delay: 200.ms)
                                .slideY(begin: -0.2, end: 0.0),
                            const SizedBox(height: 4),
                            Text(
                              'Create your account',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Color(0xFF5C4033).withOpacity(0.6),
                              ),
                            ).animate().fadeIn(delay: 400.ms),
                            const SizedBox(height: 32),

                            // Photo Upload
                            GestureDetector(
                              onTap: _pickPhoto,
                              child: CircleAvatar(
                                radius: 40,
                                backgroundColor: Color(0xFFE9E5D6),
                                backgroundImage: _photo != null
                                    ? FileImage(File(_photo!.path))
                                    : null,
                                child: _photo == null
                                    ? const Icon(
                                        Icons.camera_alt,
                                        size: 40,
                                        color: Color(0xFF5C4033),
                                      )
                                    : null,
                              ),
                            ).animate().fadeIn(delay: 600.ms).scale(),
                            const SizedBox(height: 16),

                            // Full Name
                            _buildThemedInputField(
                              controller: _nameController,
                              label: 'Full Name',
                              icon: Icons.person_outline,
                              validator: (value) =>
                                  value == null || value.isEmpty
                                      ? 'Please enter your name'
                                      : null,
                              delay: 800,
                            ),

                            // Email
                            _buildThemedInputField(
                              controller: _emailController,
                              label: 'Email',
                              icon: Icons.email_outlined,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty)
                                  return 'Please enter your email';
                                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                    .hasMatch(value))
                                  return 'Enter a valid email';
                                return null;
                              },
                              delay: 1000,
                            ),

                            // Password
                            _buildThemedInputField(
                              controller: _passwordController,
                              label: 'Password',
                              icon: Icons.lock_outline,
                              isPassword: true,
                              isVisible: _isPasswordVisible,
                              toggleVisibility: _togglePasswordVisibility,
                              validator: (value) {
                                if (value == null || value.isEmpty)
                                  return 'Please enter your password';
                                if (value.length < 6)
                                  return 'Password must be at least 6 characters';
                                return null;
                              },
                              delay: 1200,
                            ),

                            // Confirm Password
                            _buildThemedInputField(
                              controller: _confirmPasswordController,
                              label: 'Confirm Password',
                              icon: Icons.lock_outline,
                              isPassword: true,
                              isVisible: _isConfirmPasswordVisible,
                              toggleVisibility:
                                  _toggleConfirmPasswordVisibility,
                              validator: (value) {
                                if (value == null || value.isEmpty)
                                  return 'Please confirm your password';
                                if (value != _passwordController.text)
                                  return 'Passwords do not match';
                                return null;
                              },
                              delay: 1400,
                            ),

                            const SizedBox(height: 24),

                            // Sign Up Button
                            _isLoading
                                ? const CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Color(0xFF4E944F)),
                                  )
                                : ElevatedButton(
                                    onPressed: _signUp,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFF4E944F),
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 48, vertical: 12),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                    ),
                                    child: Text(
                                      'Sign Up',
                                      style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ).animate().fadeIn(delay: 1600.ms).scale(
                                    begin: const Offset(0.8, 0.8),
                                    end: const Offset(1.0, 1.0)),

                            const SizedBox(height: 16),

                            // Back to Login
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text(
                                'Already have an account? Login',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: Color(0xFF5C4033),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ).animate().fadeIn(delay: 1800.ms),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildThemedInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isPassword = false,
    bool? isVisible,
    VoidCallback? toggleVisibility,
    String? Function(String?)? validator,
    int delay = 0,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: isPassword && !(isVisible ?? true),
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.poppins(color: Color(0xFF5C4033)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Color(0xFFB7B5A4)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF4E944F), width: 2),
          ),
          prefixIcon: Icon(icon, color: Color(0xFF5C4033)),
          suffixIcon: isPassword
              ? IconButton(
            icon: Icon(
              (isVisible ?? false) ? Icons.visibility : Icons.visibility_off,
              color: Color(0xFFA9C47F),
            ),
            onPressed: toggleVisibility,
          )
              : null,
        ),
      ).animate().fadeIn(delay: Duration(milliseconds: delay)).slideX(begin: delay.isEven ? -0.2 : 0.2, end: 0.0),
    );
  }



}