import 'package:dio/dio.dart';


class DioClass {

  void getHttp() async {
    try {
      var response = await Dio().get('http://www.google.com');
      print(response);
    } catch (e) {
      print(e);
    }
  }

}