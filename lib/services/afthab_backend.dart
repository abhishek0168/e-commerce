import 'dart:developer';

import 'package:dio/dio.dart';

class Afthab {
  final dio = Dio();

  void request() async {
    try {} catch (e) {
      log('$e error afthab');
    }
  }
}
