import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:store_management/modules/login/login.dart';
import 'package:store_management/shared/componentes.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: 870,
          decoration: const BoxDecoration(
            image: DecorationImage(image: NetworkImage(''
                'https://i.pinimg.com/564x/70/ce/b3/70ceb342afa4e10c13aec23dec1220f0.jpg',
            ),
              fit: BoxFit.cover
            ),

          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      width: 60,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.green[200]
                      ),
                      child: MaterialButton(onPressed: (){
                        navigateTo(context,  LoginScreen());
                      },child: const Text(
                        '',
                      ),),
                    ),
                  ),
                  const SizedBox(
                    height: 610,
                  ),
                  Container(
                    width: double.infinity,
                    height: 70,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.green[300]
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MaterialButton(onPressed: (){},child: const Text(
                          'The Store',
                          style: TextStyle(
                            fontSize: 20
                          ),
                        ),
                        ),
                        const SizedBox(
                          width: 50,
                        ),
                        const Icon(
                          CupertinoIcons.right_chevron
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
// Expanded(
//             child: const Image(image: NetworkImage(
//               'https://img.freepik.com/premium-vector/i-love-photography-because-every-picture-tells-story-lettering-camera_97378-637.jpg?w=740'
//             ),
//             width: double.infinity,
//             fit: BoxFit.cover,),
//           )
//CarouselSlider(
//            items: const [
//              Image(image: NetworkImage(
//                  'https://img.freepik.com/free-vector/smart-home-technology-with-cctv-camera_24877-50560.jpg?w=740&t=st=1708446572~exp=1708447172~hmac=fc67a1f7129d07d1f7b09ba078c78d20e4c030a5090950df64d4940374651615'
//              ),
//                width: double.infinity,
//                fit: BoxFit.cover,),
//              Image(image: NetworkImage(
//                  'https://img.freepik.com/free-vector/wireless-smart-home-automation-infographic_1284-54599.jpg?w=740&t=st=1708445560~exp=1708446160~hmac=f228663dd0485950207f02c831bf0adeb2acf3bb59ca4ca848b7411b0debd3dc'
//              ),
//                width: double.infinity,
//                fit: BoxFit.cover,),
//              Image(image: NetworkImage(
//                  'https://img.freepik.com/free-photo/house-automation-with-camera_23-2148994154.jpg?w=996&t=st=1708446527~exp=1708447127~hmac=58ef4af61136753c9f04711e6638e287c4692d752be2b018146fb039237f1306'
//              ),
//                width: double.infinity,
//              fit: BoxFit.cover,),
//             ],
//              options: CarouselOptions(
//                height: 400,
//                initialPage: 0,
//                reverse: false,
//                enableInfiniteScroll: true,
//                viewportFraction: 1.0,
//                autoPlay: true,
//                autoPlayInterval: const Duration(
//                  seconds: 3,
//                ),
//                autoPlayAnimationDuration: const Duration(
//                  seconds: 1
//                ),
//                autoPlayCurve: Curves.fastOutSlowIn,
//                scrollDirection: Axis.horizontal
//              ),
//             ),
