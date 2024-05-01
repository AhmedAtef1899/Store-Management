import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_management/layout/cubit/cubit.dart';
import 'package:store_management/layout/cubit/state.dart';
import 'package:store_management/models/production%20model.dart';
import 'package:store_management/modules/store_screen/storeId_screen.dart';
import 'package:store_management/shared/componentes.dart';

class StoreScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoreCubit,StoreStates>(builder:
        (context,state)=>Scaffold(
        appBar: AppBar(
        title: const Text(
            'Customer World'
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CarouselSlider(
             items: const [
               Image(image: NetworkImage(
                   'https://img.freepik.com/free-vector/smart-home-technology-with-cctv-camera_24877-50560.jpg?w=740&t=st=1708446572~exp=1708447172~hmac=fc67a1f7129d07d1f7b09ba078c78d20e4c030a5090950df64d4940374651615'
               ),
                 width: double.infinity,
                 fit: BoxFit.cover,),
               Image(image: NetworkImage(
                   'https://img.freepik.com/free-vector/wireless-smart-home-automation-infographic_1284-54599.jpg?w=740&t=st=1708445560~exp=1708446160~hmac=f228663dd0485950207f02c831bf0adeb2acf3bb59ca4ca848b7411b0debd3dc'
               ),
                 width: double.infinity,
                 fit: BoxFit.cover,),
               Image(image: NetworkImage(
                   'https://img.freepik.com/free-photo/house-automation-with-camera_23-2148994154.jpg?w=996&t=st=1708446527~exp=1708447127~hmac=58ef4af61136753c9f04711e6638e287c4692d752be2b018146fb039237f1306'
               ),
                 width: double.infinity,
               fit: BoxFit.cover,),
              ],
               options: CarouselOptions(
                 height: 250,
                 initialPage: 0,
                 reverse: false,
                 enableInfiniteScroll: true,
                 viewportFraction: 1.0,
                 autoPlay: true,
                 autoPlayInterval: const Duration(
                   seconds: 3,
                 ),
                 autoPlayAnimationDuration: const Duration(
                   seconds: 1
                 ),
                 autoPlayCurve: Curves.fastOutSlowIn,
                 scrollDirection: Axis.horizontal
               ),
            ),
            const SizedBox(
              height: 20,
            ),
            if(state is StoreGetItemLoadingState)
              const LinearProgressIndicator(),
            GridView.count(
              mainAxisSpacing: 1.8,
              crossAxisSpacing: 1.8,
              crossAxisCount: 2,
              shrinkWrap: true,
              childAspectRatio: 1/1.55,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(
                  StoreCubit.get(context).items.length,
                      (index) => gridProduct(StoreCubit.get(context).items[index],context,index,state)
              ),

            )
          ],
        ),
      ),
    ),
        listener: (context,state){
      if (state is StoreAddFavoriteSuccessState)
        {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text(
              'تم الاضافة الي المفضلة'
            ))
          );
        }
        });
  }
}

Widget gridProduct(StoreModel storeModel, context, index,state) => InkWell(
  onTap: (){
    StoreCubit.get(context).getOneItem(StoreCubit.get(context).itemId[index]);
    navigateTo(context,  StoreIdScreen(storeModel: storeModel,));
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
                  fontSize: 18,
                ),
                textDirection: StoreCubit.get(context).changeLanguage? StoreCubit.get(context).directionEnglish: StoreCubit.get(context).directionArabic,
              ),
              const SizedBox(
                height: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'EGP ${storeModel.price}',
                    style: const TextStyle(
                      fontSize: 17,
                      color: Colors.blue,
                    ),
                  ),
                  if (storeModel.discount != null)
                    const SizedBox(
                      width: 7,
                    ),
                    Text(
                      '${storeModel.oldPrice}',
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  const SizedBox(
                    width: 5,
                  ),
                  IconButton(onPressed: ()
                  {
                    StoreCubit.get(context).isFav(storeModel.isFav ?? false);
                    StoreCubit.get(context).addFav(
                        name: storeModel.name ?? '',
                        image: storeModel.image ?? '',
                        price: storeModel.price ?? '',
                        discount: storeModel.discount ?? '',
                        oldPrice: storeModel.discount ?? ''
                    );
                  },
                      icon: Icon(
                    Icons.favorite_border
                  ))
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);

