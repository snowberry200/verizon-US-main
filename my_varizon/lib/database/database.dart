import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  //final ApiService apiService;
  final firesBase = FirebaseFirestore.instance;

  // Database() : apiService = ApiService(client: null);

  //for firebase

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

  // This should be for SIGN UP - creating new user
  Future<void> register({
    required String name,
    required String username,
    required String password,
  }) async {
    try {
      // First check if user already exists
      final existingUser =
          await firesBase
              .collection('credential')
              .where('user', isEqualTo: username)
              .limit(1)
              .get();

      if (existingUser.docs.isNotEmpty) {
        throw Exception('User with this email already exists');
      }

      // Create new user
      final data = {
        'name': name,
        'user': username,
        'password': password,
        'createdAt': FieldValue.serverTimestamp(),
      };

      // Add to Firestore and wait for completion
      await firesBase.collection('credential').add(data);

      log('User created successfully: $username');
    } catch (e) {
      log('signUp error: $e');
      rethrow; // IMPORTANT: rethrow so Bloc can catch the error
    }
  }

  //for javaSpringBoot

  // Future<AuthResponseDTO> signin({
  //   required String email,
  //   required String password,
  // }) async {
  //   return await apiService.signin(
  //     AuthRequestDTO.forSignIn(email, password, true),
  //   );
  // }

  // Future<AuthResponseDTO> signup({
  //   required String name,
  //   required String email,
  //   required String password,
  // }) async {
  //   return await apiService.signup(
  //     AuthRequestDTO.forSignUp(name, email, password, true),
  //   );
  // }
}
