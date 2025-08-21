import 'package:companion_mobile/models/country.dart';
import 'package:companion_mobile/providers/base_provider.dart';

class CountryProvider extends BaseProvider<Country>{
CountryProvider(): super("Countries");

  @override
  Country fromJson(data) {
    return Country.fromJson(data);
  }
}