
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:store_management/layout/layout_customer.dart';
import 'package:store_management/modules/registerScreen/cubit/cubit.dart';
import 'package:store_management/modules/registerScreen/cubit/state.dart';
import 'package:store_management/shared/componentes.dart';

class RegisterScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context)
  {
    return BlocProvider(
        create:(BuildContext context) => StoreSignUpCubit(),
      child: BlocConsumer<StoreSignUpCubit,StoreSignUpStates>(
          builder: (context,state)=>Scaffold(
        appBar: AppBar(
          backgroundColor:HexColor('1C4966') ,
          systemOverlayStyle:  SystemUiOverlayStyle(
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: HexColor('1C4966'),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children:
            [
              Container(
                width: double.infinity,
                color: HexColor('1C4966'),
                child:  Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Register',
                        style: TextStyle(
                            fontSize: 40,
                            color: Colors.white,
                            fontWeight: FontWeight.w800
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Create your Account',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[300],
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                                Icons.perm_identity_outlined
                            ),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                            label: const Text(
                              'Name',
                            ),
                          ),
                          controller: nameController,
                          keyboardType: TextInputType.name,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                                Icons.email_outlined
                            ),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                            label: const Text(
                              'Email',
                            ),
                          ),
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            suffixIcon: const Icon(
                                Icons.remove_red_eye_outlined
                            ),
                            prefixIcon: const Icon(
                                Icons.lock_outline
                            ),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                            label: const Text(
                              'Password',
                            ),
                          ),
                          controller: passController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            suffixIcon: const Icon(
                                Icons.remove_red_eye_outlined
                            ),
                            prefixIcon: const Icon(
                                Icons.lock_outline
                            ),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                            label: const Text(
                              'Confirm Password',
                            ),
                          ),
                          controller: phoneController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.green[300]
                          ),
                          child: MaterialButton(onPressed: (){
                            StoreSignUpCubit.get(context).addUser(name: nameController.text,
                                email: emailController.text,
                                pass: passController.text,
                                phone: phoneController.text
                            );
                          },
                            child: const Text(
                              'Register',
                              style: TextStyle(
                                  fontSize: 18
                              ),
                            ),),
                        ),
                      ],
                    )
                ),
              )
            ],
          ),
        ),
      ),
          listener: (context,state){
            if (state is StoreSignUpSuccessState)
              {
                navigateAndFinish(context, const LayoutCustomerScreen());
              }
          }),

    );
  }
}
