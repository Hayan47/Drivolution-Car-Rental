import 'package:drivolution/logic/cars_bloc/cars_bloc.dart';
import 'package:drivolution/presentation/themes/app_colors.dart';
import 'package:drivolution/presentation/widgets/car_card.dart';
import 'package:drivolution/presentation/widgets/shimmer_all_cars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:drivolution/presentation/themes/app_typography.dart';

class HomeScreen extends StatelessWidget {
  final _searchController = TextEditingController();
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CarsBloc, CarsState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          appBar: (state is CarSearching)
              ? AppBar(
                  title: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: SizedBox(
                      height: 45,
                      child: SingleChildScrollView(
                        child: TextField(
                          autofocus: true,
                          onChanged: (value) {
                            context.read<CarsBloc>().add(SearchForCarEvent(
                                text: _searchController.text));
                          },
                          maxLines: null,
                          textAlign: TextAlign.center,
                          style: AppTypography.labelLarge.copyWith(
                            color: AppColors.pureWhite,
                            fontSize: 18,
                          ),
                          controller: _searchController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            //!hint
                            hintText: 'saerch..',
                            //!hint style
                            hintStyle: AppTypography.h4
                                .copyWith(
                                  color: AppColors.pureWhite.withOpacity(0.5),
                                ),
                          ),
                          cursorHeight: 18,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.search,
                        ),
                      ),
                    ),
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: IconButton(
                        onPressed: () {
                          context
                              .read<CarsBloc>()
                              .add(CloseSearchForCarEvent());
                          _searchController.clear();
                        },
                        icon: const Icon(
                          Icons.clear,
                          size: 32,
                          color: AppColors.pureWhite,
                        ),
                      ),
                    )
                  ],
                )
              : AppBar(
                  title: Row(
                    children: [
                      SizedBox(width: MediaQuery.sizeOf(context).width / 8),
                      Image.asset(
                        'assets/img/logo/drivolution.png',
                        width: MediaQuery.sizeOf(context).width / 2,
                      ),
                    ],
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20, top: 5),
                      child: GestureDetector(
                        onTap: () {
                          context.read<CarsBloc>().add(
                              SearchForCarEvent(text: _searchController.text));
                        },
                        child: const Icon(
                          IconlyBroken.search,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
          body: Column(
            children: [
              BlocBuilder<CarsBloc, CarsState>(
                builder: (context, state) {
                  if (state is CarsLoading) {
                    return const AllCarsLoading();
                  } else if (state is CarsLoaded) {
                    if (state.cars.isEmpty) {
                      return Expanded(
                        child: GestureDetector(
                          onTap: () {
                            //?get cars
                            context.read<CarsBloc>().add(GetAllCarsEvent());
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.sizeOf(context).height * 0.2),
                            child: Column(
                              children: [
                                Image.asset('assets/lottie/refresh.png'),
                                Text(
                                  'Error Fetching Cars, Tap to Retry',
                                  style: AppTypography.labelLarge
                                      .copyWith(
                                        color: AppColors.oceanBlue,
                                        fontSize: 20,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Expanded(
                        child: LiquidPullToRefresh(
                          onRefresh: () async {
                            //?get cars
                            await Future.delayed(const Duration(seconds: 1));
                            context.read<CarsBloc>().add(GetAllCarsEvent());
                          },
                          animSpeedFactor: 1,
                          springAnimationDurationInMilliseconds: 100,
                          showChildOpacityTransition: false,
                          height: 200,
                          color: Colors.transparent,
                          backgroundColor: AppColors.pureWhite,
                          child: ListView.builder(
                            itemCount: state.cars.length,
                            itemBuilder: (context, index) {
                              if (index == state.cars.length - 1) {
                                //? Return the last item with some padding
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 65),
                                  child: CarCard(car: state.cars[index]),
                                );
                              } else {
                                return CarCard(car: state.cars[index]);
                              }
                            },
                          ),
                        ),
                      );
                    }
                  } else if (state is CarSearching) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: state.searchedForCars.length,
                        itemBuilder: (context, index) {
                          if (index == state.searchedForCars.length - 1) {
                            //? Return the last item with some padding
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 65),
                              child: CarCard(car: state.searchedForCars[index]),
                            );
                          } else {
                            return CarCard(car: state.searchedForCars[index]);
                          }
                        },
                      ),
                    );
                  } else {
                    context.read<CarsBloc>().add(GetAllCarsEvent());
                    return Expanded(
                      child: GestureDetector(
                        onTap: () {
                          //?get cars
                          context.read<CarsBloc>().add(GetAllCarsEvent());
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.sizeOf(context).height * 0.2),
                          child: Column(
                            children: [
                              Image.asset('assets/lottie/refresh.png'),
                              Text(
                                'Error Fetching Cars, Tap to Retry',
                                style:AppTypography.labelLarge
                                    .copyWith(
                                      color: AppColors.oceanBlue,
                                      fontSize: 20,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                },
              )
            ],
          ),
        );
      },
    );
  }
}
