import 'package:drivolution/business-logic/cubit/reservations_cubit.dart';
import 'package:drivolution/constants/my_colors.dart';
import 'package:drivolution/data/models/reservation_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  // DateTime start = DateTime.now();
  // DateTime end = DateTime.now();
  // Duration duration = const Duration();

  // //!pick start
  // Future pickStartDate() async {
  //   List<Reservation> reservations = context
  //       .read<ReservationsCubit>()
  //       .getCarReservations('1oESb2ML7Iy64lhVjEpD');
  //   print("S");
  //   Set<DateTime> disabledDates = {};
  //   for (Reservation reservation in reservations) {
  //     //todo
  //     DateTime startDate = reservation.startDate;
  //     DateTime endDate = reservation.endDate;

  //     for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
  //       DateTime currentDay = startDate.add(Duration(days: i));
  //       disabledDates
  //           .add(DateTime(currentDay.year, currentDay.month, currentDay.day));
  //     }
  //   }
  //   final result = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime.now(),
  //     lastDate: DateTime(2030),
  //     selectableDayPredicate: (DateTime date) {
  //       return !disabledDates
  //           .contains(DateTime(date.year, date.month, date.day));
  //     },
  //   );

  //   if (result == null) {
  //     return;
  //   }
  //   setState(() {
  //     start = result;
  //   });
  // }

  // //!pick end
  // Future pickEndDate() async {
  //   final result = await showDatePicker(
  //       context: context,
  //       initialDate: DateTime.now(),
  //       firstDate: DateTime.now(),
  //       lastDate: DateTime(2030));

  //   if (result == null) {
  //     return;
  //   }
  //   setState(() {
  //     end = result;
  //     duration = end.difference(start);
  //   });
  // }

  DateTimeRange? _selectedDateRange;
  List<Reservation> reservations = [];
  List<DateTime> disabledDates = [];

  //!get reservations
  Future getReservations() async {
    reservations = context
        .read<ReservationsCubit>()
        .getCarReservations('1oESb2ML7Iy64lhVjEpD');
    for (Reservation reservation in reservations) {
      DateTime startDate = reservation.startDate;
      DateTime endDate = reservation.endDate;
      for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
        DateTime currentDay = startDate.add(Duration(days: i));
        disabledDates
            .add(DateTime(currentDay.year, currentDay.month, currentDay.day));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    getReservations();
                    //!Background Container
                    return Container(
                      height: 400,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 5.0,
                            spreadRadius: 1.0,
                          ),
                        ],
                      ),
                      //!Date Range Picker
                      child: SfDateRangePicker(
                        //!when select a day
                        onSelectionChanged:
                            (DateRangePickerSelectionChangedArgs args) {
                          if (args.value is DateTimeRange) {
                            setState(() {
                              _selectedDateRange = args.value;
                            });
                          }
                        },
                        //!mode
                        selectionMode: DateRangePickerSelectionMode.range,
                        //!past days
                        enablePastDates: false,
                        //!Disabled Days
                        monthViewSettings: DateRangePickerMonthViewSettings(
                          enableSwipeSelection: false,
                          blackoutDates: disabledDates,
                          showTrailingAndLeadingDates: true,
                        ),
                        //!Day Style
                        monthCellStyle: DateRangePickerMonthCellStyle(
                          blackoutDateTextStyle: GoogleFonts.karla(
                            color: MyColors.myred,
                            decoration: TextDecoration.lineThrough,
                            fontSize: 16,
                          ),
                        ),
                        //!Selected Day Style
                        selectionTextStyle: GoogleFonts.karla(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                        //!Selected Days in Range Style
                        rangeTextStyle: GoogleFonts.karla(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        //!Range Line Style
                        rangeSelectionColor: MyColors.myred2.withOpacity(0.5),
                        startRangeSelectionColor: MyColors.myred2,
                        endRangeSelectionColor: MyColors.myred2,
                        showActionButtons: true,
                      ),
                    );
                  },
                );
              },
              icon: const Icon(Icons.date_range))),
    );
    // var price;
    // return Scaffold(
    //   body: SafeArea(
    //     child: Column(
    //       children: [
    //         Padding(
    //           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceAround,
    //             children: [
    //               GestureDetector(
    //                 onTap: pickStartDate,
    //                 child: Container(
    //                   width: 125,
    //                   height: 40,
    //                   decoration: BoxDecoration(
    //                     borderRadius: BorderRadius.circular(8),
    //                     color: MyColors.myred,
    //                   ),
    //                   child: Center(
    //                       child: Text(
    //                     '${start.year}/${start.month}/${start.day}',
    //                     style: GoogleFonts.karla(
    //                       color: MyColors.mywhite,
    //                       fontSize: 15,
    //                       fontWeight: FontWeight.bold,
    //                     ),
    //                   )),
    //                 ),
    //               ),
    //               const Icon(
    //                 Icons.arrow_forward_ios,
    //                 color: MyColors.myred,
    //               ),
    //               GestureDetector(
    //                 onTap: pickEndDate,
    //                 child: Container(
    //                   width: 125,
    //                   height: 40,
    //                   decoration: BoxDecoration(
    //                     borderRadius: BorderRadius.circular(8),
    //                     color: MyColors.myred,
    //                   ),
    //                   child: Center(
    //                     child: Text(
    //                       '${end.year}/${end.month}/${end.day}',
    //                       style: GoogleFonts.karla(
    //                         color: MyColors.mywhite,
    //                         fontSize: 15,
    //                         fontWeight: FontWeight.bold,
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //         Padding(
    //           padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
    //           child: Text(
    //             'Days: ${duration.inDays}',
    //             style: GoogleFonts.karla(
    //               color: MyColors.myBlue2,
    //               fontSize: 18,
    //               fontWeight: FontWeight.bold,
    //             ),
    //           ),
    //         ),
    //         Padding(
    //           padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
    //           child: Text(
    //             'price', // $price \$',
    //             style: GoogleFonts.karla(
    //               color: MyColors.myBlue2,
    //               fontSize: 18,
    //               fontWeight: FontWeight.bold,
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
