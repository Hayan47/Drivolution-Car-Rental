import 'package:cached_network_image/cached_network_image.dart';
import 'package:drivolution/logic/auth_cubit/auth_cubit.dart';
import 'package:drivolution/logic/cars_bloc/cars_bloc.dart';
import 'package:drivolution/constants/my_colors.dart';
import 'package:drivolution/logic/reservation_bloc/reservation_bloc.dart';
import 'package:drivolution/logic/user_bloc/user_bloc.dart';
import 'package:drivolution/presentation/widgets/alert_dialog.dart';
import 'package:drivolution/presentation/widgets/confirm_reservation_card.dart';
import 'package:drivolution/presentation/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readmore/readmore.dart';
import '../../data/models/car_model.dart';
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //!car name + model
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Hero(
                        tag: widget.car.logo,
                        child: CachedNetworkImage(
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
            const SizedBox(height: 20),
            //!car location
            Row(
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
                  onTap: () => Navigator.pushNamed(context, 'mapscreen',
                      arguments: widget.car),
                  child: const Icon(
                    Icons.location_on_outlined,
                    color: MyColors.myBlue,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            //!car price
            Row(
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
                  Builder(
                    builder: (context) {
                      switch (widget.car.type) {
                        case 'Sedan':
                          return Image.asset(
                            'assets/icons/sedan.png',
                            color: MyColors.myBlue,
                            width: 40,
                            height: 40,
                          );
                        case 'Pick Up':
                          return Image.asset(
                            'assets/icons/pickup.png',
                            color: MyColors.myBlue,
                            width: 40,
                            height: 40,
                          );
                        case 'SUV':
                          return Image.asset(
                            'assets/icons/suv.png',
                            color: MyColors.myBlue,
                            width: 40,
                            height: 40,
                          );
                        case 'Sport':
                          return Image.asset(
                            'assets/icons/sport.png',
                            color: MyColors.myBlue,
                            width: 40,
                            height: 40,
                          );
                        case 'Coupe':
                          return Image.asset(
                            'assets/icons/coupe.png',
                            color: MyColors.myBlue,
                            width: 40,
                            height: 40,
                          );
                        case 'Convertible':
                          return Image.asset(
                            'assets/icons/convertible.png',
                            color: MyColors.myBlue,
                            width: 40,
                            height: 40,
                          );
                        case 'HatchBack':
                          return Image.asset(
                            'assets/icons/hatchback.png',
                            color: MyColors.myBlue,
                            width: 40,
                            height: 40,
                          );
                        default:
                          return Container();
                      }
                    },
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
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
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
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
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
                        Builder(
                          builder: (context) {
                            switch (widget.car.fuel) {
                              case 'gaz':
                                return Image.asset(
                                  'assets/icons/gas.png',
                                  width: 50,
                                  height: 50,
                                  color: MyColors.myBlue2,
                                );
                              case 'disel':
                                return Image.asset(
                                  'assets/icons/disel.png',
                                  width: 50,
                                  height: 50,
                                  color: Theme.of(context).secondaryHeaderColor,
                                );
                              case 'electro':
                                return Image.asset(
                                  'assets/icons/disel.png',
                                  width: 50,
                                  height: 50,
                                  color: Theme.of(context).secondaryHeaderColor,
                                );
                              default:
                                return Container();
                            }
                          },
                        ),
                        const SizedBox(height: 5),
                        Text(
                          widget.car.fuel,
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
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
            const SizedBox(height: 20),
            //!features
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: MyColors.myGrey,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Center(
                  child: Text(
                    'Features',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: MyColors.myBlue,
                          fontSize: 26,
                        ),
                  ),
                ),
              ),
            ),
            Container(
              color: MyColors.myGrey,
              child: AnimatedSize(
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
                    return Column(
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
                            color: MyColors.myBlue,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            !_showAllFeatures
                ? Container(
                    decoration: const BoxDecoration(
                      color: MyColors.myGrey,
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(24),
                      ),
                    ),
                    child: GestureDetector(
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
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    color: MyColors.mywhite,
                                    fontSize: 16,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Container(
                    decoration: const BoxDecoration(
                      color: MyColors.myGrey,
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(24),
                      ),
                    ),
                    child: GestureDetector(
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
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    color: MyColors.mywhite,
                                    fontSize: 16,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
            const SizedBox(height: 20),
            //!Details
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: MyColors.myGrey,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Center(
                  child: Text(
                    'Details',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: MyColors.myBlue,
                          fontSize: 26,
                        ),
                  ),
                ),
              ),
            ),
            //!1 color
            Container(
              decoration: const BoxDecoration(
                  color: MyColors.myGrey,
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(24))),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Color',
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: MyColors.mywhite,
                                    fontSize: 18,
                                  ),
                        ),
                        Text(
                          widget.car.color,
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: MyColors.mywhite,
                                    fontSize: 18,
                                  ),
                        )
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Divider(
                      color: MyColors.myBlue,
                    ),
                  ),
                  //!2 interior color
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Interior Color',
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: MyColors.mywhite,
                                    fontSize: 18,
                                  ),
                        ),
                        Text(
                          widget.car.interiorColor,
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: MyColors.mywhite,
                                    fontSize: 18,
                                  ),
                        )
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Divider(
                      color: MyColors.myBlue,
                    ),
                  ),
                  //!3 engine
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Engine',
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: MyColors.mywhite,
                                    fontSize: 18,
                                  ),
                        ),
                        Text(
                          widget.car.engine,
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: MyColors.mywhite,
                                    fontSize: 18,
                                  ),
                        )
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Divider(
                      color: MyColors.myBlue,
                    ),
                  ),
                  //!4 transmission
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Transmission',
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: MyColors.mywhite,
                                    fontSize: 18,
                                  ),
                        ),
                        Text(
                          widget.car.transmission,
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: MyColors.mywhite,
                                    fontSize: 18,
                                  ),
                        )
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Divider(
                      color: MyColors.myBlue,
                    ),
                  ),
                  //!5 Drive train
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Drivetrain',
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: MyColors.mywhite,
                                    fontSize: 18,
                                  ),
                        ),
                        Text(
                          widget.car.drivetrain,
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: MyColors.mywhite,
                                    fontSize: 18,
                                  ),
                        )
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Divider(
                      color: MyColors.myBlue,
                    ),
                  ),
                  //!6 kilometrage
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'kilometrage',
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: MyColors.mywhite,
                                    fontSize: 18,
                                  ),
                        ),
                        Text(
                          widget.car.kilometrage.toString(),
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: MyColors.mywhite,
                                    fontSize: 18,
                                  ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            //!discription
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: MyColors.myGrey,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Discription',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: MyColors.myBlue,
                          fontSize: 26,
                        ),
                  ),
                  const SizedBox(height: 10),
                  widget.car.description != ''
                      ? ReadMoreText(
                          widget.car.description,
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
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
                  const SizedBox(height: 10),
                ],
              ),
            ),
            const SizedBox(height: 20),
            //!owner
            BlocProvider(
              create: (context) => UserBloc(),
              child: OwnerCard(car: widget.car),
            ),
            const SizedBox(height: 20),
            BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                if (state is Authenticated) {
                  if (widget.car.ownerid == state.user.uid) {
                    //*delete car
                    return BlocListener<CarsBloc, CarsState>(
                      listener: (context, state) {
                        if (state is CarDeleted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            MySnackBar(
                              icon: const Icon(Icons.done,
                                  color: Colors.green, size: 18),
                              message: state.message,
                              margin: 70,
                            ),
                          );
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            'mainscreen',
                            (Route<dynamic> route) => false,
                          );
                        } else if (state is CarsError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            MySnackBar(
                              icon: const Icon(Icons.error,
                                  color: MyColors.myred2, size: 18),
                              message: 'Error Deleting Car',
                              margin: 5,
                            ),
                          );
                          Navigator.pop(context);
                        }
                      },
                      child: Center(
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (_) {
                                    return MyAlertDialog(
                                      onPressed: () {
                                        context.read<CarsBloc>().add(
                                            DeleteCarEvent(car: widget.car));
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
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
                      ),
                    );
                  } else {
                    return BlocBuilder<ReservationBloc, ReservationState>(
                      builder: (context, state) {
                        return Column(
                          children: [
                            //!book now
                            Text(
                              'Book Now!',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    color: MyColors.mywhite,
                                    fontSize: 18,
                                  ),
                            ),
                            const SizedBox(height: 10),
                            //!Date Pick
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, 'daterangepicker',
                                          arguments: widget.car.id!);
                                    },
                                    child: Container(
                                      width: 125,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: MyColors.myred2,
                                      ),
                                      child: Center(
                                        child: Text(
                                          state is RangePicked
                                              ? '${state.selectedRange.start.year.toString()} / ${state.selectedRange.start.month.toString()} / ${state.selectedRange.start.day.toString()}'
                                              : '${range.start.year.toString()} / ${range.start.month.toString()} / ${range.start.day.toString()}',
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
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, 'daterangepicker',
                                          arguments: widget.car.id!);
                                    },
                                    child: Container(
                                      width: 125,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: MyColors.myred2,
                                      ),
                                      child: Center(
                                        child: Text(
                                          state is RangePicked
                                              ? '${state.selectedRange.end.year.toString()} / ${state.selectedRange.end.month.toString()} / ${state.selectedRange.end.day.toString()}'
                                              : '${range.end.year.toString()} / ${range.end.month.toString()} / ${range.end.day.toString()}',
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
                            const SizedBox(height: 10),
                            //!submit
                            TextButton(
                              onPressed: () {
                                showDialog(
                                  barrierColor: Colors.transparent,
                                  context: context,
                                  builder: (_) {
                                    return MultiBlocProvider(
                                      providers: [
                                        BlocProvider.value(
                                          value:
                                              context.read<ReservationBloc>(),
                                        ),
                                        BlocProvider.value(
                                          value: context.read<AuthCubit>(),
                                        ),
                                      ],
                                      child:
                                          ConfirmReservation(car: widget.car),
                                    );
                                  },
                                );
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(MyColors.myred2),
                              ),
                              child: Text(
                                'Submit',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: MyColors.mywhite,
                                      fontSize: 18,
                                    ),
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        );
                      },
                    );
                  }
                } else {
                  return Container();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
