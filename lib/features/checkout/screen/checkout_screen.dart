import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:razorpay_web/razorpay_web.dart';


import '../../../core/config/themes/app_color.dart';
import '../../cart/screen/cart_screen.dart';

// Assuming cartItems is defined globally as in your previous code
// If not, you'll need to pass it or manage it via state management
// For this example, I'll assume cartItems is accessible
// List<CartItem> cartItems = []; // Should already be defined in your main.dart

//rzp_test_RlibmHzVyH6Rwk



class CheckoutScreen extends StatefulWidget {
  static const route = '/checkout';
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _streetAddressController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _zipCodeController = TextEditingController();
  final _countryController = TextEditingController();
  String? _selectedPaymentMethod;
  bool _isLoading = false;

  final List<String> _paymentMethods = [
    'Credit Card',
    'PayPal',
    'Cash on Delivery',
  ];

  late Razorpay _razorpay;

  double get totalPrice {
    return cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));
  }

  @override
  void initState() {
    super.initState();
    // Initialize Razorpay
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    // Redirect to cart if cart is empty
    if (cartItems.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, '/cart');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Your cart is empty')),
        );
      });
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _streetAddressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipCodeController.dispose();
    _countryController.dispose();
    _razorpay.clear(); // Clear Razorpay instance
    super.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // On successful payment, place the order
    _placeOrderAfterPayment();
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    setState(() {
      _isLoading = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Payment failed: ${response.message ?? "Unknown error"}')),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('External wallet selected: ${response.walletName}')),
    );
  }

  Future<void> _placeOrderAfterPayment() async {
    setState(() {
      _isLoading = true;
    });
    // Simulate order placement (e.g., save to backend)
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _isLoading = false;
      cartItems.clear();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Order placed successfully!')),
    );
    // Navigate back to home screen
    Navigator.pushReplacementNamed(context, '/home');
  }

  void _initiateRazorpayPayment() {
    var options = {
      'key': 'rzp_test_g52cA1ZI1maLey', // Replace with your Razorpay Key ID
      'amount': (totalPrice * 100).toInt(), // Amount in paise (totalPrice * 100)
      'name': 'E-Shop',
      'description': 'Order Payment',
      'prefill': {
        'contact': '9123456789', // Replace with user's phone number
        'email': 'user@example.com', // Replace with user's email
      },
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error initiating payment: $e')),
      );
    }
  }

  Future<void> _handleOrderPlacement() async {
    if (_formKey.currentState!.validate() && _selectedPaymentMethod != null) {
      setState(() {
        _isLoading = true;
      });

      if (_selectedPaymentMethod == 'Cash on Delivery') {
        // Directly place the order for Cash on Delivery
        await _placeOrderAfterPayment();
      } else {
        // Initiate Razorpay payment for other methods
        _initiateRazorpayPayment();
      }
    } else if (_selectedPaymentMethod == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a payment method')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildShippingSection(),
                const SizedBox(height: 32),
                _buildPaymentSection(),
                const SizedBox(height: 32),
                _buildOrderSummary(),
                const SizedBox(height: 32),
                _buildOrderButton(),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColor.primaryColor,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        'Checkout',
        style: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildShippingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Shipping Address',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.blueGrey[800],
          ),
        ).animate().fadeIn(delay: 200.ms),
        const SizedBox(height: 16),
        _buildTextField(
          controller: _fullNameController,
          label: 'Full Name',
          icon: Icons.person,
          delay: 400,
          validatorText: 'Please enter your full name',
        ),
        const SizedBox(height: 16),
        _buildTextField(
          controller: _streetAddressController,
          label: 'Street Address',
          icon: Icons.home,
          delay: 600,
          maxLines: 2,
          validatorText: 'Please enter your street address',
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildTextField(
                controller: _cityController,
                label: 'City',
                delay: 800,
                validatorText: 'Please enter your city',
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildTextField(
                controller: _stateController,
                label: 'State',
                delay: 1000,
                validatorText: 'Please enter your state',
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildTextField(
                controller: _zipCodeController,
                label: 'Zip Code',
                delay: 1200,
                inputType: TextInputType.number,
                validatorText: 'Please enter your zip code',
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildTextField(
                controller: _countryController,
                label: 'Country',
                delay: 1400,
                validatorText: 'Please enter your country',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? validatorText,
    IconData? icon,
    int delay = 0,
    int maxLines = 1,
    TextInputType inputType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: inputType,
      decoration: InputDecoration(
        labelText: label,
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
        prefixIcon: icon != null
            ? Icon(
          icon,
          color: AppColor.primaryColor,
        )
            : null,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return validatorText;
        }
        return null;
      },
    ).animate().fadeIn(delay: Duration(milliseconds: delay)).slideX(begin: -0.2, end: 0.0);
  }


  Widget _buildPaymentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment Method',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.blueGrey[800],
          ),
        ).animate().fadeIn(delay: 1600.ms),
        const SizedBox(height: 16),
        ..._paymentMethods.map((method) {
          return RadioListTile<String>(
            title: Text(
              method,
              style: GoogleFonts.poppins(fontSize: 16, color: Colors.blueGrey[800]),
            ),
            value: method,
            groupValue: _selectedPaymentMethod,
            onChanged: (value) {
              setState(() {
                _selectedPaymentMethod = value;
              });
            },
            activeColor: Colors.blueGrey,
          ).animate().fadeIn(
              delay: Duration(milliseconds: 1800 + (_paymentMethods.indexOf(method) * 200)));
        }).toList(),
      ],
    );
  }

  Widget _buildOrderSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Order Summary',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.blueGrey[800],
          ),
        ).animate().fadeIn(delay: 2200.ms),
        const SizedBox(height: 16),
        Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                ...cartItems.asMap().entries.map((entry) {
                  final index = entry.key;
                  final item = entry.value;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${item.name} (x${item.quantity})',
                          style: GoogleFonts.poppins(fontSize: 14, color: Colors.blueGrey[800]),
                        ),
                        Text(
                          '₹${(item.price * item.quantity).toStringAsFixed(2)}',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.blueGrey[800],
                          ),
                        ),
                      ],
                    ),
                  ).animate().fadeIn(delay: Duration(milliseconds: 2400 + (index * 200)));
                }),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Price:',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.blueGrey[800],
                      ),
                    ),
                    Text(
                      '₹${totalPrice.toStringAsFixed(2)}',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.blueGrey[800],
                      ),
                    ),
                  ],
                ).animate().fadeIn(delay: const Duration(milliseconds: 2800)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOrderButton() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blueGrey),
        ),
      );
    }

    return ElevatedButton(
      onPressed: _handleOrderPlacement,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.primaryColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(
        _selectedPaymentMethod == 'Cash on Delivery' ? 'Place Order' : 'Make Payment',
        style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    ).animate().fadeIn(delay: const Duration(milliseconds: 3000));
  }


