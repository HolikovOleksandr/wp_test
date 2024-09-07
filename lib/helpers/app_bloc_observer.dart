import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    debugPrint('[${bloc.runtimeType}], State: $change');
  }
}
