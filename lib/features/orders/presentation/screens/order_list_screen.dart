import 'package:flutter/material.dart';

class OrderListScreen extends StatelessWidget {
  const OrderListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('قائمة الطلبات')),
      body: const Center(child: Text('شاشة قائمة الطلبات')),
    );
  }
}


