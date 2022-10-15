import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro_timer/feature/pomodoro/bloc/pomodoro_bloc.dart';
import 'package:pomodoro_timer/feature/pomodoro/repository/ticker.dart';

import '../widget/custom_timer.dart';

class PomodoroView extends StatelessWidget {
  const PomodoroView({super.key});

  static const String routeName = '/pomodoro';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PomodoroBloc(ticker: const Ticker()),
      child: const PomodoroPage(),
    );
  }
}

class PomodoroPage extends StatelessWidget {
  const PomodoroPage({super.key});

  @override
  Widget build(BuildContext context) {
    final currentDuration =
        context.select((PomodoroBloc bloc) => bloc.state.duration);

    final minStr =
        ((currentDuration / 60) % 60).floor().toString().padLeft(2, '0');
    final secStr = (currentDuration % 60).floor().toString().padLeft(2, '0');
    double percent = 0; // 1 - currentDuration * eventsDuration / 100;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: _appBarWidget(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BlocBuilder<PomodoroBloc, PomodoroState>(
              builder: (context, state) {
                return CustomTimer(
                  seconds: secStr,
                  minutes: minStr,
                  percent: percent,
                );
              },
            ),
            const SizedBox(height: 24),
            _actionButtonsWidget(),
          ],
        ),
      ),
    );
  }

  AppBar _appBarWidget() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    );
  }

  _actionButtonsWidget() {
    return BlocBuilder<PomodoroBloc, PomodoroState>(
      buildWhen: (previous, current) =>
          previous.runtimeType != current.runtimeType,
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (state is PomodoroInitial) ...[
              _startButtonWidget(context),
            ],
            if (state is PomodoroOnProgress) ...[
              _pauseButtonWidget(context),
            ],
            if (state is PomodoroOnPause) ...[
              _resumeButtonWidget(context),
            ],
            if (state is PomodoroComplete) ...[_startButtonWidget(context)],
            if (state is PomodoroBreak) ...[_startButtonWidget(context)],
          ],
        );
      },
    );
  }

  _startButtonWidget(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        BlocProvider.of<PomodoroBloc>(context).add(PomodoroStarted(
            tour: BlocProvider.of<PomodoroBloc>(context).state.tour,
            duration: BlocProvider.of<PomodoroBloc>(context).state.duration));
      },
      child: const Icon(Icons.play_arrow),
    );
  }

  _pauseButtonWidget(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        BlocProvider.of<PomodoroBloc>(context).add(const PomodoroPaused());
      },
      child: const Icon(Icons.pause),
    );
  }

  _resumeButtonWidget(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        BlocProvider.of<PomodoroBloc>(context).add(PomodoroResumed(
            duration: BlocProvider.of<PomodoroBloc>(context).state.duration));
      },
      child: const Icon(Icons.play_arrow),
    );
  }
}
