import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_qr_generator/flutter_qr_generator.dart';
import 'package:flutter_qr_generator/flutter_qr_generator_platform_interface.dart';
import 'package:flutter_qr_generator/flutter_qr_generator_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterQrGeneratorPlatform
    with MockPlatformInterfaceMixin
    implements FlutterQrGeneratorPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterQrGeneratorPlatform initialPlatform = FlutterQrGeneratorPlatform.instance;

  test('$MethodChannelFlutterQrGenerator is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterQrGenerator>());
  });

  test('getPlatformVersion', () async {
    FlutterQrGenerator flutterQrGeneratorPlugin = FlutterQrGenerator();
    MockFlutterQrGeneratorPlatform fakePlatform = MockFlutterQrGeneratorPlatform();
    FlutterQrGeneratorPlatform.instance = fakePlatform;

    expect(await flutterQrGeneratorPlugin.getPlatformVersion(), '42');
  });
}
