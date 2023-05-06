import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassadak/constants/strings.dart';
import 'package:hassadak/core/cache_helper.dart';

import 'model.dart';

part 'states.dart';

class AllSellersCubit extends Cubit<AllSellersStates> {
  AllSellersCubit() : super(AllSellersInitialState());

  static AllSellersCubit get(context) => BlocProvider.of(context);
  final dio = Dio();

  AllSellersResponse? allSellers;

  Future<void> getAllSellers() async {
    emit(AllSellersLoadingState());
    try {
      dio.options.headers['Authorization'] = 'Bearer ${CacheHelper.getToken()}';
      final response =
          await dio.get(UrlsStrings.allSellersUrl, queryParameters: {
        "role": "seller",
      });
      if (response.data["status"] == "success" && response.statusCode == 200) {
        allSellers = AllSellersResponse.fromJson(response.data);
        emit(AllSellersSuccessState());
      } else {
        emit(AllSellersFailedState(msg: response.data["status"]));
      }
    } on DioError catch (e) {
      emit(AllSellersFailedState(msg: "$e"));
    }
  }
}
