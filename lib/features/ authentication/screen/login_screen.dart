import 'package:e_shop/core/config/route/app_route.dart';
import 'package:e_shop/core/utils/logger.dart';
import 'package:e_shop/features/%20authentication/screen/register_screen.dart';
import 'package:e_shop/features/home/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/config/themes/app_color.dart';
import '../../../core/network/api_connection.dart';
import '../../../core/widgets/common_loading.dart';
import '../../../core/widgets/common_toast.dart';
import '../bloc/auth_bloc.dart';
import '../repository/auth.repository.dart';


/*
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      // Simulate login logic
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Logging in...')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get screen width for responsive design
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: screenWidth > 600 ? 400 : screenWidth * 0.9, // Responsive width
              ),
              child: Card(
                elevation: 8,
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
                        // Logo or App Name
                        Text(
                          'E-shop',
                          style: GoogleFonts.poppins(
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                            color: Colors.blueGrey[800],
                          ),
                        )
                            .animate()
                            .fadeIn(duration: 600.ms)
                            .slideY(begin: -0.2, end: 0.0),
                        const SizedBox(height: 8),
                        Text(
                          'Sign in to continue',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.blueGrey[400],
                          ),
                        ).animate().fadeIn(delay: 200.ms),
                        const SizedBox(height: 32),

                        // Email Field
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: GoogleFonts.poppins(
                              color: Colors.blueGrey[600],
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Colors.blueGrey[200]!,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: Colors.blueGrey,
                                width: 2,
                              ),
                            ),
                            prefixIcon: const Icon(
                              Icons.email_outlined,
                              color: Colors.blueGrey,
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                .hasMatch(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        )
                            .animate()
                            .fadeIn(delay: 400.ms)
                            .slideX(begin: -0.2, end: 0.0),
                        const SizedBox(height: 16),

                        // Password Field
                        TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: GoogleFonts.poppins(
                              color: Colors.blueGrey[600],
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Colors.blueGrey[200]!,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: Colors.blueGrey,
                                width: 2,
                              ),
                            ),
                            prefixIcon: const Icon(
                              Icons.lock_outline,
                              color: Colors.blueGrey,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.blueGrey[400],
                              ),
                              onPressed: _togglePasswordVisibility,
                            ),
                          ),
                          obscureText: !_isPasswordVisible,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        )
                            .animate()
                            .fadeIn(delay: 600.ms)
                            .slideX(begin: 0.2, end: 0.0),
                        const SizedBox(height: 24),

                        // Login Button
                        ElevatedButton(
                          onPressed: _login,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueGrey[700],
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 48,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Login',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                            .animate()
                            .fadeIn(delay: 800.ms)
                            .scale(begin: const Offset(0.8, 0.8), end: const Offset(1.0, 1.0)),
                        const SizedBox(height: 16),

                        // Forgot Password Link
                        TextButton(
                          onPressed: () {
                            // Navigate to forgot password screen
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Forgot Password clicked')),
                            );
                          },
                          child: Text(
                            'Forgot Password?',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.blueGrey[600],
                            ),
                          ),
                        ).animate().fadeIn(delay: 1000.ms),
                      ],
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
}

 */





