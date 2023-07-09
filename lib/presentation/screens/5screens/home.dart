import 'package:drivolution/logic/cubit/cars_cubit.dart';
import 'package:drivolution/data/models/car_model.dart';
import 'package:drivolution/presentation/widgets/car_card.dart';
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
    return BlocBuilder<CarsCubit, CarsState>(builder: (context, state) {
      if (state is CarsLoaded) {
        allCars = (state).cars;
        return DecoratedBox(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/img/background2.jpg'),
              fit: BoxFit.fill,
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
              Expanded(
                child: ListView.builder(
                  itemCount: _searchController.text.isNotEmpty
                      ? searchedForCars.length
                      : allCars.length,
                  itemBuilder: (context, index) {
                    return _searchController.text.isNotEmpty
                        ? CarCard(car: searchedForCars[index])
                        : CarCard(car: allCars[index]);
                  },
                ),
              ),
            ],
          ),
        );
      } else {
        return const DecoratedBox(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/img/background2.jpg'),
                fit: BoxFit.fill,
              ),
            ),
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.white,
                backgroundColor: Colors.transparent,
              ),
            ));
      }
    });
  }
}
