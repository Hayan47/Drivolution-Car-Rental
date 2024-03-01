import 'package:cached_network_image/cached_network_image.dart';
import 'package:drivolution/constants/my_colors.dart';
import 'package:drivolution/logic/auth_cubit/auth_cubit.dart';
import 'package:drivolution/logic/favorite_bloc/favorite_bloc.dart';
import 'package:drivolution/presentation/widgets/favorite_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../../data/models/car_model.dart';

class CarCard extends StatefulWidget {
  final Car car;

  const CarCard({required this.car, super.key});

  @override
  State<CarCard> createState() => _CarCardState();
}

class _CarCardState extends State<CarCard> {
  // List<Car> favoritesCars = [];
  // bool loading_add = false;
  // bool loading_remove = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'cardetailsscreen', arguments: widget.car);
      },
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              right: 25,
              left: 15,
              bottom: 40,
              top: 10,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: SizedBox(
                width: double.infinity,
                height: 180,
                child: Stack(
                  children: [
                    Container(color: MyColors.myGrey),
                    //?child
                    Padding(
                      padding: const EdgeInsets.all(15),
                      //?main colimn
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    const SizedBox(height: 20),
                                    Row(
                                      children: [
                                        Flexible(
                                          child: Hero(
                                            tag: widget.car.name,
                                            child: Text(
                                              '${widget.car.name} ${widget.car.model}',
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              softWrap: false,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                    color: MyColors.mywhite,
                                                  ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Hero(
                                tag: widget.car.logo,
                                child: CachedNetworkImage(
                                  imageUrl: widget.car.logo,
                                  width: 50,
                                  height: 50,
                                ),
                              )
                            ],
                          ),
                          FavoriteIcon(car: widget.car),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: MediaQuery.sizeOf(context).width / 3,
            top: 100,
            child: SizedBox(
              height: 120,
              width: MediaQuery.sizeOf(context).width * 0.6,
              child: Hero(
                tag: widget.car.img,
                child: CachedNetworkImage(
                  imageUrl: widget.car.img,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
          //!price
          Positioned(
            left: 10,
            child: Container(
              padding: const EdgeInsets.all(6),
              width: 125,
              decoration: BoxDecoration(
                color: MyColors.myred4,
                borderRadius: BorderRadius.circular(12),
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
                children: [
                  Text(
                    'Price   ',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: MyColors.mywhite,
                          fontSize: 15,
                        ),
                  ),
                  Text(
                    '${widget.car.rent} \$',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: MyColors.mywhite,
                        ),
                  ),
                  Text(
                    '/D',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: MyColors.mywhite,
                        ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
