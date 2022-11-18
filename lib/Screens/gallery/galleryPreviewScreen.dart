import 'dart:convert';
import 'package:bikerider/Http/photoHttp.dart';
import 'package:bikerider/Utility/Secure_storeage.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Image_view.dart';
import 'gallery_model.dart';

// String? token =
//     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyTW9iaWxlIjoiOTQ4MTY3NjM0OCIsImlhdCI6MTY2ODc1Nzc4MSwiZXhwIjoxNjY4NzYxMzgxfQ.7O7xVg0pKsiHUeonkb0Nv29UWXOwWtTEo-NgZApXL4I";

class GalleryPreviewScreen extends StatefulWidget {
  const GalleryPreviewScreen({Key? key}) : super(key: key);

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
      UserSecureStorage.getToken().then((value) async {
        final http.Response res = await http.post(
          body: jsonEncode({'tripId': '6373141675818e2c99e5776'}),
          Uri.parse(
              "https://riding-application.herokuapp.com/api/v1/chat/getImagePreview?page=$_page&limit=$_limit"),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'BEARER $value',
          },
        );
        // print(res.body);
        setState(() {
          _posts = json.decode(res.body);
        });
      });
    } catch (e) {
      print(e);
    }
    setState(() {
      _isFirstLoadRun = false;
      _controller = ScrollController()..addListener(_loadMore);
    });
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
          final http.Response res = await http.post(
            body: jsonEncode({'tripId': '6373141675818e2c99e5776'}),
            Uri.parse(
                "https://riding-application.herokuapp.com/api/v1/chat/getImagePreview?page=$_page&limit=$_limit"),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'BEARER $value',
            },
          );
          setState(() {
            final List fetchedPosts = json.decode(res.body);
            if (fetchedPosts.isNotEmpty) {
              _posts.addAll(fetchedPosts);
            }
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
    return Scaffold(
      body: _isFirstLoadRun
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Expanded(
                  child: MasonryGridView.builder(
                    itemCount: _posts.length,
                    controller: _controller,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    gridDelegate:
                        SliverSimpleGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (context, index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: GestureDetector(
                          onTap: () {
                            UserSecureStorage.getToken().then((value) {
                              PhotosHttp.getPhotoDetails(
                                      _posts[index]["_id"], value!)
                                  .then((value) {
                                ImageDetails temp =
                                    ImageDetails.fromJson(value);
                                print(value);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ImageView(imageDetails: temp),
                                  ),
                                );
                              });
                            });
                          },
                          child: Image.network("${_posts[index]["imageUrl"]}"),
                        ),
                      );
                    },
                  ),
                ),
                if (_isMoreRunning == true)
                  Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                if (_hasNextPage == false) Container(),
              ],
            ),
    );
  }
}
