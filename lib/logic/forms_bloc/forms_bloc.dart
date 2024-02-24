import 'dart:async';

import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class AllFieldsFormBloc extends FormBloc<String, String> {
  final typesDropdown = SelectFieldBloc(
    items: [
      'Sedan',
      'Pick Up',
      'SUV',
      'Sport',
      'Coupe',
      'Convertible',
      'HatchBack',
    ],
  );

  final fuelDropdown = SelectFieldBloc<String, String>(
    items: [
      'gaz',
      'disel',
      'electric',
    ],
  );
  final transmissionDropdown = SelectFieldBloc<String, String>(
    items: [
      'Automatic',
      'Manual',
    ],
  );
  final drivetrainDropdown = SelectFieldBloc<String, String>(
    items: [
      'AWD',
      '4WD',
      'front-wheel',
      'rear-wheel',
    ],
  );

  final carName = TextFieldBloc();
  final carModel = TextFieldBloc();
  final carColor = TextFieldBloc();
  final carInteriorColor = TextFieldBloc();
  final carEngine = TextFieldBloc();
  final carKiloMetrage = TextFieldBloc();
  final carRent = TextFieldBloc();

  final carFeatures = TextFieldBloc();

  AllFieldsFormBloc() {
    addFieldBlocs(
      fieldBlocs: [
        typesDropdown,
        fuelDropdown,
        transmissionDropdown,
        drivetrainDropdown,
        carName,
        carModel,
        carColor,
        carInteriorColor,
        carEngine,
        carKiloMetrage,
        carRent,
        carFeatures,
      ],
    );
  }

  @override
  FutureOr<void> onSubmitting() async {
    try {
      emitSuccess(canSubmitAgain: true);
    } catch (e) {
      emitFailure();
    }
  }
}
