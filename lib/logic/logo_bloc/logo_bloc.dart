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
    // List<String> photoUrls = [];
    // try {
    //   // Get a reference to the directory
    //   Reference directoryRef =
    //       FirebaseStorage.instance.ref().child('myfiles').child('logos');

    //   // List all items (files and directories) in the directory
    //   ListResult result = await directoryRef.listAll();

    //   // Filter out only image files (you can adjust this based on your file naming conventions)
    //   for (Reference ref in result.items) {
    //     String imageUrl = await ref.getDownloadURL();
    //     if (imageUrl.endsWith('.jpg') ||
    //         imageUrl.endsWith('.jpeg') ||
    //         imageUrl.endsWith('.png')) {
    //       photoUrls.add(imageUrl);
    //     }
    //   }
    //   return photoUrls;
    // } catch (e) {
    //   print('Error fetching photos: $e');
    //   return [];
    // }
    return [
      'https://firebasestorage.googleapis.com/v0/b/drivolution.appspot.com/o/myfiles%2Flogos%2Faudi.png?alt=media&token=f485f827-ed0c-4ca2-b391-813ce8fec775',
      'https://firebasestorage.googleapis.com/v0/b/drivolution.appspot.com/o/myfiles%2Flogos%2Fbmw.png?alt=media&token=51a37597-d31b-4a2e-8d12-8ac4a773d2e2',
      'https://firebasestorage.googleapis.com/v0/b/drivolution.appspot.com/o/myfiles%2Flogos%2Fmercedes.png?alt=media&token=fa05ebe0-5ea9-4995-8ada-6ae5a3b350b9',
      'https://firebasestorage.googleapis.com/v0/b/drivolution.appspot.com/o/myfiles%2Flogos%2Flamborghini.png?alt=media&token=99ed609d-17f0-42d0-8889-80a675e7ed40',
      'https://firebasestorage.googleapis.com/v0/b/drivolution.appspot.com/o/myfiles%2Flogos%2Fchevrolet.png?alt=media&token=911ee48a-bd71-4678-b6d9-b0872ddd7aa1',
      'https://firebasestorage.googleapis.com/v0/b/drivolution.appspot.com/o/myfiles%2Flogos%2Frangerover.png?alt=media&token=bdf03fdb-e755-40f9-872f-3675e60dca2f',
      'https://firebasestorage.googleapis.com/v0/b/drivolution.appspot.com/o/myfiles%2Flogos%2Fbyd.png?alt=media&token=409d93f4-e150-4bc6-a2af-814a70c7a94d',
      'https://firebasestorage.googleapis.com/v0/b/drivolution.appspot.com/o/myfiles%2Flogos%2Fkia.png?alt=media&token=f970836f-b75a-427f-93ab-ba97813b4bba',
      'https://firebasestorage.googleapis.com/v0/b/drivolution.appspot.com/o/myfiles%2Flogos%2Fastonmartin.png?alt=media&token=5eb094ef-14d9-44e3-9598-f506e04b2913',
      'https://firebasestorage.googleapis.com/v0/b/drivolution.appspot.com/o/myfiles%2Flogos%2Fbently.png?alt=media&token=1ee13dfd-c3f0-4614-9529-61024f3e3467',
      'https://firebasestorage.googleapis.com/v0/b/drivolution.appspot.com/o/myfiles%2Flogos%2Fcadilac.png?alt=media&token=1321a3d8-db40-4a5a-9259-34f1fa5b2766',
      'https://firebasestorage.googleapis.com/v0/b/drivolution.appspot.com/o/myfiles%2Flogos%2Fferrari.png?alt=media&token=30a69a7a-3ce4-40c0-93cf-ea81a35edfcb',
      'https://firebasestorage.googleapis.com/v0/b/drivolution.appspot.com/o/myfiles%2Flogos%2Ffiat.png?alt=media&token=8cad43ae-f4b6-4cdb-bedc-3a3b147ce7f7',
      'https://firebasestorage.googleapis.com/v0/b/drivolution.appspot.com/o/myfiles%2Flogos%2Fhonda.png?alt=media&token=b4c909e0-fd9b-49fe-8ea2-28d9c53f7887',
      'https://firebasestorage.googleapis.com/v0/b/drivolution.appspot.com/o/myfiles%2Flogos%2Fhyundai.png?alt=media&token=7db4f484-6d9d-4399-be57-b3cdd19592d2',
      'https://firebasestorage.googleapis.com/v0/b/drivolution.appspot.com/o/myfiles%2Flogos%2Fjaguar.png?alt=media&token=b0c49937-5bf0-4d42-9431-4ed21e5895ab',
      'https://firebasestorage.googleapis.com/v0/b/drivolution.appspot.com/o/myfiles%2Flogos%2Flexus.png?alt=media&token=4a8a901c-b09f-4249-9590-fdd48de5d1a5',
      'https://firebasestorage.googleapis.com/v0/b/drivolution.appspot.com/o/myfiles%2Flogos%2Fmazda.png?alt=media&token=a2687a07-64ad-450b-b85c-703fb0a42ca3',
      'https://firebasestorage.googleapis.com/v0/b/drivolution.appspot.com/o/myfiles%2Flogos%2Fmitsubishi.png?alt=media&token=8f0d18a8-7f47-472a-9dee-a9fe57c296fd',
      'https://firebasestorage.googleapis.com/v0/b/drivolution.appspot.com/o/myfiles%2Flogos%2Fnissan.png?alt=media&token=7b7be975-a06d-4bff-b742-78332dda5eeb',
      'https://firebasestorage.googleapis.com/v0/b/drivolution.appspot.com/o/myfiles%2Flogos%2Fopel.png?alt=media&token=0d0cf1b1-ab10-41d0-b581-b13f6cf3062a',
      'https://firebasestorage.googleapis.com/v0/b/drivolution.appspot.com/o/myfiles%2Flogos%2Fpeugeot.png?alt=media&token=8ffca1ed-1e25-4225-b1fd-1ce3bdd41697',
      'https://firebasestorage.googleapis.com/v0/b/drivolution.appspot.com/o/myfiles%2Flogos%2Fporsche.png?alt=media&token=bdbefdd9-0cbe-4d15-8850-4f0161549b4b',
      'https://firebasestorage.googleapis.com/v0/b/drivolution.appspot.com/o/myfiles%2Flogos%2Frenault.png?alt=media&token=9607467e-5c42-48e4-8bc1-5cb6b3490a7d',
      'https://firebasestorage.googleapis.com/v0/b/drivolution.appspot.com/o/myfiles%2Flogos%2Fskooda.png?alt=media&token=6af3e067-35e0-465a-944d-749d7ec02120',
      'https://firebasestorage.googleapis.com/v0/b/drivolution.appspot.com/o/myfiles%2Flogos%2Fsubaru.png?alt=media&token=89d4ef0c-b064-47e9-a18e-c8959ac919e9',
      'https://firebasestorage.googleapis.com/v0/b/drivolution.appspot.com/o/myfiles%2Flogos%2Ftoyota.png?alt=media&token=c89705c1-de38-4058-a192-e6366c9e0854',
    ]; // Return fetched car logos
  }
}
