import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:drivolution/logic/cubit/usr_cubit.dart';
import 'package:drivolution/constants/my_colors.dart';
import 'package:drivolution/data/models/usr_model.dart';
import 'package:drivolution/presentation/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../data/models/car_model.dart';

class OwnerCard extends StatefulWidget {
  final Car car;

  const OwnerCard({required this.car, super.key});

  @override
  State<OwnerCard> createState() => _OwnerCardState();
}

class _OwnerCardState extends State<OwnerCard> {
  @override
  void initState() {
    super.initState();
    context.read<UsrCubit>().getUserInfo(widget.car.ownerid);
  }

  bool favorite = false;
  late Usr usr;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsrCubit, UsrState>(
      builder: (context, state) {
        if (state is UsrLoaded) {
          usr = (state).userInfo;
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  right: 25,
                  left: 15,
                  top: 50,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    width: double.infinity,
                    height: 180,
                    child: Stack(
                      children: [
                        //!gradiant effect
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                MyColors.myred,
                                MyColors.myred2.withAlpha(130),
                                MyColors.myBlue.withAlpha(130),
                                MyColors.myBlue2,
                              ],
                            ),
                          ),
                        ),
                        //!child
                        Padding(
                          padding: const EdgeInsets.all(15),
                          //?main colimn
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //!price
                              Container(
                                padding: const EdgeInsets.all(6),
                                width: 125,
                                decoration: BoxDecoration(
                                  color: MyColors.myred.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: const [
                                    //* right
                                    BoxShadow(
                                      color: MyColors.myBlue,
                                      offset: Offset(2, 0),
                                      blurRadius: 1,
                                      spreadRadius: 0.1,
                                    ),
                                    //* left
                                    BoxShadow(
                                      color: MyColors.myBlue,
                                      offset: Offset(-2, 0),
                                      blurRadius: 1,
                                      spreadRadius: 0.1,
                                    ),
                                    //* top
                                    BoxShadow(
                                      color: MyColors.myBlue,
                                      offset: Offset(0, 2),
                                      blurRadius: 1,
                                      spreadRadius: 0.1,
                                    ),
                                    //* down
                                    BoxShadow(
                                      color: MyColors.myBlue,
                                      offset: Offset(0, -2),
                                      blurRadius: 0.5,
                                      spreadRadius: 0.1,
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      'Price   ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            color: MyColors.mywhite,
                                            fontSize: 16,
                                          ),
                                    ),
                                    Text(
                                      '${widget.car.rent} \$/D',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            color: MyColors.mywhite,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              //!divider
                              Divider(
                                color: Theme.of(context).secondaryHeaderColor,
                              ),
                              //?main row
                              //!picture
                              Expanded(
                                child: Row(
                                  children: [
                                    //! name + number + buttons
                                    SizedBox(
                                      width: 60,
                                      height: 100,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: CachedNetworkImage(
                                          placeholder: (context, url) =>
                                              const Center(
                                            child: CircularProgressIndicator(
                                              color: MyColors.mywhite,
                                            ),
                                          ),
                                          imageUrl: usr.img!,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    '${usr.firstName} ${usr.lastName}',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall!
                                                        .copyWith(
                                                          color:
                                                              MyColors.myBlue2,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 5),
                                              Text(
                                                usr.phoneNumber,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                      color: MyColors.myBlue2,
                                                    ),
                                              ),
                                            ],
                                          ),
                                          //!call button
                                          GestureDetector(
                                            onTap: () async {
                                              final Uri phone = Uri(
                                                scheme: 'tel',
                                                path: usr.phoneNumber,
                                              );
                                              if (await canLaunchUrl(phone)) {
                                                await launchUrl(phone);
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  MySnackBar(
                                                    icon: const Icon(
                                                      Icons.error,
                                                      color: MyColors.myred2,
                                                      size: 20,
                                                    ),
                                                    message:
                                                        'can\'t open phone number',
                                                    margin:
                                                        0, //MediaQuery.sizeOf(context).width * 0.2,
                                                  ),
                                                );
                                              }
                                            },
                                            child: Container(
                                              width: 100,
                                              height: 25,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  gradient: LinearGradient(
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomRight,
                                                    colors: [
                                                      MyColors.myBlue2
                                                          .withAlpha(240),
                                                      MyColors.myBlue2
                                                          .withAlpha(180),
                                                      MyColors.myBlue2
                                                          .withAlpha(120),
                                                      MyColors.myBlue2
                                                          .withAlpha(60),
                                                    ],
                                                  ),
                                                  boxShadow: const [
                                                    BoxShadow(
                                                      color: MyColors.myBlue2,
                                                      offset: Offset(3, 4),
                                                      blurRadius: 1,
                                                      spreadRadius: 0.1,
                                                    ),
                                                    BoxShadow(
                                                      color: MyColors.myBlue,
                                                      offset: Offset(0, 0),
                                                      blurRadius: 2,
                                                      spreadRadius: 1,
                                                    ),
                                                  ]),
                                              child: Center(
                                                child: Text(
                                                  'Call',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(
                                                        color: MyColors.mywhite,
                                                        fontSize: 16,
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
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: MediaQuery.sizeOf(context).width * 0.45,
                bottom: 80,
                child: SizedBox(
                  height: 200,
                  width: MediaQuery.sizeOf(context).width * 0.5,
                  child: CachedNetworkImage(
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(
                        color: MyColors.mywhite,
                      ),
                    ),
                    imageUrl: widget.car.img,
                  ),
                ),
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
    );
  }
}
