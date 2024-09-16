import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kelompok6_a22/provider/category_provider.dart';
import 'package:kelompok6_a22/provider/product_provider.dart';

import 'package:kelompok6_a22/screen/dashboard_screen/dashboard_screen.dart';
import 'package:kelompok6_a22/screen/splashscreen/splash_screen.dart';

import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  Stream<User?> authStateChanges() {
    return FirebaseAuth.instance.authStateChanges();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductProvider>(
          create: (contex) => ProductProvider(),
        ),
        ChangeNotifierProvider<CategoryProvider>(
          create: (contex) => CategoryProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Kelompok6',
        routes: {
          '/home': (context) => const DashboardScreen(),
          '/cod': (context) => const DashboardScreen(),
        },
        home: StreamBuilder<User?>(
          stream: authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              final user = snapshot.data;
              if (user == null) {
                return const DashboardScreen();
              } else {
                return const DashboardScreen();
              }
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
