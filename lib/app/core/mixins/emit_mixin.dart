import 'dart:developer';

import 'package:flutter/foundation.dart';

/// A mixin that adds an `emit` method to a [ValueNotifier] that allows emitting a new state.
///
/// The `emit` method sets the [ValueNotifier]'s value to the new state.
mixin EmitMixin<T> on ValueNotifier<T> {
  void emit(T state) {
    if (kDebugMode) {
      log('Emitting $state');
    }
    value = state;
  }
}
