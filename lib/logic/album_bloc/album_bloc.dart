import 'dart:io';
import 'dart:typed_data';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'album_event.dart';
part 'album_state.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  AlbumBloc() : super(AlbumInitial()) {
    List<XFile> pickedFiles = [];
    on<AlbumEvent>((event, emit) async {
      if (event is AddAlbumEvent) {
        List<XFile> pickedFiles2 = await ImagePicker().pickMultiImage();
        //to handle if the user enterd and exited second time without picking keep the old one
        if (pickedFiles2.isNotEmpty) {
          pickedFiles = pickedFiles2;
        }
        try {
          if (pickedFiles.isNotEmpty) {
            emit(AlbumLoading());
            final List<File> carImages = [];
            for (var pickedFile in pickedFiles) {
              final image = File(pickedFile.path);
              carImages.add(image);
            }
            emit(AlbumChanged(carImages));
          } else {
            emit(const AlbumError('No Image Selected'));
          }
        } catch (e) {
          emit(const AlbumError('images not picked correctly'));
        }
      } else if (event is ResetAlbumEvent) {
        emit(AlbumInitial());
      } else if (event is NoAlbumSelectedEvent) {
        emit(const AlbumError('No Image Selected'));
      }
    });
  }
}
