import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassadak/constants/strings.dart';
import 'package:hassadak/core/cache_helper.dart';
import 'package:hassadak/pages/home/offers/model.dart';

part 'states.dart';

class AllOffersCubit extends Cubit<AllOffersStates> {
  AllOffersCubit() : super(AllOffersInitialStates());

  static AllOffersCubit get(context) => BlocProvider.of(context);

  final dio = Dio();
  final dioCacheManager = DioCacheManager(CacheConfig());
  final myOptions =
      buildCacheOptions(const Duration(days: 2), forceRefresh: false);
  OfferResponse? allOffers;

  Future<void> getAllOffers() async {
    emit(AllOffersLoadingStates());
    try {
      dio.interceptors.add(dioCacheManager.interceptor);
      dio.options.headers['Authorization'] = 'Bearer ${CacheHelper.getToken()}';
      final response =
          await dio.get(UrlsStrings.allOffersUrl, options: myOptions);
      if (response.data["status"] == "success" && response.statusCode == 200) {
        allOffers = OfferResponse.fromJson(response.data);
        // print(response.data);
        emit(AllOffersSuccessStates());
      } else {
        emit(AllOffersFailedStates(msg: response.data["status"]));
      }
    } on DioError catch (e) {
      String errorMsg;
      if (e.type == DioErrorType.cancel) {
        errorMsg = 'Request was cancelled';
      } else if (e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.sendTimeout) {
        errorMsg = 'Connection timed out';
      } else if (e.type == DioErrorType.other) {
        errorMsg = 'Received invalid status code: ${e.response?.statusCode}';
        print(errorMsg);
      } else {
        errorMsg = 'An unexpected error occurred: ${e.error}';
        print(errorMsg);
      }
    } catch (e) {
      emit(AllOffersFailedStates(msg: 'An unknown error occurred: $e'));
    }
  }
}
