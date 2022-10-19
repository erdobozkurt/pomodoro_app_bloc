import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro_timer/feature/history/view/history_view.dart';
import 'package:pomodoro_timer/feature/pomodoro/view/pomodoro_view.dart';
import 'package:pomodoro_timer/feature/settings/view/settings_view.dart';
import 'package:pomodoro_timer/simple_bloc_observer.dart';
import 'feature/home/view/home_view.dart';

void main() {
  Bloc.observer = PomodoroObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      routes: {
        HomeView.routeName: (context) => const HomeView(),
        PomodoroPage.routeName: (context) => const PomodoroPage(),
        HistoryView.routeName: (context) => const HistoryView(),
        SettingsView.routeName: (context) => const SettingsView(),
      },
      initialRoute: HomeView.routeName,
    );
  }
}
