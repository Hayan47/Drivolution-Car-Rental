part of 'dropdown_bloc.dart';

sealed class DropdownEvent extends Equatable {
  const DropdownEvent();

  @override
  List<Object> get props => [];
}

class UpdateDropdownValueEvent extends DropdownEvent {
  final String dropdownId;
  final String newValue;

  const UpdateDropdownValueEvent(this.dropdownId, this.newValue);
}
