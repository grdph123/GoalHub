import 'package:flutter/material.dart';
import '../widgets/left_drawer.dart';
import '../widgets/product_card.dart';
import 'login.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final String nama = "Garuga Dewangga Putra Handikto";
  final String npm = "2406437615";
  final String kelas = "PBP F";

  final List<ProductItem> productItems = [
    ProductItem("All Products", Icons.shopping_cart, Color(0xFF2E7D32)), // Hijau gelap
    ProductItem("My Products", Icons.inventory, Color(0xFF43A047)),      // Hijau sedang
    ProductItem("Create Product", Icons.add_circle, Color(0xFF66BB6A)),  // Hijau terang
  ];

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'GoalHub',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFF1B5E20), // Hijau lebih gelap untuk app bar
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () async {
              final response = await request.logout(
                  "http://127.0.0.1:8000/auth/logout/");
              String message = response["message"];
              if (context.mounted) {
                  if (response['status']) {
                      String uname = response["username"];
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("$message See you again, $uname."),
                      ));
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginPage()),
                      );
                  } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(message),
                          ),
                      );
                  }
              }
            },
            tooltip: 'Logout',
          ),
        ],
      ),
      drawer: const LeftDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Info Cards - Perkecil lagi
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InfoCard(title: 'NPM', content: npm),
                  InfoCard(title: 'Name', content: nama),
                  InfoCard(title: 'Class', content: kelas),
                ],
              ),
              const SizedBox(height: 20.0), // Kurangi spacing
              
              // Welcome Text - Perkecil
              const Text(
                'Welcome to GoalHub!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0, // Perkecil
                  color: Color(0xFF1B5E20), // Warna hijau
                ),
              ),
              const SizedBox(height: 4.0),
              const Text(
                'Your Ultimate Football Shop',
                style: TextStyle(
                  fontSize: 12.0, // Perkecil
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 20.0), // Kurangi spacing
              
              // TOMBOL HORIZONTAL - EDIT BAGIAN INI
              Container(
                height: 80, // Tinggi fixed untuk tombol horizontal
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: productItems.map((ProductItem item) {
                    return Expanded( // Agar sama lebar
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4), // Sedikit margin
                        child: ProductCard(item),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final String content;

  const InfoCard({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      color: Color(0xFFE8F5E8), // Background hijau sangat terang
      child: Container(
        width: MediaQuery.of(context).size.width / 4, // Lebih kecil
        padding: const EdgeInsets.all(6.0), // Padding lebih kecil
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 9, // Lebih kecil
                color: Color(0xFF1B5E20), // Warna hijau
              ),
            ),
            const SizedBox(height: 2.0),
            Text(
              content,
              style: const TextStyle(
                fontSize: 7, // Lebih kecil
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}