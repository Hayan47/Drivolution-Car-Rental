part of 'logo_bloc.dart';

sealed class LogoEvent extends Equatable {
  const LogoEvent();

  @override
  List<Object> get props => [];
}

class SelectLogoEvent extends LogoEvent {
  final int selectedIndex;

  const SelectLogoEvent(this.selectedIndex);
}

class FetchCarLogosEvent extends LogoEvent {}

class ResetLogoEvent extends LogoEvent {}
