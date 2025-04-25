import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../features/cart/screen/cart_screen.dart';
import '../../features/product_details/screen/product_detail_screen.dart';
import '../config/route/app_route.dart';
import '../config/themes/app_color.dart';

class ProductCard extends StatelessWidget {
  final String id;
  final String name;
  final double price;
  final String imageUrl;

  const ProductCard({
    super.key,
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 1024;
    final isDesktop = screenWidth >= 1024;

    return GestureDetector(
      onTap: () {
        AppRoute.goToNextPage(
          context: context,
          screen: ProductDetailsScreen.route,
          arguments: {
            'productId': id, //
          },
        );
      },
      child: Card(
        elevation: 4,
        color: AppColor.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  imageUrl,
                  height: isMobile
                      ? 130.h
                      : isTablet
                          ? 180.h
                          : 200.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: isMobile ? 120.h : 180.h,
                    color: Colors.grey[200],
                    child: Icon(Icons.broken_image, size: 40.sp),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Name
              Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                  fontSize: isMobile ? 14 : 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.blueGrey[800],
                ),
              ),
              const SizedBox(height: 8),

              // Price
              Text(
                '₹${price.toStringAsFixed(2)}',
                style: GoogleFonts.poppins(
                  fontSize: isMobile ? 13 : 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.blueGrey[600],
                ),
              ),
              // const SizedBox(height: 8),
              Spacer(),
              // Add to Cart Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    cartItems.add(CartItem(
                      name: name,
                      price: price,
                      imageUrl: imageUrl,
                    ));
                    (context as Element).markNeedsBuild();
                  },
                  icon: Icon(Icons.add_shopping_cart,
                      color: AppColor.white, size: isMobile ? 16 : 18),
                  label: Text(
                    'Add to Cart',
                    style: TextStyle(
                      fontSize: isMobile ? 14 : 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 12 : 20,
                      vertical: isMobile ? 10 : 14,
                    ),
                    backgroundColor: AppColor.secondaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
