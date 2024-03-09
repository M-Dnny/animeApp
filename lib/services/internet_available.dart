import 'package:dio/dio.dart';

Future<bool> isInternetAvailable() async {
  var dio = Dio();
  try {
    const url = "https://www.google.com";

    final result = await dio.get(url).timeout(const Duration(seconds: 5));
    return result.statusCode == 200;
  } catch (e) {
    return true;
  }
}
