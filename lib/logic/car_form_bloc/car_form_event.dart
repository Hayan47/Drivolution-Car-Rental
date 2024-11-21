part of 'car_form_bloc.dart';

sealed class CarFormEvent extends Equatable {
  const CarFormEvent();

  @override
  List<Object> get props => [];
}

class NameChanged extends CarFormEvent {
  final String name;
  const NameChanged({required this.name});
}

class ModelChanged extends CarFormEvent {
  final String model;
  const ModelChanged({required this.model});
}

class RentChanged extends CarFormEvent {
  final int rent;
  const RentChanged({required this.rent});
}

class ColorChanged extends CarFormEvent {
  final String color;
  const ColorChanged({required this.color});
}

class InteriorColorChanged extends CarFormEvent {
  final String interiorColor;
  const InteriorColorChanged({required this.interiorColor});
}

class EngineChanged extends CarFormEvent {
  final String engine;
  const EngineChanged({required this.engine});
}

class KilometrageChanged extends CarFormEvent {
  final int kilometrage;
  const KilometrageChanged({required this.kilometrage});
}

class DescriptionChanged extends CarFormEvent {
  final String description;
  const DescriptionChanged({required this.description});
}

class TypeChanged extends CarFormEvent {
  final String type;
  const TypeChanged({required this.type});
}

class FuelChanged extends CarFormEvent {
  final String fuel;
  const FuelChanged({required this.fuel});
}

class TransmissionChanged extends CarFormEvent {
  final String transmission;
  const TransmissionChanged({required this.transmission});
}

class DrivetrainChanged extends CarFormEvent {
  final String drivetrain;
  const DrivetrainChanged({required this.drivetrain});
}

class DoorsChanged extends CarFormEvent {
  final int doors;
  const DoorsChanged({required this.doors});
}

class SeatsChanged extends CarFormEvent {
  final int seats;
  const SeatsChanged({required this.seats});
}

class LocationChanged extends CarFormEvent {
  final double lat;
  final double lang;
  final String locationName;
  const LocationChanged(
      {required this.lang, required this.lat, required this.locationName});
}

class LogoChanged extends CarFormEvent {
  final String logoPath;
  const LogoChanged({required this.logoPath});
}

class MainImageChanged extends CarFormEvent {
  final Uint8List image;
  const MainImageChanged({required this.image});
}

class CarAlbumChanged extends CarFormEvent {
  final List<Uint8List> images;
  const CarAlbumChanged({required this.images});
}

class FeatureAdded extends CarFormEvent {
  final String feature;
  const FeatureAdded({required this.feature});
}

class FeatureRemoved extends CarFormEvent {
  final String feature;
  const FeatureRemoved({required this.feature});
}

class FormSubmitted extends CarFormEvent {
  final String ownerid;

  const FormSubmitted({required this.ownerid});
}

class ResetFormEvent extends CarFormEvent {}
