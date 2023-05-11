import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassadak/constants/strings.dart';
import 'package:hassadak/core/cache_helper.dart';

import 'model.dart';

part 'states.dart';

class AllFavouritesCubit extends Cubit<AllFavouritesStates> {
  AllFavouritesCubit() : super(AllFavouritesInitialStates());

  static AllFavouritesCubit get(context) => BlocProvider.of(context);

  FavouriteResponse? allFavourites;
  final dio = Dio();

  Future<void> getAllFavourites() async {
    emit(AllFavouritesLoadingStates());
    try {
      dio.options.headers['Authorization'] = 'Bearer ${CacheHelper.getToken()}';
      final response = await dio.get(UrlsStrings.allFavouritesUrl);
      if (response.data["status"] == "success" && response.statusCode == 200) {
        allFavourites = FavouriteResponse.fromJson(response.data);
        emit(AllFavouritesSuccessStates());
      } else {
        emit(AllFavouritesFailedStates(msg: response.data["status"]));
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
      } else {
        errorMsg = 'An unexpected error occurred: ${e.error}';
        print(errorMsg);
        emit(NetworkErrorState());
      }
    } catch (e) {
      emit(AllFavouritesFailedStates(msg: 'An unknown error occurred: $e'));
    }
  }
}
