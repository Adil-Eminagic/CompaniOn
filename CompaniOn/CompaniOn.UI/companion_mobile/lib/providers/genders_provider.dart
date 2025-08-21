import 'package:companion_mobile/models/genders.dart';
import 'package:companion_mobile/providers/base_provider.dart';

class GendersProvider extends BaseProvider<Genders>{
GendersProvider(): super("Genders");

  @override
  Genders fromJson(data) {
    return Genders.fromJson(data);
  }
}