enum ScreenSize {
  small,
  medium,
  large,
  extraLarge;

  static ScreenSize fromWidth(double width) {
    if (width < 600) return ScreenSize.small;
    if (width < 1024) return ScreenSize.medium;
    if (width < 1440) return ScreenSize.large;
    return ScreenSize.extraLarge;
  }
}
