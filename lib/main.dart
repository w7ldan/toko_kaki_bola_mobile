import 'package:flutter/material.dart';
import 'package:toko_kaki_bola/menu.dart';
import 'package:toko_kaki_bola/login.dart';
import 'package:toko_kaki_bola/product_form.dart'; 
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

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
      title: 'Toko Kaki Bola',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.green,
        ).copyWith(
          secondary: Colors.greenAccent[400],
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.green, 
          foregroundColor: Colors.white, 
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white, 
          ),
        ),
      ),
      home: const LoginPage(),
      routes: {
        '/form': (context) => const ProductFormPage(),
      },)
    );
  }
}