import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'domain_models.freezed.dart';

@freezed
class TeamInfo with _$TeamInfo {
  const factory TeamInfo(String name, String crestUrl, String address,
      String founded, String fromDate, String toDate) = _TeamInfo;
}
