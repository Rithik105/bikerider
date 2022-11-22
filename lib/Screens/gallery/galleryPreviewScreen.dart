import 'dart:convert';
import 'package:bikerider/Http/photoHttp.dart';
import 'package:bikerider/Models/get_trip_model.dart';
import 'package:bikerider/Screens/gallery/image_view_future.dart';
import 'package:bikerider/Utility/Secure_storeage.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Image_view.dart';
import 'gallery_model.dart';

class GalleryPreviewScreen extends StatefulWidget {
  GalleryPreviewScreen({Key? key, required this.getTripModel})
      : super(key: key);
  GetTripModel getTripModel;

  @override
  State<GalleryPreviewScreen> createState() => _GalleryPreviewScreenState();
}

class _GalleryPreviewScreenState extends State<GalleryPreviewScreen> {
  int _page = 1;
  final _limit = 8;
  bool _isFirstLoadRun = false;
  bool _hasNextPage = true;
  List _posts = [];
  bool _isMoreRunning = false;
  late ScrollController _controller;
  void _firstLoad() async {
    setState(() {
      _isFirstLoadRun = true;
    });
    try {
      print("helllllllllllllllllloooooooooooo  ${widget.getTripModel.id}");
      UserSecureStorage.getToken().then((value) async {
        PhotosHttp.getGallery(widget.getTripModel.id!, value!, _page, _limit)
            .then((value) {
          // print(res.body);
          setState(() {
            _posts = value;
            _isFirstLoadRun = false;
            _controller = ScrollController()..addListener(_loadMore);
          });
        });
      });
    } catch (e) {
      print(e);
    }
  }

  void _loadMore() async {
    if (_hasNextPage == true &&
        _isFirstLoadRun == false &&
        _isMoreRunning == false &&
        _controller.position.extentAfter < 300) {
      setState(() {
        _isMoreRunning = true;
      });
      _page += 1;
      try {
        UserSecureStorage.getToken().then((value) async {
          PhotosHttp.getGallery(widget.getTripModel.id!, value!, _page, _limit)
              .then((value) {
            setState(() {
              final List fetchedPosts = value;
              if (fetchedPosts.isNotEmpty) {
                _posts.addAll(fetchedPosts);
              }
            });
          });
        });
      } catch (e) {
        print(e);
      }
      setState(() {
        _isMoreRunning = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _firstLoad();
  }

  Widget build(BuildContext context) {
    if (_isFirstLoadRun) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return MasonryGridView.builder(
        itemCount: _posts.length,
        controller: _controller,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: GestureDetector(
              onTap: () {
                UserSecureStorage.getToken().then((value) {
                  PhotosHttp.getPhotoDetails(_posts[index]["_id"], value!)
                      .then((value2) {
                    ImageDetails temp = value2;
                    print(value);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ImageViewFuture(imageDetails: temp, token: value!),
                      ),
                    );
                  });
                });
              },
              child: Image.network("${_posts[index]["imageUrl"]}"),
            ),
          );
        },
      );
    }
  }
}
