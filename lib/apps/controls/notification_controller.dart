import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class NotificationController extends GetxController {
  Map<DateTime, Map<String, dynamic>> notifications = {
    DateTime.now().subtract(const Duration(minutes: 5)): {
      'icon': CircleAvatar(
        child: SvgPicture.asset(
          'assets/icons/cake_2.svg',
        ),
      ),
      'title': 'Hey, it\'s time for lunch',
    },
    DateTime.now().subtract(const Duration(hours: 2)): {
      'icon': CircleAvatar(
        backgroundColor: const Color.fromARGB(255, 230, 211, 233),
        child: SvgPicture.asset(
          'assets/icons/woman_workout.svg',
        ),
      ),
      'title': 'Don\'t miss your abs workout',
    },
    DateTime.now().subtract(const Duration(hours: 6)): {
      'icon': CircleAvatar(
        child: SvgPicture.asset(
          'assets/icons/cake.svg',
        ),
      ),
      'title': 'Hey, let\'t add some meal for your body',
    },
    DateTime.now().subtract(const Duration(days: 10)): {
      'icon': CircleAvatar(
        child: SvgPicture.asset(
          'assets/icons/man_workout.svg',
        ),
      ),
      'title': 'Congratulation, you have finished your workout',
    },
    DateTime.now().subtract(const Duration(days: 50)): {
      'icon': CircleAvatar(
        child: SvgPicture.asset(
          'assets/icons/cake.svg',
        ),
      ),
      'title': 'Hey, it\'s time for lunch',
    },
    DateTime.now().subtract(const Duration(days: 100)): {
      'icon': CircleAvatar(
        backgroundColor: const Color.fromARGB(255, 230, 211, 233),
        child: SvgPicture.asset(
          'assets/icons/cake.svg',
        ),
      ),
      'title': 'Ups, You have missed your lowerbody workout',
    },
  }.obs;

  bool get isEmptyNotify {
    if (notifications.isEmpty) return true;
    return false;
  }
}
