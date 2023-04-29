import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassadak/constants/strings.dart';

import 'model.dart';

part 'states.dart';

class AllProductsCubit extends Cubit<AllProductsStates> {
  AllProductsCubit() : super(AllProductsInitialStates());
  final _allProductsController =
      StreamController<AllProductsStates>.broadcast();

  Stream<AllProductsStates> get allProductsStream =>
      _allProductsController.stream;

  static AllProductsCubit get(context) => BlocProvider.of(context);

  AllProductsResponse? allProducts;

  Future<void> getAllProducts({String? id = ""}) async {
    _allProductsController.add(AllProductsLoadingStates());
    emit(AllProductsLoadingStates());
    try {
      final response = await Dio().get("${UrlsStrings.allProductsUrl}$id");
      if (response.data["status"] == "success" && response.statusCode == 200) {
        allProducts = AllProductsResponse.fromJson(response.data);
        _allProductsController.add(AllProductsSuccessStates());
        emit(AllProductsSuccessStates());
      } else {
        emit(AllProductsFailedStates(msg: response.data["status"]));
      }
    } on DioError catch (e) {
      emit(AllProductsFailedStates(msg: "$e"));
    }
  }
}
