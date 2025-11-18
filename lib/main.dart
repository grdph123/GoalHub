import 'package:flutter/material.dart';
import 'package:goalhub/screens/menu.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:goalhub/screens/login.dart';
import 'package:goalhub/screens/product_list.dart'; // Pastikan ini ada
import 'package:goalhub/screens/my_products.dart'; // Pastikan ini ada

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) {
        CookieRequest request = CookieRequest();
        return request;
      },
      child: MaterialApp(
        title: 'GoalHub',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green)
            .copyWith(secondary: Colors.greenAccent),
        ),
        home: const LoginPage(),
      ),
    );
  }
}