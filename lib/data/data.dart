import 'package:WallGrain/model/categories_model.dart';

//api key
String apiKey = '563492ad6f9170000100000186dc2826ec2e4141a0fcacd3c1751044';

List<CategoriesModel> getCategories() {
  List<CategoriesModel> categories = List();
  CategoriesModel categoriesModel = CategoriesModel();

  categoriesModel.imgUrl =
      'https://images.pexels.com/photos/2119706/pexels-photo-2119706.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260';
  categoriesModel.categoryName = 'Street Art';
  categories.add(categoriesModel);
  categoriesModel = CategoriesModel();

  categoriesModel.imgUrl =
      'https://images.pexels.com/photos/1573134/pexels-photo-1573134.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260';
  categoriesModel.categoryName = 'Wild Life';
  categories.add(categoriesModel);
  categoriesModel = CategoriesModel();

  categoriesModel.imgUrl =
      'https://images.pexels.com/photos/3408744/pexels-photo-3408744.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260';
  categoriesModel.categoryName = 'Nature';
  categories.add(categoriesModel);
  categoriesModel = CategoriesModel();

  categoriesModel.imgUrl =
      'https://images.pexels.com/photos/374870/pexels-photo-374870.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260';
  categoriesModel.categoryName = 'City';
  categories.add(categoriesModel);
  categoriesModel = CategoriesModel();

  categoriesModel.imgUrl =
      'https://images.pexels.com/photos/2794212/pexels-photo-2794212.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260';
  categoriesModel.categoryName = 'Motivation';
  categories.add(categoriesModel);
  categoriesModel = CategoriesModel();

  return categories;
}
