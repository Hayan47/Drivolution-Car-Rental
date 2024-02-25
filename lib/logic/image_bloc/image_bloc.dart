import 'dart:io';
import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:drivolution/data/services/image_service.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
part 'image_event.dart';
part 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  ImageBloc() : super(ImageInitial()) {
    XFile? pickedFile;
    on<ImageEvent>((event, emit) async {
      if (event is AddImageEvent) {
        try {
          XFile? pickedFile2 =
              await ImagePicker().pickImage(source: ImageSource.gallery);
          //to handle if the user enterd and exited second time without picking keep the old one
          if (pickedFile2 != null) {
            pickedFile = pickedFile2;
          }
          if (pickedFile != null) {
            emit(ImageLoading());
            final image = File(pickedFile!.path);
            final imageData = await image.readAsBytes();
            final img = await ImageService().removeBackground(imageData);
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
