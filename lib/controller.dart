import 'dart:developer';

import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:gridview/image_model.dart';
import "package:collection/collection.dart";

class ImageController extends GetxController {
  final allImage = RxList<ImageModel>([]);
  final selectedList = RxList<ImageModel>([]);
  final allImageDiv = RxList<List<ImageModel>>([]);
  @override
  void onReady() {
    getAlbulm();
    super.onReady();
  }

  getAlbulm() async {
    final res = await Dio().get('https://jsonplaceholder.typicode.com/photos');

    if (res.statusCode == 200) {
      for (var element in res.data) {
        final x = ImageModel.fromJson(element);
        allImage.add(x);
      }
      final detailsTypeList = groupBy(allImage, (ImageModel details) => details.albumId).entries.toList();
      for (var element in detailsTypeList) {
        allImageDiv.add(element.value);
      }
      log(allImageDiv.length.toString());
    }
  }
}
