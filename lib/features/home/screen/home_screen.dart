import 'package:e_shop/core/config/route/app_route.dart';
import 'package:e_shop/core/network/base_network.dart';
import 'package:e_shop/core/utils/logger.dart';
import 'package:e_shop/features/cart/screen/cart_screen.dart';
import 'package:e_shop/features/home/bloc/category/category_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../ authentication/screen/login_screen.dart';
import '../../../core/config/resource/images.dart';
import '../../../core/config/themes/app_color.dart';
import '../../../core/network/api_connection.dart';
import '../../../core/storage/preference_key.dart';
import '../../../core/storage/secure_storage.dart';
import '../../../core/widgets/category_card.dart';
import '../../../core/widgets/category_filter.dart';
import '../../../core/widgets/product_card.dart';
import '../bloc/product/product_bloc.dart';
import '../repository/category.repository.dart';
import '../repository/product.repository.dart';

class HomeScreen extends StatefulWidget {
  static const route = '/Home';
   HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
/*
class _HomeScreenState extends State<HomeScreen> {
  final pref = Preference();

  late CategoryBloc _categoryBloc;
  late ProductBloc _productBloc;

  String _searchQuery = '';
  String _selectedCategory = '';

  @override
  void initState() {
    _categoryBloc = CategoryBloc(
      CategoryRepository(
          api: ApiConnection()
      ),
    );
    _categoryBloc.add(FetchCategoriesEvent());

    _productBloc = ProductBloc(
      ProductRepository(
          api: ApiConnection()
      ),
    );
    _productBloc.add(FetchProductsEvent(sort: '-created'));
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _categoryBloc.close();
    // TODO: implement
    //  dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        iconTheme: const IconThemeData(color: AppColor.white),
        elevation: 0,
        titleSpacing: 16,
        title: LayoutBuilder(
          builder: (context, constraints) {
            double maxWidth = constraints.maxWidth;

            // Dynamically adjust logo size based on screen width
            double logoHeight = maxWidth >= 1024
                ? 50
                : maxWidth >= 600
                ? 42
                : 36;

            return SizedBox(
              height: logoHeight,
              child: Image.asset(
                Images.logo,
                fit: BoxFit.contain,
              ),
            );
          },
        ),
        actions: [
          if (MediaQuery.of(context).size.width > 360)
            TextButton.icon(
              onPressed: () {
                AppRoute.goToNextPage(context: context, screen: LoginScreen.route, arguments: {});
              },
              icon: const Icon(Icons.login, color: AppColor.white),
              label: Text(
                'Login',
                style: GoogleFonts.poppins(
                  color: AppColor.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          else
            IconButton(
              onPressed: () {
                AppRoute.goToNextPage(context: context, screen: LoginScreen.route, arguments: {});
              },
              icon: const Icon(Icons.login, color: AppColor.white),
            ),
          IconButton(
            tooltip: 'Cart',
            icon: const Icon(Icons.shopping_cart, color: AppColor.white),
            onPressed: () {
              AppRoute.goToNextPage(context: context, screen: CartScreen.route, arguments: {});
            },
          ),
          const SizedBox(width: 12),
        ],
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: AppColor.primaryColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: AppColor.white,
                    child: Image.network(pref.getString(Keys.AVATAR)),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    pref.getString(Keys.NAME).toString(),
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColor.white,
                    ),
                  ),
                  Text(
                    pref.getString(Keys.EMAIL).toString(),
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: AppColor.white.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
            _drawerItem(Icons.person, 'Profile', context),
            _drawerItem(Icons.history, 'Order History', context),
            ListTile(
              leading: const Icon(Icons.logout, color: AppColor.primaryColor),
              title: Text(
                'Logout',
                style: GoogleFonts.poppins(),
              ),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.h),

            // 🔍 BEAUTIFUL SEARCH BAR
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColor.surface,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search for glass, pots...',
                    hintStyle: GoogleFonts.poppins(
                      color: AppColor.grey,
                      fontSize: 14,
                    ),
                    prefixIcon: const Icon(Icons.search, color: AppColor.grey),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onSubmitted: (query) {
                    setState(() => _searchQuery = query);
                    _productBloc.add(
                      FetchProductsEvent(
                        sort: '-created',
                        search: _searchQuery,
                        categoryId: _selectedCategory,
                      ),
                    );
                  },
                ),
              ),
            ),

            SizedBox(height: 16.h),

            BlocProvider(
              create: (context) => _categoryBloc,
              child: BlocBuilder<CategoryBloc, CategoryState>(
                builder: (context, state) {
                  if (state is CategoryLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is CategoryLoadedState) {
                    final categories = state.categories.items;
                    // 🪄 Add "All" option as the first filter
                    final filters = [
                      Filter(label: 'All', isSelected: true,id: ''), // default selection
                      ...categories.map((cat) => Filter(label: cat.name,id: cat.collectionId)),
                    ];
                    return FilterOptionWidget(
                      filters: filters,
                        onSelected: (value) {
                          debugPrint('Selected: $value');

                          // Rebuild filters list with updated selection
                          final updatedFilters = filters.map((f) {
                            return Filter(
                              iconPath: f.iconPath,
                              label: f.label,
                              id: f.id,
                              isSelected: f.id == value,
                            );
                          }).toList();

                          _selectedCategory = value;

                          _productBloc.add(
                            FetchProductsEvent(
                              sort: '-created',
                              search: _searchQuery,
                              categoryId: _selectedCategory,
                            ),
                          );

                          setState(() {
                            // Rebuild with updated filters
                            filters
                              ..clear()
                              ..addAll(updatedFilters);
                          });
                        }

                    ).animate().fadeIn(delay: 1000.ms);
                  } else if (state is CategoryErrorState) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(child:  Text("Failed to load categories: ${state.data.message ?? 'Something went wrong'}")),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ),

            BlocProvider(
              create: (context) => _productBloc,
              child: BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ProductLoadedState) {
                    final products = state.products.items;

                    return LayoutBuilder(
                      builder: (context, constraints) {
                        final width = constraints.maxWidth;

                        final crossAxisCount = width >= 1024
                            ? 4 // Desktop
                            : width >= 600
                            ? 3 // Tablet
                            : 2; // Mobile

                        final childAspectRatio= width >= 1024
                            ?1.0
                            : width >= 600
                            ? 0.6 // Tablet: more natural layout
                            : 0.65;

                        return  Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: GridView.builder(
                            shrinkWrap: true, // 🛟 ADD THIS
                            physics: const NeverScrollableScrollPhysics(), // 🛑 Prevent internal scrolling
                            itemCount: products.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: crossAxisCount,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              childAspectRatio: childAspectRatio,
                            ),
                            itemBuilder: (context, index) {
                              final product = products[index];

                              return ProductCard(
                                name: product.name ?? 'Unknown',
                                price: double.tryParse(product.price.toString()) ?? 0.0,
                                imageUrl: BaseNetwork.getPocketBaseImageUrl(
                                  collectionId: product.collectionId,
                                  recordId: product.id,
                                  fileName: product.image.first,
                                ),
                              );
                            },
                          ),
                        );
                      },
                    );
                  } else if (state is ProductErrorState) {
                    return Center(
                      child: Text(state.data.message ?? "Something went wrong"),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _drawerItem(IconData icon, String title, BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColor.primaryColor),
      title: Text(title, style: GoogleFonts.poppins()),
      onTap: () {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$title clicked')),
        );
      },
    );
  }
}

 */

class _HomeScreenState extends State<HomeScreen> {
  final pref = Preference();

