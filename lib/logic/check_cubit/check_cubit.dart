import 'package:bloc/bloc.dart';
import 'package:drivolution/logic/album_bloc/album_bloc.dart';
import 'package:drivolution/logic/features_bloc/features_bloc.dart';
import 'package:drivolution/logic/forms_bloc/forms_bloc.dart';
import 'package:drivolution/logic/image_bloc/image_bloc.dart';
import 'package:drivolution/logic/location_bloc/location_bloc.dart';
import 'package:drivolution/logic/logo_bloc/logo_bloc.dart';
import 'package:equatable/equatable.dart';

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
      emit(const NotValid(message: 'choose logo first'));
    } else if (imageState is! ImageChanged) {
      emit(const NotValid(message: 'pick image first'));
    } else if (allFieldsFormBloc.carName.value.isEmpty) {
      emit(const NotValid(message: 'add car name first'));
    } else if (allFieldsFormBloc.carModel.value.isEmpty) {
      emit(const NotValid(message: 'add car model first'));
    } else if (allFieldsFormBloc.carColor.value.isEmpty) {
      emit(const NotValid(message: 'add car color first'));
    } else if (allFieldsFormBloc.carInteriorColor.value.isEmpty) {
      emit(const NotValid(message: 'add car interior color first'));
    } else if (allFieldsFormBloc.carEngine.value.isEmpty) {
      emit(const NotValid(message: 'add car engine type first'));
    } else if (allFieldsFormBloc.carKiloMetrage.value.isEmpty) {
      emit(const NotValid(message: 'add car kilometrage first'));
    } else if (allFieldsFormBloc.carRent.value.isEmpty) {
      emit(const NotValid(message: 'add car rent first'));
    } else if (allFieldsFormBloc.typesDropdown.value == null) {
      emit(const NotValid(message: 'add car type first'));
    } else if (allFieldsFormBloc.fuelDropdown.value == null) {
      emit(const NotValid(message: 'add car fuel type first'));
    } else if (allFieldsFormBloc.transmissionDropdown.value == null) {
      emit(const NotValid(message: 'add car transmission type first'));
    } else if (allFieldsFormBloc.drivetrainDropdown.value == null) {
      emit(const NotValid(message: 'add car drivetrain first'));
    } else if (featuresState is! UpdatedFeaturesState) {
      emit(const NotValid(message: 'add car features first'));
    } else if (locationState is! LocationPickedState) {
      emit(const NotValid(message: 'add car location first'));
    } else if (albumState is! AlbumChanged) {
      emit(const NotValid(message: 'add car album first'));
    } else {
      emit(Valid());
    }
  }
}
