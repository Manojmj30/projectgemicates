import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'View/Home_screen.dart';
import 'View/Signup_screen.dart';
import 'View/products_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      routes: {
        '/signup': (context) => const SignUpPage(),
        '/products': (context) => const ProductsPage(),
      },
    );
  }
}

