import 'package:e_shop/core/config/route/app_route.dart';
import 'package:e_shop/features/home/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../ authentication/screen/login_screen.dart';
import '../../../core/config/resource/images.dart';
import '../../../core/config/themes/app_color.dart';

class LandingScreen extends StatefulWidget {
  static String route = '/';

  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController productController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController customizationController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isDesktop = constraints.maxWidth > 1200;
            final isTablet =
                constraints.maxWidth > 600 && constraints.maxWidth <= 1200;
            final isMobile = constraints.maxWidth <= 600;

            return Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [AppColor.surface, AppColor.background],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Hero Section
                  Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: isMobile
                            ? 300
                            : isTablet
                                ? 450
                                : 600,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(Images.landingImg),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: isMobile
                            ? 24
                            : isTablet
                                ? 32
                                : 40,
                        left: 16, // Add margin from left
                        right: 16, // Add margin from right
                        child: Center(
                          child: Container(
                            padding: const EdgeInsets.all(24.0),
                            constraints: BoxConstraints(
                              maxWidth: isMobile
                                  ? double
                                      .infinity // allow full width but margin from screen
                                  : isTablet
                                      ? 500
                                      : 600,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(
                                  24.0), // slightly more rounded
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Clay Products Shop',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium
                                      ?.copyWith(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.bold,
                                        fontSize: isMobile
                                            ? 24
                                            : isTablet
                                                ? 32
                                                : 40,
                                      ),
                                ),
                                const SizedBox(height: 16.0),
                                const Text(
                                  "We're dedicated to offering you more than just pottery and ceramics!",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black54,
                                  ),
                                ),
                                const SizedBox(height: 20.0),
                                ElevatedButton(
                                  onPressed: () {
                                    AppRoute.goToNextPage(
                                        context: context,
                                        screen: HomeScreen.route,
                                        arguments: {});
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFA97957),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 32.0, vertical: 14.0),
                                  ),
                                  child: const Text(
                                    'SHOP NOW',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Content Section
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile
                          ? 16.0
                          : isTablet
                              ? 32.0
                              : 64.0,
                      vertical: 40.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Oursoil (Handmade Clay Craft) – Crafting Tradition, Shaping Elegance',
                          style: TextStyle(
                            fontSize: isMobile
                                ? 24
                                : isTablet
                                    ? 32
                                    : 40,
                            fontWeight: FontWeight.bold,
                            color: AppColor.textPrimary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'At Oursoil (Handmade Clay Craft), we don’t just create clay pots—we bring an ancient art form to the modern world. Rooted in tradition and crafted with precision, our black pottery is a tribute to heritage, sustainability, and the unmatched beauty of handmade perfection.\n\n'
                          'For generations, this traditional craft was practiced in small artisan communities, often hidden from the world. Today, through Oursoil, we bring this age-old artistry online, making it accessible to homes everywhere. Each piece is shaped from pure, natural clay, fired using time-honored techniques that enhance both durability and aesthetics.\n\n'
                          'Our cookware collection offers a healthier, chemical-free cooking experience, while our decorative pottery adds an earthy elegance to any space. But more than just pottery, we are reviving a legacy—connecting skilled artisans with people who appreciate authenticity and craftsmanship.\n\n'
                          '🌿 Sustainable | Authentic | Timeless',
                          style: TextStyle(
                            fontSize: isMobile
                                ? 14
                                : isTablet
                                    ? 16
                                    : 18,
                            color: AppColor.grey,
                            height: 1.6,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        const SizedBox(height: 24),
                        Center(
                          child: Text(
                            'Experience the magic of black pottery, now at your fingertips—where tradition meets contemporary living, only at Oursoil.',
                            style: TextStyle(
                              fontSize: isMobile
                                  ? 16
                                  : isTablet
                                      ? 18
                                      : 20,
                              fontWeight: FontWeight.w600,
                              color: AppColor.textSecondary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 32),
                        Center(
                          child: Text(
                            "Planning to buy in bulk? We offer special pricing and customization for large orders.",
                            style: TextStyle(
                              fontSize: isMobile ? 14 : 16,
                              color: AppColor.textPrimary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Bulk Order Form Fields
                        Form(
                          key: _formKey,
                          child: isMobile
                              ? Column(
                                  children:
                                      _buildFormFields(), // Mobile: Stack in column
                                )
                              : Wrap(
                                  spacing: 16,
                                  runSpacing: 16,
                                  alignment: WrapAlignment.center,
                                  children:
                                      _buildFormFields(), // Desktop: Side by side
                                ),
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: ElevatedButton(
                            onPressed: _sendWhatsAppMessage,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFA97957),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 32.0, vertical: 14.0),
                            ),
                            child: const Text(
                              "Place a Bulk Order",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Center(
                          child: Text(
                            "We’re here to assist you with any inquiries or support you may need.",
                            style: TextStyle(
                              fontSize: isMobile ? 14 : 16,
                              color: AppColor.textSecondary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              Images.whatsApp,
                              height: isMobile ? 24 : 28,
                            ),
                            Text(
                              "+91 98673 96504",
                              style: TextStyle(
                                fontSize: isMobile ? 14 : 16,
                                color: AppColor.textSecondary,
                              ),
                            ),
                            const SizedBox(width: 20),
                            const Icon(Icons.email_outlined,
                                color: Colors.white),
                            Text(
                              "oursoil.2020@gmail.com",
                              style: TextStyle(
                                fontSize: isMobile ? 14 : 16,
                                color: AppColor.textSecondary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.primaryColor,
      iconTheme: const IconThemeData(color: AppColor.white),
      elevation: 0,
      titleSpacing: 16,
      title: LayoutBuilder(
        builder: (context, constraints) {
          double width = constraints.maxWidth;
          double logoHeight = width >= 1024
              ? 50
              : width >= 600
                  ? 42
                  : 36;
          return SizedBox(
            height: logoHeight,
            child: Image.asset(Images.logo, fit: BoxFit.contain),
          );
        },
      ),
      actions: [
        if (MediaQuery.of(context).size.width > 360)
          TextButton.icon(
            onPressed: () => AppRoute.goToNextPage(
                context: context, screen: LoginScreen.route, arguments: {}),
            icon: const Icon(Icons.login, color: AppColor.white),
            label: Text('Login',
                style: GoogleFonts.poppins(
                    color: AppColor.white, fontWeight: FontWeight.w500)),
          )
        else
          IconButton(
            onPressed: () => AppRoute.goToNextPage(
                context: context, screen: LoginScreen.route, arguments: {}),
            icon: const Icon(Icons.login, color: AppColor.white),
          ),
        const SizedBox(width: 12),
      ],
    );
  }

  List<Widget> _buildFormFields() {
    return [
      _buildTextField("Name", nameController),
      _buildTextField("Contact Number", contactController),
      _buildTextField("Product Interested In", productController),
      _buildTextField("Quantity", quantityController),
      _buildTextField("Customization Needs", customizationController,
          maxLines: 2),
    ];
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _sendWhatsAppMessage() {
    if (_formKey.currentState!.validate()) {
      final message = '''
*Bulk Order Inquiry*
Name: ${nameController.text}
Contact: ${contactController.text}
Product: ${productController.text}
Quantity: ${quantityController.text}
Customization: ${customizationController.text}
''';

      final uri = Uri.parse(
          'https://wa.me/9867396504?text=${Uri.encodeComponent(message)}');
      launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

Widget _buildTextField(String label, TextEditingController controller,
    {int maxLines = 1}) {
  return SizedBox(
    width: 600,
    child: TextFormField(
      controller: controller,
      maxLines: maxLines,
      validator: (value) => value == null || value.isEmpty ? 'Required' : null,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    ),
  );
}
