import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:pomodoro_timer/core/constant/app_colors.dart';
import '../bloc/pomodoro_bloc.dart';

class CustomTimer extends StatelessWidget {
  const CustomTimer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentDuration =
        context.select((PomodoroBloc bloc) => bloc.state.duration);
    final String minStr =
        ((currentDuration / 60) % 60).floor().toString().padLeft(2, '0');
    final String secStr =
        (currentDuration % 60).floor().toString().padLeft(2, '0');
    final double percent = _percentOptimizer(
        BlocProvider.of<PomodoroBloc>(context).state, currentDuration, context);

    return BlocBuilder<PomodoroBloc, PomodoroState>(
      builder: (context, state) {
        return Container(
          decoration: const BoxDecoration(
            color: ProjectColors.linkWater,
            shape: BoxShape.circle,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: CircularPercentIndicator(
              radius: MediaQuery.of(context).size.width * 0.32,
              lineWidth: 12.0,
              percent: percent,
              center: Padding(
                padding: const EdgeInsets.all(30),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    shape: BoxShape.circle,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.white,
                        blurRadius: 8,
                        spreadRadius: 8,
                      ),
                    ],
                  ),
                  child: SizedBox(
                    width: 300,
                    height: 300,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '$minStr:$secStr',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                  color: ProjectColors.gravel,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.8,
                                ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // 3 icons for 3 pomodoro sessions
                              for (int i = 0; i < 3; i++)
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Image.asset(
                                    _pathDecider(
                                      state,
                                      i,
                                    ),
                                    width: 24,
                                    height: 24,
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // rotateLinearGradient: true,
              // linearGradient: LinearGradient(
              //   begin: Alignment.topCenter,
              //   end: Alignment.bottomCenter,
              //   tileMode: TileMode.mirror,
              //   colors: _colorDecider(state),
              // ),
              progressColor: _colorDecider(state),
              backgroundColor: ProjectColors.linkWater,
              circularStrokeCap: CircularStrokeCap.round,
              maskFilter: const MaskFilter.blur(BlurStyle.inner, 1),
            ),
          ),
        );
      },
    );
  }

  Color _colorDecider(PomodoroState state) {
    if (state.tour % 2 == 0) {
      return ProjectColors.blueLotus;
    } else {
      return Colors.orange.shade800;
    }
  }

  int _eventsDuration(PomodoroState state) {
    switch (state.tour) {
      case 0:
        return 25;
      case 1:
        return 5;
      case 2:
        return 25;
      case 3:
        return 5;
      case 4:
        return 25;
      case 5:
        return 15;
      default:
        return 0;
    }
  }

  String _pathDecider(PomodoroState state, int i) {
    if (state.tour / 2 > i) {
      return 'assets/icons/ic_tomato_red.png';
    } else {
      return 'assets/icons/ic_tomato.png';
    }
  }

  double _percentOptimizer(
      PomodoroState state, int currentDuration, BuildContext context) {
    if (state is PomodoroInitial || state is PomodoroBreak) {
      return 1 - (currentDuration / _eventsDuration(state));
    }
    return 1 - (currentDuration / _eventsDuration(state)) - 0.02;
  }
}
