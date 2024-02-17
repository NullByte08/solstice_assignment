/*
 * *
 *  * Created by NullByte08 in 2024.
 *
 */

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:solstice_assignment/models/parameter_models.dart';
import 'package:solstice_assignment/models/tnc_model.dart';
import 'package:solstice_assignment/services/repository.dart';

final getTnCListFutureProvider = FutureProvider.autoDispose.family<List<TnCModel>, GetTnCListFPParams>((ref, params) async {
  return await RepositoryClass.getTnCList(limit: params.limit, startIndex: params.startIndex);
});
