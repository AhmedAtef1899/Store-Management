abstract class LoginStates{}

class LoginInitialStates extends LoginStates{}

class LoginAuthLoadingState extends LoginStates{}

class LoginAuthSuccessState extends LoginStates{
  final String uid;

  LoginAuthSuccessState(this.uid);
}

class LoginAuthErrorState extends LoginStates{}