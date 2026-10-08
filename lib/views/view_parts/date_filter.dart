import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../utilities.dart';

/// The callback for when the date filter values change.
typedef DateFilterCallback = void Function({
  DateTime? startDate,
  DateTime? endDate
});

/// Class for displaying inputs for start date and end date.
class DateFilterMenu extends StatefulWidget {
  /// Widget for displaying inputs for start date and end date.
  const DateFilterMenu({
    super.key,
    required this.onChangeCallback,
    this.initialStartDate,
    this.initialEndDate
  });

  /// The callback for when the date filter values change.
  final DateFilterCallback onChangeCallback;

  /// The initial value for the start date input.
  final DateTime? initialStartDate;

  /// The initial value for the end date input.
  final DateTime? initialEndDate;

  @override
  State<DateFilterMenu> createState() => _DateFilterMenuState();
}

class _DateFilterMenuState extends State<DateFilterMenu> {
  /// The current value of the start date filter.
  DateTime? startDateFilter;

  /// The current value of the end date filter.
  DateTime? endDateFilter;

  @override
  void initState() {
    super.initState();

    if(widget.initialStartDate == null) {
      // Set the start of the current month as the default value.
      startDateFilter = DateTimeUtility.getStartOfMonth();
    }
    if(widget.initialEndDate == null) {
      // Set the end of the current month as the default value.
      endDateFilter = DateTimeUtility.getEndOfMonth();
    }
  }

  /// Updates the state with the current values of the start date and end date
  /// filters.
  void updateFilters(String field, dynamic value) {
    switch(field) {
      // Apply changes from the date inputs.
      case 'startDate':
        // Create DateTime with the start of the day.
        DateTime? formattedValue = value != null ?
          DateTime(value.year, value.month, value.day) :
          null;
        setState(() {
          startDateFilter = formattedValue;
        });
        break;
      case 'endDate':
        // Create DateTime with the end of the day.
        DateTime? formattedValue = value != null ?
          DateTime(value.year, value.month, value.day) :
          null;
        setState(() {
          endDateFilter = formattedValue;
        });
        break;

      // Set the dates from the filter buttons.
      case 'dateFilter':
        switch(value) {
          case 'month':
            DateTime start = DateTimeUtility.getStartOfMonth();
            DateTime end = DateTimeUtility.getEndOfMonth();
            setState(() {
              startDateFilter = start;
              endDateFilter = end;
            });
            break;
          case 'year':
            DateTime start = DateTimeUtility.getStartOfYear();
            DateTime end = DateTimeUtility.getEndOfYear();
            setState(() {
              startDateFilter = start;
              endDateFilter = end;
            });
            break;
          case 'all':
          default:
            setState(() {
              startDateFilter = null;
              endDateFilter = null;
            });
            break;
        }

        break;
    }

    // Call the callback provided by the parent widget.
    widget.onChangeCallback(startDate: startDateFilter, endDate: endDateFilter);
  }

  /// Returns widgets for the start date input and the end date input.
  List<Widget> buildFilters() {
    return [
      Expanded(
        flex: 1,
        child: DateField(
          label: AppLocalizations.of(context)!.startDate,
          date: startDateFilter,
          onChangeCallback: (DateTime? value) {
            updateFilters('startDate', value);
          },
        )
      ),
      Expanded(
        flex: 1,
        child: DateField(
          label: AppLocalizations.of(context)!.endDate,
          date: endDateFilter,
          onChangeCallback: (DateTime? value) {
            updateFilters('endDate', value);
          },
        )
      )
    ];
  }

  /// Returns widgets for the filter buttons.
  ///
  /// Creates three filters: the current month, the current year and all
  /// expenses.
  List<Widget> buildFilterButtons() {
    return [
      GestureDetector(
        onTap: () {
          updateFilters('dateFilter', 'month');
        },
        child: Chip(
          label: Text(AppLocalizations.of(context)!.thisMonth)
        ),
      ),
      GestureDetector(
        onTap: () {
          updateFilters('dateFilter', 'year');
        },
        child: Chip(
          label: Text(AppLocalizations.of(context)!.thisYear)
        )
      ),
      GestureDetector(
        onTap: () {
          updateFilters('dateFilter', 'all');
        },
        child: Chip(
          label: Text(AppLocalizations.of(context)!.all)
        )
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      spacing: 10,
      children: [
        Row(
          spacing: 15,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: buildFilters()
        ),
        Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 15),
          child: Row(
            spacing: 15,
            children: [
              Flexible (
                child: Wrap(
                  spacing: 15,
                  runSpacing: 15,
                  children: buildFilterButtons()
                )
              )
            ],
          )
        )
      ]
    );

  }
}

/// The callback for when the value of the date input changes.
typedef DateFieldCallback = void Function(DateTime? date);

/// Class for displaying a date input field.
class DateField extends StatefulWidget {
  /// Widget for displaying a date input field.
  const DateField({super.key, this.label, this.date, this.onChangeCallback});

  /// The callback for when the value of the date input changes.
  final DateFieldCallback? onChangeCallback;

  /// The label text.
  final String? label;

  /// The initial date.
  final DateTime? date;

  @override
  State<DateField> createState() => _DateFieldState();
}

class _DateFieldState extends State<DateField> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    return Padding(
      padding: EdgeInsetsGeometry.all(15),
      child: DateTimeFormField(
        mode: DateTimeFieldPickerMode.date,
        decoration: InputDecoration(
            labelText: widget.label ?? AppLocalizations.of(context)!.date
        ),
        // Limit the date range to [-10 years ... +10 years] from now.
        firstDate: DateTimeUtility.getStartOfYear(year: now.year - 10),
        lastDate: DateTimeUtility.getEndOfYear(year: now.year + 10),
        initialValue: widget.date,
        initialPickerDateTime: widget.date,
        onChanged: (DateTime? value) {
          widget.onChangeCallback?.call(value);
        }
      )
    );
  }

}