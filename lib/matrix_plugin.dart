
import 'dart:async';

import 'package:flutter/services.dart';

class MatrixPlugin {
  static const MethodChannel _channel =
      const MethodChannel('matrix_plugin');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
