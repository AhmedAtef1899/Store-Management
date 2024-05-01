import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:store_management/layout/cubit/cubit.dart';
import 'package:store_management/layout/cubit/state.dart';
import 'package:store_management/models/production%20model.dart';

class UpdateScreen extends StatelessWidget
{
  final StoreModel storeModel;
  var titleController = TextEditingController();
  var priceController = TextEditingController();
  var discountController = TextEditingController();
  var oldPriceController = TextEditingController();
   UpdateScreen({super.key, required this.storeModel});

  @override
  Widget build(BuildContext context) {
    titleController.text = storeModel.name!??'';
    priceController.text = storeModel.price!??'';
    discountController.text = storeModel.discount!??'';
    oldPriceController.text = storeModel.oldPrice!??'';
    return BlocConsumer<StoreCubit,StoreStates>(
        builder: (context,state)=>Scaffold(
          appBar: AppBar(
            title: const Row(
              children: [
                Text(
                  'Update'
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.tips_and_updates_outlined,
                ),
              ],
            ),
            centerTitle: true,
            actions: [
              if (state is StoreUpdateLoadingState)
                const LinearProgressIndicator(),
            ],
          ),
          body:SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Image(image: NetworkImage('${storeModel.image}')),
                    CircleAvatar(
                      radius: 30,
                      child: IconButton(onPressed: (){}, icon: const Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.black,
                        size: 30,
                      )),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: titleController,
                        decoration: InputDecoration(
                          labelText: 'Title',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)
                          ),

                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller:priceController ,
                        decoration: InputDecoration(
                          labelText: 'Price',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)
                          ),

                        ),
                      ) ,
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller:discountController ,
                        decoration: InputDecoration(
                          labelText: 'Discount',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)
                          ),

                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: oldPriceController,
                        decoration: InputDecoration(
                          labelText: 'Old Price',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)
                          ),

                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      MaterialButton(onPressed: ()
                      {
                        // StoreCubit.get(context).update(
                        //   updateId: StoreCubit.get(context).itemId[index],
                        // title: titleController.text??'',
                        // price: priceController.text??'',
                        // discount: discountController.text??'',
                        // oldPrice: oldPriceController.text??'',
                        // );
                      },child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: HexColor('1C4966')
                        ),
                        child: const Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                  'Update',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                      fontStyle: FontStyle.italic
                                  )
                              ),
                              SizedBox(
                                width: 50,
                              ),
                              Icon(
                                Icons.auto_fix_high_outlined,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ),),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        listener: (context,state){});
  }
}
