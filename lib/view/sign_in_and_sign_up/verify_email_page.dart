import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VarifyEmailPage extends StatefulWidget {
  const VarifyEmailPage({super.key});

  @override
  State<VarifyEmailPage> createState() => _VarifyEmailPageState();
}

class _VarifyEmailPageState extends State<VarifyEmailPage> {
  bool isEmailVerified = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final signInController = Provider.of(context);
    return const Placeholder();
  }
}
