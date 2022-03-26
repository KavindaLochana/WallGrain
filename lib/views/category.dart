import 'dart:convert';

import 'package:WallGrain/data/data.dart';
import 'package:WallGrain/model/wallpaper_model.dart';
import 'package:WallGrain/widgets/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class CategorySlider extends StatefulWidget {
  final String categoryName;
  CategorySlider({this.categoryName});

  @override
  _CategorySliderState createState() => _CategorySliderState();
}

class _CategorySliderState extends State<CategorySlider> {
  List<WallpaperModel> wallpapers = [];

  //getting api data
  getSearchWallpaper(String query) async {
    var res = await http.get(
        Uri.parse('https://api.pexels.com/v1/search?query=$query&per_page=16'),
        headers: {'Authorization': apiKey});
    print(res.body.toString());

    Map<String, dynamic> jsonData = jsonDecode(res.body);
    jsonData['photos'].forEach((element) {
      //print(element);
      WallpaperModel wallpaperModel = WallpaperModel();
      wallpaperModel = WallpaperModel.fromMap(element);
      wallpapers.add(wallpaperModel);
    });

    setState(() {});
  }

  @override
  void initState() {
    getSearchWallpaper(widget.categoryName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: brandName(),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 16,
              ),
              wallpapersList(context: context, wallpapers: wallpapers),
            ],
          ),
        ),
      ),
    );
  }
}
