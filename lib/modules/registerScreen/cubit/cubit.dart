
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_management/models/user_model.dart';
import 'package:store_management/modules/registerScreen/cubit/state.dart';

class StoreSignUpCubit extends Cubit<StoreSignUpStates>
{
  StoreSignUpCubit() : super(StoreSignUpInitialState());

  static StoreSignUpCubit get(context) => BlocProvider.of(context);

  void addUser({
    required String name,
    required String email,
    required String pass,
    required String phone,
})
  {
    emit(StoreSignUpLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: pass)
        .then((value)
    {
      getUser(name: name, email: email, pass: pass, confPass: phone, uId: value.user!.uid);
    }).catchError((onError){
      print(onError.toString());
    });
  }
  void getUser({
    required String name,
    required String email,
    required String pass,
    required String confPass,
    required String uId,
})
  {
    SignUpModel signUpModel = SignUpModel(
        name: name,
        email: email,
        pass: pass,
        phone: confPass,
        uId: uId
    );
    FirebaseFirestore.instance.collection('users')
        .doc(uId)
        .set(signUpModel.toMap()).then((value)
    {
      emit(StoreSignUpSuccessState());
    }).catchError((onError){
      print(onError.toString());
    });
  }
}