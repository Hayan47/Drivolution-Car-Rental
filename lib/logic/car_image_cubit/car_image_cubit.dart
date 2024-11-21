import 'dart:io';
import 'dart:typed_data';

import 'package:drivolution/data/repositories/image_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'car_image_state.dart';

class CarImageCubit extends Cubit<CarImageState> {
  final ImageRepository imageRepository;

  CarImageCubit({required this.imageRepository}) : super(CarImageInitial());

  Future<void> pickCarImage() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        emit(CarImageLoading());

        final image = File(pickedFile.path);
        final imageData = await image.readAsBytes();

        //! Remove background specifically for car images
        final processedImage =
            await imageRepository.removeBackground(imageData);

        emit(CarImageChanged(processedImage));
      } else {
        emit(const CarImageError('No Car Image Selected'));
      }
    } catch (e) {
      emit(CarImageError('Error picking car image: ${e.toString()}'));
    }
  }

  void reset() {
    emit(CarImageInitial());
  }
}
