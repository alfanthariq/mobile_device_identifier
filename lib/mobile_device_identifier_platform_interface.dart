import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'mobile_device_identifier_method_channel.dart';

abstract class MobileDeviceIdentifierPlatform extends PlatformInterface {
  MobileDeviceIdentifierPlatform() : super(token: _token);

  static final Object _token = Object();

  static MobileDeviceIdentifierPlatform _instance =
      MethodChannelMobileDeviceIdentifier();

  static MobileDeviceIdentifierPlatform get instance => _instance;

  static set instance(MobileDeviceIdentifierPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getDeviceId();
}
