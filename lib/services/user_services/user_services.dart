import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:anime_app/models/user_model/user_list.dart';
import 'package:anime_app/utils/config.dart';

class UserService {
  var dio = Dio();

  Future<List<UserList>?> getUserList() async {
    const url = '$baseUrl/users';
    try {
      final response = await dio.get(url);
      return userListFromJson(jsonEncode(response.data));
    } catch (e) {
      debugPrint("USER LIST CATCH ERROR: ${e.toString()}");
    }
    return null;
  }

  // get user info
  Future<UserList?> getUserInfo(String userId) async {
    final url = '$baseUrl/users/$userId';
    try {
      final response = await dio.get(url);
      // debugPrint("USER INFO: ${response.data}");
      return UserList.fromJson(response.data);
    } catch (e) {
      debugPrint("USER INFO CATCH ERROR: ${e.toString()}");
    }
    return null;
  }
}
