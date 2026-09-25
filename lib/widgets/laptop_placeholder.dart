import 'package:flutter/material.dart';

class LaptopImagePlaceholder extends StatelessWidget {
  final String? imagePath;
  final List<Widget> badges;

  const LaptopImagePlaceholder({
    super.key,
    this.imagePath,
    this.badges = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color.fromRGBO(255, 255, 255, 0.5), width: 1),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(30, 58, 138, 0.05),
            offset: Offset(0, 8),
            blurRadius: 10,
            spreadRadius: -6,
          ),
          BoxShadow(
            color: Color.fromRGBO(30, 58, 138, 0.05),
            offset: Offset(0, 20),
            blurRadius: 25,
            spreadRadius: -5,
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: AspectRatio(
              aspectRatio: 1,
              child: imagePath == null
                  ? const Placeholder(color: Colors.grey)
                  : Image.asset(imagePath!, fit: BoxFit.contain),
            ),
          ),
          ...badges,
        ],
      ),
    );
  }
}