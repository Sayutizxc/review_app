import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class TagsController extends GetxController {
  RxList<dynamic> tags = [].obs;

  @override
  void onInit() {
    tags.addAll([
      "Action",
      "Comedy",
      "Drama",
      "Fantasy",
      "Horror",
      "Magic",
      "Psychological",
      "Romance",
      "School",
    ]);
    List storedTags = GetStorage().read<List>('tags');
    if (!storedTags.isNull) {
      print('ada data');
      tags = storedTags.toList().obs;
      tags.toSet().toList();
    }
    ever(tags, (_) {
      GetStorage().write('tags', tags.toSet().toList());
      print('Data disimpan');
    });
    super.onInit();
  }
}
