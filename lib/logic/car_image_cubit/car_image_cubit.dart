import 'dart:io';
import 'package:drivolution/data/repositories/image_repository.dart';
import 'package:drivolution/data/services/logger_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

part 'car_image_state.dart';

class CarImageCubit extends Cubit<CarImageState> {
  final logger = LoggerService().getLogger("Image Cubit Logger");
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

        //! Remove background specifically for car image
        final processedImage =
            await imageRepository.removeBackground(imageData);

        // Create a temporary file
        final tempDir =
            await getTemporaryDirectory(); // From path_provider package
        final tempFile = File(
            '${tempDir.path}/temp_${DateTime.now().millisecondsSinceEpoch}.png');

        // Write the bytes to the file
        await tempFile.writeAsBytes(processedImage);

        emit(CarImageChanged(tempFile));
      } else {
        emit(const CarImageError('No Car Image Selected'));
      }
    } catch (e) {
      emit(CarImageError('Error picking car image: ${e.toString()}'));
      logger.severe(e);
    }
  }

  void reset() {
    emit(CarImageInitial());
  }
}
