import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// Class for accessing storage.
class StorageController {
  /// The name of the box storing the data.
  final String boxName;

  /// The build context.
  final BuildContext context;

  /// The Hive box.
  late final box = Hive.box(boxName);

  /// Controller for accessing storage.
  StorageController({required this.boxName, required this.context});

  /// Gets all the data from the box.
  Map<dynamic, dynamic> getAll() {
    return box.toMap();
  }

  /// Gets data from the box with the given [key].
  ///
  /// Returns `null` if the [key] is `null`.
  dynamic get(String? key) {
    if(key != null) {
      return box.get(key);
    }
    else {
      return null;
    }
  }

  /// Stores data to the box with the given [key].
  ///
  /// Returns the key used for storing the data.
  ///
  /// If the [key] is `null`, the data will be stored with the string-formatted
  /// current timestamp as the key.
  Future<String> save(String? key, dynamic value) async {
    String storedKey = key ?? DateTime.timestamp().toString();
    await box.put(storedKey, value);
    return storedKey;
  }

  /// Deletes data from the box with the given [key].
  Future<void> delete(String key) async {
    return await box.delete(key);
  }
}