import '../models/category_model.dart';

List<CategoryModel> getCategories() {
  List<CategoryModel> categories = List<CategoryModel>.empty(growable: true);
  CategoryModel categoryModel = CategoryModel();

  categoryModel.categoryName = "Business";
  categoryModel.imageUrl = 'assets/news_categories/economy.jpg';
  categories.add(categoryModel);

  categoryModel = CategoryModel();
  categoryModel.categoryName = "General";
  categoryModel.imageUrl = 'assets/news_categories/general.jpg';
  categories.add(categoryModel);

  categoryModel = CategoryModel();
  categoryModel.categoryName = "Sports";
  categoryModel.imageUrl = 'assets/news_categories/sport.jpg';
  categories.add(categoryModel);

  categoryModel = CategoryModel();
  categoryModel.categoryName = "Technology";
  categoryModel.imageUrl = 'assets/news_categories/technologies.jpg';
  categories.add(categoryModel);

  return categories;
}
