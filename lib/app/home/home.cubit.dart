import 'dart:math' as math;

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:v_post/config/config_screen.dart';

part 'home.state.dart';

class HomeCubit extends Cubit<HomeState> {
  double scrollOffset = 0;
  HomeCubit() : super(HomeInitial()) {}

  void scrollListener(ScrollController _scrollController) {
    scrollOffset = math.min(_scrollController.offset, SizeConfig.safeBlockVertical * 22 * 0.88);
    emit(OffsetChanged(scrollOffset));
  }
}
