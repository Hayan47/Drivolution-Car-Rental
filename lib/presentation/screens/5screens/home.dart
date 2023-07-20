import 'package:drivolution/logic/cubit/cars_cubit.dart';
import 'package:drivolution/data/models/car_model.dart';
import 'package:drivolution/presentation/widgets/car_card.dart';
import 'package:drivolution/presentation/widgets/shimmer_all_cars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
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
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CarsCubit>(context).getAllCars();
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
                      // ignore: prefer_const_constructors
                      cursorRadius: Radius.circular(100),
                      controller: _searchController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Find A Car...',
                        hintStyle: GoogleFonts.karla(
                          decoration: TextDecoration.none,
                          color: MyColors.mywhite,
                          fontSize: 22,
                        ),
                      ),
                      style: GoogleFonts.karla(
                        decoration: TextDecoration.none,
                        color: MyColors.mywhite,
                        fontSize: 20,
                      ),
                      onChanged: (value) {
                        searchedForCars = allCars
                            .where((car) =>
                                car.name.toLowerCase().startsWith(value))
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
                          //_isSearching = false;
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
                      padding: const EdgeInsets.only(right: 10),
                      child: IconButton(
                        onPressed: () {
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
                        icon: const Icon(
                          Icons.search,
                          size: 32,
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
                  child: ListView.builder(
                    itemCount: _searchController.text.isNotEmpty
                        ? searchedForCars.length
                        : allCars.length,
                    itemBuilder: (context, index) {
                      if (_searchController.text.isNotEmpty) {
                        if (index == searchedForCars.length - 1) {
                          //? Return the last item with some padding
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 55),
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
