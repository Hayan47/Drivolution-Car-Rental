part of 'logo_bloc.dart';

class LogoState extends Equatable {
  final int selectedIndex;

  const LogoState(this.selectedIndex);

  @override
  List<Object> get props => [selectedIndex];
}
