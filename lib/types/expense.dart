import 'package:home_budget_app/types/budget_category.dart';
import 'package:home_budget_app/storage/type_controller.dart';
import 'package:intl/intl.dart';

import '../../l10n/app_localizations.dart';
import '../../utilities.dart';
import 'currency_options.dart';

/// Class for handling the Expense type.
class Expense extends TypeController {

  /// Type for handling expense information
  Expense({
    required super.context,
    super.id
  }) : super(boxName: 'expenses');

  /// The date of the expense.
  DateTime? date;

  /// The expended amount of money.
  double? amount;

  /// The category of the expense in the budget.
  BudgetCategory? category;

  /// Exports properties from this `Expense` to `Map`.
  @override
  Map<String, dynamic> exportToMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['amount'] = amount;
    data['category'] = category?.id;
    return data;
  }

  /// Imports properties from the given [data] to the properties of this
  /// `Expense`.
  @override
  void importFromMap(Map<dynamic, dynamic>? data) {
    if(data != null) {
      date = data['date'];
      amount = data['amount'];

      if(data['category'] is Map) {
        BudgetCategory categoryHelper = BudgetCategory(context: context);
        categoryHelper.importFromMap(data['category']);
        category = categoryHelper.id != null ? categoryHelper : null;
      }
      else if(data['category'] is String) {
        BudgetCategory categoryHelper = BudgetCategory(
          context: context,
          id: data['category']
        );
        categoryHelper.load();
        category = categoryHelper;
      }
      else {
        category = null;
      }
    }
  }

  /// Loads and returns a list of all data of the type `Expense`.
  ///
  /// Returns an empty list if data was not found.
  List<Expense> getAll() {
    List<Expense> resultList = <Expense>[];
    Map<dynamic, dynamic> data = loadAllData();

    if (data.isNotEmpty) {
      data.forEach((dynamic key, dynamic value) {
        String stringKey = key.toString();
        Expense expense = Expense(context: context, id: stringKey);
        expense.importFromMap(value);
        resultList.add(expense);
      });
    }

    return resultList;
  }

  /// Returns the given [expenses] sorted by date.
  List<Expense> sortByDate(List<Expense> expenses, { bool ascending = true }) {
    expenses.sort((Expense a, Expense b) {
      DateTime? aDate = a.date;
      DateTime? bDate = b.date;

      try {
        DateTime? aAddDate = DateTime.parse(aDate.toString());
        DateTime? bAddDate = DateTime.parse(bDate.toString());

        int comparison = aAddDate.compareTo(bAddDate);
        if(comparison < 0) {
          if(ascending) {
            return -1;
          } else {
            return 1;
          }
        } else if (comparison > 0) {
          if(ascending) {
            return 1;
          } else {
            return -1;
          }
        } else {
          return comparison;
        }
      } catch(e) {
        return 0;
      }
    });

    return expenses;
  }

  /// Returns the given [expenses] filtered by date.
  ///
  /// If both the [startDate] and [endDate] are `null`, returns the [expenses]
  /// list as-is.
  List<Expense>? filterByDate(
      List<Expense>? expenses,
      DateTime? startDate,
      DateTime? endDate
  ) {
    if(expenses == null || expenses.isEmpty ||
      (startDate == null && endDate == null)) {
      return expenses;
    }
    // Take the time of day into account.
    DateTime? endDateEnd = endDate != null ?
      DateTime(endDate.year, endDate.month, endDate.day, 23, 59, 999, 999) :
      null;

    return expenses.where((item) {
      return (item.date == null ||
          ((startDate == null || item.date!.compareTo(startDate) >= 0) &&
          (endDateEnd == null || item.date!.compareTo(endDateEnd) <= 0)));
    }).toList();
  }

  /// Returns the `date` property of this instance formatted to `d.m.Y`.
  ///
  /// Returns an empty string if the `date` is null.
  String getDateFormatted() {
    if(date != null) {
      return DateFormat('d.M.y').format(date!).toString();
    }
    return '';
  }

  /// Gets the `amount` property of this instance as string.
  ///
  /// Sets the decimal places according to the given [currency].
  String? getAmountFormatted(String? currency) {
    if(amount == null) return null;
    try {
      double doubleValue = amount?.toDouble() ?? 0.0;
      if(currency != null) {
        CurrencyOption? currencyData = CurrencyUtility.getCurrencyByCode(currency);
        String formattedValue = TypeUtility.doubleWithDecimalPlaces(
          doubleValue,
          currencyData != null ? currencyData.decimals : 2
        );
        return formattedValue;
      }
      else {
        return doubleValue.toString();
      }
    }
    catch(e) {
      return null;
    }
  }

  /// Gets the `name` property of the `category` of this instance.
  ///
  /// Returns an empty string if the `category` is `null` or if the name of the
  /// `category` is `null` or empty.
  String getCategoryFormatted() {
    return category?.name ?? '';
  }

  /// Checks if the given amount [value] is valid.
  ///
  /// Accepts the [value] as valid if it can be parsed to `double` and if it is
  /// greater than zero.
  ///
  /// Does not accept an empty or `null` [value] as valid.
  ///
  /// Returns `null` if the [value] is valid and an error message `String` if
  /// the [value] is invalid.
  dynamic validateAmount(String? value) {
    if(value != null && value.isNotEmpty) {
      double? doubleValue = TypeUtility.parseToDouble(value);

      if(doubleValue != null && doubleValue > 0) {
        return doubleValue;
      }
    }
    return AppLocalizations.of(context)!.amountIsInvalid;
  }

}