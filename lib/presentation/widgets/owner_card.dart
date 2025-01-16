import 'package:cached_network_image/cached_network_image.dart';
import 'package:drivolution/logic/car_owner_bloc/car_owner_bloc.dart';
import 'package:drivolution/presentation/themes/app_colors.dart';
import 'package:drivolution/presentation/themes/app_typography.dart';
import 'package:drivolution/presentation/widgets/shimmer_owner_card.dart';
import 'package:drivolution/presentation/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../data/models/car_model.dart';

class OwnerCard extends StatelessWidget {
  final Car car;
  const OwnerCard({required this.car, super.key});

  @override
  Widget build(BuildContext context) {
    context.read<CarOwnerBloc>().add(GetCarOwnerInfo(userid: car.ownerid));
    return BlocBuilder<CarOwnerBloc, CarOwnerState>(
      builder: (context, state) {
        if (state is CarOwnerLoaded) {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: SizedBox(
                    width: double.infinity,
                    height: 180,
                    child: Stack(
                      children: [
                        //!gradiant effect
                        Container(
                          decoration: const BoxDecoration(
                            gradient: AppColors.cardGradient2,
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
                                  color: AppColors.coralRed,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: const [
                                    //* right
                                    BoxShadow(
                                      color: AppColors.twilightBlue,
                                      offset: Offset(2, 0),
                                      blurRadius: 1,
                                      spreadRadius: 0.1,
                                    ),
                                    //* left
                                    BoxShadow(
                                      color: AppColors.twilightBlue,
                                      offset: Offset(-2, 0),
                                      blurRadius: 1,
                                      spreadRadius: 0.1,
                                    ),
                                    //* top
                                    BoxShadow(
                                      color: AppColors.twilightBlue,
                                      offset: Offset(0, 2),
                                      blurRadius: 1,
                                      spreadRadius: 0.1,
                                    ),
                                    //* down
                                    BoxShadow(
                                      color: AppColors.twilightBlue,
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
                                      style: AppTypography.labelLarge.copyWith(
                                        color: AppColors.pureWhite,
                                        fontSize: 15,
                                      ),
                                    ),
                                    Text(
                                      '${car.rent} \$/D',
                                      style: AppTypography.labelLarge.copyWith(
                                        color: AppColors.pureWhite,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              //!divider
                              Divider(color: AppColors.jetBlack),
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
                                          placeholder: (context, url) => Center(
                                              child: Lottie.asset(
                                                  'assets/lottie/SplashyLoader.json')),
                                          imageUrl: state.userInfo.img!,
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
                                                    '${state.userInfo.firstName} ${state.userInfo.lastName}',
                                                    style: AppTypography
                                                        .labelLarge
                                                        .copyWith(
                                                      color:
                                                          AppColors.pureWhite,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 5),
                                              Text(
                                                state.userInfo.phoneNumber,
                                                style: AppTypography.labelLarge
                                                    .copyWith(
                                                  color: AppColors.pureWhite,
                                                ),
                                              ),
                                            ],
                                          ),
                                          //!call button
                                          GestureDetector(
                                            onTap: () async {
                                              final Uri phone = Uri(
                                                scheme: 'tel',
                                                path:
                                                    state.userInfo.phoneNumber,
                                              );
                                              if (await canLaunchUrl(phone)) {
                                                await launchUrl(phone);
                                              } else {
                                                showToastMessage(
                                                  context,
                                                  'can\'t open phone number',
                                                  const Icon(
                                                    Icons.error,
                                                    color: AppColors.alertRed,
                                                    size: 20,
                                                  ),
                                                );
                                              }
                                            },
                                            child: Container(
                                              width: 130,
                                              height: 35,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                color: AppColors.charcoal,
                                                border: Border.all(
                                                  color: AppColors.steelGrey,
                                                ),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  'Call',
                                                  style:
                                                      AppTypography.h4.copyWith(
                                                    color: AppColors.pureWhite,
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
                      child:
                          CircularProgressIndicator(color: AppColors.pureWhite),
                    ),
                    imageUrl: car.img,
                  ),
                ),
              ),
            ],
          );
        } else {
          return const OwnerCardLoading();
        }
      },
    );
  }
}
