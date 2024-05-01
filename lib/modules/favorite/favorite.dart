import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_management/layout/cubit/cubit.dart';
import 'package:store_management/layout/cubit/state.dart';
import 'package:store_management/models/favorite_model.dart';
import 'package:store_management/shared/componentes.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoreCubit,StoreStates>(
        builder: (context,state) => Scaffold(
          body: Column(
            children: [
              Expanded(
                child: ListView.separated(
                    itemBuilder: (context,index) =>favoriteItems(StoreCubit.get(context).favList[index], index, context) ,
                    separatorBuilder: (context,index) => line(),
                    itemCount: StoreCubit.get(context).favList.length,
                ),
              ),
            ],
          ),
        ),
        listener: (context,state){
          if (state is StoreDelFavoriteSuccessState)
          {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text(
                    'تم الحذف من المفضلة'
                ))
            );
          }
        }
    );
  }
}

Widget favoriteItems(StoreFavoriteModel storeFavoriteModel,index,context) => Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 150,
    child: Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(image: NetworkImage(
                '${storeFavoriteModel.image}'),
              height: 140,
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                      '${storeFavoriteModel.name}',
                    textDirection: StoreCubit.get(context).changeLanguage? StoreCubit.get(context).directionEnglish: StoreCubit.get(context).directionArabic,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 20
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text('EGP ${storeFavoriteModel.price}'
                      ,
                        style: const TextStyle(
                            fontSize: 15,
                          color: Colors.blue
                        ),
                      ),
                      if (storeFavoriteModel.oldPrice != '')
                          Text(
                          '${storeFavoriteModel.oldPrice}',
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),

                      const Spacer(),
                      IconButton(onPressed: ()
                      {
                        // StoreCubit.get(context).deleteFav(StoreCubit.get(context).favoritesId[index]);
                        // StoreCubit.get(context).getFavoritesProduction();
                      }, icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ))
                    ],
                  )
                ],
              ),
            )
          ],
        ),

      ],
    ),
  ),
);
