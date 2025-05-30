import 'package:e_shop/core/network/base_network.dart';
import 'package:e_shop/features/product_details/bloc/product_detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/config/themes/app_color.dart';
import '../../../core/network/api_connection.dart';
import '../../../core/widgets/common_loading.dart';
import '../../cart/screen/cart_screen.dart';
import '../model/product.detail.response.model.dart';
import '../respository/product.detail.repository.dart';

// Assuming these models are already defined in your project
// If not, you can use these definitions
class Product {
  final String name;
  final double price;
  final List<String> imageUrls;
  final String description;

  const Product({
    required this.name,
    required this.price,
    required this.imageUrls,
    required this.description,
  });
}

class ProductDetailsScreen extends StatefulWidget {
  static const route = '/product-details';
  final String productId;
  const ProductDetailsScreen({super.key, required this.productId});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int _selectedImageIndex = 0;
  int _quantity = 1;

  void _updateQuantity(int newQuantity) {
    if (newQuantity < 1) return; // Prevent quantity from going below 1
    setState(() {
      _quantity = newQuantity;
    });
  }

  void _addToCart(ProductDetailResponseModel product) {
    cartItems.add(CartItem(
      name: product.name,
      price: product.price.toDouble(),
      imageUrl: BaseNetwork.getPocketBaseImageUrl(
        collectionId: product.collectionId,
        recordId: product.id,
        fileName: product.image[0],
      ),
      quantity: _quantity,
    ));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${product.name} added to cart')),
    );
  }

  void _buyNow(ProductDetailResponseModel product) {
    // Add the product to the cart with the selected quantity
    cartItems.add(CartItem(
      name: product.name,
      price: product.price.toDouble(),
      imageUrl: BaseNetwork.getPocketBaseImageUrl(
        collectionId: product.collectionId,
        recordId: product.id,
        fileName: product.image[0],
      ),
      quantity: _quantity,
    ));
    // Navigate to checkout screen
    Navigator.pushNamed(context, '/checkout');
  }

  late ProductDetailBloc _productDetailBloc;

  @override
  void initState() {
    _productDetailBloc = ProductDetailBloc(
      ProjectDetailRepository(api: ApiConnection()),
    );
    _productDetailBloc.add(ProductDetailEventLoad(widget.productId));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 1024;
    final isDesktop = screenWidth >= 1024;

    final Product product = Product(
      name: 'Headphones',
      price: 99.99,
      imageUrls: [
        'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80',
        'https://images.unsplash.com/photo-1607522370275-f14206abe5d3?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80',
      ],
      description: 'Wireless headphones with noise cancellation.',
    );

    // Mock reviews data
    final List<Map<String, dynamic>> reviews = [
      {
        'user': 'Alice',
        'rating': 4.5,
        'comment': 'Great product! Really happy with the quality.',
      },
      {
        'user': 'Bob',
        'rating': 4.0,
        'comment': 'Good value for money, but delivery took a bit long.',
      },
    ];

    // Mock related products data
    final List<Product> relatedProducts = [
      Product(
        name: 'Headphones',
        price: 99.99,
        imageUrls: [
          'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80',
        ],
        description: 'Wireless headphones with noise cancellation.',
      ),
      Product(
        name: 'Sneakers',
        price: 79.99,
        imageUrls: [
          'https://images.unsplash.com/photo-1607522370275-f14206abe5d3?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80',
        ],
        description: 'Stylish and comfortable sneakers.',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Product Details',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: BlocProvider(
          create: (context) => _productDetailBloc,
          child: BlocBuilder<ProductDetailBloc, ProductDetailState>(
            builder: (context, state) {
              if (state is ProductDetailStateLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ProductDetailStateLoaded) {
                final product = state.product;
                return _buildProductDetails(
                    product, reviews, relatedProducts, isMobile, isTablet);
              } else if (state is ProductDetailStateError) {
                return Center(child: Text('Error: ${state.data}'));
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildProductDetails(
      ProductDetailResponseModel product,
      List<Map<String, dynamic>> reviews,
      List<Product> relatedProducts,
      bool isMobile,
      bool isTablet) {
    // This method can be used to build the product details UI
    // You can customize it as per your requirements
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Images Section
          Center(
            child: Column(
              children: [
                Container(
                  height: isMobile
                      ? 300.h
                      : isTablet
                          ? 400.h
                          : 500.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: NetworkImage(BaseNetwork.getPocketBaseImageUrl(
                        collectionId: product.collectionId,
                        recordId: product.id,
                        fileName: product.image[_selectedImageIndex],
                      )),
                      fit: BoxFit.cover,
                    ),
                  ),
                ).animate().fadeIn(delay: 200.ms),
                const SizedBox(height: 16),
                SizedBox(
                  height: 80,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: product.image.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedImageIndex = index;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 8),
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: _selectedImageIndex == index
                                  ? Colors.blueGrey
                                  : Colors.transparent,
                              width: 2,
                            ),
                            image: DecorationImage(
                              image: NetworkImage(
                                  BaseNetwork.getPocketBaseImageUrl(
                                      collectionId: product.collectionId,
                                      recordId: product.id,
                                      fileName: product.image[index])),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ).animate().fadeIn(
                          delay: Duration(milliseconds: 400 + (index * 100)));
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Product Information Section
          Text(
            product.name,
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.blueGrey[800],
            ),
          ).animate().fadeIn(delay: 600.ms),
          const SizedBox(height: 8),
          Text(
            '₹${product.price.toStringAsFixed(2)}',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.blueGrey[600],
            ),
          ).animate().fadeIn(delay: 800.ms),
          const SizedBox(height: 16),
          Text(
            'Description',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.blueGrey[800],
            ),
          ).animate().fadeIn(delay: 1000.ms),
          const SizedBox(height: 8),
          Text(
            product.description,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.blueGrey[600],
            ),
          ).animate().fadeIn(delay: 1200.ms),
          const SizedBox(height: 16),

          // Quantity Selector
          Row(
            children: [
              Text(
                'Quantity:',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.blueGrey[800],
                ),
              ),
              const SizedBox(width: 16),
              IconButton(
                icon: const Icon(Icons.remove, color: Colors.blueGrey),
                onPressed: () {
                  _updateQuantity(_quantity - 1);
                },
              ),
              Text(
                _quantity.toString(),
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.blueGrey[800],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add, color: Colors.blueGrey),
                onPressed: () {
                  _updateQuantity(_quantity + 1);
                },
              ),
            ],
          ).animate().fadeIn(delay: 1400.ms),
          const SizedBox(height: 24),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => _addToCart(product),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey[700],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Add to Cart',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => _buyNow(product),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange[700],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Buy Now',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ).animate().fadeIn(delay: 1600.ms),
          const SizedBox(height: 32),
          _buildReviewSection(reviews),
          const SizedBox(height: 32),
          _buildRelatedProductSection(relatedProducts),
        ],
      ),
    );
  }

  Widget _buildReviewSection(List<Map<String, dynamic>> reviews) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 32),
        Text(
          'Customer Reviews',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.blueGrey[800],
          ),
        ).animate().fadeIn(delay: 1800.ms),
        const SizedBox(height: 16),
        ...reviews.asMap().entries.map((entry) {
          final index = entry.key;
          final review = entry.value;
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          review['user'],
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.blueGrey[800],
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(Icons.star,
                                color: Colors.amber, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              review['rating'].toString(),
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Colors.blueGrey[600],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      review['comment'],
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.blueGrey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
              .animate()
              .fadeIn(delay: Duration(milliseconds: 2000 + (index * 200)));
        }),
      ],
    );
  }

  Widget _buildRelatedProductSection(List<Product> relatedProducts) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 32),
        Text(
          'Related Products',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.blueGrey[800],
          ),
        ).animate().fadeIn(delay: 2400.ms),
        const SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: relatedProducts.length,
            itemBuilder: (context, index) {
              final relatedProduct = relatedProducts[index];
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/product-details',
                    arguments: relatedProduct,
                  );
                },
                child: Container(
                  width: 150,
                  margin: const EdgeInsets.only(right: 16),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(12),
                            ),
                            image: DecorationImage(
                              image: NetworkImage(relatedProduct.imageUrls[0]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                relatedProduct.name,
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.blueGrey[800],
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '₹${relatedProduct.price.toStringAsFixed(2)}',
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blueGrey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
                  .animate()
                  .fadeIn(delay: Duration(milliseconds: 2600 + (index * 200)));
            },
          ),
        ),
      ],
    );
  }
}
