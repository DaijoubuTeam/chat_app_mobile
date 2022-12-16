import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class SplachScreen extends StatefulWidget {
  const SplachScreen({super.key});

  @override
  State<SplachScreen> createState() => _SplachScreenState();
}

class _SplachScreenState extends State<SplachScreen> {
  @override
  void initState() {
    print("hello");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
