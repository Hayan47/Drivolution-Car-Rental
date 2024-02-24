part of 'logo_bloc.dart';

class LogoState extends Equatable {
  final List<String> carLogos;
  final int selectedIndex;

  const LogoState({
    required this.selectedIndex,
    required this.carLogos,
  });

  @override
  List<Object> get props => [selectedIndex];

  LogoState copyWith({
    int? selectedIndex,
    List<String>? carLogos,
  }) {
    return LogoState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      carLogos: carLogos ?? this.carLogos,
    );
  }
}
