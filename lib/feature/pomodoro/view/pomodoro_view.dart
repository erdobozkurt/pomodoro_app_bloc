import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro_timer/core/constant/app_colors.dart';
import 'package:pomodoro_timer/feature/history/view/history_view.dart';
import 'package:pomodoro_timer/feature/pomodoro/bloc/pomodoro_bloc.dart';
import 'package:pomodoro_timer/feature/pomodoro/repository/ticker.dart';
import 'package:pomodoro_timer/feature/pomodoro/widget/action_button.dart';
import 'package:pomodoro_timer/feature/settings/view/settings_view.dart';
import '../widget/custom_bottom_navbar.dart';
import '../widget/custom_timer.dart';

class PomodoroPage extends StatefulWidget {
  const PomodoroPage({super.key});

  static const String routeName = '/pomodoro';

  @override
  State<PomodoroPage> createState() => _PomodoroPageState();
}

class _PomodoroPageState extends State<PomodoroPage> {
  int currentIndex = 1;

  List screens = [
    const HistoryView(),
    const PomodoroView(),
    const SettingsView(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PomodoroBloc(ticker: const Ticker()),
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        bottomNavigationBar: BottomNavBar(
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
        ),
        appBar: _appBarWidget(context),
        body: screens[currentIndex],
      ),
    );
  }

  AppBar _appBarWidget(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded,
            color: ProjectColors.gravel, size: 20),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.more_vert_rounded,
            color: ProjectColors.gravel,
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}

class PomodoroView extends StatelessWidget {
  const PomodoroView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CustomTimer(),
          const SizedBox(height: 32),
          _actionButtonsWidget(),
        ],
      ),
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
            if (state is PomodoroInitial) ...[_startButtonWidget(context)],
            if (state is PomodoroOnProgress) ...[_pauseButtonWidget(context)],
            if (state is PomodoroOnPause) ...[_resumeButtonWidget(context)],
            if (state is PomodoroComplete) ...[_resetButtonWidget(context)],
            if (state is PomodoroBreak) ...[_startButtonWidget(context)],
          ],
        );
      },
    );
  }

  _startButtonWidget(BuildContext context) {
    return ActionButtonWidget(
        icon: Icons.play_arrow_rounded,
        onPressed: () {
          BlocProvider.of<PomodoroBloc>(context).add(PomodoroStarted(
              tour: BlocProvider.of<PomodoroBloc>(context).state.tour,
              duration: BlocProvider.of<PomodoroBloc>(context).state.duration));
        });
  }

  _pauseButtonWidget(BuildContext context) {
    return ActionButtonWidget(
        icon: Icons.pause_rounded,
        onPressed: () {
          BlocProvider.of<PomodoroBloc>(context).add(const PomodoroPaused());
        });
  }

  _resumeButtonWidget(BuildContext context) {
    return ActionButtonWidget(
        icon: Icons.play_arrow_rounded,
        onPressed: () {
          BlocProvider.of<PomodoroBloc>(context).add(PomodoroResumed(
              duration: BlocProvider.of<PomodoroBloc>(context).state.duration));
        });
  }

  _resetButtonWidget(BuildContext context) {
    return ActionButtonWidget(
        icon: Icons.refresh_rounded,
        onPressed: () {
          BlocProvider.of<PomodoroBloc>(context).add(const PomodoroReset());
        });
  }
}
