import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_management/layout/cubit/cubit.dart';
import 'package:store_management/layout/layout.dart';
import 'package:store_management/modules/login/login.dart';
import 'package:store_management/modules/registerScreen/signUp.dart';
import 'package:store_management/native%20kotlin.dart';
import 'package:store_management/shared/theme.dart';
import 'layout/cubit/state.dart';
import 'shared/bloc_observ.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();

  final Widget widget;
  if (FirebaseAuth.instance.currentUser?.uid == null)
    {
      widget = LoginScreen();
    }
  else
    {
      widget = const LayoutScreen();
    }
  runApp( MyApp(
    startWidget: widget
  ));
}

class MyApp extends StatelessWidget  {
  final Widget startWidget;

  const MyApp({super.key, required this.startWidget});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (BuildContext context) => StoreCubit()..getProduction()..getTables(),
      child: BlocConsumer<StoreCubit,StoreStates>(builder: (context,state)=>MaterialApp(
        title: 'Store Management',
        debugShowCheckedModeBanner: false,
        theme: themeLight,
        darkTheme: themeDark,
        themeMode: ThemeMode.light,
        home:  LoginScreen(),
      ),
          listener: (context,state){}),
    );
  }
}
