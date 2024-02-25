import 'package:cached_network_image/cached_network_image.dart';
import 'package:drivolution/logic/cars_bloc/cars_bloc.dart';
import 'package:drivolution/logic/cubit/reservations_cubit.dart';
import 'package:drivolution/constants/my_colors.dart';
import 'package:drivolution/constants/strings.dart';
import 'package:drivolution/presentation/screens/date_range_picker.dart';
import 'package:drivolution/presentation/widgets/alert_dialog.dart';
import 'package:drivolution/presentation/widgets/confirm_reservation_card.dart';
import 'package:drivolution/presentation/widgets/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readmore/readmore.dart';
import '../../logic/cubit/usr_cubit.dart';
import '../../data/models/car_model.dart';
import '../../data/models/reservation_model.dart';
import 'owner_card.dart';

class CarDetails extends StatefulWidget {
  final Car car;

  const CarDetails({required this.car, super.key});

  @override
  State<CarDetails> createState() => _CarDetailsState();
}

class _CarDetailsState extends State<CarDetails> {
  bool _showAllFeatures = false;
  DateTimeRange range =
      DateTimeRange(start: DateTime.now(), end: DateTime.now());
  Duration duration = const Duration();
  int price = 0;

  //? pick Range
  Future pickRange() async {
    try {
      Map<String, dynamic> result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => ReservationsCubit(),
              child: DateRangePicker(carid: widget.car.id!),
            ),
          ));
      setState(() {
        range = result['selectedRange'];
        duration = range.end.difference(range.start) + const Duration(days: 1);
        price = duration.inDays * widget.car.rent;
      });
    } catch (e) {
      print(e);
    }
  }

  //? submit button
  submit() {
    if (FirebaseAuth.instance.currentUser != null) {
      showDialog(
        barrierColor: Colors.transparent,
        context: context,
        builder: (_) {
          return ConfirmReservation(
              car: widget.car, range: range, price: price, confirm: confirm);
        },
      );
    }
  }

  //? confirm button
  confirm() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
    );
    try {
      context.read<ReservationsCubit>().addReservation(
            Reservation(
              carId: widget.car.id!,
              customerId: FirebaseAuth.instance.currentUser!.uid,
              startDate: range.start,
              endDate: range.end,
            ),
          );
      Navigator.pop(context);
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(MySnackBar(
        icon: const Icon(
          Icons.done,
          color: Colors.green,
          size: 20,
        ),
        message: 'Reservation Completed Successfuly',
        margin: 0,
      ));
      range = DateTimeRange(start: DateTime.now(), end: DateTime.now());
    } catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(MySnackBar(
        icon: const Icon(
          Icons.error,
          color: MyColors.myred2,
          size: 20,
        ),
        message: 'Make Reservation Failed',
        margin: 0,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            MyColors.myGrey,
            MyColors.myBlue4,
            MyColors.myGrey,
          ],
        ),
      ),
      //?main column
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //!car name + model
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Hero(
                        tag: widget.car.logo,
                        child: CachedNetworkImage(
                          placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(
                            color: MyColors.mywhite,
                          )),
                          imageUrl: widget.car.logo,
                          width: 35,
                          height: 35,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.only(right: 10),
                          child: Text(
                            widget.car.name.toUpperCase(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            softWrap: false,
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: MyColors.mywhite,
                                      fontSize: 20,
                                    ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  widget.car.model,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: MyColors.mywhite,
                        fontSize: 20,
                      ),
                ),
              ],
            ),
          ),
          //!car location
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          'Location   ',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          softWrap: false,
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: MyColors.mywhite,
                                    fontSize: 20,
                                  ),
                        ),
                      ),
                      Text(
                        widget.car.locationName,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: MyColors.mywhite,
                              fontSize: 18,
                            ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, mapscreen,
                      arguments: widget.car),
                  child: const Icon(
                    Icons.location_on_outlined,
                    color: MyColors.myBlue,
                  ),
                ),
              ],
            ),
          ),
          //!car price
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Rent',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: MyColors.mywhite,
                        fontSize: 20,
                      ),
                ),
                Text(
                  '${widget.car.rent.toString()} \$/D',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: MyColors.mywhite,
                        fontSize: 20,
                      ),
                ),
              ],
            ),
          ),
          Divider(
            color: Theme.of(context).secondaryHeaderColor,
          ),
          //!car type
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 10),
                Text(
                  widget.car.type,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: MyColors.mywhite,
                        fontSize: 20,
                      ),
                ),
                const SizedBox(width: 10),
                if (widget.car.type == 'Sedan')
                  Image.asset(
                    'assets/icons/sedan.png',
                    color: MyColors.myBlue,
                    width: 40,
                    height: 40,
                  ),
                if (widget.car.type == 'Pick Up')
                  Image.asset(
                    'assets/icons/pickup.png',
                    color: MyColors.myBlue,
                    width: 40,
                    height: 40,
                  ),
                if (widget.car.type == 'SUV')
                  Image.asset(
                    'assets/icons/suv.png',
                    color: MyColors.myBlue,
                    width: 40,
                    height: 40,
                  ),
                if (widget.car.type == 'Sport')
                  Image.asset(
                    'assets/icons/sport.png',
                    color: MyColors.myBlue,
                    width: 40,
                    height: 40,
                  ),
                if (widget.car.type == 'Coupe')
                  Image.asset(
                    'assets/icons/coupe.png',
                    color: MyColors.myBlue,
                    width: 40,
                    height: 40,
                  ),
                if (widget.car.type == 'Convertible')
                  Image.asset(
                    'assets/icons/convertible.png',
                    color: MyColors.myBlue,
                    width: 40,
                    height: 40,
                  ),
                if (widget.car.type == 'HatchBack')
                  Image.asset(
                    'assets/icons/hatchback.png',
                    color: MyColors.myBlue,
                    width: 40,
                    height: 40,
                  ),
              ],
            ),
          ),
          ////////////////////? CAR INFO
          //!1 seats
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 5, right: 2, left: 2),
                  height: 88,
                  width: 88,
                  decoration: BoxDecoration(
                    boxShadow: [
                      //*botom right dark
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        offset: const Offset(1, 1),
                        blurRadius: 2,
                        spreadRadius: 1,
                      ),
                    ],
                    color: MyColors.myBlue,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/icons/seat.png',
                        width: 50,
                        height: 50,
                        color: MyColors.myBlue2,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '${widget.car.seats.toString()} seats',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: MyColors.myBlue2,
                              fontSize: 16,
                            ),
                      )
                    ],
                  ),
                ),
                //!2 doors
                Container(
                  padding: const EdgeInsets.only(top: 5, right: 2, left: 2),
                  height: 88,
                  width: 88,
                  decoration: BoxDecoration(
                    boxShadow: [
                      //*botom right dark
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        offset: const Offset(1, 1),
                        blurRadius: 2,
                        spreadRadius: 1,
                      ),
                    ],
                    color: MyColors.myBlue,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/icons/door.png',
                        width: 50,
                        height: 50,
                        color: MyColors.myBlue2,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '${widget.car.doors.toString()} doors',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: MyColors.myBlue2,
                              fontSize: 16,
                            ),
                      )
                    ],
                  ),
                ),
                //!3 fuel
                Container(
                  padding: const EdgeInsets.only(top: 5, right: 2, left: 2),
                  height: 88,
                  width: 88,
                  decoration: BoxDecoration(
                    boxShadow: [
                      //*botom right dark
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        offset: const Offset(1, 1),
                        blurRadius: 2,
                        spreadRadius: 1,
                      ),
                    ],
                    color: MyColors.myBlue,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    children: [
                      if (widget.car.fuel == 'gaz')
                        Image.asset(
                          'assets/icons/gas.png',
                          width: 50,
                          height: 50,
                          color: MyColors.myBlue2,
                        ),
                      if (widget.car.fuel == 'disel')
                        Image.asset(
                          'assets/icons/disel.png',
                          width: 50,
                          height: 50,
                          color: Theme.of(context).secondaryHeaderColor,
                        ),
                      if (widget.car.fuel == 'electric')
                        Image.asset(
                          'assets/icons/electro.png',
                          width: 50,
                          height: 50,
                          color: Theme.of(context).secondaryHeaderColor,
                        ),
                      const SizedBox(height: 5),
                      Text(
                        widget.car.fuel,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: MyColors.myBlue2,
                              fontSize: 16,
                            ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            color: MyColors.myBlue2,
          ),

          //!features
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Text(
              'Features',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: MyColors.mywhite,
                    fontSize: 20,
                  ),
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeInOutCubicEmphasized,
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget.car.features.length >= 3
                  ? _showAllFeatures
                      ? widget.car.features.length
                      : 3
                  : widget.car.features.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: MyColors.myBlue,
                          foregroundColor: MyColors.myBlue2,
                          child: Text('${index + 1}'),
                        ),
                        title: Text(
                          widget.car.features[index],
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: MyColors.mywhite,
                                    fontSize: 16,
                                  ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Divider(
                          color: MyColors.myBlue2,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          !_showAllFeatures
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      _showAllFeatures = true;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.arrow_drop_down,
                          color: MyColors.mywhite,
                        ),
                        Text(
                          'Show all features',
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: MyColors.mywhite,
                                    fontSize: 16,
                                  ),
                        ),
                      ],
                    ),
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    setState(() {
                      _showAllFeatures = false;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.arrow_drop_up,
                          color: MyColors.mywhite,
                        ),
                        Text(
                          'Show less',
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: MyColors.mywhite,
                                    fontSize: 16,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
          Divider(
            color: Theme.of(context).secondaryHeaderColor,
          ),
          //!Details
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Details',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: MyColors.mywhite,
                    fontSize: 22,
                  ),
            ),
          ),
          //!1 color
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Color',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: MyColors.mywhite,
                        fontSize: 18,
                      ),
                ),
                Text(
                  widget.car.color,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: MyColors.mywhite,
                        fontSize: 18,
                      ),
                )
              ],
            ),
          ),
          Divider(
            color: Theme.of(context).secondaryHeaderColor,
          ),
          //!2 interior color
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Interior Color',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: MyColors.mywhite,
                        fontSize: 18,
                      ),
                ),
                Text(
                  widget.car.interiorColor,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: MyColors.mywhite,
                        fontSize: 18,
                      ),
                )
              ],
            ),
          ),
          Divider(
            color: Theme.of(context).secondaryHeaderColor,
          ),
          //!3 engine
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Engine',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: MyColors.mywhite,
                        fontSize: 18,
                      ),
                ),
                Text(
                  widget.car.engine,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: MyColors.mywhite,
                        fontSize: 18,
                      ),
                )
              ],
            ),
          ),
          Divider(
            color: Theme.of(context).secondaryHeaderColor,
          ),
          //!4 transmission
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Transmission',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: MyColors.mywhite,
                        fontSize: 18,
                      ),
                ),
                Text(
                  widget.car.transmission,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: MyColors.mywhite,
                        fontSize: 18,
                      ),
                )
              ],
            ),
          ),
          Divider(
            color: Theme.of(context).secondaryHeaderColor,
          ),
          //!5 Drive train
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Drivetrain',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: MyColors.mywhite,
                        fontSize: 18,
                      ),
                ),
                Text(
                  widget.car.drivetrain,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: MyColors.mywhite,
                        fontSize: 18,
                      ),
                )
              ],
            ),
          ),
          Divider(
            color: Theme.of(context).secondaryHeaderColor,
          ),
          //!6 kilometrage
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'kilometrage',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: MyColors.mywhite,
                        fontSize: 18,
                      ),
                ),
                Text(
                  widget.car.kilometrage.toString(),
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: MyColors.mywhite,
                        fontSize: 18,
                      ),
                )
              ],
            ),
          ),
          Divider(
            color: Theme.of(context).secondaryHeaderColor,
          ),
          //!discription
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Discription',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: MyColors.mywhite,
                        fontSize: 18,
                      ),
                ),
                const SizedBox(height: 10),
                widget.car.description != ''
                    ? ReadMoreText(
                        widget.car.description,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: MyColors.mywhite,
                              fontSize: 15,
                            ),
                        trimMode: TrimMode.Line,
                        trimLines: 2,
                        moreStyle:
                            Theme.of(context).textTheme.bodySmall!.copyWith(
                                  color: MyColors.mywhite,
                                  fontSize: 15,
                                ),
                        lessStyle:
                            Theme.of(context).textTheme.bodySmall!.copyWith(
                                  color: MyColors.mywhite,
                                  fontSize: 15,
                                ),
                      )
                    : Center(
                        child: Text(
                          'No Description',
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: MyColors.mywhite,
                                    fontSize: 15,
                                  ),
                        ),
                      ),
              ],
            ),
          ),
          //!owner
          BlocProvider(
            create: (context) => UsrCubit(),
            child: OwnerCard(car: widget.car),
          ),
          const SizedBox(height: 20),
          FirebaseAuth.instance.currentUser != null &&
                  widget.car.ownerid == FirebaseAuth.instance.currentUser!.uid
              //! delete
              ? Center(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (_) {
                              return MyAlertDialog(
                                onPressed: () {
                                  context
                                      .read<CarsBloc>()
                                      .add(DeleteCarEvent(car: widget.car));
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                                text:
                                    'are you sure you want to delete this car?',
                              );
                            },
                          );
                        },
                        child: Container(
                          height: 40,
                          width: 140,
                          decoration: BoxDecoration(
                            border: Border.all(color: MyColors.myBlue),
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                MyColors.myred.withOpacity(0.6),
                                MyColors.myred2.withOpacity(1),
                                MyColors.myred.withOpacity(0.6),
                              ],
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'delete car',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: MyColors.mywhite,
                                      fontSize: 20,
                                    ),
                              ),
                              Image.asset(
                                'assets/icons/delete.png',
                                width: 25,
                                height: 25,
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                )
              : Column(
                  children: [
                    Divider(
                      color: Theme.of(context).secondaryHeaderColor,
                    ),
                    //!book now
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Text(
                        'Book Now!',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: MyColors.mywhite,
                              fontSize: 18,
                            ),
                      ),
                    ),
                    //!Date Pick
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: pickRange,
                            child: Container(
                              width: 125,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: MyColors.myred2,
                              ),
                              child: Center(
                                child: Text(
                                  '${range.start.year.toString()} / ${range.start.month.toString()} / ${range.start.day.toString()}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        color: MyColors.mywhite,
                                        fontSize: 15,
                                      ),
                                ),
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: MyColors.myred,
                          ),
                          GestureDetector(
                            onTap: pickRange,
                            child: Container(
                              width: 125,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: MyColors.myred2,
                              ),
                              child: Center(
                                child: Text(
                                  '${range.end.year.toString()} / ${range.end.month.toString()} / ${range.end.day.toString()}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        color: MyColors.mywhite,
                                        fontSize: 15,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //!Duration
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 5),
                      child: Text(
                        'Days: ${duration.inDays}',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: MyColors.mywhite,
                              fontSize: 18,
                            ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 5),
                      child: Text(
                        'price $price \$',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: MyColors.mywhite,
                              fontSize: 18,
                            ),
                      ),
                    ),
                    //!submit
                    Padding(
                      padding: const EdgeInsets.all(25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: submit,
                            child: Container(
                              width: 75,
                              height: 35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: FirebaseAuth.instance.currentUser == null
                                    ? Colors.grey.shade400
                                    : MyColors.myred2,
                              ),
                              child: Center(
                                child: Text(
                                  'submit',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        color: MyColors.mywhite,
                                        fontSize: 15,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
