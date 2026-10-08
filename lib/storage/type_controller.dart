import 'package:flutter/material.dart';

import '../storage/storage_controller.dart';

/// Class for defining fields and methods shared by all extending classes.
///
/// Stores an instance of `StorageController` and handles loading, saving and
/// deleting data.
abstract class TypeController {
  /// The build context.
  BuildContext context;

  /// The name of the box storing the data.
  String boxName;

  /// An instance of `StorageController` for accessing the database.
  late StorageController storageController = StorageController(
    boxName: boxName, context: context);

  /// The ID of the data.
  String? id;

  /// Controller for accessing fields and methods shared by all extending
  /// classes.
  TypeController({
    required this.context,
    required this.boxName,
    this.id
  });

  /// Loads the data with the [id] of this instance and updates the properties
  /// of this instance with the data.
  void load() {
    if(id != null && id!.isNotEmpty) {
      var res = storageController.get(id);
      if(res != null) {
        importFromMap(res);
      }
    }
  }

  /// Saves the data of this instance to the database.
  ///
  /// If this instance is saved for the first time, a new [id] gets
  /// generated automatically.
  ///
  /// Updates the [id] property of this instance after saving.
  ///
  /// Returns the [id] of this instance.
  Future<String> save() async {
    Map<dynamic, dynamic> data = exportToMap();
    String newId = await storageController.save(id, data);
    id = newId;
    return newId;
  }

  /// Deletes the data of this instance from the database.
  ///
  /// Returns `false` if the [id] property of this instance is `null` and `true`
  /// otherwise.
  Future<bool> delete() async {
    if(id != null) {
      var _ = await storageController.delete(id!);
      return true;
    } else {
      return false;
    }
  }

  /// Gets the data of all stored instances of the same type.
  Map<dynamic, dynamic> loadAllData() {
    return storageController.getAll();
  }

  /// Imports properties from the given [data] to the properties of this
  /// instance.
  ///
  /// This method is implemented by each instance type.
  void importFromMap(Map<dynamic, dynamic>? data);

  /// Exports properties from this instance to `Map`.
  ///
  /// This method is implemented by each instance type.
  Map<dynamic, dynamic> exportToMap();

}