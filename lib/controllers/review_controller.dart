import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:review_app/models/review_model.dart';

class ReviewController extends GetxController {
  var reviews = List<ReviewModel>().obs;

  @override
  void onInit() {
    List storedReviews = GetStorage().read<List>('reviews');
    if (!storedReviews.isNull) {
      reviews = storedReviews.map((e) => ReviewModel.fromJson(e)).toList().obs;
    }
    ever(reviews, (_) {
      GetStorage().write('reviews', reviews.toList());
    });
    super.onInit();
  }
}
