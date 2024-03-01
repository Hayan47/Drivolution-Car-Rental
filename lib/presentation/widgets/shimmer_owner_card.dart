import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class OwnerCardLoading extends StatelessWidget {
  const OwnerCardLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.black54,
      highlightColor: Colors.white10,
      period: const Duration(milliseconds: 500),
      child: Padding(
        padding: const EdgeInsets.only(
          right: 25,
          left: 15,
          top: 50,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            color: Colors.white,
            width: double.infinity,
            height: 180,
            child: const Padding(
              padding: EdgeInsets.all(15),
            ),
          ),
        ),
      ),
    );
  }
}
