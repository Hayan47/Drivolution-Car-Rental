import 'dart:io';
import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:drivolution/data/services/remove_image_background.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

part 'image_event.dart';
part 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  ImageBloc() : super(ImageInitial()) {
    on<ImageEvent>((event, emit) async {
      if (event is AddImageEvent) {
        try {
          XFile? pickedFile =
              await ImagePicker().pickImage(source: ImageSource.gallery);
          if (pickedFile != null) {
            emit(ImageLoading());
            final image = File(pickedFile.path);
            final imageData = await image.readAsBytes();
            final img = await RemoveBackground().removeBackground(imageData);
            emit(ImageChanged(img));
          } else {
            emit(const ImageError('No Image Selected'));
          }
        } catch (e) {
          emit(const ImageError('image not picked correctly'));
        }
      } else if (event is NoImageSelectedEvent) {
        emit(const ImageError('No Image Selected'));
      }
    });
  }
}
