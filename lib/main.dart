import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:khana_delivery/providers/address_provider.dart';
import 'package:khana_delivery/providers/auth_provider.dart';
import 'package:khana_delivery/providers/cart_provider.dart';
import 'package:khana_delivery/providers/wishlist_provider.dart';
import 'package:khana_delivery/screens/homePage.dart';
import 'package:khana_delivery/providers/product_provider.dart';
import 'package:khana_delivery/screens/product_overview.dart';
import 'package:khana_delivery/screens/signup_page.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider<ProductProvider>(
        create: (context)=>ProductProvider(),),
      ChangeNotifierProvider<AuthenticationProvider>(
        create: (context)=>AuthenticationProvider(),),
      ChangeNotifierProvider<CartProvider>(
        create: (context)=>CartProvider(),),
      ChangeNotifierProvider<WishlistProvider>(
        create: (context)=>WishlistProvider(),),
      ChangeNotifierProvider<AddressProvider>(
        create: (context)=>AddressProvider(),)
    ],child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: false,
      ),
      home: AuthPage(),
    ),);
  }
}


class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  @override
  Widget build(BuildContext context) {

    final user = FirebaseAuth.instance.currentUser;

    if(user == null){
      return SignupPage();
    }
    else
    {
      return HomePage();
    }

  }
}
