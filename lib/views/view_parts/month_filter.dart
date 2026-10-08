import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../l10n/app_localizations.dart';

/// The callback for when the month filter value changes.
typedef MonthFilterCallback = void Function({
  required int month,
  required int year
});

/// Class for displaying inputs for selecting a month and a year.
class MonthFilterMenu extends StatefulWidget {
  /// Widget for displaying inputs for selecting a month and a year.
  const MonthFilterMenu({
    super.key,
    required this.onChangeCallback,
    this.initialMonth,
    this.initialYear
  });

  /// The callback for when the month filter value changes.
  final MonthFilterCallback onChangeCallback;

  /// The initial value for the month input.
  final int? initialMonth;

  /// The initial value for the year input.
  final int? initialYear;

  @override
  State<MonthFilterMenu> createState() => _MonthFilterMenuState();
}

class _MonthFilterMenuState extends State<MonthFilterMenu> {
  /// The current value of the month input.
  int? monthFilter;

  /// The current value of the year input.
  int? yearFilter;

  @override
  void initState() {
    super.initState();

    // Default to the current month and year.
    monthFilter = widget.initialMonth ?? DateTime.now().month;
    yearFilter = widget.initialYear ?? DateTime.now().year;
  }

  /// Updates the state with the current values of the month and year filters.
  void updateFilters(String field, dynamic value) {
    switch(field) {
      case 'month':
        setState(() {
          monthFilter = value;
        });
        break;
      case 'year':
        setState(() {
          yearFilter = value;
        });
        break;
    }

    // Call the callback provided by the parent widget.
    widget.onChangeCallback(month: monthFilter!, year: yearFilter!);
  }

  /// Returns a list of `DropdownMenuEntry` items for each month option.
  List<DropdownMenuEntry> buildMonthOptions() {
    return List<DropdownMenuEntry>.generate(12, (int i) {
      int index = i + 1;
      return DropdownMenuEntry(
        value: index,
        label: DateFormat('MMMM').format(DateTime(DateTime.now().year, index))
      );
    }).toList();
  }

  /// Returns a list of `DropdownMenuEntry` items for each year option.
  List<DropdownMenuEntry> buildYearOptions() {
    // Create a range of [-10 years...current year].
    int index = DateTime.now().year + 1;
    return List<DropdownMenuEntry>.generate(11, (int i) {
      index -= 1;
      return DropdownMenuEntry(
        value: index,
        label: index.toString()
      );
    }).toList();
  }

  /// Returns widgets for the month input and the year input.
  List<Widget> buildFilters() {
    return [
      DropdownMenu(
        label: Text(AppLocalizations.of(context)!.month),
        dropdownMenuEntries: buildMonthOptions(),
        initialSelection: monthFilter,
        onSelected: (value) {
          updateFilters('month', value);
        },
      ),
      DropdownMenu(
        label: Text(AppLocalizations.of(context)!.year),
        dropdownMenuEntries: buildYearOptions(),
        initialSelection: yearFilter,
        onSelected: (value) {
          updateFilters('year', value);
        },
      )
    ];
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsetsGeometry.all(15),
      child: Row(
        spacing: 15,
        mainAxisSize: MainAxisSize.max,
        children: [
          Flexible (
            child: Wrap(
              spacing: 15,
              runSpacing: 15,
              children: buildFilters()
            )
          )
        ]
      )
    );

  }
}