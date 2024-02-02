// ignore_for_file: use_build_context_synchronously
import 'package:cached_network_image/cached_network_image.dart';
import 'package:drivolution/data/models/car_model.dart';
import 'package:drivolution/data/models/reservation_model.dart';
import 'package:drivolution/logic/cubit/cars_cubit.dart';
import 'package:drivolution/logic/cubit/usr_cubit.dart';
import 'package:drivolution/data/models/usr_model.dart';
import 'package:drivolution/presentation/widgets/add_phone_number.dart';
import 'package:drivolution/presentation/widgets/car_card.dart';
import 'package:drivolution/presentation/widgets/reservation_card.dart';
import 'package:drivolution/presentation/widgets/shimmer_profile.dart';
import 'package:drivolution/presentation/widgets/snackbar.dart';
import 'package:drivolution/data/services/user_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../constants/my_colors.dart';

class ProfileDetailsScreen extends StatefulWidget {
  const ProfileDetailsScreen({super.key});

  @override
  State<ProfileDetailsScreen> createState() => _ProfileDetailsScreenState();
}

class _ProfileDetailsScreenState extends State<ProfileDetailsScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  late Usr usr;
  Uint8List? _image;
  List<Car> reservedCars = [];
  List<Car> myCars = [];
  final _controller = PageController();
  final _controller2 = PageController();
  List<Reservation> myReservations = [];

  //? upload profile picture
  Future<void> uploadProfilePicture() async {
    try {
      XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = await image.readAsBytes();
      setState(() {
        _image = imageTemporary;
      });
      final path = 'profile pictures/${user.email}';
      final ref = FirebaseStorage.instance.ref().child(path);
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(
            color: MyColors.mywhite,
          ),
        ),
      );
      await ref.putData(_image!);
      Navigator.pop(context);
      final url = await ref.getDownloadURL();
      await UserServices().addImage(context, url, user.uid);
      // await context.read<UsrCubit>().getUserInfo(user.uid);
    } on PlatformException {
      ScaffoldMessenger.of(context).showSnackBar(MySnackBar(
        color: MyColors.myred,
        icon: const Icon(
          Icons.error,
          color: MyColors.mywhite,
          size: 20,
        ),
        title: 'Error',
        message: 'failed to pick image',
        margin: MediaQuery.sizeOf(context).width * 0.2,
      ));
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<UsrCubit>().getUserInfo(user.uid);
  }

  @override
  Widget build(BuildContext context) {
    // return const ProfileLoading();

    return BlocBuilder<UsrCubit, UsrState>(
      builder: (context, state) {
        if (state is UsrLoaded) {
          usr = (state).userInfo;
          myReservations = (state).reservation;
          return Expanded(
            child: ListView(
              children: [
                //!profile card
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        MyColors.myred.withOpacity(0.3),
                        MyColors.myred2.withOpacity(0.9),
                        MyColors.myred.withOpacity(0.3),
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            ClipOval(
                              child: Material(
                                color: MyColors.myred2,
                                child: GestureDetector(
                                  onTap: uploadProfilePicture,
                                  child: SizedBox(
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.3,
                                    height:
                                        MediaQuery.sizeOf(context).width * 0.3,
                                    child: (usr.img != null)
                                        ? CachedNetworkImage(
                                            placeholder: (context, url) =>
                                                const Center(
                                              child: CircularProgressIndicator(
                                                color: MyColors.mywhite,
                                              ),
                                            ),
                                            imageUrl: usr.img!,
                                            fit: BoxFit.cover,
                                          )
                                        : CachedNetworkImage(
                                            placeholder: (context, url) =>
                                                const Center(
                                              child: CircularProgressIndicator(
                                                color: MyColors.mywhite,
                                              ),
                                            ),
                                            imageUrl:
                                                'https://i.imgur.com/sWmIhUZ.png',
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 15,
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border:
                                      Border.all(color: Colors.white, width: 2),
                                  color: Colors.blue,
                                ),
                                padding: const EdgeInsets.all(3),
                                child: const Icon(
                                  Icons.edit,
                                  size: 20,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(width: 20),
                        RichText(
                          text: TextSpan(
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: MyColors.mywhite,
                                      fontSize: 30,
                                    ),
                            children: [
                              TextSpan(
                                text: usr.firstName,
                              ),
                              const TextSpan(text: '\n \t'),
                              TextSpan(
                                text: usr.lastName,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //!phone number
                usr.phoneNumber == ""
                    ? Padding(
                        padding:
                            const EdgeInsets.only(top: 8, right: 12, left: 12),
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                              barrierColor: Colors.transparent,
                              context: context,
                              builder: (context) {
                                return AddPhoneNumber(id: user.uid);
                              },
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'add phone number',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      color: MyColors.mywhite,
                                      fontSize: 18,
                                    ),
                              ),
                              const SizedBox(width: 4),
                              const Icon(
                                Icons.add_circle_outline,
                                color: MyColors.mywhite,
                              )
                            ],
                          ),
                        ),
                      )
                    : Padding(
                        padding:
                            const EdgeInsets.only(top: 8, right: 12, left: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'phone number :',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    color: MyColors.mywhite,
                                    fontSize: 18,
                                  ),
                            ),
                            Text(
                              usr.phoneNumber,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    color: MyColors.mywhite,
                                    fontSize: 18,
                                  ),
                            ),
                          ],
                        ),
                      ),
                //!divider
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Divider(
                    color: MyColors.mywhite,
                  ),
                ),
                //!firste text
                myCars.isEmpty
                    ? Container()
                    : Center(
                        child: Text(
                          'Your Cars',
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: MyColors.mywhite,
                                    fontSize: 28,
                                  ),
                        ),
                      ),
                const SizedBox(height: 15),
                //!user cars
                BlocBuilder<CarsCubit, CarsState>(
                  builder: (context, state) {
                    if (state is CarsLoaded) {
                      for (var car in (state).cars) {
                        //?add user cars to my cars list
                        if (car.ownerid == user.uid) {
                          if (!myCars.contains(car)) {
                            myCars.add(car);
                          }
                        } else {
                          //?add reserved cars to reserserved cars list
                          for (var reservation in myReservations) {
                            if (car.id == reservation.carId) {
                              if (!reservedCars.contains(car)) {
                                reservedCars.add(car);
                              }
                            }
                          }
                        }
                      }
                      return myCars.isEmpty
                          ? Container()
                          : Column(
                              children: [
                                Stack(
                                  children: [
                                    SizedBox(
                                      height: 240,
                                      child: PageView(
                                        controller: _controller,
                                        children: List.generate(
                                            myCars.length,
                                            (index) =>
                                                CarCard(car: myCars[index])),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 230),
                                        child: SmoothPageIndicator(
                                          effect: const ExpandingDotsEffect(
                                            activeDotColor: MyColors.myred2,
                                            dotColor: Colors.white,
                                            dotHeight: 5,
                                            dotWidth: 5,
                                          ),
                                          count: myCars.length,
                                          controller: _controller,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 15),
                                //!second text
                                Center(
                                  child: Text(
                                    'Your Reservations',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          color: MyColors.mywhite,
                                          fontSize: 28,
                                        ),
                                  ),
                                ),
                                const SizedBox(height: 15),
                                //!user Reservations
                                reservedCars.isEmpty
                                    ? Container()
                                    : Column(
                                        children: [
                                          Stack(
                                            children: [
                                              Align(
                                                alignment: Alignment.center,
                                                child: SizedBox(
                                                  height: 150,
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          0.7,
                                                  child: PageView(
                                                    controller: _controller2,
                                                    children: List.generate(
                                                        reservedCars.length,
                                                        (index) {
                                                      List<Reservation>
                                                          carReservations = [];
                                                      for (var reservation
                                                          in myReservations) {
                                                        if (reservation.carId ==
                                                            reservedCars[index]
                                                                .id) {
                                                          carReservations
                                                              .add(reservation);
                                                        }
                                                      }
                                                      return ReservationCard(
                                                        car:
                                                            reservedCars[index],
                                                        carReservations:
                                                            carReservations,
                                                      );
                                                    }),
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.center,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 150),
                                                  child: SmoothPageIndicator(
                                                    effect:
                                                        const ExpandingDotsEffect(
                                                      activeDotColor:
                                                          MyColors.myred2,
                                                      dotColor: Colors.white,
                                                      dotHeight: 5,
                                                      dotWidth: 5,
                                                    ),
                                                    count: reservedCars.length,
                                                    controller: _controller2,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                              ],
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
                const SizedBox(height: 15),
                GestureDetector(
                  onTap: () => showDialog(
                    barrierColor: Colors.transparent,
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        backgroundColor: MyColors.mywhite,
                        elevation: 0,
                        insetPadding:
                            const EdgeInsets.symmetric(horizontal: 25),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        content: Text(
                          'are you sure you want to sign out ?',
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: MyColors.myred,
                                    fontSize: 19,
                                  ),
                        ),
                        actions: [
                          //!yes
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 20, bottom: 15),
                            child: GestureDetector(
                              onTap: () async {
                                FirebaseAuth.instance.signOut();
                                Navigator.pop(context);
                              },
                              child: Container(
                                width: 60,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: MyColors.myred2,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: const Color.fromARGB(
                                          255, 36, 114, 121),
                                      width: 2),
                                ),
                                child: Center(
                                  child: Text(
                                    'yes',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: MyColors.mywhite,
                                          fontSize: 18,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          //!no
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 20, bottom: 15),
                            child: GestureDetector(
                              onTap: () async {
                                Navigator.pop(context);
                              },
                              child: Container(
                                width: 60,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: MyColors.myred2,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: const Color.fromARGB(
                                          255, 36, 114, 121),
                                      width: 2),
                                ),
                                child: Center(
                                  child: Text(
                                    'no',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: MyColors.mywhite,
                                          fontSize: 18,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(right: 20, left: 20, bottom: 100),
                    child: Container(
                      height: 40,
                      width: 100,
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
                          'Sign out',
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: MyColors.mywhite,
                                    fontSize: 22,
                                  ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const ProfileLoading();
        }
      },
    );
  }
}
