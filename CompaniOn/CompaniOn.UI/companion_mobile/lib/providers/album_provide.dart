import 'package:companion_mobile/models/albums.dart';
import 'package:companion_mobile/providers/base_provider.dart';

class AlbumsProvider extends BaseProvider<Albums>{
AlbumsProvider(): super("Albums");

  @override
  Albums fromJson(data) {
    return Albums.fromJson(data);
  }
}