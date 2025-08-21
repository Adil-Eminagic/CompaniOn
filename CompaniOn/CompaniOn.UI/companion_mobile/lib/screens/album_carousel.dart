import 'package:carousel_slider/carousel_slider.dart';
import 'package:companion_mobile/providers/albumItems_provider.dart';
import 'package:companion_mobile/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';

import '../models/albumItems.dart';
import '../models/search_result.dart';

class AlbumCarousel extends StatefulWidget {
  const AlbumCarousel({super.key, required this.albumId, this.albumName});
  final int albumId;
  final String? albumName;

  @override
  State<AlbumCarousel> createState() => _AlbumCarouselState();
}

class _AlbumCarouselState extends State<AlbumCarousel> {
  AlbumItemsProvider _albumItemsProvider = AlbumItemsProvider();

  late FlutterTts _flutterTts;

  SearchResult<AlbumItems>? result;
  bool isLoading = true;

  List<AlbumItemObject> albuItemsList = [];

  @override
  void initState() {
    super.initState();

    _albumItemsProvider = context.read<AlbumItemsProvider>();
    _flutterTts = FlutterTts();

    _fetchImages();

    if (result != null &&
        result!.items.isNotEmpty &&
        albuItemsList[0].description != null) {
      _flutterTts.speak(albuItemsList[0].description ?? '');
    }
  }

  Future<void> _fetchImages() async {
    result = await _albumItemsProvider
        .getPaged(filter: {'albumId': widget.albumId, 'pageSize': 100000});

        if (result != null &&
        result!.items.isNotEmpty &&
        result?.items[0].description != null) {
      _flutterTts.speak(result?.items[0].description ?? '');
    }

    if (result != null && result!.items.isNotEmpty) {
      for (var item in result!.items) {
        albuItemsList.add(AlbumItemObject(item.description, item.dateOfPhoto,
            imageFromBase64String(item.photo?.data ?? '')));
      }
    }

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
            widget.albumName ?? '',
            style: const TextStyle(color: Colors.white),
          ),
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
        body: Center(
          child: isLoading
              ? const SpinKitCircle(color: Colors.green)
              : (result == null || result!.items.isEmpty)
                  ? const Text('No images')
                  : CarouselSlider(
                      options: CarouselOptions(
                          height: 600.0, onPageChanged: _pageChangeHandle,enableInfiniteScroll: result!.items.length > 1 ),
                      items: albuItemsList.map((albumItem) {
                        return Row(children: [
                          Expanded(
                            flex: 2,
                            child: Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 15, 0, 10),
                                child: Column(
                                  children: [
                                    Text(albumItem.description ?? 'Photo',
                                        style: const TextStyle(
                                            fontSize: 25,
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold)),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    albumItem.dateOfPhoto == null
                                        ? const Text('',
                                            style: TextStyle(fontSize: 20))
                                        : Text(
                                            '${albumItem.dateOfPhoto?.day}. ${getMonthName(albumItem.dateOfPhoto!.month)} ${albumItem.dateOfPhoto?.year}.',
                                            style:
                                                const TextStyle(fontSize: 20)),
                                    const SizedBox(height: 20),
                                    Container(
                                        constraints: const BoxConstraints(
                                            maxHeight: 500, maxWidth: 350),
                                        child: albumItem.photo),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ]);
                      }).toList(),
                    ),
        ));
  }

  _pageChangeHandle(int index, CarouselPageChangedReason reason) {
    var text = albuItemsList[index].description;

    if (text != null) {
      _flutterTts.speak(text);
    }
  }
}

class AlbumItemObject {
  String? description;
  DateTime? dateOfPhoto;
  Image photo;

  AlbumItemObject(this.description, this.dateOfPhoto, this.photo);
}

String getMonthName(int monthNumber) {
  const List<String> monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  if (monthNumber < 1 || monthNumber > 12) {
    return 'Invalid month';
  }

  return monthNames[monthNumber - 1];
}
