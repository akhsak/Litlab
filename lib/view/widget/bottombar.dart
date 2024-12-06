import 'package:flutter/material.dart';
import 'package:littlab/controller/bottom.dart';
import 'package:provider/provider.dart';

class BottomScreen extends StatelessWidget {
  BottomScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<BottomProvider>(
        builder: (context, value, child) => value.screens[value.currentIndex],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        elevation: 0,
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _BottomNavItem(Icons.home, 'ᴴᵒᵐᵉ', 0, context),
            _BottomNavItem(
                Icons.play_circle_filled_rounded, 'ᴹʸ ˡᵉᵃʳⁿⁱⁿᵍ', 1, context),
            _BottomNavItem(Icons.favorite, 'ʷⁱˢʰˡⁱˢᵗ', 2, context),
            _BottomNavItem(Icons.settings, 'ˢᵉᵗᵗⁱⁿᵍˢ', 3, context),
          ],
        ),
      ),
    );
  }

  Widget _BottomNavItem(
      IconData icon, String label, int index, BuildContext context) {
    final bottomProvider = Provider.of<BottomProvider>(context);
    final isSelected = bottomProvider.currentIndex == index;
    final color = isSelected
        ? Colors.deepPurple
        : const Color.fromARGB(255, 183, 171, 171);

    return GestureDetector(
      onTap: () => bottomProvider.onTap(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color),
          Text(label, style: TextStyle(color: color)),
        ],
      ),
    );
  }
}
