import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_management/layout/cubit/cubit.dart';
import 'package:store_management/layout/cubit/state.dart';
import 'package:store_management/models/production%20model.dart';

class ItemIdScreen extends StatelessWidget
{
  final StoreModel storeModel;
  const ItemIdScreen({super.key, required this.storeModel});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoreCubit,StoreStates>(
        builder: (context,state)=> Scaffold(
          appBar: AppBar(
            title: const Text(
              'Item Details',
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
              [
                Image(image: NetworkImage(
                    '${storeModel.image}')
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child:  Text(
                    '${storeModel.name}',
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    ),
                    textDirection: StoreCubit.get(context).changeLanguage? StoreCubit.get(context).directionEnglish: StoreCubit.get(context).directionArabic,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Text(
                        'EGP ${storeModel.price}',
                        style: const TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 17,
                          color: Colors.deepOrange
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      if (storeModel.discount != '')
                        Text(
                            '${storeModel.oldPrice}',
                          style: const TextStyle(
                            decoration: TextDecoration.lineThrough
                          ),
                        )
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    'Product Description',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900
                    ),
                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        border: Border.all(
                            style: BorderStyle.solid
                        ),
                        borderRadius: BorderRadius.circular(20)
                    ),
                    width: double.infinity,
                    child: Text(
                      '${storeModel.description}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                      ),
                      textDirection: StoreCubit.get(context).changeLanguage? StoreCubit.get(context).directionEnglish: StoreCubit.get(context).directionArabic,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        listener: (context,state){});
  }
}

