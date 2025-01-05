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

class SignOut extends UserEvent {}

class AddUserPhoneNumber extends UserEvent {
  final String phoneNumber;
  final int userid;

  const AddUserPhoneNumber({required this.phoneNumber, required this.userid});
}

class AddUserImage extends UserEvent {
  final File image;
  final int userid;

  const AddUserImage({required this.image, required this.userid});
}

class SignUp extends UserEvent {
  final String email;
  final String password;
  final String username;
  final String phoneNumber;
  final int age;

  const SignUp({
    required this.email,
    required this.password,
    required this.username,
    required this.phoneNumber,
    required this.age,
  });
}

class GetUserInfo extends UserEvent {}

class GetUserReservation extends UserEvent {
  final int userid;

  const GetUserReservation({required this.userid});
}

class ResetPassword extends UserEvent {
  final String email;

  const ResetPassword({required this.email});
}
