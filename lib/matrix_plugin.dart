import 'dart:async';

import 'package:flutter/services.dart';

class MatrixPlugin {
  static const MethodChannel _channel = const MethodChannel('matrix_plugin');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  /// 初始化
  static Future<Object> initWithHomeServer(String homeServer) async {
    final Object response = await _channel.invokeMethod(
      'initWithHomeServer',
      {"homeServer": homeServer},
    );
    return response;
  }

  /// 获取服务器支持的规范的版本。
  static Future<Object> supportedMatrixVersions() async {
    final Object response =
        await _channel.invokeMethod('supportedMatrixVersions');
    return response;
  }

  /// 注册
  static Future<Object> registerWithLoginTypeUsernamePwd(
      String username, String password) async {
    final Object response = await _channel.invokeMethod(
      'registerWithLoginTypeUsernamePwd',
      {"username": username, "password": password},
    );
    return response;
  }

  /// 对注册端点进行ping以尽早检测可能的注册问题。
  static Future<Object> testUserRegistration(String username) async {
    final Object response = await _channel.invokeMethod(
      'testUserRegistration',
      {"username": username},
    );
    return response;
  }

  /// 检查用户名是否可用。
  static Future<Object> isUsernameAvailable(String username) async {
    final Object response = await _channel.invokeMethod(
      'isUsernameAvailable',
      {"username": username},
    );
    return response;
  }

  /// 获取主服务器支持的寄存器流列表。
  static Future<Object> getRegisterSession() async {
    final Object response = await _channel.invokeMethod('getRegisterSession');
    return response;
  }

  /// 登录
  static Future<Object> loginWithTypeUsernamePwd(
      String username, String password) async {
    final Object response = await _channel.invokeMethod(
      'loginWithTypeUsernamePwd',
      {"username": username, "password": password},
    );
    return response;
  }
}
