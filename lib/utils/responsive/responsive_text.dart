import 'package:drivolution/utils/responsive/screen_size.dart';
import 'package:flutter/material.dart';

class ResponsiveText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Map<ScreenSize, double>? sizeMappings;

  const ResponsiveText({
    super.key,
    required this.text,
    required this.style,
    this.sizeMappings,
  });

  @override
  Widget build(BuildContext context) {
    final baseSize = style.fontSize ?? 14.0;
    final screenSize = ScreenSize.fromWidth(MediaQuery.of(context).size.width);

    double getFontSize() {
      if (sizeMappings != null && sizeMappings!.containsKey(screenSize)) {
        return sizeMappings![screenSize]!;
      }

      switch (screenSize) {
        case ScreenSize.small:
          return baseSize;
        case ScreenSize.medium:
          return baseSize * 1.2;
        case ScreenSize.large:
          return baseSize * 1.4;
        case ScreenSize.extraLarge:
          return baseSize * 1.6;
      }
    }

    return Text(
      text,
      style: style.copyWith(fontSize: getFontSize()),
    );
  }
}
