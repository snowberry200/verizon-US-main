import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  Database();
  final firesBase = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> getData({
    required String userID,
    required dynamic password,
    required String securityQuestion,
    required String securityQuestionAnswer,
  }) async {
    final data = {
      " a. userID": userID,
      " b. password": password,
      " c. securityQuestion": securityQuestion,
      " d. securityQuestionAnswer": securityQuestionAnswer,
    };
    try {
      await firesBase.collection('loginInfo').add(data);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return {};
    }
    return data;
  }
}
