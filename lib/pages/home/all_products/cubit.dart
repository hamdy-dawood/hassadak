import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassadak/constants/strings.dart';
import 'package:hassadak/core/cache_helper.dart';

import 'model.dart';

part 'states.dart';

class AllProductsCubit extends Cubit<AllProductsStates> {
  AllProductsCubit() : super(AllProductsInitialState());
  final _allProductsController =
      StreamController<AllProductsStates>.broadcast();

  Stream<AllProductsStates> get allProductsStream =>
      _allProductsController.stream;

  static AllProductsCubit get(context) => BlocProvider.of(context);
  final dio = Dio();
  AllProductsResponse? allProducts;

  Future<void> getAllProducts({String? id = ""}) async {
    _allProductsController.add(AllProductsLoadingState());
    emit(AllProductsLoadingState());
    try {
       dio.options.headers['Authorization'] = 'Bearer ${CacheHelper.getToken()}';
      final response = await dio.get("${UrlsStrings.allProductsUrl}$id");
      if (response.data["status"] == "success" && response.statusCode == 200) {
        allProducts = AllProductsResponse.fromJson(response.data);
        _allProductsController.add(AllProductsSuccessState());
        emit(AllProductsSuccessState());
        print(response.data);
      } else {
        emit(AllProductsFailedState(msg: response.data["status"]));
      }
    } on DioError catch (e) {
      String errorMsg;
      if (e.type == DioErrorType.cancel) {
        errorMsg = 'Request was cancelled';
      } else if (e.type == DioErrorType.connectionTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.sendTimeout) {
        errorMsg = 'Connection timed out';
      } else if (e.type == DioErrorType.badResponse) {
        errorMsg = 'Received invalid status code: ${e.response?.statusCode}';
        print("Received invalid status code: ${e.response?.statusCode}");
        print(errorMsg);
      } else {
        errorMsg = 'An unexpected error occurred: ${e.error}';
        print(errorMsg);
        emit(NetworkErrorState());
      }
    } catch (e) {
      emit(AllProductsFailedState(msg: 'An unknown error occurred: $e'));
    }
  }
}
