import 'package:flutter/cupertino.dart';
import 'package:xuseme/model/category_model.dart';

import '../api_services/api_services.dart';

class CategoryProvider extends ChangeNotifier {

  final ApiServices _apiServices = ApiServices();
  bool _isLoading = false;
  List<CategoryModel> _categoryList = [];

  List<CategoryModel> get categoryList => _categoryList;
  bool get isLoading => _isLoading;

  Future<void> categoryData() async {
    _isLoading = true;
    _categoryList.clear();
    await _apiServices.getCategory().then((value) {
      _categoryList = value;
      _isLoading = false;
      notifyListeners();
    });
  }
}
