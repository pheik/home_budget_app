import 'package:home_budget_app/storage/type_controller.dart';

/// Class for handling the BudgetCategory type.
class BudgetCategory extends TypeController {

  /// Type for handling category information.
  BudgetCategory({
    required super.context,
    super.id
  }) : super(boxName: 'categories');

  /// The name of the category.
  String? name;

  /// Exports properties from this `BudgetCategory` to `Map`.
  @override
  Map<String, dynamic> exportToMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }

  /// Imports properties from the given [data] to the properties of this
  /// `BudgetCategory`.
  @override
  void importFromMap(Map<dynamic, dynamic>? data) {
    if(data != null) {
      name = data['name'];
    }
  }

  /// Loads and returns a list of all data of the type `BudgetCategory`.
  ///
  /// Returns an empty list if data was not found.
  List<BudgetCategory> getAll() {
    List<BudgetCategory> resultList = <BudgetCategory>[];
    Map<dynamic, dynamic> data = loadAllData();

    if (data.isNotEmpty) {
      data.forEach((dynamic key, dynamic value) {
        String stringKey = key.toString();
        BudgetCategory category = BudgetCategory(
          context: context,
          id: stringKey
        );
        category.importFromMap(value);
        resultList.add(category);
      });
    }

    return resultList;
  }

}