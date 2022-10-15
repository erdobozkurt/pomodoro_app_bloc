import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class CustomTimer extends StatelessWidget {
  const CustomTimer({
    required this.percent,
    required this.seconds,
    required this.minutes,
    Key? key,
  }) : super(key: key);

  final double percent;
  final String seconds;
  final String minutes;

  @override
  Widget build(BuildContext context) {
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
            child: Center(
              child: Text(
                '$minutes : $seconds',
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
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
  }
}
