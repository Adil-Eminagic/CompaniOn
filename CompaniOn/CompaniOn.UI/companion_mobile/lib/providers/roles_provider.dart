import 'package:companion_mobile/models/roles.dart';
import 'package:companion_mobile/providers/base_provider.dart';

class RolesProvider extends BaseProvider<Roles>{
RolesProvider(): super("Roles");

  @override
  Roles fromJson(data) {
    return Roles.fromJson(data);
  }
}