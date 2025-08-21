import 'package:companion_mobile/models/photos.dart';
import 'package:companion_mobile/providers/base_provider.dart';

class PhotosProvider extends BaseProvider<Photos>{
PhotosProvider(): super("Photos");

  @override
  Photos fromJson(data) {
    return Photos.fromJson(data);
  }
}