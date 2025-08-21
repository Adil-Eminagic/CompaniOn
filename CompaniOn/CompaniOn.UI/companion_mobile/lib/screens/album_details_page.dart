import 'dart:convert';
import 'dart:io';

import 'package:companion_mobile/models/albumItems.dart';
import 'package:companion_mobile/models/albums.dart';
import 'package:companion_mobile/providers/albumItems_provider.dart';
import 'package:companion_mobile/providers/album_provide.dart';
import 'package:companion_mobile/screens/albumItem_details_page.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../models/search_result.dart';
import '../utils/util.dart';
import '../utils/util_widgets.dart';

class AlbumDetailsPage extends StatefulWidget {
  const AlbumDetailsPage({super.key, this.album, this.userId});
  final Albums? album;
  final int? userId;

  @override
  State<AlbumDetailsPage> createState() => _AlbumDetailsPageState();
}

class _AlbumDetailsPageState extends State<AlbumDetailsPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  late AlbumsProvider _albumsProvider;
  late AlbumItemsProvider _albumItemsProvider;

  SearchResult<AlbumItems>? albumItems;

  String? photo;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initialValue = {
      'id': widget.album?.id.toString(),
      'name': widget.album?.name,
      'description': widget.album?.description,
      'userId': widget.album != null
          ? widget.album?.userId.toString()
          : widget.userId.toString()
    };

    _albumsProvider = context.read<AlbumsProvider>();
    _albumItemsProvider = context.read<AlbumItemsProvider>();

    initForm();
  }

  Future<void> initForm() async {
    if (widget.album != null) {
      albumItems = await _albumItemsProvider
          .getPaged(filter: {'albumId': widget.album?.id, 'pageSize': 100000});
    }

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _deleteAlbumItem(int id) async {
    try {
      showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: const Text("Deleting album item"),
                content: const Text("Do you want to delete this album itme"),
                actions: [
                  TextButton(
                      onPressed: (() {
                        Navigator.pop(context);
                      }),
                      child: const Text("Cancel")),
                  TextButton(
                      onPressed: () async {
                        try {
                          await _albumItemsProvider.delete(id);
                          setState(() {
                            albumItems?.items
                                .removeWhere((album) => album.id == id);
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('Album item deleted successfully!')),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.album == null ? 'New album' : 'Edit album',
            style: const TextStyle(color: Colors.white)),
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
      body: isLoading
          ? const SpinKitCircle(color: Colors.green)
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  FormBuilder(
                    initialValue: _initialValue,
                    key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FormBuilderTextField(
                              style: const TextStyle(fontSize: 20),
                              decoration: InputDecoration(
                                labelText: 'Name',
                                labelStyle:
                                    const TextStyle(color: Colors.green),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Field is mandatory";
                                } else {
                                  return null;
                                }
                              },
                              name: 'name'),
                          const SizedBox(height: 20),
                          FormBuilderTextField(
                            name: 'description',
                            maxLines: 3,
                            decoration: const InputDecoration(
                              label: Text('Description'),
                              labelStyle: TextStyle(color: Colors.green),
                            ),
                          ),
                          const SizedBox(height: 20),
                          widget.album == null
                              ? Container()
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Album items',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    IconButton(
                                      tooltip: 'Add',
                                      onPressed: () async {
                                        var result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp', 'tiff', 'tif', 'heic', 'heif', 'ico', 'svg']); 

                                        if (result != null &&
                                            result.files.single.path != null) {
                                          var image = File(result.files.single
                                              .path!); //jer smo sa if provjerili pa je sigurn !
                                          var base64Image = base64Encode(
                                              image.readAsBytesSync()); //opet !

                                          if (base64Image != '') {
                                            var refresh =
                                                await Navigator.of(context)
                                                    .push(MaterialPageRoute(
                                              builder: (context) =>
                                                  AlbumItemDetailsPage(
                                                    albumId: widget.album?.id,
                                                photoBase64: base64Image,
                                              ),
                                            ));

                                            if (refresh == 'reload') {
                                              initForm();
                                            }
                                          } else {
                                            alertBox(context, "No photo",
                                                'You must select photo!');
                                          }
                                        }
                                      },
                                      icon: const Icon(
                                        Icons.add,
                                        size: 25,
                                        color: Colors.white,
                                      ),
                                      style: IconButton.styleFrom(
                                          backgroundColor: Colors.green),
                                    )
                                  ],
                                ),
                          widget.album == null ? Container() : const Divider(),
                        ]),
                  ),
                  const SizedBox(height: 10),
                  widget.album == null
                      ? Container()
                      : Expanded(
                          child: ListView.builder(
                            itemCount: albumItems!.items.length,
                            itemBuilder: (context, index) {
                              final albumItem = albumItems!.items[index];
                              return Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 5,
                                margin: const EdgeInsets.only(bottom: 16),
                                child: ListTile(
                                  contentPadding: const EdgeInsets.all(16),
                                  leading: albumItem.photoId != null
                                      ? imageFromBase64String(
                                          albumItem.photo?.data ?? '')
                                      : Image.asset(
                                          'assets/images/album_cover_3.png'),
                                  title: Text(
                                    albumItem.description ?? 'Picture',
                                    style: const TextStyle(fontSize: 22),
                                  ),
                                  subtitle: albumItem.dateOfPhoto == null ? const Text('No date') : Text('${albumItem.dateOfPhoto?.year}-${albumItem.dateOfPhoto?.month.toString().padLeft(2, '0')}-${albumItem.dateOfPhoto?.day.toString().padLeft(2, '0')}'),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red),
                                    onPressed: () =>
                                        _deleteAlbumItem(albumItem.id ?? 0),
                                  ),
                                  onTap: () async {
                                    var refresh = await Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) =>
                                          AlbumItemDetailsPage(
                                              albumItem: albumItem),
                                    ));

                                    if (refresh == 'reload') {
                                      initForm();
                                    }
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: const Text('Save'),
                      onPressed: () async {
                        _formKey.currentState?.save();

                        try {
                          if (_formKey.currentState!.validate()) {
                            if (widget.album != null) {
                              Map<String, dynamic> request =
                                  Map.of(_formKey.currentState!.value);

                              request['id'] = widget.album?.id;

                              request['userId'] = widget.album?.userId;

                              await _albumsProvider.update(request);

                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text('Album successfully modified')));

                              Navigator.pop(context, 'reload');
                            } else {
                              Map<String, dynamic> request =
                                  Map.of(_formKey.currentState!.value);

                              request['userId'] = widget.userId;

                              await _albumsProvider.insert(request);

                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text('Album succesffuly added')));

                              Navigator.pop(context, 'reload');
                            }
                          }
                        } on Exception catch (e) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                    title: Text('Error'),
                                    content: Text(
                                      e.toString(),
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Ok'))
                                    ],
                                  ));
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 25),
                ],
              ),
            ),
    );
  }
}
