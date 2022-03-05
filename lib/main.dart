import 'package:firebase_core/firebase_core.dart';
import 'package:stack/controller/Themecontroller.dart';
import 'package:stack/controller/auth/authController.dart';
import 'package:stack/navScreens/bottom_nav_Screen.dart';
import 'package:stack/provider/cartProvider.dart';
import 'package:stack/provider/productNotifier.dart';
import 'package:stack/provider/wishListProvider.dart';
import 'package:stack/screens/AppScreen.dart';
import 'package:stack/screens/Landing/Landing.dart';
import 'package:stack/screens/ProductDetails.dart';
import 'package:stack/screens/auth/Login.dart';
import 'package:stack/screens/auth/SignUpScreen.dart';
import 'package:stack/screens/auth/authStateScreen.dart';
import 'package:stack/screens/cart_screen.dart';
import 'package:stack/screens/catagory_feed.dart';
import 'package:stack/screens/feedScreen.dart';
import 'package:stack/screens/homeScreen.dart';
import 'package:stack/screens/innerscreens/brand_nav_rail.dart';
import 'package:stack/screens/searchScreen.dart';
import 'package:stack/screens/upload/uploadProductScreen.dart';
import 'package:stack/screens/userScreen.dart';
import 'package:stack/screens/wishList.dart';
import 'package:stack/styles/themes/myApptheme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => ThemeNotifier()),
        ChangeNotifierProvider(create: (ctx) => ProductProvider()),
        ChangeNotifierProvider(create: (ctx) => CartProvider()),
        ChangeNotifierProvider(create: (ctx) => WishlistProvider()),
        ChangeNotifierProvider(create: (ctx) => AuthProvider()),
      ],
      child: Consumer<ThemeNotifier>(builder: (context, notifier, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const AuthStateScreen(),
          theme: MyappTheme.mytheme(notifier.isDark, context),
          routes: {
            HomeScreen.routesName: (ctx) => const HomeScreen(),
            FeedsScreen.routesName: (ctx) => const FeedsScreen(),
            SearchScreen.routesName: (ctx) => const SearchScreen(),
            CartScreen.routesName: (ctx) => const CartScreen(),
            UserScreen.routesName: (ctx) => const UserScreen(),
            BrandNavRailScreen.routeName: (ctx) => const BrandNavRailScreen(),
            WishList.routeName: (ctx) => const WishList(),
            ProductDetails.routeName: (context) => ProductDetails(),
            Catagory_feed.routeName: (context) => Catagory_feed(),
            LandingScreen.routeName: (context) => LandingScreen(),
            LogInScreen.routeName: (context) => LogInScreen(),
            SignupScreen.routeName: (context) => SignupScreen(),
            BottomNavScreen.routesName: (ctx) => BottomNavScreen(),
            UploadProductScreen.routeName: (ctx) => UploadProductScreen(),
          },
        );
      }),
    );
  }
}
