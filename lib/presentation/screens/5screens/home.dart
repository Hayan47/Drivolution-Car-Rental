import 'package:drivolution/logic/cars_bloc/cars_bloc.dart';
import 'package:drivolution/data/models/car_model.dart';
import 'package:drivolution/presentation/widgets/car_card.dart';
import 'package:drivolution/presentation/widgets/shimmer_all_cars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    await Future.delayed(const Duration(seconds: 1));
    context.read<CarsBloc>().add(GetAllCarsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _isSearching
            ? SafeArea(
                child: Container(
                  margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        MyColors.myred.withOpacity(0.6),
                        MyColors.myred2,
                        MyColors.myred.withOpacity(0.6),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: AppBar(
                    title: TextField(
                      cursorColor: MyColors.mywhite,
                      cursorRadius: const Radius.circular(100),
                      controller: _searchController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'find a car...',
                        hintStyle:
                            Theme.of(context).textTheme.bodySmall!.copyWith(
                                  color: MyColors.mywhite,
                                  fontSize: 22,
                                  fontWeight: FontWeight.normal,
                                ),
                      ),
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: MyColors.mywhite,
                            fontSize: 22,
                            fontWeight: FontWeight.normal,
                          ),
                      onChanged: (value) {
                        searchedForCars = allCars
                            .where(
                                (car) => car.name.toLowerCase().contains(value))
                            .toList();
                        setState(() {});
                      },
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
                  ),
                ),
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
        BlocBuilder<CarsBloc, CarsState>(
          builder: (context, state) {
            if (state is CarsError) {
              return Center(
                child: Text(
                  state.message,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: MyColors.myred,
                        fontSize: 22,
                      ),
                ),
              );
            } else if (state is CarsLoading) {
              return const AllCarsLoading();
            } else if (state is CarsLoaded) {
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
            } else {
              return Expanded(
                  child: LiquidPullToRefresh(
                onRefresh: refresh,
                animSpeedFactor: 1,
                springAnimationDurationInMilliseconds: 100,
                showChildOpacityTransition: false,
                height: 200,
                color: Colors.transparent,
                backgroundColor: MyColors.mywhite,
                child: ListView(),
              ));
            }
          },
        )
      ],
    );
  }
}
