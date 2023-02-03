import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:image_saerch/data/data_source/result.dart';
import 'package:image_saerch/domain/model/photo_model.dart';
import 'package:image_saerch/domain/repository/photo_api_repository.dart';
import 'package:image_saerch/presentation/home/home_view_model.dart';

void main() {
  test('Stream 이 잘 동작해야한다.', () async {
    // viewModel 로 따로 분리를 했기에 이렇게 test 코드로 작성가능한 것이다.
    final viewModel = HomeViewModel(FakePhotoApiRepository());

    await viewModel.fetch('apple');

    final List<PhotoModel> result =
        fakeJson.map((e) => PhotoModel.fromJson(e)).toList();

    expect(viewModel.photos, result);
  });
}

// 임의의 클래스를 만들어 주입시켜준다.
class FakePhotoApiRepository extends PhotoApiRepository {
  @override
  Future<Result<List<PhotoModel>>> fetch(String query) async {
    // 딜레이를 준다.
    Future.delayed(const Duration(milliseconds: 500));

    // 가짜데이터를 PhotoModel.fromJson 에 매핑해준다.
    return Result.success(fakeJson.map((e) => PhotoModel.fromJson(e)).toList());
  }
}

// 가짜 데이터를 그대로 넣어준다.
List<Map<String, dynamic>> fakeJson = [
  {
    "id": 2295434,
    "pageURL":
        "https://pixabay.com/photos/spring-bird-bird-tit-spring-blue-2295434/",
    "type": "photo",
    "tags": "spring bird, bird, tit",
    "previewURL":
        "https://cdn.pixabay.com/photo/2017/05/08/13/15/spring-bird-2295434_150.jpg",
    "previewWidth": 150,
    "previewHeight": 99,
    "webformatURL":
        "https://pixabay.com/get/g2d0806cf3ecb54379ef7b49fff34b7fe14aa9befa24eb94b5c5dd0ba5d130ff771c55d76487ae03401c8b87fdcaba75b3eac014958513a6438b14516ba38fcd2_640.jpg",
    "webformatWidth": 640,
    "webformatHeight": 426,
    "largeImageURL":
        "https://pixabay.com/get/g9963a4416a7094b2d7fc79081785913be73c06e8b9096c4cc2a3f2216ac7c02a7574c31f47d02d2d1f3e0cc0ec76166cc0a85df1bd7b96eafed62def3a82d41c_1280.jpg",
    "imageWidth": 5363,
    "imageHeight": 3575,
    "imageSize": 2938651,
    "views": 621251,
    "downloads": 358054,
    "collections": 2053,
    "likes": 1981,
    "comments": 249,
    "user_id": 334088,
    "user": "JillWellington",
    "userImageURL":
        "https://cdn.pixabay.com/user/2018/06/27/01-23-02-27_250x250.jpg"
  },
  {
    "id": 3063284,
    "pageURL":
        "https://pixabay.com/photos/rose-flower-petal-floral-noble-3063284/",
    "type": "photo",
    "tags": "rose, flower, petal",
    "previewURL":
        "https://cdn.pixabay.com/photo/2018/01/05/16/24/rose-3063284_150.jpg",
    "previewWidth": 150,
    "previewHeight": 99,
    "webformatURL":
        "https://pixabay.com/get/g74eebf94a08a77f5c607a68e11c5188c2ed5479c3f835103f526625d1696d36add22668b152744fa6abfb57924e3531a3f90358a0cec96df4c87bef24807748f_640.jpg",
    "webformatWidth": 640,
    "webformatHeight": 426,
    "largeImageURL":
        "https://pixabay.com/get/g732b9d620fd51dc9e839c24201cfcbcc40f7adee22c4fa4b7d81e6e2c1f03a7aacc6c1bcf5a8faac698f8f793b6b3a7c941afdd198e2e810f5b36cce379b29a8_1280.jpg",
    "imageWidth": 6000,
    "imageHeight": 4000,
    "imageSize": 3574625,
    "views": 1043353,
    "downloads": 674161,
    "collections": 1408,
    "likes": 1524,
    "comments": 329,
    "user_id": 1564471,
    "user": "anncapictures",
    "userImageURL":
        "https://cdn.pixabay.com/user/2015/11/27/06-58-54-609_250x250.jpg"
  },
];
