import 'package:get/get.dart';

class MainPageGetX extends GetxController {
  List<bool> selectedToggle = [true, false];
  void setSelectedToggle(int i) {
    if (i == 0) {
      selectedToggle[0] = true;
      selectedToggle[1] = false;
    } else {
      selectedToggle[0] = false;
      selectedToggle[1] = true;
    }
    update();
  }
}
