part of 'dropdown_bloc.dart';

class DropdownState extends Equatable {
  final Map<String, String> dropdownValues;

  const DropdownState(this.dropdownValues);

  @override
  List<Object> get props => [dropdownValues];
}
