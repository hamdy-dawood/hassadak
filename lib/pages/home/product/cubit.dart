import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassadak/constants/strings.dart';

import 'model.dart';

part 'states.dart';

class ProductCubit extends Cubit<ProductStates> {
  ProductCubit() : super(ProductInitialStates());

  static ProductCubit get(context) => BlocProvider.of(context);

  ProductModel? product;

  Future<void> getProduct({required String id}) async {
    emit(ProductLoadingStates());
    try {
      final response =
          await Dio().get("${UrlsStrings.allProductsUrl}?categoryId=$id");
      if (response.data["status"] == "success" && response.statusCode == 200) {
        product = ProductModel.fromJson(response.data);
        // print(response.data);
        emit(ProductSuccessStates());
      } else {
        emit(ProductFailedStates(msg: response.data["status"]));
      }
    } on DioError catch (e) {
      emit(ProductFailedStates(msg: "$e"));
    }
  }
}
