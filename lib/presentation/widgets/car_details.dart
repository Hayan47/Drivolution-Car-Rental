import 'package:cached_network_image/cached_network_image.dart';
import 'package:drivolution/logic/cubit/reservations_cubit.dart';
import 'package:drivolution/constants/my_colors.dart';
import 'package:drivolution/constants/strings.dart';
import 'package:drivolution/presentation/screens/date_range_picker.dart';
import 'package:drivolution/presentation/widgets/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
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
  //!pick Range
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35),
          gradient: const LinearGradient(
            colors: [MyColors.myBlue, MyColors.myBlue2],
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
                              widget.car.name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              softWrap: false,
                              style: GoogleFonts.karla(
                                color: MyColors.myBlue2,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    widget.car.model,
                    style:
                        GoogleFonts.karla(color: MyColors.myBlue, fontSize: 20),
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
                            style: GoogleFonts.karla(
                              color: MyColors.myBlue2,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          widget.car.locationName,
                          style: GoogleFonts.karla(
                            color: MyColors.myBlue2,
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
                    style: GoogleFonts.karla(
                      color: MyColors.myBlue2,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // RichText(
                  //   text: TextSpan(
                  //     children: [
                  //       TextSpan(
                  //         text: widget.car.rent.toString(),
                  //         style: GoogleFonts.karla(
                  //             color: MyColors.myBlue, fontSize: 20),
                  //       ),
                  //       TextSpan(
                  //         text: ' \$/D',
                  //         style: GoogleFonts.karla(
                  //             color: MyColors.myred2, fontSize: 20),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Text(
                    '${widget.car.rent.toString()} \$/D',
                    style:
                        GoogleFonts.karla(color: MyColors.myBlue, fontSize: 20),
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
                  Text(
                    'Type',
                    style: GoogleFonts.karla(
                      color: MyColors.myBlue2,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    widget.car.type,
                    style:
                        GoogleFonts.karla(color: MyColors.myBlue, fontSize: 20),
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
                      boxShadow: const [
                        //*boorom right dark
                        BoxShadow(
                          color: MyColors.myBlue2,
                          offset: Offset(5, 5),
                          blurRadius: 15,
                          spreadRadius: 1,
                        ),
                        //*top left light
                        BoxShadow(
                          color: MyColors.myBlue,
                          offset: Offset(-5, -5),
                          blurRadius: 15,
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
                          '${widget.car.seats.toString()} ' 'seats',
                          style: GoogleFonts.karla(color: MyColors.myBlue2),
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
                      boxShadow: const [
                        BoxShadow(
                          color: MyColors.myBlue2,
                          offset: Offset(5, 5),
                          blurRadius: 15,
                          spreadRadius: 1,
                        ),
                        BoxShadow(
                          color: MyColors.myBlue,
                          offset: Offset(-3, -3),
                          blurRadius: 15,
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
                          '${widget.car.doors.toString()} ' 'doors',
                          style: GoogleFonts.karla(color: MyColors.myBlue2),
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
                      boxShadow: const [
                        BoxShadow(
                          color: MyColors.myBlue2,
                          offset: Offset(5, 5),
                          blurRadius: 15,
                          spreadRadius: 1,
                        ),
                        BoxShadow(
                          color: MyColors.myBlue2,
                          offset: Offset(-5, -5),
                          blurRadius: 15,
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
                          style: GoogleFonts.karla(color: MyColors.myBlue2),
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
                style: GoogleFonts.karla(
                  color: MyColors.myBlue2,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
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
                            backgroundColor: MyColors.myBlue2,
                            foregroundColor: MyColors.mywhite,
                            child: Text('${index + 1}'),
                          ),
                          title: Text(
                            widget.car.features[index],
                            style: GoogleFonts.karla(
                              color: MyColors.myBlue2,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Divider(),
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
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.arrow_drop_down),
                          Text('Show all features'),
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
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.arrow_drop_up),
                          Text('Show less'),
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
                style: GoogleFonts.karla(
                  color: MyColors.myBlue2,
                  fontWeight: FontWeight.bold,
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
                    style: GoogleFonts.karla(
                      color: MyColors.myBlue2,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.car.color,
                    style: GoogleFonts.karla(
                      color: MyColors.myBlue,
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
                    style: GoogleFonts.karla(
                      color: MyColors.myBlue2,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.car.interiorColor,
                    style: GoogleFonts.karla(
                      color: MyColors.myBlue,
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
                    style: GoogleFonts.karla(
                      color: MyColors.myBlue2,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.car.engine,
                    style: GoogleFonts.karla(
                      color: MyColors.myBlue,
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
                    style: GoogleFonts.karla(
                      color: MyColors.myBlue2,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.car.transmission,
                    style: GoogleFonts.karla(
                      color: MyColors.myBlue,
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
                    style: GoogleFonts.karla(
                      color: MyColors.myBlue2,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.car.drivetrain,
                    style: GoogleFonts.karla(
                      color: MyColors.myBlue,
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
                    style: GoogleFonts.karla(
                      color: MyColors.myBlue2,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.car.kilometrage.toString(),
                    style: GoogleFonts.karla(
                      color: MyColors.myBlue,
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
                    style: GoogleFonts.karla(
                      color: MyColors.myBlue2,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  widget.car.description != ''
                      ? ReadMoreText(
                          widget.car.description,
                          style: GoogleFonts.karla(
                            color: MyColors.mywhite,
                            fontSize: 15,
                          ),
                          trimMode: TrimMode.Line,
                          trimLines: 2,
                          moreStyle: GoogleFonts.karla(
                            color: MyColors.myBlue,
                            fontSize: 15,
                          ),
                          lessStyle: GoogleFonts.karla(
                            color: MyColors.myBlue,
                            fontSize: 15,
                          ),
                        )
                      : Center(
                          child: Text(
                            'No Description',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.karla(
                              color: MyColors.mywhite.withOpacity(0.8),
                              fontSize: 18,
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
                        Container(
                          height: 40,
                          width: 160,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
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
                          child: Center(
                            child: Text(
                              'Delete Car',
                              style: GoogleFonts.karla(
                                color: MyColors.mywhite,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
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
                          style: GoogleFonts.karla(
                            color: MyColors.myBlue2,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
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
                                  color: MyColors.myred,
                                ),
                                child: Center(
                                    child: Text(
                                  '${range.start.year.toString()} / ${range.start.month.toString()} / ${range.start.day.toString()}',
                                  style: GoogleFonts.karla(
                                    color: MyColors.mywhite,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
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
                                  color: MyColors.myred,
                                ),
                                child: Center(
                                  child: Text(
                                    '${range.end.year.toString()} / ${range.end.month.toString()} / ${range.end.day.toString()}',
                                    style: GoogleFonts.karla(
                                      color: MyColors.mywhite,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
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
                          style: GoogleFonts.karla(
                            color: MyColors.myBlue2,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 5),
                        child: Text(
                          'price $price \$',
                          style: GoogleFonts.karla(
                            color: MyColors.myBlue2,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (FirebaseAuth.instance.currentUser != null) {
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
                                    context
                                        .read<ReservationsCubit>()
                                        .addReservation(
                                          Reservation(
                                            carId: widget.car.id!,
                                            customerId: FirebaseAuth
                                                .instance.currentUser!.uid,
                                            startDate: range.start,
                                            endDate: range.end,
                                          ),
                                        );
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(MySnackBar(
                                      icon: const Icon(
                                        Icons.done,
                                        color: Colors.green,
                                        size: 20,
                                      ),
                                      title: 'Done',
                                      message:
                                          'Reservation Completed Successfuly',
                                    ));
                                  } catch (e) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(MySnackBar(
                                      icon: const Icon(
                                        Icons.error,
                                        color: MyColors.myred,
                                        size: 20,
                                      ),
                                      title: 'Error',
                                      message: 'Make Reservation Failed',
                                    ));
                                  }
                                }
                              },
                              child: Container(
                                width: 75,
                                height: 35,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  color:
                                      FirebaseAuth.instance.currentUser == null
                                          ? Colors.grey.shade400
                                          : MyColors.myred,
                                ),
                                child: Center(
                                  child: Text(
                                    'submit',
                                    style: GoogleFonts.karla(
                                      color: MyColors.mywhite,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
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
      ),
    );
  }
}
