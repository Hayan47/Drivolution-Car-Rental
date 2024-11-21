import 'package:drivolution/data/models/car_model.dart';
import 'package:drivolution/data/services/user_services.dart';

class UserRepository {
  final UserServices userServices;

  UserRepository({required this.userServices});

  Future<List<Car>> getFavoriteCars(List<String> favoriteCarsIds) async {
    return await userServices.getFavoriteCars(favoriteCarsIds);
  }

  Future<void> addToFavorite(String carid, String userid) async {
    userServices.addToFavorite(carid, userid);
  }

  Future<void> removeFromFavorite(String carid, String userid) async {
    userServices.removeFromFavorite(carid, userid);
  }
}