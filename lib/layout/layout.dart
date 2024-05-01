import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:store_management/layout/cubit/cubit.dart';
import 'package:store_management/layout/cubit/state.dart';
import 'package:store_management/layout/layout_customer.dart';
import 'package:store_management/modules/store_screen/store_screen.dart';
import 'package:store_management/shared/componentes.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoreCubit,StoreStates>(builder: (context,state)=> Scaffold(
      appBar: AppBar(
        title: const Text(
          'Admin World'
        ),
        actions: [
          if(state is StoreUpdateLoadingState)
            const LinearProgressIndicator(),
          TextButton(onPressed: (){
            navigateTo(context, StoreScreen());
          }, child:
             const Row(
              children: [
                Text(
                  'YOUR STORE',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w800,
                    fontSize: 17
                  ),
                ),
                Icon(
                  CupertinoIcons.right_chevron
                )
              ],
            )
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(items: StoreCubit.get(context).bottomBar,
      currentIndex: StoreCubit.get(context).currentIndex,
        onTap: (index){
          StoreCubit.get(context).navBar(index);
        },
      ),
      body: StoreCubit.get(context).screens[StoreCubit.get(context).currentIndex],
    ),
        listener: (context,state){}
    );
  }
}
