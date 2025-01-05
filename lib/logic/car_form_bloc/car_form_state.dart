part of 'car_form_bloc.dart';

enum FormStatus { initial, loading, success, failure }

class CarFormState extends Equatable {
  final String name;
  final String model;
  final double dailyRate;
  final String color;
  final String interiorColor;
  final String engine;
  final int kiloMetrage;
  final CarType? type;
  final FuelType? fuel;
  final Transmission? transmission;
  final DrivetrainType? drivetrain;
  final int doors;
  final int seats;
  final String discription;
  final double lat;
  final double lang;
  final String city;
  final String logo;
  final File? image;
  final List<String> features;
  final List<File> images;
  final Map<String, String> errors;
  final FormStatus status;
  final DateTime? dateTime;

  const CarFormState({
    this.name = '',
    this.model = '',
    this.dailyRate = 0.0,
    this.color = '',
    this.interiorColor = '',
    this.engine = '',
    this.kiloMetrage = 0,
    this.type,
    this.fuel,
    this.transmission,
    this.drivetrain,
    this.doors = 4,
    this.seats = 4,
    this.discription = '',
    this.lat = 0.0,
    this.lang = 0.0,
    this.city = '',
    this.logo = '',
    this.image,
    this.features = const [],
    this.images = const [],
    this.errors = const {},
    this.status = FormStatus.initial,
    this.dateTime,
  });

  CarFormState copyWith({
    String? name,
    String? model,
    double? dailyRate,
    String? color,
    String? interiorColor,
    String? engine,
    int? kiloMetrage,
    CarType? type,
    FuelType? fuel,
    Transmission? transmission,
    DrivetrainType? drivetrain,
    int? doors,
    int? seats,
    String? discription,
    double? lat,
    double? lang,
    String? city,
    String? logo,
    File? image,
    List<String>? features,
    List<File>? images,
    Map<String, String>? errors,
    FormStatus? status,
    DateTime? dateTime,
  }) {
    return CarFormState(
      name: name ?? this.name,
      model: model ?? this.model,
      dailyRate: dailyRate ?? this.dailyRate,
      color: color ?? this.color,
      interiorColor: interiorColor ?? this.interiorColor,
      engine: engine ?? this.engine,
      kiloMetrage: kiloMetrage ?? this.kiloMetrage,
      type: type ?? this.type,
      fuel: fuel ?? this.fuel,
      transmission: transmission ?? this.transmission,
      drivetrain: drivetrain ?? this.drivetrain,
      doors: doors ?? this.doors,
      seats: seats ?? this.seats,
      discription: discription ?? this.discription,
      lat: lat ?? this.lat,
      lang: lang ?? this.lang,
      city: city ?? this.city,
      logo: logo ?? this.logo,
      image: image ?? this.image,
      features: features ?? this.features,
      images: images ?? this.images,
      errors: errors ?? this.errors,
      status: status ?? this.status,
      dateTime: dateTime,
    );
  }

  @override
  List<Object?> get props => [
        name,
        model,
        dailyRate,
        color,
        interiorColor,
        engine,
        kiloMetrage,
        type,
        fuel,
        transmission,
        drivetrain,
        doors,
        seats,
        discription,
        lat,
        lang,
        city,
        logo,
        image,
        features,
        images,
        errors,
        status,
        dateTime,
      ];
}
