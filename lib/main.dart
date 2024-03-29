import 'package:ecommerce_app/view/selection_page/selection_page.dart';
import 'package:ecommerce_app/view/theme/app_color_theme.dart';
import 'package:ecommerce_app/view_model/admin_page_viewmodel.dart';
import 'package:ecommerce_app/view_model/payment_view_model.dart';
import 'package:ecommerce_app/view_model/product_data_from_firebase.dart';
import 'package:ecommerce_app/view_model/main_page_view_model.dart';
import 'package:ecommerce_app/view_model/promo_code_viewmodel.dart';
import 'package:ecommerce_app/view_model/shop_view_model.dart';
import 'package:ecommerce_app/view_model/sign_in_page_viewmodel.dart';
import 'package:ecommerce_app/view_model/user_address_viewmodel.dart';
import 'package:ecommerce_app/view_model/user_details_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Container(
      alignment: Alignment.center,
      child: const Text(
        'Error\nSomthing went wrong',
        style: TextStyle(
          color: Colors.orangeAccent,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        textAlign: TextAlign.center,
      ),
    );
  };
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      'pk_test_51NT5iwSFB6cWaNPUZRnBwMmfGMv78RASH5wScFxqz11NMRpiFQIgchWV2Soz5qfUpvdHFUd9dN9oYA90tWwEipSs00q6H14450';
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MainPageViewModel()..init()),
        ChangeNotifierProvider(create: (_) => UserDetailsViewModel()..init()),
        ChangeNotifierProvider(create: (_) => DataFromFirebase()),
        ChangeNotifierProvider(create: (_) => ShopViewModel()),
        ChangeNotifierProvider(create: (_) => AdminPageViewModel()),
        ChangeNotifierProvider(create: (_) => PromoCodeViewModel()..init()),
        ChangeNotifierProvider(create: (_) => SignInPageViewModel()),
        ChangeNotifierProvider(create: (_) => AddressViewModel()..init()),
        ChangeNotifierProvider(create: (_) => PaymentViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter e-commerce',
        navigatorKey: navigatorKey,
        theme: ThemeData(
          textTheme: GoogleFonts.alataTextTheme(Theme.of(context).textTheme),
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
          useMaterial3: true,
        ),
        home: const SelectPage(),
        // home: const AdminPanel(),
      ),
    );
  }
}
