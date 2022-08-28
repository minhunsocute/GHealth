import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/controls/dailyPlanController/tracker_controller.dart';

import 'dailyPlanController/daily_plan_controller.dart';
import '../data/models/workout_model.dart';
import 'package:gold_health/constrains.dart';

class WorkoutPlanController extends GetxController with TrackerController {
  TextEditingController text = TextEditingController();
  RxInt allTime = 60.obs;
  RxInt isReady = 1.obs;
  RxInt currentWorkoutIndex = 0.obs;
  RxList<Map<String, dynamic>> listWorkout = [
    {
      'name': 'Jumping Jacks',
      'time': 20,
      'ready': 10,
      'calo': 300,
    },
    {
      'name': 'Warm Up',
      'time': 20,
      'ready': 10,
      'calo': 400,
    }
  ].obs;

  var exercises = Rx<Map<String, Exercise>>({});
  var workouts = Rx<List<Workout>>([]);

  Future fetchExerciseList() async {
    try {
      CollectionReference<Map<String, dynamic>> listExercise =
          FirebaseFirestore.instance.collection('exercise');
      final data = await listExercise.get();
      print(data.size);
      for (var doc in data.docs) {
        exercises.value.putIfAbsent(doc.id, () => Exercise.fromSnap(doc));
      }
      // exercises.bindStream(
      //   firestore.collection('exercise').snapshots().map(
      //     (event) {
      //       List<Exercise> result = [];
      //       for (var item in event.docs) {
      //         result.add(Exercise.fromSnap(item));
      //       }
      //       return result;
      //     },
      //   ),
      // );
      update();
    } catch (e) {
      print('fetchExerciseList ------ ${e.toString()}');
      rethrow;
    }
  }
}
