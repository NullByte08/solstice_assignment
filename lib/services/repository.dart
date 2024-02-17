/*
 * *
 *  * Created by NullByte08 in 2024.
 *
 */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:solstice_assignment/models/tnc_model.dart';

class RepositoryClass {
  static Future<List<TnCModel>> getTnCList({
    required int startIndex,
    required int limit,
  }) async {
    debugPrint("getTnCList: $startIndex, $limit");
    await Future.delayed(const Duration(seconds: 2)); // for testing pagination

    var querySnapshot =
        await FirebaseFirestore.instance.collection("tnc_list").orderBy("id").where("id", isGreaterThanOrEqualTo: startIndex).limit(limit).get();

    List<TnCModel> result = [];
    for (var doc in querySnapshot.docs) {
      var docMap = doc.data();

      result.add(TnCModel(
        id: docMap["id"],
        value: docMap["value"],
        createdAt: docMap["createdAt"],
        updatedAt: docMap["updatedAt"],
      ));
    }

    return result;
  }
}