// Login Screen
class LoginScreen extends StatefulWidget {
  static const route = '/login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLoading = false;

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
    _emailController.dispose();
    _passwordController.dispose();
    _authBloc.close();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      _authBloc.add(AuthLoginEvent(
          email: _emailController.text, password: _passwordController.text));
      // setState(() {
      //   _isLoading = true;
      // });
      // // Simulate a login API call
      // await Future.delayed(const Duration(seconds: 2));
      // setState(() {
      //   _isLoading = false;
      // });
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(content: Text('Login successful!')),
      // );
      // Navigate to the e-shop home screen (placeholder)
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    /// Bloc connection is pending 
    return
      BlocProvider<AuthBloc>(
        create: (context) => _authBloc,
        child: Scaffold(
          backgroundColor: AppColor.white,
          body:BlocListener<AuthBloc, AuthState>(
              listener: (context, state)  {
                if (state is AuthLoadingState) {
                   showLoading(context);
                }
                else if (state is AuthLoginState) {
                  hideLoading(context);
                  AppRoute.pushReplacement(context, HomeScreen.route, arguments: {});
                }
                if (state is AuthErrorState) {
                   hideLoading(context);
                   showNotification(context, message: state.data.message.toString(),status: Status.failed);
                }
              },
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: screenWidth > 600 ? 400 : screenWidth * 0.9,
                      ),
                      child: Card(
                        color: AppColor.white,
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
                    <path d="M12 2C6.48 2 2 6.48 2 12C2 17.52 6.48 22 12 22C17.52 22 22 17.52 22 12C22 6.48 17.52 2 12 2ZM12 20C7.58 20 4 16.42 4 12C4 7.58 7.58 4 12 4C16.42 4 20 7.58 20 12C20 16.42 16.42 20 12 20ZM12 6C10.34 6 9 7.34 9 9C9 10.66 10.34 12 12 12C13.66 12 15 10.66 15 9C15 7.34 13.66 6 12 6ZM12 14C9.24 14 7 16.24 7 19H17C17 16.24 14.76 14 12 14Z" fill="#B05C3C"/>
                  </svg>
                  ''',
                                  width: 48,
                                  height: 48,
                                )
                                    .animate()
                                    .fadeIn(duration: 600.ms)
                                    .scale(),
                                const SizedBox(height: 8),
                                Text(
                                  'OUR SOIL',
                                  style: GoogleFonts.poppins(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.primaryColor,
                                  ),
                                )
                                    .animate()
                                    .fadeIn(delay: 200.ms)
                                    .slideY(begin: -0.2, end: 0.0),
                                const SizedBox(height: 4),
                                Text(
                                  'Sign in to start shopping',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: AppColor.grey,
                                  ),
                                ).animate().fadeIn(delay: 400.ms),
                                const SizedBox(height: 32),

                                // Email Field
                                TextFormField(
                                  controller: _emailController,
                                  decoration: InputDecoration(
                                    labelText: 'Email',
                                    labelStyle: GoogleFonts.poppins(
                                      color: AppColor.grey,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                        color: AppColor.lightGrey,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                        color: AppColor.primaryColor,
                                        width: 2,
                                      ),
                                    ),
                                    prefixIcon: const Icon(
                                      Icons.email_outlined,
                                      color: AppColor.primaryColor,
                                    ),
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your email';
                                    }
                                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                        .hasMatch(value)) {
                                      return 'Please enter a valid email';
                                    }
                                    return null;
                                  },
                                )
                                    .animate()
                                    .fadeIn(delay: 600.ms)
                                    .slideX(begin: -0.2, end: 0.0),
                                const SizedBox(height: 16),

                                // Password Field
                                TextFormField(
                                  controller: _passwordController,
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    labelStyle: GoogleFonts.poppins(
                                      color: AppColor.grey,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                        color: AppColor.lightGrey,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                        color: AppColor.primaryColor,
                                        width: 2,
                                      ),
                                    ),
                                    prefixIcon: const Icon(
                                      Icons.lock_outline,
                                      color: AppColor.primaryColor,
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _isPasswordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: AppColor.grey,
                                      ),
                                      onPressed: _togglePasswordVisibility,
                                    ),
                                  ),
                                  obscureText: !_isPasswordVisible,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your password';
                                    }
                                    if (value.length < 6) {
                                      return 'Password must be at least 6 characters';
                                    }
                                    return null;
                                  },
                                )
                                    .animate()
                                    .fadeIn(delay: 800.ms)
                                    .slideX(begin: 0.2, end: 0.0),
                                const SizedBox(height: 24),

                                // Login Button
                                _isLoading
                                    ? const CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(AppColor.primaryColor),
                                )
                                    : ElevatedButton(
                                  onPressed: _login,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColor.primaryColor,
                                    foregroundColor: AppColor.white,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 48,
                                      vertical: 12,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: Text(
                                    'Login',
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                )
                                    .animate()
                                    .fadeIn(delay: 1000.ms)
                                    .scale(begin: const Offset(0.8, 0.8), end: const Offset(1.0, 1.0)),
                                const SizedBox(height: 16),

                                // Forgot Password and Sign Up Links
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('Forgot Password clicked')),
                                        );
                                      },
                                      child: Text(
                                        'Forgot Password?',
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          color: AppColor.grey,
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        AppRoute.goToNextPage(context: context, screen: SignUpScreen.route, arguments: {});
                                      },
                                      child: Text(
                                        'Sign Up',
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          color: AppColor.primaryColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ).animate().fadeIn(delay: 1200.ms),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
      )),
          )
      );
  }
}