  late final CategoryBloc _categoryBloc;
  late final ProductBloc _productBloc;

  String _searchQuery = '';
  String _selectedCategory = '';

  @override
  void initState() {
    super.initState();

    _categoryBloc = CategoryBloc(CategoryRepository(api: ApiConnection()));
    _productBloc = ProductBloc(ProductRepository(api: ApiConnection()));

    _categoryBloc.add(FetchCategoriesEvent());
    _productBloc.add(FetchProductsEvent(sort: '-created'));
  }

  @override
  void dispose() {
    _categoryBloc.close();
    _productBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _categoryBloc),
        BlocProvider.value(value: _productBloc),
      ],
      child: Scaffold(
        backgroundColor: AppColor.white,
        appBar: _buildAppBar(context),
        drawer: _buildDrawer(context),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              16.verticalSpace,
              _buildSearchBar(),
              16.verticalSpace,
              _buildCategoryFilter(),
              _buildProductGrid(),
            ],
          ),
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
          double logoHeight = width >= 1024 ? 50 : width >= 600 ? 42 : 36;
          return SizedBox(
            height: logoHeight,
            child: Image.asset(Images.logo, fit: BoxFit.contain),
          );
        },
      ),
      actions: [
        if (MediaQuery.of(context).size.width > 360)
          TextButton.icon(
            onPressed: () => AppRoute.goToNextPage(context: context, screen: LoginScreen.route, arguments: {}),
            icon: const Icon(Icons.login, color: AppColor.white),
            label: Text('Login', style: GoogleFonts.poppins(color: AppColor.white, fontWeight: FontWeight.w500)),
          )
        else
          IconButton(
            onPressed: () => AppRoute.goToNextPage(context: context, screen: LoginScreen.route, arguments: {}),
            icon: const Icon(Icons.login, color: AppColor.white),
          ),
        IconButton(
          tooltip: 'Cart',
          icon: const Icon(Icons.shopping_cart, color: AppColor.white),
          onPressed: () => AppRoute.goToNextPage(context: context, screen: CartScreen.route, arguments: {}),
        ),
        const SizedBox(width: 12),
      ],
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: AppColor.primaryColor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: AppColor.white,
                  backgroundImage: NetworkImage(pref.getString(Keys.AVATAR)),
                ),
                const SizedBox(height: 8),
                Text(pref.getString(Keys.NAME).toString(),
                    style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600, color: AppColor.white)),
                Text(pref.getString(Keys.EMAIL).toString(),
                    style: GoogleFonts.poppins(fontSize: 14, color: AppColor.white.withOpacity(0.7))),
              ],
            ),
          ),
          _drawerItem(Icons.person, 'Profile', context),
          _drawerItem(Icons.history, 'Order History', context),
          ListTile(
            leading: const Icon(Icons.logout, color: AppColor.primaryColor),
            title: Text('Logout', style: GoogleFonts.poppins()),
            onTap: () => Navigator.pushReplacementNamed(context, '/login'),
          ),
        ],
      ),
    );
  }

  Widget _drawerItem(IconData icon, String title, BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColor.primaryColor),
      title: Text(title, style: GoogleFonts.poppins()),
      onTap: () {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$title clicked')));
      },
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.surface,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 4)),
          ],
        ),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Search for glass, pots...',
            hintStyle: GoogleFonts.poppins(color: AppColor.grey, fontSize: 14),
            prefixIcon: const Icon(Icons.search, color: AppColor.grey),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 14),
          ),
          onSubmitted: (query) {
            setState(() => _searchQuery = query);
            _fetchProducts();
          },
        ),
      ),
    );
  }


  Widget _buildCategoryFilter() {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CategoryLoadedState) {
          final categories = state.categories.items;

          // 🪄 Add "All" option as the first filter
          final filters = [
            Filter(label: 'All', isSelected: true), // default selection
            ...categories.map((cat) => Filter(label: cat.name)),
          ];

          return FilterOptionWidget(
            filters: filters,
            onSelected: (label) {
              debugPrint('Selected category: $label');
              // Find selected category ID
              String selectedId = '';
              if (label != 'All') {
                final selected = categories.firstWhere(
                      (c) => c.name == label,
                  orElse: () => categories.first,
                );
                selectedId = selected.id;
                debugPrint('Selected category: $selectedId');
              }

                _selectedCategory = selectedId;

                _productBloc.add(
                  FetchProductsEvent(
                    sort: '-created',
                    search: _searchQuery,
                    categoryId: _selectedCategory,
                  ),
                );
              // Optional: Handle "All" category logic here
            },
          ).animate().fadeIn(delay: 1000.ms);
        } else if (state is CategoryErrorState) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Text("Failed to load categories: ${state.data.message ?? 'Something went wrong'}"),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }



  Widget _buildProductGrid() {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ProductLoadedState) {
          final products = state.products.items;

          return LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;

              final crossAxisCount = width >= 1024
                  ? 4
                  : width >= 600
                  ? 3
                  : 2;

              final childAspectRatio = width >= 1024
                  ? 1.0
                  : width >= 600
                  ? 0.6
                  : 0.65;

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: products.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: childAspectRatio,
                  ),
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return ProductCard(
                      id: product.id,
                      name: product.name ?? 'Unknown',
                      price: double.tryParse(product.price.toString()) ?? 0.0,
                      imageUrl: BaseNetwork.getPocketBaseImageUrl(
                        collectionId: product.collectionId,
                        recordId: product.id,
                        fileName: product.image.first,
                      ),
                    );
                  },
                ),
              );
            },
          );
        } else if (state is ProductErrorState) {
          return Center(child: Text(state.data.message ?? "Something went wrong"));
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  void _fetchProducts() {
    _productBloc.add(FetchProductsEvent(
      sort: '-created',
      search: _searchQuery,
      categoryId: _selectedCategory,
    ));
  }
}


