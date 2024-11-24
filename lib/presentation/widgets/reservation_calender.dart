import 'package:drivolution/data/models/car_model.dart';
import 'package:drivolution/presentation/themes/app_colors.dart';
import 'package:drivolution/presentation/themes/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../data/models/reservation_model.dart';

class ReservationCalender extends StatelessWidget {
  final List<Reservation> reservations;
  final List<Car> cars;
  final List<DateTime> reservedDays;
  const ReservationCalender({
    super.key,
    required this.reservations,
    required this.cars,
    required this.reservedDays,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: MediaQuery.sizeOf(context).height * 0.75,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 5.0,
                  spreadRadius: 1.0,
                ),
              ],
            ),
            child: SfDateRangePicker(
              monthViewSettings: DateRangePickerMonthViewSettings(
                blackoutDates: reservedDays,
                enableSwipeSelection: false,
                showTrailingAndLeadingDates: true,
                weekendDays: const [5, 6],
                viewHeaderHeight: MediaQuery.sizeOf(context).height * 0.05,
                viewHeaderStyle: DateRangePickerViewHeaderStyle(
                  backgroundColor: AppColors.deepNavy.withOpacity(0.9),
                  textStyle: AppTypography.labelLarge
                      .copyWith(color: AppColors.pureWhite),
                ),
              ),
              //!Header Style
              headerHeight: MediaQuery.sizeOf(context).height * 0.1,
              headerStyle: DateRangePickerHeaderStyle(
                backgroundColor: AppColors.deepNavy.withOpacity(0.8),
                textStyle: AppTypography.labelLarge.copyWith(
                  color: AppColors.pureWhite,
                  fontSize: 32,
                ),
              ),
              todayHighlightColor: AppColors.oceanBlue,
              selectionColor: AppColors.pearl,
              selectionTextStyle:
                  AppTypography.labelLarge.copyWith(color: AppColors.jetBlack),
              //!Day Style
              monthCellStyle: DateRangePickerMonthCellStyle(
                blackoutDateTextStyle: AppTypography.labelLarge
                    .copyWith(color: AppColors.jetBlack),
                blackoutDatesDecoration: const BoxDecoration(
                  // image: DecorationImage(
                  //     image: CachedNetworkImageProvider(cars[0].img)),
                  image: DecorationImage(
                      image: AssetImage('assets/img/cars/carholder2.jpg')),
                  shape: BoxShape.circle,
                ),
                textStyle: AppTypography.labelLarge
                    .copyWith(color: AppColors.jetBlack),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
