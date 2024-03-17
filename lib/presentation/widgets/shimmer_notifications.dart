import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class NotificationLoading extends StatelessWidget {
  const NotificationLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Shimmer.fromColors(
        baseColor: Colors.black54,
        highlightColor: Colors.white10,
        period: const Duration(milliseconds: 500),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: 5,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                color: Colors.white,
                width: double.infinity,
                height: 120,
                child: const Padding(
                  padding: EdgeInsets.all(15),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
