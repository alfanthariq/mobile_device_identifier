import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_device_identifier/mobile_device_identifier_method_channel.dart';

void main() {
  MethodChannelMobileDeviceIdentifier platform =
      MethodChannelMobileDeviceIdentifier();
  const MethodChannel channel = MethodChannel('mobile_device_identifier');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return null;
      },
    );
  });

  test('getDeviceId', () async {
    expect(await platform.getDeviceId(), '42');
  });
}
