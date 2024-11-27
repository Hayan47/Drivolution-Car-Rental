import 'package:drivolution/logic/logo_bloc/logo_bloc.dart';
import 'package:drivolution/presentation/widgets/select_car_image.dart';
import 'package:drivolution/presentation/widgets/select_logo_widget.dart';
import 'package:drivolution/utils/responsive/responsive_helper.dart';
import 'package:drivolution/utils/responsive/responsive_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCar1 extends StatelessWidget {
  const AddCar1({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<LogoBloc>().add(FetchCarLogosEvent());
    return ResponsiveWidget(
      mobile: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //! Select Logo
          ConstrainedBox(
            constraints:
                BoxConstraints(maxHeight: ResponsiveHelper.hp(context, 40)),
            child: SelectLogoWidget(),
          ),
          const SizedBox(height: 5),
          //!select main image
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: ResponsiveHelper.hp(context, 40),
            ),
            child: SelectCarImage(),
          ),
        ],
      ),
      tablet: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: ResponsiveHelper.wp(context, 40),
            ),
            child: SelectLogoWidget(),
          ),
          const SizedBox(width: 5),
          //!select main image
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: ResponsiveHelper.wp(context, 40),
            ),
            child: SelectCarImage(),
          ),
        ],
      ),
    );
  }
}
