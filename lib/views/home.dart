import 'dart:convert';

import 'package:WallGrain/data/data.dart';
import 'package:WallGrain/model/categories_model.dart';
import 'package:WallGrain/model/wallpaper_model.dart';
import 'package:WallGrain/views/category.dart';
import 'package:WallGrain/views/search.dart';
import 'package:WallGrain/widgets/widgets.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoriesModel> categories = [];
  List<WallpaperModel> wallpapers = [];

  TextEditingController searchController = TextEditingController();
  ScrollController _scrollController = ScrollController();

  bool isBottom = false;

  int imageCount = 79;
  int pageNumber = 1;

//getting api data
  getTrendingWallpaper(int imageCount) async {
    var res = await http.get(
        // Uri.parse('https://api.pexels.com/v1/curated?per_page=$imageCount'),
        Uri.parse(
            'https://api.pexels.com/v1/curated?page=$pageNumber&per_page=$imageCount'),
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
    categories = getCategories();
    getTrendingWallpaper(imageCount);
    super.initState();

    _scrollController.addListener(() {
      //reached bottom
      if (_scrollController.offset >=
              _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        setState(() => isBottom = true);
        print('bottom');
      }

      //Reached top
      if (_scrollController.offset <=
              _scrollController.position.minScrollExtent &&
          !_scrollController.position.outOfRange) {
        setState(() => isBottom = false);
        print('top');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: brandName(),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Container(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(0xfff5f8fd),
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(horizontal: 24),
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          hintText: 'Search Wallpaper',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Search(
                              searchQuery: searchController.text,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        child: Icon(Icons.search),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                height: 80,
                child: ListView.builder(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24,
                    ),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return CategoryTile(
                        title: categories[index].categoryName,
                        imgUrl: categories[index].imgUrl,
                      );
                    }),
              ),
              wallpapersList(context: context, wallpapers: wallpapers),
              isBottom == true
                  ? Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextButton(
                        onPressed: () {
                          print('tapped');
                          // pageNumber++;
                          // print(pageNumber.toString() + ' Page Number');
                          // imageCount = 79;
                          // getTrendingWallpaper(imageCount);
                        },
                        child: Text('Load More.'),
                        style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all(Colors.blueAccent)),
                      ),
                    )
                  // ? GestureDetector(
                  //     onTap: () {
                  //       print('tapped');
                  //       pageNumber++;
                  //       print(pageNumber.toString() + ' Page Number');
                  //       imageCount = 79;
                  //       getTrendingWallpaper(imageCount);
                  //     },
                  //     child: Container(
                  //       padding: EdgeInsets.only(bottom: 30.0),
                  //       child: Text('Load More'),
                  //     ),
                  //   )
                  // ? Positioned(
                  //     bottom: 20,
                  //     left: 18,
                  //     right: 18,
                  //     child: Container(
                  //         alignment: Alignment.center,
                  //         height: 50,
                  //         decoration: BoxDecoration(
                  //           color: Colors.orangeAccent,
                  //           borderRadius: BorderRadius.circular(15),
                  //         ),
                  //         child: Text('Your widget at the end')))
                  : Container(),
              SizedBox(
                height: 25.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final String imgUrl;
  final String title;
  CategoryTile({@required this.imgUrl, @required this.title});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    CategorySlider(categoryName: title.toLowerCase())));
      },
      child: Container(
        margin: EdgeInsets.only(
          right: 4,
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imgUrl,
                height: 50,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.black26,
              ),
              height: 50,
              width: 100,
              alignment: Alignment.center,
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
