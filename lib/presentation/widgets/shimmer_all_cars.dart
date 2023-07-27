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
          physics: AlwaysScrollableScrollPhysics(),
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
              // Positioned(
              //   left: MediaQuery.sizeOf(context).width / 3,
              //   top: 110,
              //   child: Container(
              //     height: 120,
              //     width: 250,
              //     child: Image.asset(
              //       'assets/img/cars/audi.png',
              //       color: Colors.white,
              //     ),
              //   ),
              // ),
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
