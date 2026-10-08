import 'package:flutter/material.dart';
import 'package:home_budget_app/utilities.dart';
import 'package:home_budget_app/types/setting.dart';
import 'package:home_budget_app/views/budget_form.dart';
import 'package:home_budget_app/views/categories.dart';

import '../l10n/app_localizations.dart';
import '../types/currency.dart';
import 'currency_form.dart';

/// Class for displaying the app settings view.
class AppSettingsView extends StatefulWidget {
  /// Widget for displaying the app settings view.
  const AppSettingsView({super.key});

  @override
  State<AppSettingsView> createState() => _AppSettingsViewState();
}

class _AppSettingsViewState extends State<AppSettingsView> {
  /// The `Setting` that stores the budget information.
  Setting? budgetSetting;

  /// The budget defined in the settings.
  double? currentBudget;

  /// Controller for accessing currency information.
  late CurrencyController currencyController;

  /// The selected currency.
  String? currency;

  @override
  void initState() {
    super.initState();

    CurrencyController controller = CurrencyController(context: context);
    setState(() {
      currencyController = controller;
    });

    loadSettings();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Load currency setting after localizations have become available.
    if(currency == null) {
      loadCurrency();
    }
  }

  /// Loads the budget information from the settings.
  void loadSettings() {
    Setting settingHelper = Setting(context: context);
    List<Setting> allSettings = settingHelper.getAll();

    try {
      budgetSetting = allSettings.firstWhere((item) => item.id == 'budget');
    }
    catch(e) {
      budgetSetting = Setting(context: context, id: 'budget');
    }

    setState(() {
      currentBudget = budgetSetting?.value;
    });
  }

  /// Loads the currency setting.
  Future<void> loadCurrency() async {
    String? currencySetting = await currencyController.getCurrency(true);
    setState(() {
      currency = currencySetting;
    });
  }

  /// Returns a label for the budget.
  String getBudgetLabel() {
    if(currentBudget == null) {
      return AppLocalizations.of(context)!.setMonthlyBudget;
    }
    String budgetLabel = currencyController.getFormattedCurrency(currentBudget, currency) ?? '';

    return budgetLabel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarUtility(routeLabel: AppLocalizations.of(context)!.settings),
      body: ListView(
        children: [
          ListTile(
            title: Text(AppLocalizations.of(context)!.monthlyBudget),
            subtitle: Text(getBudgetLabel()),
            onTap: () async {
              // Display the budget form.
              await Navigator.of(context).push(
                MaterialPageRoute<void>(
                    builder: (context) => const BudgetFormView()
                )
              ).whenComplete(() {
                // Update state after returning to this view.
                loadSettings();
              });
            }
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.categories),
            subtitle: Text(
                AppLocalizations.of(context)!.editAvailableCategories
            ),
            onTap: () async {
              // Display the category form.
              await Navigator.of(context).push(
                MaterialPageRoute<void>(
                    builder: (context) => const CategoriesView()
                )
              );
            }
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.currency),
            subtitle: Text(currency ?? ''),
            onTap: () async {
              // Display the currency form.
              await Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (context) => const CurrencyFormView()
                )
              ).whenComplete(() {
                // Update state after returning to this view.
                loadCurrency();
              });
            }
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.about),
            subtitle: Text(
              AppLocalizations.of(context)!.informationAboutApplication
            ),
            onTap: () async {
              showAboutDialog(context: context);
            }
          ),
        ],
      )
    );

  }

}

