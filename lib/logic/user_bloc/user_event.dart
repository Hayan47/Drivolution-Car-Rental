part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class SignIn extends UserEvent {
  final String email;
  final String password;

  const SignIn({required this.email, required this.password});
}

class SignInWithGoogle extends UserEvent {}

class SignOut extends UserEvent {}

class AddUserPhoneNumber extends UserEvent {
  final String phoneNumber;
  final String userID;

  const AddUserPhoneNumber({required this.phoneNumber, required this.userID});
}

class AddUserImage extends UserEvent {
  final String imageUrl;
  final String userID;

  const AddUserImage({required this.imageUrl, required this.userID});
}

class SignUp extends UserEvent {
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final int age;

  const SignUp({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.age,
  });
}

class GetUserInfo extends UserEvent {
  final String userID;

  const GetUserInfo({required this.userID});
}

// class GetUserCars extends UserEvent {
//   final String userID;

//   const GetUserCars({required this.userID});
// }

class GetUserReservation extends UserEvent {
  final String userID;

  const GetUserReservation({required this.userID});
}

class ResetPassword extends UserEvent {
  final String email;

  const ResetPassword({required this.email});
}
