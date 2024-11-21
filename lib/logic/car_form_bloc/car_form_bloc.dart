import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drivolution/data/models/car_model.dart';
import 'package:drivolution/data/repositories/car_repository.dart';
import 'package:drivolution/data/repositories/image_repository.dart';
import 'package:drivolution/data/services/logger_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'car_form_event.dart';
part 'car_form_state.dart';

//todo text fields value vanishing
class CarFormBloc extends Bloc<CarFormEvent, CarFormState> {
  final logger = LoggerService().getLogger('CarForm Bloc Logger');
  final CarRepository carRepository;
  final ImageRepository imageRepository;
  CarFormBloc({required this.carRepository, required this.imageRepository})
      : super(CarFormState()) {
    on<LogoChanged>(_onLogoChanged);
    on<MainImageChanged>(_onMainImageChanged);
    // on<ImageAdded>(_onImageAdded);
    on<CarAlbumChanged>(_onAlbumChanged);
    // on<AdditionalImageRemoved>(_onAdditionalImageRemoved);
    // on<ImageRemoved>(_onImageRemoved);
    on<NameChanged>(_onNameChanged);
    on<ModelChanged>(_onModelChanged);
    on<EngineChanged>(_onEngineChanged);
    on<ColorChanged>(_onColorChanged);
    on<InteriorColorChanged>(_onInteriorColorChanged);
    on<KilometrageChanged>(_onKilometrageChanged);
    on<RentChanged>(_onRentChanged);
    on<TypeChanged>(_onTypeChanged);
    on<FuelChanged>(_onFuelChanged);
    on<TransmissionChanged>(_onTransmissionChanged);
    on<DrivetrainChanged>(_onDrivetrainChanged);
    on<DoorsChanged>(_onDoorsChanged);
    on<SeatsChanged>(_onSeatsChanged);
    on<FeatureAdded>(_onFeatureAdded);
    on<FeatureRemoved>(_onFeatureRemoved);
    on<DescriptionChanged>(_onDescriptionChanged);
    on<LocationChanged>(_onLocationChanged);
    on<FormSubmitted>(_onFormSubmitted);
    on<ResetFormEvent>(_onResetForm);
  }

  void _onModelChanged(ModelChanged event, Emitter<CarFormState> emit) {
    emit(state.copyWith(
      model: event.model,
      errors: Map<String, String>.from(state.errors)..remove('model'),
    ));
  }

  void _onRentChanged(RentChanged event, Emitter<CarFormState> emit) {
    emit(state.copyWith(
      rent: event.rent,
      errors: Map<String, String>.from(state.errors)..remove('rent'),
    ));
  }

  void _onColorChanged(ColorChanged event, Emitter<CarFormState> emit) {
    emit(state.copyWith(
      color: event.color,
      errors: Map<String, String>.from(state.errors)..remove('color'),
    ));
  }

  void _onInteriorColorChanged(
      InteriorColorChanged event, Emitter<CarFormState> emit) {
    emit(state.copyWith(
      interiorColor: event.interiorColor,
      errors: Map<String, String>.from(state.errors)..remove('interiorColor'),
    ));
  }

  void _onEngineChanged(EngineChanged event, Emitter<CarFormState> emit) {
    emit(state.copyWith(
      engine: event.engine,
      errors: Map<String, String>.from(state.errors)..remove('engine'),
    ));
  }

  void _onKilometrageChanged(
      KilometrageChanged event, Emitter<CarFormState> emit) {
    emit(state.copyWith(
      kiloMetrage: event.kilometrage,
      errors: Map<String, String>.from(state.errors)..remove('kilometrage'),
    ));
  }

  void _onDescriptionChanged(
      DescriptionChanged event, Emitter<CarFormState> emit) {
    emit(state.copyWith(
      discription: event.description,
      errors: Map<String, String>.from(state.errors)..remove('discription'),
    ));
  }

  void _onTypeChanged(TypeChanged event, Emitter<CarFormState> emit) {
    emit(state.copyWith(
      type: event.type,
      errors: Map<String, String>.from(state.errors)..remove('type'),
    ));
  }

  void _onFuelChanged(FuelChanged event, Emitter<CarFormState> emit) {
    emit(state.copyWith(
      fuel: event.fuel,
      errors: Map<String, String>.from(state.errors)..remove('fuel'),
    ));
  }

  void _onTransmissionChanged(
      TransmissionChanged event, Emitter<CarFormState> emit) {
    emit(state.copyWith(
      transmission: event.transmission,
      errors: Map<String, String>.from(state.errors)..remove('transmission'),
    ));
  }

  void _onDrivetrainChanged(
      DrivetrainChanged event, Emitter<CarFormState> emit) {
    emit(state.copyWith(
      drivetrain: event.drivetrain,
      errors: Map<String, String>.from(state.errors)..remove('drivetrain'),
    ));
  }

  void _onDoorsChanged(DoorsChanged event, Emitter<CarFormState> emit) {
    emit(state.copyWith(
      doors: event.doors,
      errors: Map<String, String>.from(state.errors)..remove('doors'),
    ));
  }

