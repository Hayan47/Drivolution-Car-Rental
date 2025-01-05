import 'dart:io';

import 'package:drivolution/data/repositories/image_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'user_image_state.dart';

class UserImageCubit extends Cubit<UserImageState> {
  final ImageRepository imageRepository;

  UserImageCubit({required this.imageRepository}) : super(UserImageInitial());

  Future<void> pickUserImage(String userEmail) async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        emit(UserImageLoading());

        final image = File(pickedFile.path);
        // final imageData = await image.readAsBytes();

        // final imageUrl = await imageRepository.uploadImages(
        //     images: [imageData], path: 'profile pictures/$userEmail');
        emit(UserImageChanged(
            image: image, message: 'Image Changed Successfully'));
      } else {
        emit(const UserImageError('No User Image Selected'));
      }
    } catch (e) {
      emit(UserImageError('Error picking user image: ${e.toString()}'));
    }
  }

  void clearUserImage() {
    emit(UserImageInitial());
  }
}
