import 'package:flutter/material.dart';
import '../../models/product_model.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bidhaa Zote'),
      ),
      body: const Center(
        child: Text('Product List Screen - Coming Soon'),
      ),
    );
  }
}
