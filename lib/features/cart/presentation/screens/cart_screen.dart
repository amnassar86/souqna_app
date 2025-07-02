import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('سلة التسوق')),
      body: const Center(child: Text('شاشة سلة التسوق')),
    );
  }
}


