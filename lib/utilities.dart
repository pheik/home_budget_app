import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

/// Class for displaying the app bar.
class AppBarUtility extends AppBar {
  /// Widget for displaying the app bar.
  AppBarUtility({super.key, required this.routeLabel, this.actionButtons});

  /// The header of the current view.
  final String routeLabel;

  /// Action buttons to be displayed in the top-right corner.
  final List<Widget>? actionButtons;

  @override
  State<AppBarUtility> createState() => _AppBarUtilityState();
}

class _AppBarUtilityState extends State<AppBarUtility> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: Navigator.of(context).canPop() ?
        IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
                Icons.arrow_back,
                semanticLabel: AppLocalizations.of(context)!.back
            )
        ) : null,
        title: Text(widget.routeLabel),
        actions: widget.actionButtons
    );
  }
}

/// Class for displaying a `FloatingActionButton`.
class ActionButtonUtility extends StatefulWidget {
  /// Widget for displaying a `FloatingActionButton`.
  const ActionButtonUtility({
    super.key,
    required this.tooltip,
    required this.icon,
    required this.onPressed
  });

  /// The tooltip and semantic label.
  final String tooltip;

  /// The icon displayed on the button.
  final IconData icon;

  /// Callback for the `onPressed` event.
  final VoidCallback? onPressed;

  @override
  State<ActionButtonUtility> createState() => _ActionButtonUtilityState();
}

class _ActionButtonUtilityState extends State<ActionButtonUtility> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      tooltip: widget.tooltip,
      onPressed: widget.onPressed,
      child: Icon(widget.icon, semanticLabel: widget.tooltip),
    );
  }
}

/// Class that contains static functions for displaying notifications.
class NotificationUtility {

  /// Displays a confirmation dialog with "Cancel" and "OK" options.
  ///
  /// Displays the [title] as the header and [content] as the message.
  static Future<bool> confirmDialog(
      BuildContext context,
      String title,
      String content
      ) async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text(AppLocalizations.of(context)!.cancel)
            ),
            TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text(AppLocalizations.of(context)!.ok)
            ),
          ],
        )
    );
  }

  /// Displays a `SnackBar` notification.
  ///
  /// Displays the [message] as the content.
  ///
  /// Set [persist] as true to make the user dismiss the message manually
  /// (e.g. when an error has occurred).
  static void notify(
      BuildContext context,
      String message,
      {
        bool persist = false
      }
      ) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          persist: persist,
          showCloseIcon: persist,
        )
    );
  }

}

/// Class that contains static functions for handling different stored types.
class TypeUtility {

  /// Deletes the given item.
  ///
  /// Displays a confirmation dialog before deletion.
  ///
  /// Returns true on success and false on failure.
  static Future<bool> deleteItem({
    required BuildContext context,
    required dynamic item,
    String? title,
    String? confirmMessage,
    Function? onSuccess,
    Function? onError
  } ) async {
    if(item?.id != null) {
      bool doDelete = await NotificationUtility.confirmDialog(
          context,
          title ?? AppLocalizations.of(context)!.deleteItem,
          confirmMessage ?? AppLocalizations.of(context)!.confirmDeletingItem
      );

      if(doDelete) {
        bool result = await item.delete();
        if(result) {
          onSuccess?.call();
          return true;
        }
      }
      else {
        return false;
      }
    }

    onError?.call();
    return false;
  }

  /// Tries to parse the given string [value] to double.
  ///
  /// Converts all commas to dots and removes spaces before parsing the [value]
  /// to double.
  ///
  /// Returns a double value if the [value] could be parsed and `null`
  /// otherwise.
  static double? parseToDouble(String value) {
    // Accept either a dot or a comma as the separator and remove spaces.
    String decimalValue = value.replaceAll(',', '.').replaceAll(' ', '');
    double? doubleValue = double.tryParse(decimalValue);
    return doubleValue;
  }

  /// Rounds the given double [value] correct to [decimalPlaces] decimal
  /// places.
  static double round(double value, {int decimalPlaces = 0}) {
    String roundedPercent = value.toStringAsFixed(decimalPlaces);
    return double.parse(roundedPercent);
  }

  /// Returns the given double [value] with [decimalPlaces] decimal
  /// places.
  static String doubleWithDecimalPlaces(double value, int decimalPlaces) {
    return value.toStringAsFixed(decimalPlaces);
  }

}

/// Class that contains static functions for handling `DateTime` items.
class DateTimeUtility {

  /// Gets DateTime for the first day of the month.
  ///
  /// Time is set to midnight.
  ///
  /// Defaults to the current year if the year is not given.
  ///
  /// Defaults to the current month if the month is not given.
  static DateTime getStartOfMonth([ int? year, int? month ]) {
    if(year == null || month == null) {
      DateTime now = DateTime.now();
      year ??= now.year;
      month ??= now.month;
    }
    return DateTime(year, month, 1);
  }

  /// Gets DateTime for the last day of the month.
  ///
  /// Time is set to midnight.
  ///
  /// Defaults to the current year if the year is not given.
  ///
  /// Defaults to the current month if the month is not given.
  static DateTime getEndOfMonth([ int? year, int? month ]) {
    if(year == null || month == null) {
      DateTime now = DateTime.now();
      year ??= now.year;
      month ??= now.month;
    }
    if(month == DateTime.december) {
      return DateTime(year, DateTime.december, 31, 23, 59, 999, 999);
    }
    else {
      return DateTime(year, month + 1, 0, 23, 59, 999, 999);
    }
  }

  /// Get DateTime for the first day of the year.
  ///
  /// Time is set to midnight.
  ///
  /// Defaults to the current year if the year is not provided.
  static DateTime getStartOfYear({ int? year }) {
    if(year == null) {
      DateTime now = DateTime.now();
      year = now.year;
    }
    return DateTime(year, DateTime.january, 1);
  }

  /// Get DateTime for the last day of the year.
  ///
  /// Time is set to midnight.
  ///
  /// Defaults to the current year if the year is not provided.
  static DateTime getEndOfYear({ int? year }) {
    if(year == null) {
      DateTime now = DateTime.now();
      year = now.year;
    }
    return DateTime(year, DateTime.december, 31, 23, 59, 999, 999);
  }

}
