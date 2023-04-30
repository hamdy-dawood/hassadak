import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassadak/constants/strings.dart';
import 'package:hassadak/core/cache_helper.dart';

import 'model.dart';

part 'states.dart';

class AllFavouritesCubit extends Cubit<AllFavouritesStates> {
  AllFavouritesCubit() : super(AllFavouritesInitialStates());
  final _allFavouritesController =
      StreamController<AllFavouritesStates>.broadcast();

  Stream<AllFavouritesStates> get allFavouritesStream =>
      _allFavouritesController.stream;

  static AllFavouritesCubit get(context) => BlocProvider.of(context);

  FavouriteResponse? allFavourites;
  final dio = Dio();
  Future<void> getAllFavourites() async {

    _allFavouritesController.add(AllFavouritesLoadingStates());
    emit(AllFavouritesLoadingStates());

    try {
      dio.options.headers['Authorization'] = 'Bearer ${CacheHelper.getToken()}';
      final response =await dio.get(UrlsStrings.allFavouritesUrl);

      if (response.data["status"] == "success" && response.statusCode == 200) {
        allFavourites = FavouriteResponse.fromJson(response.data);
        _allFavouritesController.add(AllFavouritesSuccessStates());
        print(response.data);
        print(allFavourites!.products);
        emit(AllFavouritesSuccessStates());
      } else {
        emit(AllFavouritesFailedStates(msg: response.data["status"]));
      }
    } on DioError catch (e) {
      emit(AllFavouritesFailedStates(msg: "$e"));
    }
  }
}
