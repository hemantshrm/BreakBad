import 'dart:async';

import 'package:demo/Api.dart';
import 'package:demo/Model/api_model.dart';

enum Doing { FETCH, SEARCH }

class BreakingBadBloc {
  var apiRepo = ApiManager();
  final _stateStreamController = StreamController<List<BreakingBadModel>>();
  StreamSink<List<BreakingBadModel>> get _charactersSink =>
      _stateStreamController.sink;
  Stream<List<BreakingBadModel>> get charactersStream =>
      _stateStreamController.stream;

  final _eventStreamController = StreamController<Doing>();
  StreamSink<Doing> get bBEventSink => _eventStreamController.sink;
  Stream<Doing> get _bBEventStream => _eventStreamController.stream;

  BreakingBadBloc() {
    _bBEventStream.listen((event) async {
      if (event == Doing.FETCH) {
        try {
          /// Api call and store in var
          var bbCharacters = await ApiManager.getAllCharacters();

          /// then add them to 2nd pipe input [sink]
          _charactersSink.add(bbCharacters);
        } on Exception catch (e) {
          _charactersSink.addError('Something Went Wrong');
          print(e);
        }
      }
    });
  }

  void dispose() {
    _stateStreamController.close();
    _eventStreamController.close();
  }
}
