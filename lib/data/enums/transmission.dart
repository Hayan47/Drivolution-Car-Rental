enum Transmission {
  manual,
  automatic;

  String toApiString() => name.toUpperCase();

  static Transmission fromApiString(String value) {
    return Transmission.values.firstWhere(
      (e) => e.name.toUpperCase() == value,
      orElse: () => Transmission.automatic,
    );
  }
}
