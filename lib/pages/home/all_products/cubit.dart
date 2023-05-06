import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassadak/constants/strings.dart';

import 'model.dart';

part 'states.dart';

class AllProductsCubit extends Cubit<AllProductsStates> {
  AllProductsCubit() : super(AllProductsInitialState());
  final _allProductsController =
      StreamController<AllProductsStates>.broadcast();

  Stream<AllProductsStates> get allProductsStream =>
      _allProductsController.stream;

  static AllProductsCubit get(context) => BlocProvider.of(context);

  AllProductsResponse? allProducts;
  // bool isLoved = false;

  Future<void> getAllProducts({String? id = ""}) async {
    _allProductsController.add(AllProductsLoadingState());
    emit(AllProductsLoadingState());
    try {
      final response = await Dio().get("${UrlsStrings.allProductsUrl}$id");
      if (response.data["status"] == "success" && response.statusCode == 200) {
        allProducts = AllProductsResponse.fromJson(response.data);
        _allProductsController.add(AllProductsSuccessState());
        emit(AllProductsSuccessState());
      } else {
        emit(AllProductsFailedState(msg: response.data["status"]));
      }
    } on DioError catch (e) {
      emit(AllProductsFailedState(msg: "$e"));
    }
  }

  // changeFavourite() {
  //   isLoved = !isLoved;
  //   emit(ChangeFavouriteState());
  // }
}
