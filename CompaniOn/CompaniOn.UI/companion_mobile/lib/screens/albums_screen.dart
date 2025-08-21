import 'package:companion_mobile/models/albums.dart';
import 'package:companion_mobile/providers/album_provide.dart';
import 'package:companion_mobile/screens/album_details_page.dart';
import 'package:companion_mobile/screens/album_carousel.dart';
import 'package:companion_mobile/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/util_widgets.dart';

class AlbumsPage extends StatefulWidget {
  final int userId;

  const AlbumsPage({super.key, required this.userId});

  @override
  _AlbumsPageState createState() => _AlbumsPageState();
}

class _AlbumsPageState extends State<AlbumsPage> {
  late AlbumsProvider _albumsProvider;
  List<Albums> _albums = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _albumsProvider = context.read<AlbumsProvider>();
    _fetchAlbums();
  }

  Future<void> _fetchAlbums() async {
    try {
      var result = await _albumsProvider.getPaged(
        filter: {'userId': widget.userId, 'pageSize': 1000},
      );
      setState(() {
        _albums = result.items
            .where((album) => album.userId == widget.userId)
            .toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading reminders: $e')),
      );
    }
  }

  Future<void> _deleteAlbum(int id) async {
    try {
      showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: const Text("Deleting album"),
                content: const Text("Do you want to delete this album"),
                actions: [
                  TextButton(
                      onPressed: (() {
                        Navigator.pop(context);
                      }),
                      child: const Text("Cancel")),
                  TextButton(
                      onPressed: () async {
                        try {
                          await _albumsProvider.delete(id);
                          setState(() {
                            _albums.removeWhere((album) => album.id == id);
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Album deleted successfully!')),
                          );
                          Navigator.pop(context);
                        } catch (e) {
                          alertBoxMoveBack(context, 'Error', e.toString());
                        }
                      },
                      child: const Text('Ok')),
                ],
              ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting Album: $e')),
      );
    }
  }

  void _navigateToAddAlbum() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AlbumDetailsPage(userId: widget.userId),
      ),
    );

    // Check if reminder was successfully added
    if (result == 'reload') {
      _fetchAlbums();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Albums', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.green,
        elevation: 4.0,
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _albums.isEmpty
              ? const Center(child: Text('No albums found.'))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.builder(
                    itemCount: _albums.length,
                    itemBuilder: (context, index) {
                      final album = _albums[index];
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 5,
                        margin: const EdgeInsets.only(bottom: 16),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16),
                          leading: album.coverPhotoId != null
                              ? imageFromBase64String(
                                  album.coverPhoto?.data ?? '')
                              : Image.asset('assets/images/album_cover_3.png'),
                          title: Text(
                            album.name ?? '',
                            style: const TextStyle(fontSize: 22),
                          ),
                          subtitle: Text(album.description ?? 'No description'),
                          trailing: loggedUser?.roleId == 1
                              ? null
                              : IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                  onPressed: () => _deleteAlbum(album.id ?? 0),
                                ),
                          onTap: () async {
                            if (loggedUser?.roleId == 2) {
                              var refresh = await Navigator.of(context)
                                  .push(MaterialPageRoute(
                                builder: (context) =>
                                    AlbumDetailsPage(album: _albums[index]),
                              ));

                              if (refresh == 'reload') {
                                _fetchAlbums();
                              }
                            }else{
                              await Navigator.of(context)
                                  .push(MaterialPageRoute(
                                builder: (context) =>
                                    AlbumCarousel(albumId: album.id ?? 0, albumName: album.name),
                              ));
                            }
                          },
                        ),
                      );
                    },
                  ),
                ),
      floatingActionButton: loggedUser?.roleId == 1 ? null : FloatingActionButton(
        onPressed: _navigateToAddAlbum,
        backgroundColor: Colors.green,
        child: const Icon(Icons.add, color: Colors.white),
        tooltip: 'Add Album',
      ),
    );
  }
}
