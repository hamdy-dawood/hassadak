import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassadak/constants/strings.dart';
import 'package:hassadak/core/cache_helper.dart';

import 'states.dart';

class LikeSellerCubit extends Cubit<LikeSellerStates> {
  LikeSellerCubit() : super(LikeSellerInitialState());

  static LikeSellerCubit get(context) => BlocProvider.of(context);
  final dio = Dio();

  Future<void> likeSeller({required String id}) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer ${CacheHelper.getToken()}';
      final response = await dio.patch("${UrlsStrings.likeSellerUrl}/$id");
      if (response.data["status"] == "success" && response.statusCode == 201) {
        print(response.data["status"]);
      } else {
        emit(LikeSellerFailureState(msg: response.data["status"]));
      }
    } catch (e) {
      emit(LikeSellerFailureState(msg: 'An unknown error : $e'));
    }
  }
}
