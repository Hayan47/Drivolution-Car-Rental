part of 'features_bloc.dart';

sealed class FeaturesState extends Equatable {
  const FeaturesState();

  @override
  List<Object> get props => [];

  List<String> get features;
  String get inputText;
}

class InitialFeaturesState extends FeaturesState {
  @override
  List<String> get features => [];

  @override
  String get inputText => "";

  @override
  List<Object> get props => [features, inputText];
}

class UpdatedFeaturesState extends FeaturesState {
  final List<String> features;
  final String inputText;

  const UpdatedFeaturesState(this.features, this.inputText);

  @override
  List<Object> get props => [features, inputText];
}
