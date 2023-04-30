import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassadak/constants/strings.dart';
import 'package:hassadak/core/cache_helper.dart';

part 'states.dart';

class DeleteFavCubit extends Cubit<DeleteFavStates> {
  DeleteFavCubit() : super(DeleteFavInitialStates());


  static DeleteFavCubit get(context) => BlocProvider.of(context);
  
  final dio = Dio();
  Future<void> deleteFav({required String id}) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer ${CacheHelper.getToken()}';
      final response = await dio.patch("${UrlsStrings.allProductsUrl}/$id/unlove");

      if (response.data["status"] == "success" && response.statusCode == 200) {
        
        emit(DeleteFavSuccessStates());
      } else {
        emit(DeleteFavFailedStates(msg: response.data["status"]));
      }
    } on DioError catch (e) {
      emit(DeleteFavFailedStates(msg: "$e"));
    }
  }
}
