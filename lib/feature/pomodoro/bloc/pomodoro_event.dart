part of 'pomodoro_bloc.dart';

abstract class PomodoroEvent extends Equatable {
  const PomodoroEvent();

  @override
  List<Object> get props => [];
}

class PomodoroStarted extends PomodoroEvent {
  const PomodoroStarted({
    required this.tour,
    required this.duration,
  });
  final int tour;
  final int duration;
}

class PomodoroPaused extends PomodoroEvent {
  const PomodoroPaused();
}

class PomodoroResumed extends PomodoroEvent {
  const PomodoroResumed({
    required this.duration,
  });
  final int duration;
}

class PomodoroTicked extends PomodoroEvent {
  const PomodoroTicked({required this.duration});
  final int duration;

  @override
  List<Object> get props => [duration];
}

class PomodoroReset extends PomodoroEvent {
  const PomodoroReset();
}

