import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProfileLoading extends StatelessWidget {
  const ProfileLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          Shimmer.fromColors(
            baseColor: Colors.black54,
            highlightColor: Colors.white10,
            period: const Duration(milliseconds: 500),
            child: Column(
              children: [
                //!profile card

                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    color: Colors.white,
                    width: double.infinity,
                    height: 160,
                    child: const Padding(
                      padding: EdgeInsets.all(15),
                    ),
                  ),
                ),

                //! SizedBox
                const SizedBox(height: 5),

                //!Divider
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 1,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                //! SizedBox
                const SizedBox(height: 10),

                //!First Text
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 30,
                    width: 75,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                //!Car Card
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 25,
                        left: 15,
                        bottom: 20,
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

                //!Page View Pointer
                Container(
                  padding: const EdgeInsets.all(12),
                  height: 6,
                  width: 15,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                const SizedBox(height: 18),

                //!Second Text
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 30,
                    width: 75,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 25),
                //!Reservations Card
                Container(
                  padding: const EdgeInsets.all(12),
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),

                //! SizedBox
              ],
            ),
          ),
        ],
      ),
    );
  }
}
