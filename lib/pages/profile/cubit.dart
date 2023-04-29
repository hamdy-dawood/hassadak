// import 'package:dio/dio.dart';
//
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hassadak/constants/strings.dart';
// import 'package:hassadak/core/cache_helper.dart';
//
// import 'states.dart';
//
// class ProfileCubit extends Cubit<ProfileStates> {
//   ProfileCubit() : super(ProfileInitialState());
//
//   static ProfileCubit get(context) => BlocProvider.of(context);
//
//   Future<void> profile() async {
//     emit(ProfileLoadingState());
//     try {
//       final response = await Dio().post(UrlsStrings.loginUrl, data: {
//         "email": CacheHelper.getEmail(),
//         "password":  CacheHelper.getPass(),
//       });
//       if (response.data["status"] == "success" && response.statusCode == 200) {
//         emit(ProfileSuccessState());
//       } else {
//         emit(ProfileFailureState(msg: response.data["status"]));
//       }
//     } on DioError catch (e) {
//       emit(ProfileFailureState(msg: "$e"));
//     }
//   }
//
// }
