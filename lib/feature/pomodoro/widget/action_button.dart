import 'package:flutter/material.dart';
import '../../../core/constant/app_colors.dart';

class ActionButtonWidget extends StatelessWidget {
  const ActionButtonWidget({super.key, required this.icon, this.onPressed});

  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: ProjectColors.blueLotus,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.white,
            blurRadius: 5,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(8),
            backgroundColor: MaterialStateProperty.all(ProjectColors.blueLotus),
            shape: MaterialStateProperty.all(
              const CircleBorder(
                side: BorderSide(
                  strokeAlign: StrokeAlign.inside,
                  style: BorderStyle.solid,
                  color: ProjectColors.linkWater,
                  width: 2,
                ),
              ),
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Icon(size: 40, icon),
          ),
        ),
      ),
    );
  }
}
