import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductItemCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  const ProductItemCard({
    super.key,
    required this.product,
    required this.onTap,
  });

  String _formatPrice(int price) {
    return 'Rp ${price.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]}.',
        )}';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      child: ListTile(
        leading: product.thumbnail.isNotEmpty
            ? Image.network(
                'http://127.0.0.1:8000/proxy-image/?url=${Uri.encodeComponent(product.thumbnail)}',
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 50,
                  height: 50,
                  color: Colors.grey[300],
                  child: const Icon(Icons.shopping_bag),
                ),
              )
            : Container(
                width: 50,
                height: 50,
                color: Colors.green[100],
                child: const Icon(Icons.shopping_bag, color: Colors.green),
              ),
        title: Text(
          product.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(product.category.toUpperCase()),
            Text(_formatPrice(product.price)),
            if (product.isFeatured)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                margin: const EdgeInsets.only(top: 4),
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'FEATURED',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}