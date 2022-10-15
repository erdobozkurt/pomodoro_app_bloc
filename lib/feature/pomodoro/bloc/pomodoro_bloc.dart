// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../repository/ticker.dart';

part 'pomodoro_event.dart';
part 'pomodoro_state.dart';

class PomodoroBloc extends Bloc<PomodoroEvent, PomodoroState> {
  PomodoroBloc({required Ticker ticker})
      : _ticker = ticker,
        super(const PomodoroInitial(duration: _duration, tour: _tour)) {
    on<PomodoroStarted>(_onStarted);
    on<PomodoroPaused>(_onPaused);
    on<PomodoroResumed>(_onResumed);
    on<PomodoroTicked>(_onTicked);
  }

  final Ticker _ticker;
  static const int _duration = 3;
  static const int _shortBreak = 1;
  static const int _longBreak = 2;
  static const int _tour = 0;

  StreamSubscription<int>? _tickerSubscription;

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  void _onStarted(PomodoroStarted event, Emitter<PomodoroState> emit) {
    emit(PomodoroOnProgress(duration: event.duration, tour: event.tour));

    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker.tick(ticks: event.duration).listen(
          (duration) => add(PomodoroTicked(duration: duration)),
        );
  }

  void _onPaused(PomodoroPaused event, Emitter<PomodoroState> emit) {
    _tickerSubscription?.pause();
    emit(PomodoroOnPause(duration: state.duration, tour: state.tour));
  }

  void _onResumed(PomodoroResumed event, Emitter<PomodoroState> emit) {
    _tickerSubscription?.resume();
    emit(PomodoroOnProgress(duration: state.duration, tour: state.tour));
  }

  void _onTicked(PomodoroTicked event, Emitter<PomodoroState> emit) {
    emit(event.duration >= 0
        ? PomodoroOnProgress(duration: event.duration, tour: state.tour)
        : _isBreakOrComplete(state.tour));
  }

  _isBreakOrComplete(int tour) {
    switch (tour) {
      case 0:
        return PomodoroBreak(duration: _shortBreak, tour: tour + 1);
      case 1:
        return PomodoroBreak(duration: _duration, tour: tour + 1);
      case 2:
        return PomodoroBreak(duration: _shortBreak, tour: tour + 1);
      case 3:
        return PomodoroBreak(duration: _duration, tour: tour + 1);
      case 4:
        return PomodoroBreak(duration: _longBreak, tour: tour + 1);
      case 5:
        return const PomodoroComplete(duration: _duration, tour: 0); 

      default:
        return PomodoroComplete(duration: _duration, tour: tour);
    }
  }
}
