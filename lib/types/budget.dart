import 'package:home_budget_app/types/setting.dart';

import '../../l10n/app_localizations.dart';
import '../../utilities.dart';
import 'currency_options.dart';

/// Class for handling the Budget setting.
class Budget extends Setting {

  /// Type for handling the Budget setting.
  Budget({
    required super.context,
  }) : super(id: 'budget');

  /// Checks if the given budget [value] is valid.
  ///
  /// Accepts the [value] as valid if it can be parsed to `double` and if it is
  /// equal to or greater than zero.
  ///
  /// Accepts an empty or `null` [value] as valid.
  ///
  /// Returns `null` if the [value] is valid and an error message `String` if
  /// the [value] is invalid.
  dynamic validateBudget(String? value) {
    if(value != null && value.isNotEmpty) {
      double? doubleValue = TypeUtility.parseToDouble(value);

      if(doubleValue != null && doubleValue >= 0) {
        return doubleValue;
      }
      else {
        return AppLocalizations.of(context)!.budgetIsInvalid;
      }

    } else {
      // Null value is considered valid.
      return null;
    }
  }

  /// Formats the given budget value as string.
  ///
  /// Sets the decimal places according to the given [currency].
  String? getValueFormatted(double? budgetValue, String? currency) {
    if(budgetValue == null) return null;
    try {
      double doubleValue = budgetValue.toDouble();
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

  /// Gets the data of all stored instances of the type `Setting`.
  @override
  List<Setting> getAll() {
    List<Setting> resultList = <Setting>[];
    resultList.add(this);
    return resultList;
  }

}