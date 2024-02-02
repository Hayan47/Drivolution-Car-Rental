// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:drivolution/presentation/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'package:drivolution/logic/cubit/reservations_cubit.dart';
import 'package:drivolution/constants/my_colors.dart';
import 'package:drivolution/data/models/reservation_model.dart';

class DateRangePicker extends StatefulWidget {
  String carid;
  DateRangePicker({
    Key? key,
    required this.carid,
  }) : super(key: key);

  @override
  State<DateRangePicker> createState() => _DateRangePickerState();
}

class _DateRangePickerState extends State<DateRangePicker> {
  DateTimeRange _selectedDateRange =
      DateTimeRange(start: DateTime.now(), end: DateTime.now());
  List<Reservation> reservations = [];
  List<DateTime> disabledDates = [];
  bool isValid = true;

  //!get reservations
  Future getReservations() async {
    reservations = await context
        .read<ReservationsCubit>()
        .getCarReservations(widget.carid);
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
      backgroundColor: MyColors.myBlue2,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Choose Date'),
        centerTitle: true,
      ),
      body: BlocBuilder<ReservationsCubit, ReservationsState>(
        builder: (context, state) {
          //!call function
          getReservations();
          if ((state) is ReservationsLoaded) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: MediaQuery.sizeOf(context).height * 0.8,
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
                    //!Date Range Picker
                    child: SfDateRangePicker(
                      //!when select a day
                      onSelectionChanged:
                          (DateRangePickerSelectionChangedArgs args) {
                        if (args.value is PickerDateRange) {
                          PickerDateRange pickerDateRange = args.value;
                          DateTimeRange selectedRange = DateTimeRange(
                            start: DateTime.now(),
                            end: DateTime.now(),
                          );
                          if (pickerDateRange.startDate != null &&
                              pickerDateRange.endDate != null) {
                            selectedRange = DateTimeRange(
                              start: pickerDateRange.startDate!,
                              end: pickerDateRange.endDate!,
                            );
                          }
                          if (pickerDateRange.startDate != null &&
                              pickerDateRange.endDate == null) {
                            selectedRange = DateTimeRange(
                              start: pickerDateRange.startDate!,
                              end: pickerDateRange.startDate!,
                            );
                          }
                          bool isRangeValid = true;
                          for (int i = 0;
                              i <= selectedRange.duration.inDays;
                              i++) {
                            final date =
                                selectedRange.start.add(Duration(days: i));
                            if (disabledDates.contains(date)) {
                              isRangeValid = false;
                              break;
                            }
                          }
                          setState(() {
                            _selectedDateRange = selectedRange;
                            isValid = isRangeValid;
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
                        weekendDays: const [5, 6],
                        viewHeaderHeight:
                            MediaQuery.sizeOf(context).height * 0.05,
                        viewHeaderStyle: DateRangePickerViewHeaderStyle(
                          backgroundColor: MyColors.myBlue2.withOpacity(0.9),
                          textStyle:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: MyColors.mywhite,
                                    fontSize: 16,
                                  ),
                        ),
                      ),
                      //!Header Style
                      headerHeight: MediaQuery.sizeOf(context).height * 0.1,
                      headerStyle: DateRangePickerHeaderStyle(
                        backgroundColor: MyColors.myBlue2.withOpacity(0.8),
                        textStyle:
                            Theme.of(context).textTheme.bodySmall!.copyWith(
                                  color: MyColors.mywhite,
                                  fontSize: 32,
                                ),
                      ),
                      onCancel: () {
                        Navigator.pop(context);
                      },
                      onSubmit: (p0) {
                        if (isValid) {
                          Navigator.of(context).pop({
                            'selectedRange': _selectedDateRange,
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(MySnackBar(
                            color: MyColors.myred,
                            icon: const Icon(
                              Icons.error,
                              color: MyColors.mywhite,
                              size: 20,
                            ),
                            title: 'Error',
                            message: 'selected range contains taken dates',
                            margin: 0,
                          ));
                        }
                      },
                      todayHighlightColor: MyColors.myBlue,
                      //!Day Style
                      monthCellStyle: DateRangePickerMonthCellStyle(
                        blackoutDateTextStyle:
                            Theme.of(context).textTheme.bodySmall!.copyWith(
                                  color: MyColors.mywhite,
                                  fontSize: 16,
                                  decoration: TextDecoration.lineThrough,
                                  decorationColor: MyColors.myred,
                                  decorationStyle: TextDecorationStyle.dashed,
                                  decorationThickness: 7,
                                ),
                        blackoutDatesDecoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(colors: [
                            MyColors.myBlue2.withOpacity(0.5),
                            MyColors.myBlue.withOpacity(0.5),
                          ]),
                        ),
                        textStyle: GoogleFonts.karla(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      //!Selected Day Style
                      selectionTextStyle:
                          Theme.of(context).textTheme.bodySmall!.copyWith(
                                color: MyColors.mywhite,
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
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: MyColors.mywhite,
              ),
            );
          }
        },
      ),
    );
  }
}
