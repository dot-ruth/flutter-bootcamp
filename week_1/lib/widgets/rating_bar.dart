import 'package:flutter/material.dart';

class RatingBar extends StatelessWidget {
  final double rating; 

  const RatingBar({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    final normalized = (rating / 2).clamp(0, 5); 
    return Row(
      children: List.generate(5, (index) {
        final fill = normalized - index;
        IconData icon;
        if (fill >= 1) {
          icon = Icons.star;
        } else if (fill > 0) {
          icon = Icons.star_half;
        } else {
          icon = Icons.star_border;
        }
        return Icon(
          icon,
          color: Colors.amber,
          size: 16,
        );
      }),
    );
  }
}

