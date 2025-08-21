import 'dart:convert';
import 'dart:io';

import 'package:companion_mobile/models/albumItems.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../providers/albumItems_provider.dart';
import '../utils/util.dart';

class AlbumItemDetailsPage extends StatefulWidget {
  const AlbumItemDetailsPage(
      {super.key, this.albumItem, this.albumId, this.photoBase64});
  final AlbumItems? albumItem;
  final int? albumId;
  final photoBase64;

  @override
  State<AlbumItemDetailsPage> createState() => _AlbumItemDetailsPageState();
}

class _AlbumItemDetailsPageState extends State<AlbumItemDetailsPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  late AlbumItemsProvider _albumItemsProvider;

  String? photo;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initialValue = {
      'id': widget.albumItem?.id.toString(),
      'dateOfPhoto': widget.albumItem?.dateOfPhoto,
      'description': widget.albumItem?.description,
      'albumId': widget.albumItem != null
          ? widget.albumItem?.albumId.toString()
          : widget.albumId.toString()
    };

    _albumItemsProvider = context.read<AlbumItemsProvider>();

    photo = widget.albumItem != null ? widget.albumItem!.photo?.data :  widget.photoBase64;

    initForm();
  }

  Future<void> initForm() async {
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
              widget.albumItem == null ? 'New album item' : 'Edit album itme',
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
            : SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      FormBuilder(
                        initialValue: _initialValue,
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Center(
                                      child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 15, 0, 10),
                                    child: Column(
                                      children: [
                                        (photo == null)
                                            ? Container()
                                            : InkWell(
                                                onTap: getimage,
                                                child: Container(
                                                    constraints:
                                                        const BoxConstraints(
                                                            maxHeight: 350,
                                                            maxWidth: 350),
                                                    child: imageFromBase64String(
                                                        photo!)),
                                              ),
                                        photo == null
                                            ? ElevatedButton(
                                                onPressed: getimage,
                                                child: const Text('Choose image'))
                                            : Container()
                                      ],
                                    ),
                                  )),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            FormBuilderTextField(
                              name: 'description',
                              maxLines: 2,
                              decoration: const InputDecoration(
                                  label: Text('Description')),
                            ),
                             const SizedBox(height: 10),
                            FormBuilderDateTimePicker(
                              name: 'dateOfPhoto',
                              decoration: const InputDecoration(
                                  label: Text(
                                      "Date of photo")),
                            ),
                          ],
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
                                if (widget.albumItem != null) {
                                  Map<String, dynamic> request =
                                      Map.of(_formKey.currentState!.value);
              
                                  request['id'] = widget.albumItem?.id;
              
                                  request['albumId'] = widget.albumItem?.albumId;
              
                                  request['photo'] = photo;
              
                                  request['dateOfPhoto'] = dateEncode(_formKey
                                      .currentState?.value['dateOfPhoto']);
              
                                  await _albumItemsProvider.update(request);
              
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Album item successfully modified')));
              
                                  Navigator.pop(context, 'reload');
                                } else {
                                  Map<String, dynamic> request =
                                      Map.of(_formKey.currentState!.value);
              
                                  request['albumId'] = widget.albumId;
              
                                  request['dateOfPhoto'] = dateEncode(_formKey
                                      .currentState?.value['dateOfPhoto']);

                                  request['photo'] = photo;
              
                                  await _albumItemsProvider.insert(request);
              
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Album item succesffuly added')));
              
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
            ));
  }

  Future getimage() async {
    var result = await FilePicker.platform
        .pickFiles(type: FileType.custom , allowedExtensions: ['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp', 'tiff', 'tif', 'heic', 'heif', 'ico', 'svg']); //sam prepoznaj platformu u kjoj radi
    if (result != null && result.files.single.path != null) {
      var image = File(
          result.files.single.path!); //jer smo sa if provjerili pa je sigurn !
      var base64Img = base64Encode(image.readAsBytesSync()); //opet !

      if (mounted) {
        setState(() {
          photo = base64Img;
        });
      }
    }
  }
}

