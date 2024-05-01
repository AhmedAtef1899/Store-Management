import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_management/layout/cubit/cubit.dart';
import 'package:store_management/layout/cubit/state.dart';
import 'package:store_management/models/table_model.dart';

class ViewTableScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoreCubit,StoreStates>(
        builder: (context,state) =>  Scaffold(
        body: Column(
          children: [
            Expanded(
              child: ListView.separated(itemBuilder: (context,index)=>tableItems(StoreCubit.get(context).tables[index],context,index)
                  , separatorBuilder: (context,index) => const SizedBox(
                    height: 20,
                  ), itemCount: StoreCubit.get(context).tables.length
              ),
            ),
          ],
        )
    )
        , listener: (context,state){
      if (state is StoreRemoveTableSuccessState)
      {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text(
                'Deleted Table Successfully'
            ))
        );
      }
      if (state is StoreRemoveOneTableState)
      {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text(
                'Deleted Row Successfully'
            ))
        );
      }
    });
  }
}

Widget tableItems(StoreTableModel storeTableModel,context,index) => SingleChildScrollView(
  child: Column(
    children: [
      Padding(
        padding: const EdgeInsets.all(25),
        child: Table(
          border: TableBorder.all(color: Colors.grey),
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            TableRow(
              children: [
                Center(
                  child: Text("${storeTableModel.text2}",style:
                  const TextStyle(fontWeight: FontWeight.w900,
                      fontSize: 22),),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Text("${storeTableModel.text1}",style:const TextStyle(
                            fontWeight: FontWeight.w900,
                          fontSize: 22
                        ),),
                      ),
                    ),
                    IconButton(onPressed: (){
                      StoreCubit.get(context).deleteItemTable(StoreCubit.get(context).tableId[index]);
                      StoreCubit.get(context).getTables();
                      }, icon: const Icon(
                      Icons.delete_sweep_outlined
                    ))
                  ],
                ),
              ],
            ),
            if (storeTableModel.text3 != '' && storeTableModel.text4 !='')
             TableRow(
                children: [
                  Center(
                    child: Text("${storeTableModel.text4}",style:
                    const TextStyle(fontWeight: FontWeight.bold,
                        fontSize: 20),),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: Text("${storeTableModel.text3}",style:const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20),),
                        ),
                      ),
                      IconButton(onPressed: (){
                        StoreCubit.get(context).deleteTable1(StoreCubit.get(context).tableId[index]);
                      }, icon: const Icon(
                        Icons.delete_forever
                      ))
                    ],
                  ),
                ]
            ),
            if (storeTableModel.text5 != '' && storeTableModel.text6 !='')
              TableRow(
                  children: [
                    Center(
                      child: Text("${storeTableModel.text6}",style:
                      const TextStyle(fontWeight: FontWeight.bold,
                          fontSize: 20),),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: Text("${storeTableModel.text5}",style:const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20),),
                          ),
                        ),
                        IconButton(onPressed: (){
                          StoreCubit.get(context).deleteTable2(StoreCubit.get(context).tableId[index]);
                        }, icon: const Icon(
                            Icons.delete_forever
                        ))
                      ],
                    ),
                  ]
              ),
            if (storeTableModel.text8 != '' && storeTableModel.text7 !='')
              TableRow(
                  children: [
                    Center(
                      child: Text("${storeTableModel.text8}",style:
                      const TextStyle(fontWeight: FontWeight.bold,
                          fontSize: 20),),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: Text("${storeTableModel.text7}",style:const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20),),
                          ),
                        ),
                        IconButton(onPressed: (){
                          StoreCubit.get(context).deleteTable3(StoreCubit.get(context).tableId[index]);
                        }, icon: const Icon(
                            Icons.delete_forever
                        ))
                      ],
                    ),
                ]
            ),
            if (storeTableModel.text10 != '' && storeTableModel.text9 !='')
              TableRow(
                  children: [
                    Center(
                      child: Text("${storeTableModel.text10}",style:
                      const TextStyle(fontWeight: FontWeight.bold,
                          fontSize: 20),),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: Text("${storeTableModel.text9}",style:const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20),),
                            
                          ),
                        ),
                        IconButton(onPressed: (){
                          StoreCubit.get(context).deleteTable4(StoreCubit.get(context).tableId[index]);
                        }, icon: const Icon(
                            Icons.delete_forever
                        ))
                      ],
                    ),
                  ]
              ),
            if (storeTableModel.text12 != '' && storeTableModel.text11 !='')
              TableRow(
                  children: [
                    Center(
                      child: Text("${storeTableModel.text12}",style:
                      const TextStyle(fontWeight: FontWeight.bold,
                          fontSize: 20),),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: Text("${storeTableModel.text11}",style:const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20),),
                          ),
                        ),
                        IconButton(onPressed: (){
                          StoreCubit.get(context).deleteTable5(StoreCubit.get(context).tableId[index]);
                        }, icon: const Icon(
                            Icons.delete_forever
                        ))
                      ],
                    ),
                  ]
              ),
          ],
        ),
      )
    ],
  ),
);

