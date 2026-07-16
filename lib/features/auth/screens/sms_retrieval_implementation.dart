import 'package:pinput/pinput.dart';
import 'package:smart_auth/smart_auth.dart';

class SmsRetrieverImpl implements SmsRetriever {
  SmsRetrieverImpl(this.smartAuth);
  final SmartAuth smartAuth;

  @override
  bool get listenForMultipleSms => false;

  @override
  Future<String?> getSmsCode() async {
    final result = await smartAuth.getSmsWithRetrieverApi();

    if (
      result.hasData &&
      result.data != null &&
      result.data!.code!.isNotEmpty
    ) {
      return result.data!.code;
    }

    return null;
  }

  @override
  Future<void> dispose() {
    return smartAuth.removeSmsRetrieverApiListener();
  }
}
