import 'package:companion_mobile/models/accessSignUp.dart';
import 'package:companion_mobile/providers/base_provider.dart';

class AccessSignUpProvider extends BaseProvider<AccessSignUp>{
AccessSignUpProvider(): super("Access/SignUp");

  @override
  AccessSignUp fromJson(data) {
    return AccessSignUp.fromJson(data);
  }
}