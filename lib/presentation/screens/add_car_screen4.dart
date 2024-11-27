import 'package:drivolution/presentation/widgets/car_pick_album_widget.dart';
import 'package:drivolution/presentation/widgets/submit_car_button.dart';
import 'package:drivolution/utils/responsive/responsive_widget.dart';
import 'package:flutter/material.dart';

class AddCar4 extends StatelessWidget {
  const AddCar4({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      mobile: Column(
        children: [
          //! Car Pick Album
          CarPickAlbumWidget(),
          const SizedBox(height: 15),
          //!submit
          SubmitCarButton(),
        ],
      ),
      tablet: Row(
        children: [
          //! Car Pick Album
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CarPickAlbumWidget(),
            ),
          ),
          //!submit
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(16),
            child: SubmitCarButton(),
          )),
        ],
      ),
    );
  }
}
