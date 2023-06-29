import 'package:drivolution/constants/my_colors.dart';
import 'package:drivolution/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';

import '../../business-logic/cubit/usr_cubit.dart';
import '../../data/models/car_model.dart';
import 'owner_card.dart';

class CarDetails extends StatefulWidget {
  final Car car;

  const CarDetails({required this.car, super.key});

  @override
  State<CarDetails> createState() => _CarDetailsState();
}

class _CarDetailsState extends State<CarDetails> {
  DateTimeRange dateTimeRange =
      DateTimeRange(start: DateTime.now(), end: DateTime.now());
  Future pickDateRange() async {
    DateTimeRange? newdateTimeRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030, 12, 31),
      currentDate: DateTime.now(),
    );
    if (newdateTimeRange == null) {
      return;
    }
    setState(() {
      dateTimeRange = newdateTimeRange;
    });
  }

  @override
  Widget build(BuildContext context) {
    final start = dateTimeRange.start;
    final end = dateTimeRange.end;
    final duration = dateTimeRange.duration;
    int _price = widget.car.rentd! * duration.inDays;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(35),
            gradient: const LinearGradient(
                colors: [MyColors.myBlue, MyColors.myBlue2])),

        //main column

        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //car name + model
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Hero(
                          tag: widget.car.logo!,
                          child: Image.asset(
                            widget.car.logo!,
                            width: 35,
                            height: 35,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Flexible(
                          child: Container(
                            padding: const EdgeInsets.only(right: 10),
                            child: Text(
                              widget.car.name!,
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
                    widget.car.model!,
                    style:
                        GoogleFonts.karla(color: MyColors.myBlue, fontSize: 20),
                  ),
                ],
              ),
            ),

            //car location
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
                          widget.car.location!,
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
                      )),
                ],
              ),
            ),
            //car price
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Price',
                    style: GoogleFonts.karla(
                      color: MyColors.myBlue2,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${widget.car.rentd!.toString()}\$ /D',
                    style:
                        GoogleFonts.karla(color: MyColors.myBlue, fontSize: 20),
                  ),
                ],
              ),
            ),
            Divider(
              color: Theme.of(context).secondaryHeaderColor,
            ),
            //car type
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
                    widget.car.type!,
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
            // car info

            //1
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
                      // ignore: prefer_const_literals_to_create_immutables
                      boxShadow: const [
                        //boorom right dark
                        BoxShadow(
                          color: MyColors.myBlue2,
                          offset: Offset(5, 5),
                          blurRadius: 15,
                          spreadRadius: 1,
                        ),
                        //top left light
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
                        // ignore: prefer_const_constructors
                        SizedBox(height: 5),
                        Text(
                          '${widget.car.seats!.toString()} ' + 'seats',
                          style: GoogleFonts.karla(color: MyColors.myBlue2),
                        )
                      ],
                    ),
                  ),
                  //2
                  Container(
                    padding: const EdgeInsets.only(top: 5, right: 2, left: 2),
                    height: 88,
                    width: 88,
                    decoration: BoxDecoration(
                      // ignore: prefer_const_literals_to_create_immutables
                      boxShadow: [
                        //boorom right dark
                        const BoxShadow(
                          color: MyColors.myBlue2,
                          offset: Offset(5, 5),
                          blurRadius: 15,
                          spreadRadius: 1,
                        ),
                        //top left light
                        const BoxShadow(
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
                        // ignore: prefer_const_constructors
                        SizedBox(height: 5),
                        Text(
                          '${widget.car.doors!.toString()} ' + 'doors',
                          style: GoogleFonts.karla(color: MyColors.myBlue2),
                        )
                      ],
                    ),
                  ),
                  //3
                  Container(
                    padding: const EdgeInsets.only(top: 5, right: 2, left: 2),
                    height: 88,
                    width: 88,
                    decoration: BoxDecoration(
                      // ignore: prefer_const_literals_to_create_immutables
                      boxShadow: [
                        //boorom right dark
                        const BoxShadow(
                          color: MyColors.myBlue2,
                          offset: Offset(5, 5),
                          blurRadius: 15,
                          spreadRadius: 1,
                        ),
                        //top left light
                        const BoxShadow(
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
                        // ignore: prefer_const_constructors
                        SizedBox(height: 5),
                        Text(
                          widget.car.fuel!,
                          style: GoogleFonts.karla(color: MyColors.myBlue2),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: Theme.of(context).secondaryHeaderColor,
            ),

            //features
            ListTile(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    backgroundColor: MyColors.myBlue2,
                    scrollable: true,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Features',
                          style: GoogleFonts.karla(
                            color: MyColors.myBlue,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.close,
                            color: MyColors.myBlue,
                          ),
                        ),
                      ],
                    ),
                    content: Column(
                        children: List.generate(
                      widget.car.features!.length,
                      (index) => Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                        ),
                        child: ListTile(
                            title: Text(
                          widget.car.features![index],
                          style: GoogleFonts.karla(
                            color: MyColors.myBlue,
                          ),
                        )),
                      ),
                    )),
                    actions: [TextButton(onPressed: () {}, child: Text('Ok'))],
                  ),
                );
              },
              title: Text(
                'Features',
                style: GoogleFonts.karla(
                  color: MyColors.myBlue2,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: Text(
                'View All',
                style: GoogleFonts.karla(color: MyColors.myBlue, fontSize: 16),
              ),
            ),
            Divider(
              color: Theme.of(context).secondaryHeaderColor,
            ),
            //Details
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'Details',
                style: GoogleFonts.karla(
                  color: MyColors.myBlue2,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            //1 color
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
                    ),
                  ),
                  Text(
                    widget.car.color!,
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
            //2 interior color
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
                    ),
                  ),
                  Text(
                    widget.car.interiorColor!,
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
            //3 engine
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
                    ),
                  ),
                  Text(
                    widget.car.engine!,
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
            //4 transmission
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
                    ),
                  ),
                  Text(
                    widget.car.transmission!,
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
            //5 Drive train
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
                    ),
                  ),
                  Text(
                    widget.car.drivetrain!,
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
            //6 kilometrage
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
                    ),
                  ),
                  Text(
                    widget.car.kilometrage!.toString(),
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
            //discription
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
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
                  ReadMoreText(
                    widget.car.description!,
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
                ],
              ),
            ),
            //owner
            BlocProvider(
              create: (context) => UsrCubit(),
              child: OwnerCard(car: widget.car),
            ),
            const SizedBox(height: 10),
            Divider(
              color: Theme.of(context).secondaryHeaderColor,
            ),
            //book now
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                'Book Now!',
                style: GoogleFonts.karla(
                  color: MyColors.myBlue2,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: pickDateRange,
                    child: Container(
                      width: 125,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: MyColors.myred,
                      ),
                      child: Center(
                          child: Text(
                        '${start.year}/${start.month}/${start.day}',
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
                    onTap: pickDateRange,
                    child: Container(
                      width: 125,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: MyColors.myred,
                      ),
                      child: Center(
                          child: Text(
                        '${end.year}/${end.month}/${end.day}',
                        style: GoogleFonts.karla(
                          color: MyColors.mywhite,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
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
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
              child: Text(
                'price ${_price} \$',
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
                    //onTap: pickDateRange,
                    child: Container(
                      width: 75,
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: MyColors.myred,
                      ),
                      child: Center(
                          child: Text(
                        'submit',
                        style: GoogleFonts.karla(
                          color: MyColors.mywhite,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
