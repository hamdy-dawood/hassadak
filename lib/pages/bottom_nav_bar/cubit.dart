import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'controller.dart';
import 'states.dart';

class NavBarCubit extends Cubit<NavBarStates> {
  NavBarCubit() : super(NavBarInitialState());

  static NavBarCubit get(context) => BlocProvider.of(context);
  final controller = NavBarController();
  var scaffoldKey = GlobalKey<ScaffoldState>();

  selectItem(index) {
    controller.selectedItem = index;
    emit(SelectItemState());
  }
}
