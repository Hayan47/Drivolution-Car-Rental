import 'package:cached_network_image/cached_network_image.dart';
import 'package:drivolution/constants/my_colors.dart';
import 'package:drivolution/logic/image_bloc/image_bloc.dart';
import 'package:drivolution/logic/logo_bloc/logo_bloc.dart';
import 'package:drivolution/presentation/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCar1 extends StatelessWidget {
  const AddCar1({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<LogoBloc>().add(FetchCarLogosEvent());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Text(
          'Select Car Logo',
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: MyColors.mywhite,
              ),
        ),
        BlocBuilder<LogoBloc, LogoState>(
          builder: (context, state) {
            return Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  childAspectRatio: 1,
                ),
                itemCount: state.carLogos.length,
                itemBuilder: (context, index) {
                  final isSelected = state.selectedIndex == index;
                  // selectedlogo = state.selectedIndex;
                  return GestureDetector(
                    onTap: () {
                      context.read<LogoBloc>().add(SelectLogoEvent(index));
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                      decoration: BoxDecoration(
                        borderRadius:
                            isSelected ? BorderRadius.circular(14) : null,
                        border: isSelected
                            ? Border.all(
                                color: MyColors.myBlue,
                                width: 2,
                              )
                            : null,
                        boxShadow: isSelected
                            ? [
                                const BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 5,
                                  offset: Offset(0, 2),
                                ),
                              ]
                            : null,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: CachedNetworkImage(
                          imageUrl: state.carLogos[index],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
        //!select main image
        Text(
          'Select Car Image',
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: MyColors.mywhite,
              ),
        ),
        const SizedBox(height: 25),
        Expanded(
          child: GestureDetector(
            onTap: () {
              context.read<ImageBloc>().add(AddImageEvent());
            },
            child: BlocConsumer<ImageBloc, ImageState>(
              listener: (context, state) {
                if (state is ImageError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    MySnackBar(
                      icon: const Icon(Icons.error,
                          color: MyColors.myred2, size: 18),
                      message: state.errorMessage,
                      margin: 5,
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is ImageChanged) {
                  return Center(
                    child: SizedBox(
                      child: Card(
                        color: Colors.transparent,
                        child: Image.memory(
                          state.image,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  );
                } else if (state is ImageLoading) {
                  return const SizedBox(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: MyColors.myred,
                      ),
                    ),
                  );
                } else {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: MyColors.myBlue,
                        width: 2,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        'assets/img/cars/carholder.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
