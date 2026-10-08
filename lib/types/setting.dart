import 'package:home_budget_app/storage/type_controller.dart';

/// The parent class for all Setting instances.
class Setting extends TypeController {

  /// Type for handling settings.
  Setting({
    required super.context,
    super.id,
  }) : super(boxName: 'settings');

  dynamic value;

  /// Exports properties from this `Setting` to `Map`.
  @override
  Map<String, dynamic> exportToMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    return data;
  }

  /// Imports properties from the given [data] to the properties of this
  /// `Setting`.
  @override
  void importFromMap(Map<dynamic, dynamic>? data) {
    if(data != null) {
      value = data['value'];
    }
  }

  /// Loads and returns a list of all data of the type `Setting`, including any
  /// type that extends the `Setting` class.
  ///
  /// Returns an empty list if data was not found.
  List<Setting> getAll() {
    List<Setting> resultList = <Setting>[];
    Map<dynamic, dynamic> data = loadAllData();

    if(data.isNotEmpty) {
      data.forEach((dynamic key, dynamic value) {
        String stringKey = key.toString();
        Setting setting = Setting(context: context, id: stringKey);
        setting.importFromMap(value);
        resultList.add(setting);
      });
    }

    return resultList;
  }

}