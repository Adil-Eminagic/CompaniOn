import 'package:companion_mobile/models/accessSignIn.dart';
import 'package:companion_mobile/providers/base_provider.dart';

class AccessSignInProvider extends BaseProvider<AccessSignIn>{
AccessSignInProvider(): super("Access/SignIn");

  @override
  AccessSignIn fromJson(data) {
    return AccessSignIn.fromJson(data);
  }
}