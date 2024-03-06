import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AllCarsLoading extends StatelessWidget {
  const AllCarsLoading({super.key});

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
          itemBuilder: (context, index) => Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  right: 25,
                  left: 15,
                  bottom: 40,
                  top: 10,
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
              //!price
              Positioned(
                left: 10,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  width: 125,
                  height: 25,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
