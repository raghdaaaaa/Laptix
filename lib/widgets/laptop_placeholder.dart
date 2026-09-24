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
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 6),
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