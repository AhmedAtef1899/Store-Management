import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:store_management/layout/cubit/cubit.dart';
import 'package:store_management/layout/cubit/state.dart';
import 'package:store_management/models/production%20model.dart';
import 'package:store_management/shared/componentes.dart';

class SettingScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<StoreCubit,StoreStates>(
        builder: (context,state)=>Scaffold(
          body:Column(
            children: [
              Container(
                height: 100,
                color: Colors.grey[100],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: MaterialButton(onPressed: (){
                        StoreCubit.get(context).changeLang(StoreCubit.get(context).lang);
                      },
                          child: Container(
                        padding: const EdgeInsets.all(12),
                        width: 120,
                        height: 50,
                        decoration: BoxDecoration(
                          color: HexColor('1C4966'),
                          borderRadius: BorderRadius.circular(50)
                        ),
                        child:  Text(
                          'LANGUAGE',
                          style: TextStyle(
                            color: Colors.grey[200],
                            fontSize: 15
                          ),
                        ),
                      )
                      ),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Expanded(
                      child: Text(
                        StoreCubit.get(context).changeLanguage? StoreCubit.get(context).lang : 'AR',
                        style: const TextStyle(
                          fontSize: 20,fontWeight: FontWeight.w600,fontStyle: FontStyle.italic,color: Colors.blue
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: ListView.separated(itemBuilder: (context,index) => updateItems(StoreCubit.get(context).items[index],context,index,state),
                  separatorBuilder: (context,index) => line(),
                  itemCount: StoreCubit.get(context).items.length,
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                ),
              ),
            ],
          ),
        ),
        listener: (context,state){
          if (state is StoreUpdateSuccessState)
          {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text(
                    'Updated Successfully'
                ))
            );
          }
          if (state is StoreUpdateErrorState)
          {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text(
                    'Updated Failed'
                ))
            );
          }
        });
  }
}

Widget updateItems(StoreModel storeModel,context,index,state) => Padding(
  padding: const EdgeInsets.all(20),
  child: Builder(
    builder: (context) {
      var titleController = TextEditingController();
      var priceController = TextEditingController();
      var discountController = TextEditingController();
      var oldPriceController = TextEditingController();
      titleController.text  = storeModel.name! ?? '';
      priceController.text = storeModel.price! ?? '';
      discountController.text = storeModel.discount! ?? '';
      oldPriceController.text = storeModel.oldPrice! ?? '';
      return Column(
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              state is StorePickUpdateSuccessState?
                Image(image: FileImage(StoreCubit.get(context).newImage!))
                 : Image(
                  image: NetworkImage('${storeModel.image}')),
              CircleAvatar(
                radius: 30,
                backgroundColor: HexColor('1C4966'),
                child: IconButton(onPressed: (){
                  StoreCubit.get(context).pickUpdateImage();
                }, icon: Icon(
                  Icons.camera_alt_outlined,
                  color: Colors.grey[200],
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
              children:
              [
                TextFormField(
                  textDirection: StoreCubit.get(context).changeLanguage? StoreCubit.get(context).directionEnglish: StoreCubit.get(context).directionArabic,
                  maxLines: null,
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
                  StoreCubit.get(context).update(updateId: StoreCubit.get(context).itemId[index],
                    name: titleController.text ?? '',
                    price: priceController.text ?? '',
                    discount: discountController.text ?? '',
                    oldPrice: oldPriceController.text ?? '',
                  );
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
      );
    }
  ),
);
