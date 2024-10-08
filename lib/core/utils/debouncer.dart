import 'dart:async';

import 'package:flutter/material.dart';

class DeBouncer {
  final Duration debouncingDuration;

  DeBouncer({required this.debouncingDuration});

  Timer? _timer;

  void debounce({required VoidCallback callback}) {
    _timer?.cancel();
    _timer = null;
    _timer = Timer(debouncingDuration, () {
      callback();
      _timer?.cancel();
      _timer = null;
    });
  }
}
