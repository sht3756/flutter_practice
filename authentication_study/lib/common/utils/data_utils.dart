import 'dart:convert';

import 'package:authentication_study/common/const/data.dart';

class DataUtils {
  // string 형태로 이미지 한개 받기
  // url 로 만들어주는 로직 : String 타입으로 리턴, 현재 플랫폼에 맞는 ip 와 path 를 넣어 url 를 만들언준다.
  static String pathToUrl(String value) {
    // value 는 thumbUrl 이다.
    return 'http://$ip$value';
  }

  // list 형태로 이미지 여러개 받기
  static List<String> listPathsToUrls(List paths){
    return paths.map((e)=> pathToUrl(e)).toList();
  }

  // base 64 로 인코딩 하는 로직 : String 타입을 리턴, 하는 로직
  static String plainToBase64(String plain) {
    Codec<String, String> stringToBase64 = utf8.fuse(base64);

    String encoded = stringToBase64.encode(plain);

    return encoded;
  }
}