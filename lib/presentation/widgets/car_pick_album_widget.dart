import 'package:drivolution/logic/album_bloc/album_bloc.dart';
import 'package:drivolution/logic/car_form_bloc/car_form_bloc.dart';
import 'package:drivolution/presentation/themes/app_colors.dart';
import 'package:drivolution/presentation/themes/app_typography.dart';
import 'package:drivolution/presentation/widgets/toast.dart';
import 'package:drivolution/utils/responsive/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarPickAlbumWidget extends StatelessWidget {
  const CarPickAlbumWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'pick an album',
          style: AppTypography.labelLarge.copyWith(color: AppColors.pureWhite),
        ),
        const SizedBox(height: 10),
        ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: ResponsiveHelper.hp(context, 50),
          ),
          child: GestureDetector(
            onLongPress: () {
              context.read<AlbumBloc>().add(ResetAlbumEvent());
              context.read<CarFormBloc>().add(CarAlbumChanged(images: []));
            },
            onTap: () => context.read<AlbumBloc>().add(AddAlbumEvent()),
            child: BlocConsumer<AlbumBloc, AlbumState>(
              listener: (context, state) {
                if (state is AlbumError) {
                  showToastMessage(
                    context,
                    state.errorMessage,
                    const Icon(Icons.error,
                        color: AppColors.alertRed, size: 18),
                  );
                }
              },
              builder: (context, state) {
                if (state is AlbumChanged) {
                  context
                      .read<CarFormBloc>()
                      .add(CarAlbumChanged(images: state.images));
                  return GridView.count(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    padding: const EdgeInsets.all(8),
                    crossAxisCount: 3,
                    children: List.generate(
                      state.images.length,
                      (index) => Card(
                        child: Image.file(state.images[index]),
                      ),
                    ),
                  );
                } else if (state is AlbumLoading) {
                  return const SizedBox(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: AppColors.blazingRed,
                      ),
                    ),
                  );
                } else {
                  return GridView.count(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    crossAxisCount: 3,
                    children: List.generate(
                      9,
                      (index) => Card(
                        child: Image.asset(
                          'assets/img/cars/carholder2.jpg',
                        ),
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
