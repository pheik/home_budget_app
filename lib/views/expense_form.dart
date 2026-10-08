import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:home_budget_app/utilities.dart';

import '../l10n/app_localizations.dart';
import '../types/budget_category.dart';
import '../types/currency.dart';
import '../types/expense.dart';

/// Class for creating or editing an expense.
class ExpenseFormView extends StatefulWidget {
  /// Widget for displaying a form for creating or editing an expense.
  const ExpenseFormView({super.key, this.id});

  /// The ID of the expense.
  ///
  /// Set as `null` to create a new expense.
  final String? id;

  @override
  State<ExpenseFormView> createState() => _ExpenseFormViewState();
}

class _ExpenseFormViewState extends State<ExpenseFormView> {
  /// The form key.
  final _formKey = GlobalKey<FormState>();

  /// The expense.
  Expense? expense;

  /// List of all available categories.
  List<BudgetCategory> categories = <BudgetCategory>[];

  /// List of `DropdownMenuEntry` items for each category option.
  List<DropdownMenuEntry> categoryOptions = <DropdownMenuEntry>[];

  /// Controller for editing the amount.
  final TextEditingController amountEditingController = TextEditingController();

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

    amountEditingController.addListener(updateAmountField);

    loadCurrency();
    loadExpense();
    loadCategories();
  }

  @override
  dispose() {
    super.dispose();
    amountEditingController.dispose();
  }

  /// Loads the currency information.
  Future<void> loadCurrency() async {
    String? currencySetting = await currencyController.getCurrency(true);
    setState(() {
      currency = currencySetting;
    });

    // After the currency is loaded, update the initial value for the amount field.
    updateAmountField(true);
  }

  /// Updates the value of the text editing controller of the amount field.
  ///
  /// Set [setInitialValue] as true when setting the initial value.
  void updateAmountField([bool setInitialValue = false]) {
    String newValue = amountEditingController.text;
    if(setInitialValue) {
      newValue = expense?.amount != null ?
        (expense?.getAmountFormatted(currency) ?? '') : '';
    }
    amountEditingController.value = amountEditingController.value.copyWith(
      text: newValue
    );
  }

  /// Loads the expense information.
  void loadExpense() {
    Expense expenseItem = Expense(context: context, id: widget.id);
    expenseItem.load();

    setState(() {
      expense = expenseItem;
    });
  }

  /// Loads all categories from the settings.
  void loadCategories() {
    BudgetCategory categoryHelper = BudgetCategory(context: context);
    List<BudgetCategory> categoryList = categoryHelper.getAll();
    if(categoryList.isNotEmpty) {
      setState(() {
        categories = categoryList;
      });
    }
  }

  /// Builds `DropdownMenuEntry` items for each category.
  void generateCategoryOptions() {
    List<DropdownMenuEntry> menuEntries = <DropdownMenuEntry>[];

    // Add the null option.
    menuEntries.add(
      DropdownMenuEntry(
        value: null,
        label: AppLocalizations.of(context)!.noCategory
      )
    );

    if(categories.isNotEmpty) {
      // Add the other options.
      menuEntries.addAll(
        List<DropdownMenuEntry>.generate(categories.length, (int i) {
          BudgetCategory item = categories[i];
            return DropdownMenuEntry(
              value: item.id,
              label: item.name ?? AppLocalizations.of(context)!.unnamedCategory
            );
          }
        )
      );
    }

    setState(() {
      categoryOptions = menuEntries;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if(currency == null) {
      loadCurrency();
    }

    // Call generateCategoryOptions after initState has completed and
    // localizations have become available.
    if(categoryOptions.isEmpty) {
      generateCategoryOptions();
    }
  }

  /// Deletes the [expenseItem].
  ///
  /// Displays a confirmation dialog before deletion.
  Future<void> deleteExpense(Expense? expenseItem) async {
    await TypeUtility.deleteItem(
      context: context,
      item: expenseItem,
      title: AppLocalizations.of(context)!.deleteExpense,
      confirmMessage: AppLocalizations.of(context)!.confirmDeletingExpense,
      onSuccess: () {
        NotificationUtility.notify(
          context,
          AppLocalizations.of(context)!.expenseDeleted
        );

        // Return to the previous view.
        if(Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }
      },
      onError: () {
        NotificationUtility.notify(
          context,
          AppLocalizations.of(context)!.failedToDeleteExpense,
          persist: true
        );
      }
    );
  }

  /// Returns a list of actions buttons for saving and deleting the expense.
  List<IconButton> buildEditingButtons(BuildContext context) {
    List<IconButton> buttons = <IconButton>[];

    buttons.add(
      IconButton(
        onPressed: () async {
          // Validate the form and save changes.
          if(_formKey.currentState != null && _formKey.currentState!.validate()) {
            await expense?.save().whenComplete(() {
              if(context.mounted) {
                NotificationUtility.notify(
                  context,
                  AppLocalizations.of(context)!.changesSaved
                );

                // Return to the previous view.
                if(Navigator.of(context).canPop()) {
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
    );

    if(expense?.id != null) {
      buttons.add(
        IconButton(
          onPressed: () async {
            deleteExpense(expense);
          },
          icon: Icon(
            Icons.delete,
            semanticLabel: AppLocalizations.of(context)!.delete
          )
        )
      );
    }

    return buttons;
  }

  @override
  Widget build(BuildContext context) {
    String routeLabel = widget.id != null ?
      AppLocalizations.of(context)!.editExpense :
      AppLocalizations.of(context)!.addExpense;

    if(expense != null && expense?.date == null) {
      expense?.date = DateTime.now();
    }

    return Scaffold(
      appBar: AppBarUtility(
        routeLabel: routeLabel,
        actionButtons: buildEditingButtons(context),
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
            spacing: 20,
            children: [
              DateTimeFormField(
                mode: DateTimeFieldPickerMode.date,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.date
                ),
                firstDate: DateTime.now().subtract(
                  const Duration(days: 365 * 5)
                ),
                lastDate: DateTime.now().add(
                  const Duration(days: 365 * 5)
                ),
                initialValue: expense?.date,
                initialPickerDateTime: expense?.date,
                validator: (value) {
                  if(value != null) {
                    return null;
                  }
                  else {
                    return AppLocalizations.of(context)!.dateMustNotBeEmpty;
                  }
                },
                onChanged: (DateTime? value) {
                  expense?.date = value;
                }
              ),

              TextFormField(
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.amount,
                  suffixText: currencyController.getSymbol(currency) ?? ''
                ),
                keyboardType: TextInputType.numberWithOptions(
                  decimal: true,
                  signed: false
                ),
                controller: amountEditingController,
                validator: (value) {
                  dynamic validationResult = expense?.validateAmount(value);
                  if(validationResult is String) {
                    // Received an error message.
                    return validationResult;
                  }
                  else {
                    // Received a double value (ok).
                    expense?.amount = validationResult;
                    return null;
                  }
                }
              ),

              DropdownMenu(
                width: MediaQuery.of(context).size.width,
                label: Text(
                  '${AppLocalizations.of(context)!.category} (${AppLocalizations.of(context)!.optional})'
                ),
                dropdownMenuEntries: categoryOptions,
                initialSelection: expense?.category?.id,
                helperText: categories.isEmpty ?
                  AppLocalizations.of(context)!.createCategoriesFromSettings :
                  null,
                onSelected: (value) {
                  if(value == null) {
                    expense?.category = null;
                  }
                  else {
                    BudgetCategory? selectedCategory;
                    try {
                      selectedCategory = categories.firstWhere(
                        (item) => item.id == value
                      );
                      expense?.category = selectedCategory;
                    }
                    catch(e) {
                      expense?.category = null;
                    }
                  }
                },
              )
            ]
          )
        )
      )
    );
  }
}