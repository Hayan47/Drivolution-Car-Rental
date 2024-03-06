import 'package:drivolution/logic/cars_bloc/cars_bloc.dart';
import 'package:drivolution/presentation/widgets/car_card.dart';
import 'package:drivolution/presentation/widgets/shimmer_all_cars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import '../../../constants/my_colors.dart';

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
                    child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          MyColors.myBlue2.withOpacity(0.1),
                          MyColors.myred2.withOpacity(0.2),
                          MyColors.myred2.withOpacity(0.4),
                          MyColors.myred2.withOpacity(0.6),
                          MyColors.myred2.withOpacity(0.6),
                          MyColors.myred2.withOpacity(0.4),
                          MyColors.myred2.withOpacity(0.2),
                          MyColors.myBlue2.withOpacity(0.1),
                        ]),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: SingleChildScrollView(
                        child: TextField(
                          autofocus: true,
                          onChanged: (value) {
                            context.read<CarsBloc>().add(SearchForCarEvent(
                                text: _searchController.text));
                          },
                          maxLines: null,
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: MyColors.mywhite,
                                    fontSize: 18,
                                  ),
                          controller: _searchController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            //!hint
                            hintText: 'find a car',
                            //!hint style
                            hintStyle: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: MyColors.mywhite.withOpacity(0.5),
                                  fontSize: 18,
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
                          color: MyColors.myred2,
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
                      padding: const EdgeInsets.only(right: 15, top: 5),
                      child: GestureDetector(
                        onTap: () {
                          context.read<CarsBloc>().add(
                              SearchForCarEvent(text: _searchController.text));
                        },
                        child: Image.asset(
                          'assets/icons/search.png',
                          width: 35,
                          height: 35,
                          color: MyColors.mywhite,
                        ),
                      ),
                    ),
                  ],
                ),
          body: Column(
            children: [
              BlocBuilder<CarsBloc, CarsState>(
                builder: (context, state) {
                  // if (state is CarsError) {
                  // return Column(
                  //   children: [
                  //     Image.asset('assets/lottie/refresh.png'),
                  //     Text(
                  //       'Error Fetching Cars, Tap to Retry',
                  //       style:
                  //           Theme.of(context).textTheme.bodySmall!.copyWith(
                  //                 color: MyColors.myBlue,
                  //                 fontSize: 22,
                  //                 fontWeight: FontWeight.normal,
                  //               ),
                  //     ),
                  //   ],
                  // );
                  // } else
                  if (state is CarsLoading) {
                    return const AllCarsLoading();
                  } else if (state is CarsLoaded) {
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
                        backgroundColor: MyColors.mywhite,
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
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      color: MyColors.myBlue,
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
