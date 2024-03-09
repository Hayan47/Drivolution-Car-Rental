// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:drivolution/logic/reservation_bloc/reservation_bloc.dart';
import 'package:drivolution/presentation/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:drivolution/constants/my_colors.dart';

class DateRangePicker extends StatelessWidget {
  String carid;
  DateRangePicker({
    Key? key,
    required this.carid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ReservationBloc>().add(GetCarReservations(carID: carid));
    return Scaffold(
      backgroundColor: MyColors.myBlue2,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Choose Date'),
        centerTitle: true,
      ),
      body: BlocConsumer<ReservationBloc, ReservationState>(
        listener: (context, state) {
          if (state is ReservationsError) {
            showToastMessage(
              context,
              state.message,
              const Icon(Icons.error, color: MyColors.myred2, size: 18),
            );
          } else if (state is RangePicked) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          if (state is ReservationsLoaded) {
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
                          context
                              .read<ReservationBloc>()
                              .add(PickRange(pickerDateRange: pickerDateRange));
                        }
                      },
                      //!mode
                      selectionMode: DateRangePickerSelectionMode.range,
                      //!past days
                      enablePastDates: false,
                      //!Disabled Days
                      monthViewSettings: DateRangePickerMonthViewSettings(
                        enableSwipeSelection: false,
                        blackoutDates: state.disabledDates,
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
                        context.read<ReservationBloc>().add(ConfirmRange());
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
