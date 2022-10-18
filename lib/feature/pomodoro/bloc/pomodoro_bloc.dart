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
    on<PomodoroReset>(_onReset);
  }

  final Ticker _ticker;
  static const int _duration = 25;
  static const int _shortBreak = 5;
  static const int _longBreak = 15;
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

  void _onReset(PomodoroReset event, Emitter<PomodoroState> emit) {
    _tickerSubscription?.cancel();
    emit(const PomodoroInitial(duration: _duration, tour: _tour));
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
        return PomodoroComplete(duration: 0, tour: tour);

      default:
        return PomodoroComplete(duration: _duration, tour: tour);
    }
  }
}
