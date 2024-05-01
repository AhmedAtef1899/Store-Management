
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:store_management/layout/layout.dart';
import 'package:store_management/modules/login/cubit/state.dart';
import 'package:store_management/shared/componentes.dart';

class LoginCubit extends Cubit<LoginStates>
{
  LoginCubit() : super(LoginInitialStates());

  static LoginCubit get(context) => BlocProvider.of(context);

  void login({
   required String email,
    required String password
})
  {
    emit(LoginAuthLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email
        , password: password
    ).then((value){
      emit(LoginAuthSuccessState(value.user!.uid));
    }).catchError((onError){
      print(onError.toString());
      emit(LoginAuthErrorState());
    });
  }


}