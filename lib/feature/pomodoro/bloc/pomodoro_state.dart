part of 'pomodoro_bloc.dart';

abstract class PomodoroState extends Equatable {
  final int tour;
  final int duration;

  const PomodoroState({required this.tour, required this.duration});

  @override
  List<Object> get props => [
        tour,
        duration,
      ];
}

//* Pomodoro session states

class PomodoroInitial extends PomodoroState {
  const PomodoroInitial({required super.tour, required super.duration});
}

class PomodoroOnPause extends PomodoroState {
  const PomodoroOnPause({required super.tour, required super.duration});
}

class PomodoroOnProgress extends PomodoroState {
  const PomodoroOnProgress({required super.tour, required super.duration});
}

class PomodoroComplete extends PomodoroState {
  const PomodoroComplete({required super.tour, required super.duration});
}

class PomodoroBreak extends PomodoroState {
  const PomodoroBreak({required super.tour, required super.duration});
}

class PomodoroOnReset extends PomodoroState {
  const PomodoroOnReset({required super.tour, required super.duration});
}
