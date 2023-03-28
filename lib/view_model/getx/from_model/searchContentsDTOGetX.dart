import 'package:cryptofile/model/dioHandling/dioHandling.dart';
import 'package:cryptofile/model/dto/searchContentsDTO.dart';
import 'package:get/get.dart';

class SearchContentsDTOGetX extends GetxController {
  List<SearchContentsDTO> searchedList = [];
  void setSearchedList(String? keyword) async {
    searchedList = [];
    DioHandling dioHandling = DioHandling();
    searchedList = await dioHandling.search(keyword ?? "");
    update();
  }
}
