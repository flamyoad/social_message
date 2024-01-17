import 'package:flutter/services.dart';

abstract class ShareMessageUseCase {
  void shareMessage(String message);
}

class ShareMessageUseCaseImpl implements ShareMessageUseCase {
  static const platform = MethodChannel('com.flamyoad.sharemessage');

  @override
  void shareMessage(String message) {
    try {
      platform.invokeMethod('method_share_message', {'arg_message': message});
    } on PlatformException catch (e) {
      // no-op
    }
  }
}
