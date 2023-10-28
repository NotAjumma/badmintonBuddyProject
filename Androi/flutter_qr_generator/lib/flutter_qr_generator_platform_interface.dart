import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_qr_generator_method_channel.dart';

abstract class FlutterQrGeneratorPlatform extends PlatformInterface {
  /// Constructs a FlutterQrGeneratorPlatform.
  FlutterQrGeneratorPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterQrGeneratorPlatform _instance = MethodChannelFlutterQrGenerator();

  /// The default instance of [FlutterQrGeneratorPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterQrGenerator].
  static FlutterQrGeneratorPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterQrGeneratorPlatform] when
  /// they register themselves.
  static set instance(FlutterQrGeneratorPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
