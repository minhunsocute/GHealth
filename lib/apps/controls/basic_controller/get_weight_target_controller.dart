import 'package:get/get.dart';
import 'package:gold_health/apps/controls/sign_up_controller.dart';
import 'package:intl/intl.dart';

import '../../../constains.dart';
import '../../data/enums/app_enums.dart';
import '../../global_widgets/dialog/yes_no_dialog.dart';
import '../auth_controller.dart';
import 'basic_controller.dart';

class GetWeightTargetC extends GetxController with BasicController {
  RxInt weight = 1.obs;
  final signUpC = Get.find<SignUpC>();
  var list = [for (var i = 1; i <= 200; i++) i];
  @override
  // void OnInit() {
  //   super.onInit();
  // }

  void nextBtnClick() {
    signUpC.basicProfile!.value.weightTarget = weight.value;
    print(signUpC.basicProfile!.value.weight);
    Get.dialog(
      YesNoDialog(
        press: () async {
          String result = await AuthC().signUp(
            name: signUpC.basicProfile!.value.name,
            username: signUpC.basicProfile!.value.username,
            password: signUpC.basicProfile!.value.password,
            height: signUpC.basicProfile!.value.height,
            weight: signUpC.basicProfile!.value.weight,
            heightTarget: signUpC.basicProfile!.value.heightTarget,
            weightTarget: signUpC.basicProfile!.value.weightTarget,
            dateOfBirth: signUpC.basicProfile!.value.dateOfBirth,
            gender: signUpC.basicProfile!.value.gender,
            duration: signUpC.basicProfile!.value.duration,
            image: signUpC.image,
          );
          //ignore: avoid_print
          print(result);
          if (result == "Create account is success") {
            await firebaseAuth.signInWithEmailAndPassword(
                email: signUpC.basicProfile!.value.username,
                password: signUpC.basicProfile!.value.password);

            Get.find<AuthC>();
          }
        },
        question: 'Confirm Information',
        title1:
            'Name: ${signUpC.basicProfile!.value.name}\nDate of birth: ${DateFormat.yMd().format(signUpC.basicProfile!.value.dateOfBirth)} \n',
        title2:
            'Current Height: ${signUpC.basicProfile!.value.height}\nCurrent Weight: ${signUpC.basicProfile!.value.weight}\nDuration: ${listTimesString[signUpC.basicProfile!.value.duration]}',
      ),
    );
  }
}
