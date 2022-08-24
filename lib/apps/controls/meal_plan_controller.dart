import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/controls/dailyPlanController/tracker_controller.dart';
import 'package:gold_health/constrains.dart';

import '../data/models/Meal.dart';
import 'dailyPlanController/daily_plan_controller.dart';

class MealPlanController extends GetxController with TrackerController {
  final Rx<List<Meal>> _listMealToday = Rx<List<Meal>>([]);
  final Rx<List<Meal>> _listMealBreakFast = Rx<List<Meal>>([]);
  final Rx<List<Meal>> _listMealLunch = Rx<List<Meal>>([]);
  List<Meal> get listMealLunch => _listMealLunch.value;
  List<Meal> get listMealToday => _listMealToday.value;
  List<Meal> get listMealBreakFast => _listMealBreakFast.value;
  @override
  void onInit() {
    super.onInit();
    getAllMeal();
    getListMealBreakFast();
    getListMealLunch();
  }

  TextEditingController text = TextEditingController();
  RxList<Map<String, dynamic>> todayListMeal = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> listMealDinner = <Map<String, dynamic>>[].obs;

  getAllMeal() async {
    _listMealToday.bindStream(
      firestore.collection('meal').snapshots().map(
        (event) {
          List<Meal> result = [];
          for (var item in event.docs) {
            //print(1);
            result.add(Meal.fromSnap(item));
          }
          return result;
        },
      ),
    );
    update();
  }

  getListMealBreakFast() async {
    _listMealBreakFast.bindStream(
      firestore.collection('meal').snapshots().map(
        (event) {
          List<Meal> result = [];
          for (var item in event.docs) {
            //print(1);
            Map<String, dynamic> temp = item.data();
            if (temp['time'] == 1) {
              result.add(Meal.fromSnap(item));
            }
          }
          return result;
        },
      ),
    );
    update();
  }

  getListMealLunch() async {
    _listMealLunch.bindStream(
      firestore.collection('meal').snapshots().map(
        (event) {
          List<Meal> result = [];
          for (var item in event.docs) {
            //print(1);
            Map<String, dynamic> temp = item.data();
            if (temp['time'] == 2) {
              result.add(Meal.fromSnap(item));
            }
          }
          return result;
        },
      ),
    );
    update();
  }
  //@override
  // fetchTracksByDate(DateTime date) {
  //   // TODO: implement fetchTracksByDate
  //   throw UnimplementedError();
  // }
}
