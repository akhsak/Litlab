import 'package:flutter/material.dart';
import 'package:littlab/view/widget/text.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({super.key});

  @override
  State<Wishlist> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Wishlist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: textAbel(name: "Wishlist")),
    );
  }
}
