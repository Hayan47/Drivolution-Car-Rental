enum CarType {
  sedan,
  pickup,
  suv,
  sport,
  coupe,
  convertible,
  hatchback;

  String toApiString() => name.toUpperCase();

  static CarType fromApiString(String value) {
    return CarType.values.firstWhere(
      (e) => e.name.toUpperCase() == value,
      orElse: () => CarType.sedan,
    );
  }
}
