import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'features_event.dart';
part 'features_state.dart';

class FeaturesBloc extends Bloc<FeaturesEvent, FeaturesState> {
  FeaturesBloc() : super(InitialFeaturesState()) {
    on<AddFeature>((event, emit) {
      List<String> features = List.from(state.features);
      features.add(event.text);
      emit(UpdatedFeaturesState(features, state.inputText));
    });

    on<DeleteFeature>((event, emit) {
      List<String> features = List.from(state.features);
      features.removeAt(event.index);
      emit(UpdatedFeaturesState(features, state.inputText));
    });

    // on<UpdateInput>((event, emit) {
    //   emit(UpdatedFeaturesState(state.features, event.text));
    // });
  }
}
