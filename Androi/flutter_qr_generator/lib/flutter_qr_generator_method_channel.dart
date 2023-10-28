import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_qr_generator_platform_interface.dart';

/// An implementation of [FlutterQrGeneratorPlatform] that uses method channels.
class MethodChannelFlutterQrGenerator extends FlutterQrGeneratorPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_qr_generator');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
