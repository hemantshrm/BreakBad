import 'dart:async';

import 'package:demo/Api.dart';
import 'package:demo/Model/api_model.dart';

enum Do { FETCH, SEARCH }

class BreakingBadBloc {
  var apiRepo = ApiManager();
  final _stateStreamController = StreamController<BreakingBadModel>();
  final _eventStreamController = StreamController<Do>();
}
