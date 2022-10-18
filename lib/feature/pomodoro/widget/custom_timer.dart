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
    final double percent = 1 -
        (currentDuration /
            _eventsDuration(BlocProvider.of<PomodoroBloc>(context).state));

    return BlocBuilder<PomodoroBloc, PomodoroState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            shape: BoxShape.circle,
            boxShadow: const [
              BoxShadow(
                color: Colors.white,
                blurRadius: 5,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: CircularPercentIndicator(
              radius: MediaQuery.of(context).size.width * 0.32,
              lineWidth: 13.0,
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
                        blurRadius: 5,
                        spreadRadius: 5,
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
                            '$minStr : $secStr',
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // 4 icons for 4 pomodoro sessions
                              for (int i = 0; i < 3; i++)
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      color: _colorDecider(state, i),
                                      shape: BoxShape.circle,
                                    ),
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
              rotateLinearGradient: true,
              linearGradient: LinearGradient(
                colors: [
                  Colors.grey.shade200,
                  Colors.deepPurple,
                ],
              ),
              backgroundColor: Colors.grey.shade200,
              circularStrokeCap: CircularStrokeCap.round,
              maskFilter: const MaskFilter.blur(BlurStyle.inner, 3),
            ),
          ),
        );
      },
    );
  }

  Color _colorDecider(PomodoroState state, int i) {
    if (state.tour / 2 > i) {
      return ProjectColors.vividBlue;
    } else {
      return ProjectColors.aluminium;
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
}
