part of 'features_bloc.dart';

sealed class FeaturesEvent extends Equatable {
  const FeaturesEvent();

  @override
  List<Object> get props => [];
}

class AddFeature extends FeaturesEvent {
  final String text;

  const AddFeature(this.text);

  @override
  List<Object> get props => [text];
}

class DeleteFeature extends FeaturesEvent {
  final int index;

  const DeleteFeature(this.index);

  @override
  List<Object> get props => [index];
}

// class UpdateInput extends FeaturesEvent {
//   final String text;

//   const UpdateInput(this.text);

//   @override
//   List<Object> get props => [text];
// }
