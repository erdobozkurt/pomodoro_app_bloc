
// ignore_for_file: avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';

class PomodoroObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('${bloc.runtimeType} $change');
  }
}