enum FuelType {
  petrol,
  diesel,
  electric,
  hybrid;

  String toApiString() => name.toUpperCase();

  static FuelType fromApiString(String value) {
    return FuelType.values.firstWhere(
      (e) => e.name.toUpperCase() == value,
      orElse: () => FuelType.petrol,
    );
  }
}
