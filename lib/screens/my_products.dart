import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/left_drawer.dart';
import 'product_detail.dart';
import '../widgets/product_item_card.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class MyProductsPage extends StatefulWidget {
  const MyProductsPage({super.key});

  @override
  State<MyProductsPage> createState() => _MyProductsPageState();
}

class _MyProductsPageState extends State<MyProductsPage> {
  Future<List<Product>> fetchMyProducts(CookieRequest request) async {
    final response = await request.get('http://127.0.0.1:8000/json/');
    
    var data = response;
    
    List<Product> allProducts = [];
    for (var d in data) {
      if (d != null) {
        allProducts.add(Product.fromJson(d));
      }
    }
    
    // FILTER: Hanya tampilkan produk milik user yang login
    String currentUsername = request.jsonData?['username'] ?? '';
    List<Product> myProducts = allProducts.where((product) {
      return product.userUsername == currentUsername;
    }).toList();
    
    return myProducts;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Products'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: FutureBuilder(
        future: fetchMyProducts(request),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center( // #PERBAIKAN: Wrap dengan Center
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center, // #PERBAIKAN: Tambah ini
                  children: [
                    Icon(Icons.inventory_2, size: 64, color: Colors.grey),
                    SizedBox(height: 16),
                    Text(
                      'You haven\'t added any products yet.',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                      textAlign: TextAlign.center, // #PERBAIKAN: Pastikan text juga center
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Tap "Create Product" to add your first product!',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) => ProductItemCard(
                  product: snapshot.data![index],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailPage(
                          product: snapshot.data![index],
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          }
        },
      ),
    );
  }
}