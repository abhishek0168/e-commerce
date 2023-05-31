import 'package:ecommerce_app/utils/constants.dart';
import 'package:flutter/material.dart';

class AdminPanel extends StatelessWidget {
  const AdminPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  label: Text('Product name'),
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text('Brand name'),
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text('Product price'),
                ),
              ),
              height20,
              FilledButton(
                onPressed: () {},
                child: const Text('Sumbit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
