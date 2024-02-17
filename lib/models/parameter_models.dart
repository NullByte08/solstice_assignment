/*
 * *
 *  * Created by NullByte08 in 2024.
 *
 */

import 'package:equatable/equatable.dart';

class GetTnCListFPParams extends Equatable {
  final int startIndex;
  final int limit;

  const GetTnCListFPParams({required this.startIndex, required this.limit});

  @override
  List<Object?> get props => [startIndex, limit];
}
