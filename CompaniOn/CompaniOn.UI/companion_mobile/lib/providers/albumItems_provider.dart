import 'package:companion_mobile/models/albumItems.dart';
import 'package:companion_mobile/providers/base_provider.dart';

class AlbumItemsProvider extends BaseProvider<AlbumItems>{
AlbumItemsProvider(): super("AlbumItems");

  @override
  AlbumItems fromJson(data) {
    return AlbumItems.fromJson(data);
  }
}