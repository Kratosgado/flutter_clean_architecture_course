import 'dart:async';

import 'package:rxdart/subjects.dart';

import '../common/state_render/state_render_impl.dart';

abstract class BaseViewModel extends BaseViewModelInputs with BaseViewModelOutputs {
  StreamController _inputStateStreamController = BehaviorSubject<FlowState>();

  @override
  Sink get inputState => _inputStateStreamController.sink;

  @override
  Stream<FlowState> get outputState => _inputStateStreamController.stream.map((event) => event);

  @override
  void dispose() {
    _inputStateStreamController.close();
  }
  // shared variables and functions that will be used through any view model
}

abstract class BaseViewModelInputs {
  void start();
  void dispose();

  Sink get inputState;
}

mixin BaseViewModelOutputs {
  Stream<FlowState> get outputState;
}
