import 'package:flutter/material.dart';
import '../types/currency.dart';
import '../utilities.dart';
import '../types/budget.dart';
import '../l10n/app_localizations.dart';

/// Class for displaying the budget editing view.
class BudgetFormView extends StatefulWidget {
  /// Widget for displaying the budget editing view.
  const BudgetFormView({super.key});

  @override
  State<BudgetFormView> createState() => _BudgetFormViewState();
}

class _BudgetFormViewState extends State<BudgetFormView> {
  /// The form key.
  final _formKey = GlobalKey<FormState>();

  /// The `Budget` that stores the budget information.
  Budget? budgetSetting;

  /// The current budget.
  double? currentBudget;

  /// Controller for editing the budget.
  final TextEditingController budgetEditingController = TextEditingController();

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

    budgetEditingController.addListener(updateBudgetField);

    loadBudget();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if(currency == null) {
      loadCurrency();
    }
  }

  /// Loads the budget information from the settings.
  void loadBudget() {
    budgetSetting = Budget(context: context);
    budgetSetting?.load();

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

    // After the currency is loaded, update the initial value for the budget field.
    updateBudgetField(true);
  }

  /// Updates the value of the text editing controller of the budget field.
  ///
  /// Set [setInitialValue] as true when setting the initial value.
  void updateBudgetField([bool setInitialValue = false]) {
    String newValue = budgetEditingController.text;
    if(setInitialValue) {
      newValue = currentBudget != null ?
        (budgetSetting?.getValueFormatted(currentBudget, currency) ?? '') : '';
    }
    budgetEditingController.value = budgetEditingController.value.copyWith(
      text: newValue
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBarUtility(
        routeLabel: AppLocalizations.of(context)!.editBudget,
        actionButtons: [
          IconButton(
            onPressed: () async {
              // Validate the form and save changes.
              if(_formKey.currentState != null && _formKey.currentState!.validate()) {
                await budgetSetting?.save().whenComplete(() {
                  if(context.mounted) {
                    NotificationUtility.notify(context,
                      AppLocalizations.of(context)!.changesSaved);

                    // Return to the previous view.
                    if(Navigator.canPop(context)) {
                      Navigator.of(context).pop();
                    }
                  }
                });
              }
            },
            icon: Icon(
              Icons.check,
              semanticLabel: AppLocalizations.of(context)!.save
            )
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsetsGeometry.directional(
          start: 20,
          end: 20,
          top: 10,
          bottom: 10
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.monthlyBudget,
                  suffixText: currencyController.getSymbol(currency) ?? ''
                ),
                keyboardType: TextInputType.numberWithOptions(
                    decimal: true,
                    signed: false
                ),
                controller: budgetEditingController,
                validator: (value) {
                  var validationResult = budgetSetting?.validateBudget(value);
                  if(validationResult is String) {
                    // Received an error message.
                    return validationResult;
                  }
                  else {
                    // Received a double or null value (both ok).
                    budgetSetting?.value = validationResult;
                    return null;
                  }
                }
              ),
            ],
          )
        )
      )
    );

  }
}