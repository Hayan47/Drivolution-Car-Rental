import 'package:bloc/bloc.dart';
import 'package:drivolution/logic/album_bloc/album_bloc.dart';
import 'package:drivolution/logic/features_bloc/features_bloc.dart';
import 'package:drivolution/logic/forms_bloc/forms_bloc.dart';
import 'package:drivolution/logic/image_bloc/image_bloc.dart';
import 'package:drivolution/logic/location_bloc/location_bloc.dart';
import 'package:drivolution/logic/logo_bloc/logo_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'check_state.dart';

class CheckCubit extends Cubit<CheckState> {
  CheckCubit() : super(PageControllerInitial());

  checkThenGo({
    required LogoState logoState,
    required ImageState imageState,
    required AllFieldsFormBloc allFieldsFormBloc,
    required FeaturesState featuresState,
    required LocationState locationState,
    required AlbumState albumState,
  }) {
    if (logoState.selectedIndex == -1) {
      emit(NotValid(message: 'choose logo first', dateTime: DateTime.now()));
    } else if (imageState is! ImageChanged) {
      emit(NotValid(message: 'pick image first', dateTime: DateTime.now()));
    } else if (allFieldsFormBloc.carName.value.isEmpty) {
      emit(NotValid(message: 'add car name first', dateTime: DateTime.now()));
    } else if (allFieldsFormBloc.carModel.value.isEmpty) {
      emit(NotValid(message: 'add car model first', dateTime: DateTime.now()));
    } else if (allFieldsFormBloc.carColor.value.isEmpty) {
      emit(NotValid(message: 'add car color first', dateTime: DateTime.now()));
    } else if (allFieldsFormBloc.carInteriorColor.value.isEmpty) {
      emit(NotValid(
          message: 'add car interior color first', dateTime: DateTime.now()));
    } else if (allFieldsFormBloc.carEngine.value.isEmpty) {
      emit(NotValid(
          message: 'add car engine type first', dateTime: DateTime.now()));
    } else if (allFieldsFormBloc.carKiloMetrage.value.isEmpty) {
      emit(NotValid(
          message: 'add car kilometrage first', dateTime: DateTime.now()));
    } else if (allFieldsFormBloc.carRent.value.isEmpty) {
      emit(NotValid(message: 'add car rent first', dateTime: DateTime.now()));
    } else if (allFieldsFormBloc.typesDropdown.value == null) {
      emit(NotValid(message: 'add car type first', dateTime: DateTime.now()));
    } else if (allFieldsFormBloc.fuelDropdown.value == null) {
      emit(NotValid(
          message: 'add car fuel type first', dateTime: DateTime.now()));
    } else if (allFieldsFormBloc.transmissionDropdown.value == null) {
      emit(NotValid(
          message: 'add car transmission type first',
          dateTime: DateTime.now()));
    } else if (allFieldsFormBloc.drivetrainDropdown.value == null) {
      emit(NotValid(
          message: 'add car drivetrain first', dateTime: DateTime.now()));
    } else if (featuresState is! UpdatedFeaturesState) {
      emit(NotValid(
          message: 'add car features first', dateTime: DateTime.now()));
    } else if (locationState is! LocationPickedState) {
      emit(NotValid(
          message: 'add car location first', dateTime: DateTime.now()));
    } else if (albumState is! AlbumChanged) {
      emit(NotValid(message: 'add car album first', dateTime: DateTime.now()));
    } else {
      emit(Valid());
    }
  }
}
