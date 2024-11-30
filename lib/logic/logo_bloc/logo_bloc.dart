import 'package:drivolution/data/exceptions/firestore_exception.dart';
import 'package:drivolution/data/exceptions/network_exception.dart';
import 'package:drivolution/data/repositories/image_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'logo_event.dart';
part 'logo_state.dart';

class LogoBloc extends Bloc<LogoEvent, LogoState> {
  List<String> carLogos = [];
  final ImageRepository imageRepository;
  LogoBloc({required this.imageRepository})
      : super(const LogoState(selectedIndex: -1, carLogos: [])) {
    on<SelectLogoEvent>(
      (event, emit) async {
        emit(
          LogoState(
              selectedIndex: event.selectedIndex, carLogos: state.carLogos),
        );
      },
    );
    on<FetchCarLogosEvent>(
      (event, emit) async {
        try {
          carLogos = await imageRepository.getCarLogos();
          emit(state.copyWith(carLogos: carLogos));
        } on FirestoreException catch (e) {
          //todo
        } on NetworkException catch (e) {
          //todo
        } catch (e) {
          //todo
        }
      },
    );
    on<ResetLogoEvent>(
      (event, emit) => emit(
        LogoState(selectedIndex: -1, carLogos: carLogos),
      ),
    );
  }
}
