import 'package:WallGrain/model/wallpaper_model.dart';
import 'package:WallGrain/views/imageView.dart';
import 'package:flutter/material.dart';

Widget brandName() {
  return RichText(
    text: TextSpan(
      text: '',
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
      children: const <TextSpan>[
        TextSpan(text: 'Wall', style: TextStyle(color: Color(0xffed9121))),
        TextSpan(text: 'Grain', style: TextStyle(color: Colors.white)),
      ],
    ),
  );
}

Widget wallpapersList({List<WallpaperModel> wallpapers, context}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: GridView.count(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 0.6,
      mainAxisSpacing: 6.0,
      crossAxisSpacing: 6.0,
      children: wallpapers.map((wallpaper) {
        return GridTile(
            child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ImageView(
                  imgUrl: wallpaper.src.portrait,
                ),
              ),
            );
          },
          child: Hero(
            tag: wallpaper.src.portrait,
            child: Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  wallpaper.src.portrait,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ));
      }).toList(),
    ),
  );
}
