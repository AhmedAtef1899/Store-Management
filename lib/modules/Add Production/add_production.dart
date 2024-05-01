import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:store_management/layout/cubit/cubit.dart';
import 'package:store_management/layout/cubit/state.dart';

class AddProductionScreen extends StatelessWidget {

  var nameController = TextEditingController();
  var oldPriceController = TextEditingController();
  var discountController = TextEditingController();
  var priceController = TextEditingController();
  var descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoreCubit,StoreStates>(
        builder: (context,state)=>Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    if (state is StoreGetItemLoadingState)
                      const LinearProgressIndicator(),
                    if (StoreCubit.get(context).productionImage ==null)
                      InkWell(
                        onTap: (){
                          StoreCubit.get(context).pickProductionImage();
                        },
                        child: Container(
                          decoration:  BoxDecoration(
                              color: Colors.grey[300],
                              shape: BoxShape.circle
                          ),
                          width: 90,
                          height: 90,
                          child: const Icon(
                            Icons.add_a_photo_outlined,
                            size: 30,
                          ),
                        ),
                      ),
                    if (StoreCubit.get(context).productionImage !=null)
                      Card(
                        elevation: 10,
                        clipBehavior:Clip.antiAliasWithSaveLayer,
                        margin: const EdgeInsets.all(8),
                        child: Stack(
                          children: [
                            Image(image:
                            FileImage(StoreCubit.get(context).productionImage!),
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            IconButton(onPressed: (){
                              StoreCubit.get(context).removeImage();
                            }, icon: const Icon(
                              Icons.close
                            ))
                          ],
                        ),
                      ),
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      maxLines: null,
                      controller: nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                        label: const Text(
                          'Production Name',
                        ),
                      ),
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: priceController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                        label: const Text(
                          'Price',
                        ),
                      ),
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: discountController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                        label: const Text(
                          'Discount',
                        ),
                      ),
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: oldPriceController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                        label: const Text(
                          'Old Price',
                        ),
                      ),
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      maxLines: null,
                      controller: descriptionController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                        label: const Text(
                          'Description',
                        ),
                      ),
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MaterialButton(onPressed: (){
                      if (StoreCubit.get(context).productionImage != null) {
                        StoreCubit.get(context).addProduction(name: nameController.text,
                            price: priceController.text,
                            oldPrice: oldPriceController.text,
                            discount: discountController.text,
                            description: descriptionController.text
                        );
                      }
                      nameController.text ='';
                      priceController.text ='';
                      oldPriceController.text ='';
                      discountController.text ='';
                      descriptionController.text ='';
                      StoreCubit.get(context).removeImage();
                    },child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: HexColor('1C4966')
                      ),
                      child: const Center(
                        child: Text(
                          'Add Production',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontStyle: FontStyle.italic
                          )
                        ),
                      ),
                    ),),


                  ],
                ),
              )
            ],
          ),
        )
    ),
        listener:  (context,state){
          if (state is StoreSetProductionSuccessState)
          {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text(
                    "Added Successfully"
                ))
            );
          }
        });
  }
}
