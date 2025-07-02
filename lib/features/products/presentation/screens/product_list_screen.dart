import 'package:flutter/material.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('قائمة المنتجات')),
      body: const Center(child: Text('شاشة قائمة المنتجات')),
    );
  }
}


