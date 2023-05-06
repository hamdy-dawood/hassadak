import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassadak/constants/strings.dart';
import 'package:hassadak/pages/home/offers/model.dart';

part 'states.dart';

class AllOffersCubit extends Cubit<AllOffersStates> {
  AllOffersCubit() : super(AllOffersInitialStates());

  static AllOffersCubit get(context) => BlocProvider.of(context);

  OfferResponse? allOffers;

  Future<void> getAllOffers() async {
    emit(AllOffersLoadingStates());
    try {
      final response = await Dio().get(UrlsStrings.allOffersUrl);
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
      } else if (e.type == DioErrorType.connectionTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.sendTimeout) {
        errorMsg = 'Connection timed out';
      } else if (e.type == DioErrorType.badResponse) {
        errorMsg = 'Received invalid status code: ${e.response?.statusCode}';
      } else {
        errorMsg = 'An unexpected error occurred: ${e.error}';
      }
    } catch (e) {
      AllOffersFailedStates(msg: 'An unknown error occurred: $e');
    }
  }
}
