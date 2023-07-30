import 'package:drivolution/logic/cubit/cars_cubit.dart';
import 'package:drivolution/data/models/car_model.dart';
import 'package:drivolution/presentation/widgets/car_card.dart';
import 'package:drivolution/presentation/widgets/shimmer_all_cars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import '../../../constants/my_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Car> allCars = [];
  List<Car> searchedForCars = [];
  bool _isSearching = false;
  final _searchController = TextEditingController();

  Future<void> refresh() async {
    //?get cars
    await Future.delayed(const Duration(seconds: 2));
    await context.read<CarsCubit>().getAllCars();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xff1E1E24),
            Color(0xff243B55),
            Color(0xff1E1E24),
          ],
        ),
      ),
      child: Column(
        children: [
          _isSearching
              ? AppBar(
                  title: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      cursorColor: MyColors.mywhite,
                      cursorRadius: const Radius.circular(100),
                      controller: _searchController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Find A Car...',
                        hintStyle:
                            Theme.of(context).textTheme.bodySmall!.copyWith(
                                  color: MyColors.mywhite,
                                  fontSize: 22,
                                ),
                      ),
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: MyColors.mywhite,
                            fontSize: 22,
                          ),
                      onChanged: (value) {
                        searchedForCars = allCars
                            .where(
                                (car) => car.name.toLowerCase().contains(value))
                            .toList();
                        setState(() {});
                      },
                    ),
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: IconButton(
                        onPressed: () {
                          _searchController.clear();
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.clear,
                          size: 32,
                        ),
                      ),
                    )
                  ],
                )
              : AppBar(
                  title: Row(
                    children: [
                      SizedBox(width: MediaQuery.sizeOf(context).width / 8),
                      const Text(
                        'All Cars',
                      ),
                    ],
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(right: 15, top: 5),
                      child: GestureDetector(
                        onTap: () {
                          ModalRoute.of(context)!
                              .addLocalHistoryEntry(LocalHistoryEntry(
                            onRemove: () {
                              setState(() {
                                _searchController.clear();
                                _isSearching = false;
                              });
                            },
                          ));
                          setState(() {
                            _isSearching = true;
                          });
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
          BlocBuilder<CarsCubit, CarsState>(
            builder: (context, state) {
              if (state is CarsLoaded) {
                allCars = (state).cars;
                return Expanded(
                  child: LiquidPullToRefresh(
                    onRefresh: refresh,
                    animSpeedFactor: 1,
                    springAnimationDurationInMilliseconds: 100,
                    showChildOpacityTransition: false,
                    height: 200,
                    color: Colors.transparent,
                    backgroundColor: MyColors.mywhite,
                    child: ListView.builder(
                      itemCount: _searchController.text.isNotEmpty
                          ? searchedForCars.length
                          : allCars.length,
                      itemBuilder: (context, index) {
                        if (_searchController.text.isNotEmpty) {
                          if (index == searchedForCars.length - 1) {
                            //? Return the last item with some padding
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 65),
                              child: CarCard(car: searchedForCars[index]),
                            );
                          } else {
                            return CarCard(car: searchedForCars[index]);
                          }
                        } else {
                          if (index == allCars.length - 1) {
                            //? Return the last item with some padding
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 65),
                              child: CarCard(car: allCars[index]),
                            );
                          } else {
                            return CarCard(car: allCars[index]);
                          }
                        }
                      },
                    ),
                  ),
                );
              } else if (state is CarsError) {
                return Center(
                  child: Text(
                    state.message,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: MyColors.myred,
                          fontSize: 22,
                        ),
                  ),
                );
              } else {
                Future.delayed(const Duration(seconds: 3));
                return const AllCarsLoading();
              }
            },
          )
        ],
      ),
    );
  }
}