/*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[700],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Checkout',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Shipping Address Section
                Text(
                  'Shipping Address',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.blueGrey[800],
                  ),
                ).animate().fadeIn(delay: 200.ms),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _fullNameController,
                  decoration: InputDecoration(
                    labelText: 'Full Name',
                    labelStyle: GoogleFonts.poppins(color: Colors.blueGrey[600]),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.blueGrey[200]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.blueGrey, width: 2),
                    ),
                    prefixIcon: const Icon(Icons.person, color: Colors.blueGrey),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your full name';
                    }
                    return null;
                  },
                ).animate().fadeIn(delay: 400.ms),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _streetAddressController,
                  maxLines: 2,
                  decoration: InputDecoration(
                    labelText: 'Street Address',
                    labelStyle: GoogleFonts.poppins(color: Colors.blueGrey[600]),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.blueGrey[200]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.blueGrey, width: 2),
                    ),
                    prefixIcon: const Icon(Icons.home, color: Colors.blueGrey),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your street address';
                    }
                    return null;
                  },
                ).animate().fadeIn(delay: 600.ms),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _cityController,
                        decoration: InputDecoration(
                          labelText: 'City',
                          labelStyle: GoogleFonts.poppins(color: Colors.blueGrey[600]),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.blueGrey[200]!),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.blueGrey, width: 2),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your city';
                          }
                          return null;
                        },
                      ).animate().fadeIn(delay: 800.ms),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: _stateController,
                        decoration: InputDecoration(
                          labelText: 'State',
                          labelStyle: GoogleFonts.poppins(color: Colors.blueGrey[600]),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.blueGrey[200]!),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.blueGrey, width: 2),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your state';
                          }
                          return null;
                        },
                      ).animate().fadeIn(delay: 1000.ms),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _zipCodeController,
                        decoration: InputDecoration(
                          labelText: 'Zip Code',
                          labelStyle: GoogleFonts.poppins(color: Colors.blueGrey[600]),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.blueGrey[200]!),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.blueGrey, width: 2),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your zip code';
                          }
                          return null;
                        },
                      ).animate().fadeIn(delay: 1200.ms),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: _countryController,
                        decoration: InputDecoration(
                          labelText: 'Country',
                          labelStyle: GoogleFonts.poppins(color: Colors.blueGrey[600]),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.blueGrey[200]!),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.blueGrey, width: 2),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your country';
                          }
                          return null;
                        },
                      ).animate().fadeIn(delay: 1400.ms),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Payment Method Section
                Text(
                  'Payment Method',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.blueGrey[800],
                  ),
                ).animate().fadeIn(delay: 1600.ms),
                const SizedBox(height: 16),
                Column(
                  children: _paymentMethods.map((method) {
                    return RadioListTile<String>(
                      title: Text(
                        method,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.blueGrey[800],
                        ),
                      ),
                      value: method,
                      groupValue: _selectedPaymentMethod,
                      onChanged: (value) {
                        setState(() {
                          _selectedPaymentMethod = value;
                        });
                      },
                      activeColor: Colors.blueGrey,
                    ).animate().fadeIn(delay: Duration(milliseconds: 1800 + (_paymentMethods.indexOf(method) * 200)));
                  }).toList(),
                ),
                const SizedBox(height: 32),

                // Order Summary Section
                Text(
                  'Order Summary',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.blueGrey[800],
                  ),
                ).animate().fadeIn(delay: 2200.ms),
                const SizedBox(height: 16),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        ...cartItems.asMap().entries.map((entry) {
                          final index = entry.key;
                          final item = entry.value;
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${item.name} (x${item.quantity})',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: Colors.blueGrey[800],
                                  ),
                                ),
                                Text(
                                  '₹${(item.price * item.quantity).toStringAsFixed(2)}',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.blueGrey[800],
                                  ),
                                ),
                              ],
                            ),
                          ).animate().fadeIn(delay: Duration(milliseconds: 2400 + (index * 200)));
                        }),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Price:',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.blueGrey[800],
                              ),
                            ),
                            Text(
                              '₹${totalPrice.toStringAsFixed(2)}',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.blueGrey[800],
                              ),
                            ),
                          ],
                        ).animate().fadeIn(delay: const Duration(milliseconds: 2800)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // Place Order / Make Payment Button
                _isLoading
                    ? const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blueGrey),
                  ),
                )
                    : ElevatedButton(
                  onPressed: _handleOrderPlacement,
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
                    _selectedPaymentMethod == 'Cash on Delivery'
                        ? 'Place Order'
                        : 'Make Payment',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ).animate().fadeIn(delay: const Duration(milliseconds: 3000)),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

   */
}








