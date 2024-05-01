import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:store_management/layout/cubit/state.dart';
import 'package:store_management/models/favorite_model.dart';
import 'package:store_management/models/production%20model.dart';
import 'package:store_management/models/table_model.dart';
import 'package:store_management/modules/Add%20Production/add_production.dart';
import 'package:store_management/modules/Setting/setting.dart';
import 'package:store_management/modules/customer_setting/setting.dart';
import 'package:store_management/modules/favorite/favorite.dart';
import 'package:store_management/modules/items/items.dart';
import 'package:store_management/modules/store_screen/store_screen.dart';
import 'package:store_management/modules/table/tableScreen.dart';
import 'package:store_management/modules/table_screen/table_screen.dart';

class StoreCubit extends Cubit<StoreStates> {
  StoreCubit() : super(StoreInitialState());

  static StoreCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  int currentCustomerIndex = 0;
  List<Widget> screens = [
    AddProductionScreen(),
    ItemsScreen(),
    AddTableScreen(),
    ViewTableScreen(),
    SettingScreen(),
  ];
  List<Widget> customerScreens = [
    StoreScreen(),
    const FavoriteScreen(),
    const CustomerSettingScreen()
  ];

  List<BottomNavigationBarItem> bottomBar = [
    const BottomNavigationBarItem(
      icon: Icon(
        CupertinoIcons.cart_badge_plus,
      ),
      label: 'Add Production',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        CupertinoIcons.square_list,
      ),
      label: 'The Items',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        CupertinoIcons.table_badge_more,
      ),
      label: 'Add Table',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        CupertinoIcons.text_aligncenter,
      ),
      label: 'Table',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        CupertinoIcons.settings,
      ),
      label: 'Setting',
    )
  ];

  List<BottomNavigationBarItem> bottomCustomerBar = [
    const BottomNavigationBarItem(
      icon: Icon(
        CupertinoIcons.cart,
      ),
      label: 'المنتجات',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        CupertinoIcons.heart,
      ),
      label: 'المفضلة',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        CupertinoIcons.settings,
      ),
      label: 'الاعدادات',
    ),
  ];

  void navCustomerBar(int index) {
    currentCustomerIndex = index;
    emit(StoreBottomBarState());
  }

  void navBar(int index) {
    currentIndex = index;
    if(index == 1)
      {
        getProduction();
      }
    if(index == 3)
      {
        getTables();
      }
    emit(StoreBottomBarState());
  }

  File? productionImage;

  void pickProductionImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      productionImage = File(pickedFile.path);
      emit(StorePickSuccessState());
    } else {
      emit(StorePickErrorState());
    }
  }

  List<StoreModel> items = [];

  // Get production items from Firestore
  void getProduction() {
    emit(StoreGetItemLoadingState());
    FirebaseFirestore.instance.collection('production').get().then((querySnapshot) {
      items.clear(); // Clear existing items before adding new ones
      querySnapshot.docs.forEach((doc) {
        itemId.add(doc.id);
        items.add(StoreModel.fromJson(doc.data()));
      });
      emit(StoreGetItemSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(StoreGetItemErrorState());
    });
  }
  StoreModel? storeModel;
  // Add a production item to Firestore
  void addProduction({
    required String name,
    required String price,
    String? oldPrice,
    String? discount,
    String? image,
    String? description,
  }) async {
    emit(StoreSetProductionLoadingState());
    StoreModel storeModel = StoreModel(
      name: name,
      price: price,
      image: image,
      discount: discount,
      oldPrice: oldPrice,
        description: description
    );

    try {
      // Upload the image to Firebase Storage if available
      if (productionImage != null)
      {
        Reference imageRef = FirebaseStorage.instance.ref('production_images/${basename(productionImage!.path)}');
        await imageRef.putFile(productionImage!);
        String imageUrl = await imageRef.getDownloadURL();
        storeModel.image = imageUrl; // Update the image URL in the model
      }

      // Add the production item to Firestore
      await FirebaseFirestore.instance.collection('production').add(storeModel.toMap());

      // Refresh the production list
      getProduction();

      emit(StoreSetProductionSuccessState());
    } catch (error) {
      print(error.toString());
      emit(StoreSetProductionErrorState());
    }
  }



  void removeImage()
  {
    productionImage = null;
    emit(StoreRemoveImageState());
  }

  List <String> itemId=[];
  void removeItem(String removeIt)
  {
    FirebaseFirestore.instance.collection('production')
        .doc(removeIt)
        .delete().then((value){
          getProduction();
      emit(StoreRemoveItemSuccessState());
    }).catchError((onError){
      print(onError.toString());
      emit(StoreRemoveItemErrorState());
    });

  }

  void getOneItem(String getItem)
  {
    FirebaseFirestore.instance.collection('production')
        .doc(getItem)
        .get()
        .then((value){
          emit(StoreGetOneItemSuccessState());
    }).catchError((onError){
      print(onError.toString());
      emit(StoreGetItemSuccessState());
    });
  }

  File? newImage;

  void pickUpdateImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      newImage = File(pickedFile.path);
      emit(StorePickUpdateSuccessState());
    } else {
      emit(StorePickUpdateErrorState());
    }
  }
  void update({
    required String updateId,
    required String? name,
    required String? price,
    required String? discount,
    required String? oldPrice,

  }) async {
    emit(StoreUpdateLoadingState());

    // Create a map to hold the fields to update
    Map<String, dynamic> updateData = {};

    // Conditionally add fields to the update data if they are provided


    try {
      if (name != null) {
        updateData['name'] = name;
      }
      if (price != null) {
        updateData['price'] = price;
      }
      if (discount != null) {
        updateData['discount'] = discount;
      }
      if (oldPrice != null) {
        updateData['oldPrice'] = oldPrice;
      }
      // Update the image if a new image is provided
      if (newImage != null)
      {
        Reference imageRef = FirebaseStorage.instance.ref('production_images/${basename(newImage!.path)}');
        await imageRef.putFile(newImage!);
        String imageUrl = await imageRef.getDownloadURL();
        updateData['image'] = imageUrl; // Update the image URL in the update data
      }

      // Update the Firestore document with the provided fields
      await FirebaseFirestore.instance.collection('production')
          .doc(updateId)
          .update(updateData);
      emit(StoreUpdateSuccessState());
    } catch (error) {
      print(error.toString());
      emit(StoreUpdateErrorState());
    }
  }


  void changeToUpdate()
  {
    currentIndex = 4;
    emit(StoreChangeToUpdateState());
  }

  StoreTableModel? storeTableModel;
  void addTableItems({
  String? text1,
  String? text2,
  String? text3,
  String? text4,
  String? text5,
  String? text6,
  String? text7,
  String? text8,
  String? text9,
  String? text10,
  String? text11,
  String? text12,
})
  async {
    storeTableModel = StoreTableModel(
     text1: text1,
     text2: text2,
     text3: text3,
     text4: text4,
     text5: text5,
     text6: text6,
     text7: text7,
     text8: text8,
     text9: text9,
     text10: text10,
     text11: text11,
     text12: text12,
    );

    await FirebaseFirestore.instance.collection('table')
    .add(storeTableModel!.toMap()).then((value) {
      getTables();
      emit(StoreAddTableSuccessState());
    }).catchError((onError){
      print(onError.toString());
      emit(StoreAddTableErrorState());
    });
  }

  List<StoreTableModel> tables = [];
  List<String> tableId = [];

  void getTables()
  {
    emit(StoreGetTableLoadingState());
    FirebaseFirestore.instance.collection('table')
    .get()
    .then((value)
    {
      tables.clear();
      value.docs.forEach((element) {
        tableId.add(element.id);
        tables.add(StoreTableModel.fromJson(element.data()));
      });
      emit(StoreGetTableSuccessState());
    }).catchError((onError){
      print(onError.toString());
      emit(StoreGetTableErrorState());
    });
  }

  void deleteItemTable(String tableId)
  {
    FirebaseFirestore.instance.collection('table')
        .doc(tableId)
        .delete()
        .then((value){
          getTables();
          emit(StoreRemoveTableSuccessState());
    }).catchError((onError){
          print(onError.toString());
          emit(StoreRemoveTableErrorState());
    });
  }
  void deleteTable1(String tableId)
  {
    FirebaseFirestore.instance.collection('table')
        .doc(tableId)
        .update({'text3': ''})
        .then((_)
    {
      emit(StoreRemoveOneTableState());
      getTables();
    }).catchError((error) {
      print("Failed to update rows: $error");
      emit(StoreRemoveOneTableErrorState());
    });
  }
  void deleteTable2(String tableId)
  {
    FirebaseFirestore.instance.collection('table')
        .doc(tableId)
        .update({'text5': ''})
        .then((_) {
      getTables(); // Refresh the table data
      emit(StoreRemoveOneTableState());
    }).catchError((error) {
      print("Failed to update rows: $error");
      emit(StoreRemoveOneTableErrorState());
    });
  }
  void deleteTable3(String tableId)
  {
    FirebaseFirestore.instance.collection('table')
        .doc(tableId)
        .update({'text7': ''})
        .then((_) {
      getTables(); // Refresh the table data
      emit(StoreRemoveOneTableState());
    }).catchError((error) {
      print("Failed to update rows: $error");
      emit(StoreRemoveOneTableErrorState());
    });
  }
  void deleteTable4(String tableId)
  {
    FirebaseFirestore.instance.collection('table')
        .doc(tableId)
        .update({'text9': ''})
        .then((_) {
      getTables(); // Refresh the table data
      emit(StoreRemoveOneTableState());
    }).catchError((error) {
      print("Failed to update rows: $error");
      emit(StoreRemoveOneTableErrorState());
    });
  }
  void deleteTable5(String tableId)
  {
    FirebaseFirestore.instance.collection('table')
        .doc(tableId)
        .update({'text11': ''})
        .then((_) {
      getTables(); // Refresh the table data
      emit(StoreRemoveOneTableState());
    }).catchError((error) {
      print("Failed to update rows: $error");
      emit(StoreRemoveOneTableErrorState());
    });
  }
  TextDirection directionEnglish = TextDirection.ltr;
  TextDirection directionArabic = TextDirection.rtl;
  TextDirection? direction;
  bool changeLanguage = false;
  String lang = 'EN';
  void changeLang(String value) {
      changeLanguage = !changeLanguage;
      lang = value;
      if (value == 'AR') {
        direction = directionArabic;
      } else
      {
        direction = directionEnglish;
      }
      emit(StoreChangeLangState());
  }
  StoreFavoriteModel? storeFavoriteModel;
  void addFav({
    required String name,
    required String image,
    required String price,
    required String discount,
    required String oldPrice
})
  {
    StoreFavoriteModel storeFavoriteModel = StoreFavoriteModel(
      name: name,
      image: image,
      price: price,
      discount: discount,
      oldPrice: oldPrice,
    );
    FirebaseFirestore.instance.collection('favorite')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .set(storeFavoriteModel.toMap()).then((value) 
    {
      getFav();
      emit(StoreAddFavoriteSuccessState());
    }).catchError((onError)
    {
      emit(StoreAddFavoriteErrorState());
    });
  }
  List<StoreFavoriteModel> favList = [];
  void getFav()
  {
    FirebaseFirestore.instance.collection('favorite')
        .get().then((value) {
          favList.clear();
          value.docs.forEach((element) {
            favList.add(StoreFavoriteModel.fromJson(element.data()));
          });
          emit(StoreGetFavoriteSuccessState());
    }).catchError((onError){
      emit(StoreGetFavoriteErrorState());
    });
  }
  void isFav(bool isFav)
  {
    StoreModel storeModel = StoreModel(
      isFav : isFav
    );
    storeModel.isFav = !storeModel.isFav!;
    emit(StoreIsFavState());
  }
}
