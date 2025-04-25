import 'package:e_shop/features/cart/screen/cart_screen.dart';
import 'package:e_shop/features/checkout/screen/checkout_screen.dart';
import 'package:e_shop/features/home/screen/home_screen.dart';
import 'package:e_shop/features/onboarding/screen/landing_screen.dart';
import 'package:e_shop/features/product_details/screen/product_detail_screen.dart';
import 'package:flutter/material.dart';
import '../../../features/ authentication/screen/login_screen.dart';
import '../../../features/ authentication/screen/register_screen.dart';
import '../../widgets/screen_404.dart';

class AppRoute{
  Route onGenerateRoute(RouteSettings settings){
    switch(settings.name){
      case '/':
        return MaterialPageRoute(builder: (_) => LandingScreen());
      case '/Home':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case '/SignUp':
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      case '/cart':
        return MaterialPageRoute(builder: (_) => CartScreen());
      case '/checkout':
        return MaterialPageRoute(builder: (_) => CheckoutScreen());
      case '/product-details':
        Map ? argument = settings.arguments as Map ?;
       
        return MaterialPageRoute(builder: (_) => ProductDetailsScreen(
          productId: argument!['productId'],
        ));


      default:
        return  MaterialPageRoute(builder: (_) => const Screen404(
          title: "404",
          message: "'This is a Dead End'",
        ));
    }
  }

  static void goToNextPage({ required BuildContext context,  required String screen, required Map arguments}) {
    Navigator.pushNamed(context, screen,arguments: arguments);
  }

  static void pop(BuildContext context) {
    Navigator.canPop(context) ? Navigator.of(context).pop() : _showErrorCantGoBack(context);
  }

  static void  pushReplacement(BuildContext context, String routeName, { required Map arguments, screen}) {
    Navigator.pushReplacementNamed(context, routeName, arguments: arguments);
  }


  static void popUntil(BuildContext context,String routeName,{required Map arguments}){
    Navigator.of(context).popUntil(ModalRoute.withName(routeName));
  }

  static void pushAndRemoveUntil(BuildContext context, String routeName, {required Map arguments}) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      routeName,
          (Route<dynamic> route) => false,
      arguments: arguments,
    );
  }

  static _showErrorCantGoBack(BuildContext context) {
    const SnackBar(
      content: Text(
        'Oops! Something went wrong. There are no previous screens to navigate back to.',
        style: TextStyle(fontSize: 16),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 3),
    );
  }
}
//No Screen to go Back