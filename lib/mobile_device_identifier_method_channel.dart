import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'mobile_device_identifier_platform_interface.dart';

class MethodChannelMobileDeviceIdentifier
    extends MobileDeviceIdentifierPlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('mobile_device_identifier');

  @override
  Future<String?> getDeviceId() async {
    return await methodChannel.invokeMethod<String?>('getDeviceId');
  }
}
