import 'package:flutter/material.dart';

class StoreListScreen extends StatelessWidget {
  const StoreListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('قائمة المحلات')), 
      body: const Center(child: Text('شاشة قائمة المحلات')), 
    );
  }
}


