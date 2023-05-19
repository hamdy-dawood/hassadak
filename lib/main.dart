import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/cache_helper.dart';
import 'core/snack_and_navigate.dart';
import 'pages/favourite/add_fav/cubit.dart';
import 'pages/home/all_products/cubit.dart';
import 'pages/home/categories/cubit.dart';
import 'pages/home/offers/cubit.dart';
import 'pages/profile/personal_data/cubit.dart';
import 'pages/reviews/add_review/cubit.dart';
import 'pages/reviews/cubit.dart';
import 'pages/reviews/delete_review/cubit.dart';
import 'pages/reviews/edit_review/cubit.dart';
import 'pages/splash/view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => AllProductsCubit()),
            BlocProvider(create: (context) => AllOffersCubit()),
            BlocProvider(create: (context) => AllCategoriesCubit()),
            BlocProvider(create: (context) => AddFavCubit()),
            BlocProvider(create: (context) => ReviewsCubit()),
            BlocProvider(create: (context) => AddReviewsCubit()),
            BlocProvider(create: (context) => DeleteReviewsCubit()),
            BlocProvider(create: (context) => EditReviewsCubit()),
            BlocProvider(create: (context) => PersonalDataCubit()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Hassadak',
            navigatorKey: navigatorKey,
            theme: ThemeData(
              platform: TargetPlatform.iOS,
            ),
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('ar', 'AE'),
            ],
            locale: const Locale('ar', 'AE'),
            home: child,
          ),
        );
      },
      child: const SplashView(),
    );
  }
}
