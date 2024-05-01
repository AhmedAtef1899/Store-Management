import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:store_management/layout/cubit/cubit.dart';
import 'package:store_management/layout/cubit/state.dart';

class AddTableScreen extends StatelessWidget
{
  var text1Controller = TextEditingController();
  var text2Controller = TextEditingController();
  var text3Controller = TextEditingController();
  var text4Controller = TextEditingController();
  var text5Controller = TextEditingController();
  var text6Controller = TextEditingController();
  var text7Controller = TextEditingController();
  var text8Controller = TextEditingController();
  var text9Controller = TextEditingController();
  var text10Controller = TextEditingController();
  var text11Controller = TextEditingController();
  var text12Controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoreCubit,StoreStates>(builder: (context,state)=>Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (state is StoreGetTableLoadingState)
                const LinearProgressIndicator(),
                const SizedBox(height: 5,),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      maxLines: null,
                      controller: text2Controller,
                      textDirection: TextDirection.rtl,
                      decoration: const InputDecoration(
                        hintText: 'Text2',
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TextFormField(
                      maxLines: null,
                      controller: text1Controller,
                      textDirection: TextDirection.rtl,
                      decoration: const InputDecoration(
                          hintText: 'Text1'
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      maxLines: null,
                      controller: text4Controller,
                      decoration: const InputDecoration(
                        hintText: 'Text4',
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TextFormField(
                      maxLines: null,
                      controller: text3Controller,
                      textDirection: TextDirection.rtl,
                      decoration: const InputDecoration(
                          hintText: 'Text3'
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      maxLines: null,
                      controller: text6Controller,
                      textDirection: TextDirection.rtl,
                      decoration: const InputDecoration(
                        hintText: 'Text6',
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TextFormField(
                      maxLines: null,
                      controller: text5Controller,
                      textDirection: TextDirection.rtl,
                      decoration: const InputDecoration(
                          hintText: 'Text5'
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      maxLines: null,
                      controller: text8Controller,
                      textDirection: TextDirection.rtl,
                      decoration: const InputDecoration(
                        hintText: 'Text8',
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TextFormField(
                      maxLines: null,
                      controller: text7Controller,
                      textDirection: TextDirection.rtl,
                      decoration: const InputDecoration(
                          hintText: 'Text7'
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      maxLines: null,
                      controller: text10Controller,
                      textDirection: TextDirection.rtl,
                      decoration: const InputDecoration(
                        hintText: 'Text10',
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TextFormField(
                      maxLines: null,
                      controller: text9Controller,
                      textDirection: TextDirection.rtl,
                      decoration: const InputDecoration(
                          hintText: 'Text9'
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      maxLines: null,
                      controller: text12Controller,
                      textDirection: TextDirection.rtl,
                      decoration: const InputDecoration(
                        hintText: 'Text12',
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TextFormField(
                      maxLines: null,
                      controller: text11Controller,
                      textDirection: TextDirection.rtl,
                      decoration: const InputDecoration(
                          hintText: 'Text11'
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              MaterialButton(onPressed: ()
              {
                StoreCubit.get(context).addTableItems(
                  text1: text1Controller.text ?? '',
                  text2: text2Controller.text ?? '',
                  text3: text3Controller.text ?? '',
                  text4: text4Controller.text ?? '',
                  text5: text5Controller.text ?? '',
                  text6: text6Controller.text ?? '',
                  text7: text7Controller.text ?? '',
                  text8: text8Controller.text ?? '',
                  text9: text9Controller.text ?? '',
                  text10: text10Controller.text ?? '',
                  text11: text11Controller.text ?? '',
                  text12: text12Controller.text ??'' ,

                );
                text1Controller.text = '';
                text2Controller.text = '';
                text3Controller.text = '';
                text4Controller.text = '';
                text5Controller.text = '';
                text6Controller.text = '';
                text7Controller.text='';
                text8Controller.text='';
                text9Controller.text='';
                text10Controller.text='';
                text11Controller.text='';
                text12Controller.text='';
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
                          'Add',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              fontStyle: FontStyle.italic
                          )
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),)
            ],
          ),
        ),
      ),
    ), listener:  (context,state){
      if (state is StoreAddTableSuccessState)
      {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text(
                'Added Table Successfully'
            ))
        );
      }
    });
  }
}
