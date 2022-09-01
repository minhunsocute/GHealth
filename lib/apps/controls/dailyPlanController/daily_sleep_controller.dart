import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/controls/dailyPlanController/tracker_controller.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../constrains.dart';
import '../../../services/auth_service.dart';
import '../../../services/data_service.dart';
import '../../data/models/sleep.dart';
import '../../global_widgets/toggle_button_ios.dart';

class DailySleepController extends GetxController with TrackerController {
  RxList<Map<String, dynamic>> stepWeek = <Map<String, dynamic>>[].obs;
  Map<String, dynamic> get sleepBasictime =>
      DataService.instance.sleepBasicTIme;
  List<Sleep> get listSleep => DataService.instance.listSleepTime;

  @override
  void onInit() {
    super.onInit();
    _calendarController.value = CalendarController();
    update();
  }

  //------------------------------------
  List<Sleep> get listSleepToday => [
        for (var item in DataService.instance.listSleepTime)
          if (item.listDate.contains(DateTime.now().weekday)) item
      ];
  List<Sleep> listSleepWithDate(int date) => [
        for (var item in DataService.instance.listSleepTime)
          if (item.listDate.contains(date)) item
      ];
  final Rx<int> _onFocus = 1.obs;
  final Rx<CalendarController> _calendarController = CalendarController().obs;
  CalendarController get calendarController => _calendarController.value;
  final List<DateTime> listDateTime = [
    for (int i = 1; i <= 30; i++) DateTime.now().subtract(Duration(days: i)),
    for (int i = 0; i <= 30; i++) DateTime.now().add(Duration(days: i))
  ];
  setFocus(int index, DateTime time) {
    _onFocus.value = index;
    _calendarController.value.displayDate = time;
    // getMealDate(time);
    // getNutriData(listDateTime[index]);
    update();
  }

  //------------------------------------add alarm

  Rx<DateTime> choseTime = DateTime.now().obs;
  DateTime tempTime = DateTime.now();

  Rx<Duration> choseDuration = const Duration(hours: 8).obs;
  Duration tempDuration = const Duration();
  var isVibrate = true.obs;

  initAll() {
    choseTime = DateTime.now().obs;
    tempTime = DateTime.now();

    choseDuration = const Duration(hours: 8).obs;
    tempDuration = const Duration();
    isVibrate = true.obs;
    listVariable = {
      'Sun': false.obs,
      'Mon': false.obs,
      'Tue': false.obs,
      'Wed': false.obs,
      'Thu': false.obs,
      'Fri': false.obs,
      'Sat': false.obs,
    };
    update();
  }

  Map<String, dynamic> listVariable = {
    'Sun': false.obs,
    'Mon': false.obs,
    'Tue': false.obs,
    'Wed': false.obs,
    'Thu': false.obs,
    'Fri': false.obs,
    'Sat': false.obs,
  };

  Map<String, dynamic> tempData = {
    'alarm': DateTime.now(),
    'bedTime': DateTime.now(),
    'isTurnOn': true,
    'isTurnOn1': true,
    'listDate': [],
  };
  Map<String, dynamic> weekDayTonInt = {
    'Sun': 7,
    'Mon': 1,
    'Tue': 2,
    'Wed': 3,
    'Thu': 4,
    'Fri': 5,
    'Sat': 6,
  };
  saveAlarmFirebase() async {
    List<int> dateSelect = [];
    listVariable.forEach((key, value) {
      if ((value as RxBool).value) {
        dateSelect.add(weekDayTonInt[key]);
      }
    });
    await firestore
        .collection('users')
        .doc(AuthService.instance.currentUser!.uid)
        .collection('sleep_basic_time')
        .doc('sleep')
        .collection('sleep_time')
        .add({
      'alarm': (choseTime.value).add((choseDuration.value)),
      'bedTime': choseTime.value,
      'isTurnOn': isVibrate.value,
      'isTurnOn1': isVibrate.value,
      'listDate': dateSelect.isNotEmpty ? dateSelect : [1, 2, 3, 4, 5, 6, 7],
    }).then((value) => print(value));
  }
  //------------------------------------

  int get onFocus => _onFocus.value;
  Widget itemBuilder(Map<String, dynamic> element, double widthDevice) {
    DateTime timeBed = element['timeBed'] as DateTime;
    DateTime timeAlarm = element['timeAlarm'] as DateTime;
    int hourBed = (DateTime.now().hour - timeBed.hour).abs();
    int minuteBed = (DateTime.now().minute - timeBed.minute).abs();
    int hourAlarm = (DateTime.now().hour - timeAlarm.hour).abs();
    int minuteAlarm = (DateTime.now().hour - timeAlarm.hour).abs();
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      width: widthDevice * 0.9,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 240, 248, 251),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          for (int i = 0; i < 3; i++)
            (i == 1)
                ? const Divider()
                : ListTile(
                    isThreeLine: true,
                    leading: Image.asset(i == 0
                        ? 'assets/images/bed.png'
                        : 'assets/images/Icon-Alaarm.png'),
                    title: RichText(
                      text: TextSpan(
                        text: '${i == 0 ? 'BedTime' : 'Alarm'}, ',
                        style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Sen',
                          fontSize: 19,
                          fontWeight: FontWeight.w600,
                        ),
                        children: [
                          TextSpan(
                              text:
                                  "${DateFormat().add_jm().format(i == 0 ? timeBed : timeAlarm)} ",
                              style: const TextStyle(
                                  fontFamily: 'Sen',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54)),
                        ],
                      ),
                    ),
                    subtitle: Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: RichText(
                        text: TextSpan(
                          text: 'in ',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[600],
                          ),
                          children: [
                            TextSpan(
                              text: '${i == 0 ? hourBed : hourAlarm}',
                              style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[600]),
                            ),
                            TextSpan(
                              text: 'hours ',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey[600],
                              ),
                            ),
                            TextSpan(
                              text: '${i == 0 ? minuteBed : minuteAlarm}',
                              style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[600]),
                            ),
                            TextSpan(
                              text: 'minutes',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                          child: ToggleButtonIos(
                              val: (i == 0)
                                  ? element['isTurnOn']
                                  : element['isTurnOn1'] as bool),
                        ),
                      ],
                    ),
                  ),
        ],
      ),
    );
  }
}
// InkWell(
                        //   onTap: () {},
                        //   child: const Icon(
                        //     Icons.more_vert,
                        //     size: 20,
                        //     color: Colors.black,
                        //   ),
                        // ),