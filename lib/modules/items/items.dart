import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_management/layout/cubit/cubit.dart';
import 'package:store_management/layout/cubit/state.dart';
import 'package:store_management/models/production%20model.dart';
import 'package:store_management/modules/items/itemId_screen.dart';
import 'package:store_management/shared/componentes.dart';

class ItemsScreen extends StatelessWidget
{

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoreCubit,StoreStates>(builder:
        (context,state)=>Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            if(state is StoreGetItemLoadingState)
              const LinearProgressIndicator(),
            GridView.count(
              mainAxisSpacing: 1.5,
              crossAxisSpacing: 1.5,
              crossAxisCount: 2,
              shrinkWrap: true,
              childAspectRatio: 1/1.62,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(
                  StoreCubit.get(context).items.length,
                      (index) => gridProduct(StoreCubit.get(context).items[index],context,index)
              ),

            )
          ],
        ),
      ),
    ),
        listener: (context,state){
          if (state is StoreRemoveItemSuccessState)
          {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text(
                    'Deleted Successfully'
                ))
            );
          }
        });
  }
}

Widget gridProduct(StoreModel storeModel, context, index) => InkWell(
  onTap: (){
    StoreCubit.get(context).getOneItem(StoreCubit.get(context).itemId[index]);
    navigateTo(context,  ItemIdScreen(storeModel: storeModel,));
  },
  child: Container(
    color: Colors.grey[100],
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage(
                storeModel.image ?? '',
              ),
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            if (storeModel.oldPrice != '')
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                color: Colors.red,
                child: const Text(
                  'DISCOUNT',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                storeModel.name ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                ),
                textDirection: StoreCubit.get(context).changeLanguage? StoreCubit.get(context).directionEnglish: StoreCubit.get(context).directionArabic,
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Text(
                    'EGP ${storeModel.price}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.blue,
                    ),
                  ),
                  if (storeModel.discount != null)
                    Text(
                      '${storeModel.oldPrice}',
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      StoreCubit.get(context).changeToUpdate();
                    },
                    icon: const CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.deepPurple,
                      child: Icon(
                        Icons.auto_fix_high_outlined,
                        size: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      StoreCubit.get(context).removeItem(
                        StoreCubit.get(context).itemId[index],
                      );
                    },
                    icon: const CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.red,
                      child: Icon(
                        Icons.delete,
                        size: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);

