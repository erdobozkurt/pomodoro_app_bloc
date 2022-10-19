import 'package:flutter/material.dart';

import '../../../core/constant/app_colors.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar(
      {super.key, required this.currentIndex, required this.onTap});

  final int currentIndex;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.088,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(60)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 2,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: ProjectColors.gravel,
          unselectedItemColor: ProjectColors.aluminium,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: (index) => onTap(index),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.analytics_outlined),
              label: 'History',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.timer_outlined,
              ),
              label: 'Timer',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.settings_outlined,
              ),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
