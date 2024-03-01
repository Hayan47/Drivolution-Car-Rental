import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:drivolution/data/services/image_service.dart';
import 'package:equatable/equatable.dart';
part 'upload_event.dart';
part 'upload_state.dart';

class UploadBloc extends Bloc<UploadEvent, UploadState> {
  UploadBloc() : super(UploadInitial()) {
    on<UploadImagesEvent>((event, emit) async {
      emit(const UploadingState());
      try {
        final imageUrl = await ImageService().uploadImages(
          images: event.images,
          path: event.path,
        );
        emit(UploadSuccessState(imageUrl, 'Images Uploaded Sucessfuly'));
      } catch (e) {
        emit(UploadFailedState(e.toString()));
      }
    });
  }
}
