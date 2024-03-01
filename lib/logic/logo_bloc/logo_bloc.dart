import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart';

part 'logo_event.dart';
part 'logo_state.dart';

class LogoBloc extends Bloc<LogoEvent, LogoState> {
  LogoBloc() : super(const LogoState(selectedIndex: -1, carLogos: [])) {
    on<LogoEvent>((event, emit) async {
      if (event is SelectLogoEvent) {
        emit(LogoState(
            selectedIndex: event.selectedIndex, carLogos: state.carLogos));
      } else if (event is FetchCarLogosEvent) {
        final carLogos = await fetchCarLogos();
        emit(state.copyWith(carLogos: carLogos));
      }
    });
  }

  Future<List<String>> fetchCarLogos() async {
    List<String> photoUrls = [];
    try {
      Reference directoryRef =
          FirebaseStorage.instance.ref().child('myfiles').child('logos');

      ListResult result = await directoryRef.listAll();

      for (Reference ref in result.items) {
        String imageUrl = await ref.getDownloadURL();
        photoUrls.add(imageUrl);
      }
      return photoUrls;
    } catch (e) {
      return [];
    }
  }

  String getSelectedLogo() {
    if (state.selectedIndex != -1 &&
        state.selectedIndex < state.carLogos.length) {
      return state.carLogos[state.selectedIndex];
    } else {
      return '';
    }
  }
}
