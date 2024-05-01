import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_management/layout/cubit/cubit.dart';
import 'package:store_management/layout/cubit/state.dart';

class LayoutCustomerScreen extends StatelessWidget {
  const LayoutCustomerScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoreCubit,StoreStates>(builder: (context,state)=> Scaffold(
      appBar: AppBar(
        title: const Text(
            'Customer World'
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(items: StoreCubit.get(context).bottomCustomerBar,
        currentIndex: StoreCubit.get(context).currentCustomerIndex,
        onTap: (index){
          StoreCubit.get(context).navCustomerBar(index);
        },
      ),
      body: StoreCubit.get(context).customerScreens[StoreCubit.get(context).currentCustomerIndex],
    ),
        listener: (context,state){}
    );
  }
}