  void _onSeatsChanged(SeatsChanged event, Emitter<CarFormState> emit) {
    emit(state.copyWith(
      seats: event.seats,
      errors: Map<String, String>.from(state.errors)..remove('seats'),
    ));
  }

  void _onLogoChanged(LogoChanged event, Emitter<CarFormState> emit) {
    emit(state.copyWith(
      logo: event.logoPath,
      errors: Map<String, String>.from(state.errors)..remove('logo'),
    ));
  }

  void _onMainImageChanged(MainImageChanged event, Emitter<CarFormState> emit) {
    emit(state.copyWith(
      image: event.image,
      errors: Map<String, String>.from(state.errors)..remove('image'),
    ));
  }

  void _onFeatureAdded(FeatureAdded event, Emitter<CarFormState> emit) {
    final features = List<String>.from(state.features)..add(event.feature);
    emit(state.copyWith(features: features));
  }

  void _onFeatureRemoved(FeatureRemoved event, Emitter<CarFormState> emit) {
    final features = List<String>.from(state.features)..remove(event.feature);
    emit(state.copyWith(features: features));
  }

  Future<void> _onResetForm(
      ResetFormEvent event, Emitter<CarFormState> emit) async {
    emit(CarFormState());
  }

  Future<void> _onFormSubmitted(
      FormSubmitted event, Emitter<CarFormState> emit) async {
    if (!_validateForm()) return;

    emit(state.copyWith(status: FormStatus.loading));

    //! Upload Images
    List<Uint8List> images = state.images;
    images.insert(0, state.image!);
    List<String> paths = await imageRepository.uploadImages(
        images: images,
        path: 'cars/${event.ownerid}/${state.name}/${state.name}');
    try {
      carRepository.addCar(Car(
        logo: state.logo,
        img: paths.first,
        name: state.name,
        model: state.model,
        rent: state.rent,
        images: paths.sublist(1),
        geoPoint: GeoPoint(state.lat, state.lang),
        locationName: state.city,
        type: state.type!,
        seats: state.seats,
        doors: state.doors,
        fuel: state.fuel!,
        features: state.features,
        color: state.color,
        interiorColor: state.interiorColor,
        engine: state.engine,
        drivetrain: state.drivetrain!,
        kilometrage: state.kiloMetrage,
        transmission: state.transmission!,
        ownerid: event.ownerid,
        description: state.discription,
      ));
      await Future.delayed(Duration(seconds: 2)); // Simulate API call
      emit(state.copyWith(status: FormStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
          status: FormStatus.failure,
          errors: {'submit': 'Failed to submit form: $e'},
        ),
      );
    }
  }

  void _onNameChanged(NameChanged event, Emitter<CarFormState> emit) {
    emit(state.copyWith(
      name: event.name,
      errors: Map<String, String>.from(state.errors)..remove('name'),
    ));
  }

  void _onLocationChanged(LocationChanged event, Emitter<CarFormState> emit) {
    emit(state.copyWith(
      lat: event.lat,
      lang: event.lang,
      city: event.locationName,
      errors: Map<String, String>.from(state.errors)..remove('location'),
    ));
  }

  void _onAlbumChanged(CarAlbumChanged event, Emitter<CarFormState> emit) {
    final images = List<Uint8List>.from(state.images)..addAll(event.images);

    emit(state.copyWith(
      images: images,
      errors: Map<String, String>.from(state.errors)..remove('images'),
    ));
  }

  bool _validateForm() {
    Map<String, String> errors = {};

    if (state.logo.isEmpty) errors['logo'] = 'Car Logo is required';

    if (state.image == null) errors['image'] = 'Car Image is required';

    if (state.name.isEmpty) errors['name'] = 'Car Name is required';

    if (state.model.isEmpty) errors['model'] = 'Car Model is required';

    if (state.color.isEmpty) errors['color'] = 'Car Color is required';

    if (state.interiorColor.isEmpty) {
      errors['interiorColor'] = 'Car Interior Color is required';
    }

    if (state.engine.isEmpty) errors['engine'] = 'Car Engine is required';

    if (state.kiloMetrage <= 0) {
      errors['kilometrage'] = 'Car Kilometrage is required';
    }

    if (state.rent <= 0) errors['price'] = 'Car Rent must be greater than 0';

    if (state.type == null) errors['type'] = 'Car Type is required';
    if (state.fuel == null) errors['fuel'] = 'Car Fuel is required';
    if (state.transmission == null) {
      errors['transmission'] = 'Car Transmission is required';
    }
    if (state.drivetrain == null) {
      errors['drivetrain'] = 'Car Drivetrain is required';
    }
    if (state.lang == 0.0 || state.lang == 0.0) {
      errors['location'] = 'Car Location is required';
    }

    if (state.images.isEmpty) {
      errors['images'] = 'At least one image is required';
    }
    print(state);
    emit(state.copyWith(
      errors: errors,
      dateTime: DateTime.now(),
    ));
    return errors.isEmpty;
  }
}
