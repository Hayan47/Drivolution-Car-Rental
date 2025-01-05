enum ReservationStatus {
  pending,
  confirmed,
  active,
  completed,
  canceled;

  String toApiString() => name.toUpperCase();

  static ReservationStatus fromApiString(String value) {
    return ReservationStatus.values.firstWhere(
      (e) => e.name.toUpperCase() == value,
      orElse: () => ReservationStatus.pending,
    );
  }
}
