enum DrivetrainType {
  fwd,
  rwd,
  awd,
  fourwd;

  String toApiString() {
    return name == 'fourwd' ? '4WD' : name.toUpperCase();
  }

  static DrivetrainType fromApiString(String value) {
    if (value == '4WD') return DrivetrainType.fourwd;
    return DrivetrainType.values.firstWhere(
      (e) => e.name.toUpperCase() == value,
      orElse: () => DrivetrainType.fwd,
    );
  }
}
