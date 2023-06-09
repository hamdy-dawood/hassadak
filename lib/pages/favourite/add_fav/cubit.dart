import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassadak/constants/strings.dart';
import 'package:hassadak/core/cache_helper.dart';

part 'states.dart';

class AddFavCubit extends Cubit<AddFavStates> {
  AddFavCubit() : super(AddFavInitialStates());

  static AddFavCubit get(context) => BlocProvider.of(context);

  final dio = Dio();

  Map<int, FavStatus> favStatusMap = {};
  Map<String, FavStatus> favStatusMapId = {};

  Future<void> addFav({required String id}) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer ${CacheHelper.getToken()}';
      final response =
          await dio.patch("${UrlsStrings.allProductsUrl}/$id/love");
      if (response.data["status"] == "success" && response.statusCode == 200) {
        emit(AddFavSuccessStates());
      } else {
        emit(AddFavFailedStates(msg: response.data["status"]));
      }
    } on DioError catch (e) {
      emit(AddFavFailedStates(msg: "$e"));
    }
  }

  void changeFavourite(int index, bool isLove) {
    if (favStatusMap.containsKey(index)) {
      favStatusMap[index]!.isLoved = !isLove;
    } else {
      favStatusMap[index] = FavStatus(!isLove);
    }
    emit(ChangeFavStates(Map.from(favStatusMap)));
  }

  void changeFavouriteId(String id, bool isLove) {
    if (favStatusMapId.containsKey(id)) {
      favStatusMapId[id]!.isLoved = !isLove;
    } else {
      favStatusMapId[id] = FavStatus(!isLove);
    }
    emit(ChangeFavStates(Map.from(favStatusMapId)));
  }
}
