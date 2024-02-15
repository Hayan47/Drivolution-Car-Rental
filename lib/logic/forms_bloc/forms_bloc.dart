import 'dart:async';

import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class AllFieldsFormBloc extends FormBloc<String, String> {
  final typesDropdown = SelectFieldBloc<String, String>(
      // validators: [FieldBlocValidators.required],
      items: [
        'Sedan',
        'Pick Up',
        'SUV',
        'Sport',
        'Coupe',
        'Convertible',
        'HatchBack',
      ]);

  final fuelDropdown = SelectFieldBloc<String, String>(
    validators: [FieldBlocValidators.required],
  );
  final transmissionDropdown = SelectFieldBloc<String, String>(
    validators: [FieldBlocValidators.required],
  );
  final drivetrainDropdown = SelectFieldBloc<String, String>(
    validators: [FieldBlocValidators.required],
  );

  @override
  FutureOr<void> onLoading() {
    typesDropdown.updateItems([
      'Sedan',
      'Pick Up',
      'SUV',
      'Sport',
      'Coupe',
      'Convertible',
      'HatchBack',
    ]);

    fuelDropdown.updateItems([
      'gaz',
      'disel',
      'electric',
    ]);

    transmissionDropdown.updateItems([
      'Automatic',
      'Manual',
    ]);

    drivetrainDropdown.updateItems([
      'AWD',
      '4WD',
      'front-wheel',
      'rear-wheel',
    ]);
  }

  @override
  FutureOr<void> onSubmitting() async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 500));

      emitSuccess(canSubmitAgain: true);
    } catch (e) {
      emitFailure();
    }
  }
}
