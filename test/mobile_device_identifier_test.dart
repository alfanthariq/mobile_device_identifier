import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_device_identifier/mobile_device_identifier.dart';
import 'package:mobile_device_identifier/mobile_device_identifier_platform_interface.dart';
import 'package:mobile_device_identifier/mobile_device_identifier_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockMobileDeviceIdentifierPlatform
    with MockPlatformInterfaceMixin
    implements MobileDeviceIdentifierPlatform {
  @override
  Future<String?> getDeviceId() => Future.value('42');
}

void main() {
  final MobileDeviceIdentifierPlatform initialPlatform =
      MobileDeviceIdentifierPlatform.instance;

  test('$MethodChannelMobileDeviceIdentifier is the default instance', () {
    expect(
        initialPlatform, isInstanceOf<MethodChannelMobileDeviceIdentifier>());
  });

  test('getDeviceId', () async {
    MobileDeviceIdentifier mobileDeviceIdentifierPlugin =
        MobileDeviceIdentifier();
    MockMobileDeviceIdentifierPlatform fakePlatform =
        MockMobileDeviceIdentifierPlatform();
    MobileDeviceIdentifierPlatform.instance = fakePlatform;

    expect(await mobileDeviceIdentifierPlugin.getDeviceId(), '42');
  });
}
