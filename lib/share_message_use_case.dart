import 'package:flutter/services.dart';

abstract class ShareMessageUseCase {
  void shareMessage(String message);
  void shareImage();
}

class ShareMessageUseCaseImpl implements ShareMessageUseCase {
  final MethodChannel platform;

  ShareMessageUseCaseImpl(this.platform);

  @override
  void shareMessage(String message) {
    try {
      platform.invokeMethod('method_share_message', {'arg_message': message});
    } on PlatformException catch (e) {
      // no-op
    }
  }

  @override
  void shareImage() {
    // TODO: implement shareImage
  }
}
