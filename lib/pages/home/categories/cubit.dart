import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassadak/constants/strings.dart';
import 'package:hassadak/core/cache_helper.dart';

import 'model.dart';

part 'states.dart';

class AllCategoriesCubit extends Cubit<AllCategoriesStates> {
  AllCategoriesCubit() : super(AllCategoriesInitialStates());

  static AllCategoriesCubit get(context) => BlocProvider.of(context);

  AllCategories? allCategories;
  final dio = Dio();
  final _allCategoriesController =
      StreamController<AllCategoriesStates>.broadcast();

  Stream<AllCategoriesStates> get allCategoriesStream =>
      _allCategoriesController.stream;

  Future<void> getAllCategories() async {
    _allCategoriesController.add(AllCategoriesLoadingStates());
    emit(AllCategoriesLoadingStates());
    try {
      dio.options.headers['Authorization'] = 'Bearer ${CacheHelper.getToken()}';
      final response = await dio.get(UrlsStrings.allCategoriesUrl);
      if (response.data["status"] == "success" && response.statusCode == 200) {
        allCategories = AllCategories.fromJson(response.data);
        _allCategoriesController
            .add(AllCategoriesSuccessStates(id: allCategories!.data.doc));
        emit(AllCategoriesSuccessStates(id: allCategories!.data.doc));
      } else {
        emit(AllCategoriesFailedStates(msg: response.data["status"]));
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
      }
      _allCategoriesController.add(AllCategoriesFailedStates(msg: errorMsg));
    } catch (e) {
      _allCategoriesController
          .add(AllCategoriesFailedStates(msg: 'An unknown error occurred: $e'));
    }
  }

  void dispose() {
    _allCategoriesController.close();
  }
}
