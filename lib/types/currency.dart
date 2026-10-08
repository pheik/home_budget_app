import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utilities.dart';
import 'currency_options.dart';

/// Controller class for handling the currency setting.
class CurrencyController {
  /// Controller widget for handling the currency setting.
  CurrencyController({required this.context});

  /// The build context.
  BuildContext context;

  /// Instance of `SharedPreferences`.
  SharedPreferences? _sharedPreferences;

  /// List of all available currencies.
  List<CurrencyOption>? _currencies;

  /// Returns the currency from the settings.
  ///
  /// If [setDefaultIfEmpty] is true and the currency setting is not set, this
  /// method sets the default currency as the currency setting and returns the
  /// default currency. Returns null if the currency cannot be set.
  Future<String?> getCurrency([bool setDefaultIfEmpty = false]) async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
    String? currency = _sharedPreferences?.getString('currency');

    if(currency != null && currency.isNotEmpty) {
      return currency;
    }
    else if(setDefaultIfEmpty) {
      String? defaultCurrency = getDefaultCurrency();
      if(defaultCurrency != null) {
        bool result = await setCurrency(defaultCurrency);
        return result ? defaultCurrency : null;
      }
    }

    return null;
  }

  /// Returns the default currency by the user's locale.
  String? getDefaultCurrency() {
    try {
      NumberFormat currencyFormat = NumberFormat.simpleCurrency(
          locale: Localizations.localeOf(context).toString()
      );
      return currencyFormat.currencyName;
    }
    catch(e) {
      return null;
    }
  }

  /// Sets the currency.
  Future<bool> setCurrency(String? newCurrency) async {
    if(validateCurrency(newCurrency)) {
      _sharedPreferences ??= await SharedPreferences.getInstance();
      bool? result = await _sharedPreferences?.setString(
          'currency', newCurrency!);

      return (result != null && result);
    }
    else {
      return false;
    }
  }

  /// Validates the given currency.
  bool validateCurrency(String? currency) {
    if(currency == null || currency.isEmpty) {
      return false;
    }

    try {
      return (CurrencyUtility.getCurrencyByCode(currency) != null);
    }
    catch(e) {
      return false;
    }
  }

  /// Returns the double value formatted for the currency.
  String? getFormattedCurrency(double? amount, String? currency) {
    if(amount == null) return null;
    try {
      double doubleValue = amount.toDouble();
      String? currencySymbol = getSymbol(currency);

      if(currency != null) {
        CurrencyOption? currencyData = CurrencyUtility.getCurrencyByCode(currency);
        String formattedValue = TypeUtility.doubleWithDecimalPlaces(
          doubleValue,
          currencyData != null ? currencyData.decimals : 2
        );
        return '$formattedValue${currencySymbol != null ? ' $currencySymbol' : ''}';
      }
      else {
        return '$doubleValue${currencySymbol != null ? ' $currencySymbol' : ''}';
      }

    }
    catch(e) {
      return null;
    }
  }

  /// Returns the currency symbol for the given currency.
  String? getSymbol(String? currency) {
    try {
      NumberFormat currencyFormat = NumberFormat.simpleCurrency(
          name: currency
      );
      return currencyFormat.currencySymbol;
    }
    catch(e) {
      return null;
    }
  }

  /// Loads all currency options.
  List<CurrencyOption> getCurrencies() {
    // Load currencies only once and store the resulting list.
    _currencies ??= CurrencyUtility.getCurrencyOptions();
    return _currencies ?? <CurrencyOption>[];
  }

}