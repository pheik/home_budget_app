import 'package:flutter/material.dart';
import 'package:home_budget_app/utilities.dart';
import 'package:home_budget_app/views/view_parts/date_filter.dart';

import '../l10n/app_localizations.dart';
import '../types/currency.dart';
import '../types/expense.dart';
import 'expense_form.dart';

/// Class for displaying expenses.
class ExpensesView extends StatefulWidget {
  /// Widget for displaying expenses.
  const ExpensesView({super.key});

  @override
  State<ExpensesView> createState() => _ExpensesViewState();
}

class _ExpensesViewState extends State<ExpensesView> {
  /// List of all expenses.
  List<Expense>? allExpenses;

  /// List of expenses filtered by date.
  List<Expense>? filteredExpenses;

  /// The value of the start date filter.
  DateTime? startDateFilter;

  /// The value of the end date filter.
  DateTime? endDateFilter;

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

    // Set the default values for the start date and end date.
    DateTime now = DateTime.now();
    DateTime startDate = DateTimeUtility.getStartOfMonth(now.year, now.month);
    DateTime endDate = DateTimeUtility.getEndOfMonth(now.year, now.month);
    setState(() {
      startDateFilter = startDate;
      endDateFilter = endDate;
    });

    loadExpenses();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if(currency == null) {
      loadCurrency();
    }
  }

  /// Loads the currency setting.
  Future<void> loadCurrency() async {
    String? currencySetting = await currencyController.getCurrency(true);
    setState(() {
      currency = currencySetting;
    });
  }

  /// Loads all expenses and sorts them by date in a descending order.
  ///
  /// Calls [filterExpenses()] for applying date filters.
  void loadExpenses() {
    Expense expenseHelper = Expense(context: context);
    List<Expense>? resultList = expenseHelper.getAll();
    resultList = expenseHelper.sortByDate(resultList, ascending: false);

    setState(() {
      allExpenses = resultList;
    });

    filterExpenses();
  }

  /// Displays the form for creating or editing an expense.
  ///
  /// Leaving the [expenseId] empty will display the form for creating a new
  /// expense.
  Future<void> editExpense({String? expenseId}) async {
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => ExpenseFormView(
          id: expenseId
        )
      )
    ).then((dynamic value) {
      // Update the list of expenses after returning to this view.
      loadExpenses();
    });
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

        // Update the list of expenses after successful deletion.
        loadExpenses();
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

  /// Updates the date filters.
  void updateFilters({ DateTime? startDate, DateTime? endDate }) {
    setState(() {
      startDateFilter = startDate;
      endDateFilter = endDate;
    });
    filterExpenses();
  }

  /// Filters the list of all expenses by date.
  void filterExpenses() {
    Expense expenseHelper = Expense(context: context);
    List<Expense>? resultList = (allExpenses != null && allExpenses!.isNotEmpty) ?
      expenseHelper.filterByDate(allExpenses!, startDateFilter, endDateFilter) :
      null;
    setState(() {
      filteredExpenses = resultList;
    });
  }

  /// Displays the main content of this view.
  List<Widget> displayExpenses() {
    List<Widget> resultList = <Widget>[];

    if(allExpenses == null || allExpenses!.isEmpty) {
      resultList.add(
        Padding(
          padding: EdgeInsetsGeometry.all(15),
          child: Text(AppLocalizations.of(context)!.expensesHaveNotBeenAdded)
        )
      );
    }
    else {
      resultList.addAll([
        DateFilterMenu(onChangeCallback: updateFilters),

        (filteredExpenses == null || filteredExpenses!.isEmpty) ?
          Padding(
            padding: EdgeInsetsGeometry.all(15),
            child: Text(
              AppLocalizations.of(context)!.noExpensesFoundWithFilters
            )
          ) :
          Expanded(
            child: ListView(
              children: buildExpenseList()
            )
          )
      ]);
    }

    return resultList;
  }

  /// Builds the displayed list of expenses.
  List<Widget> buildExpenseList() {
    List<Widget> resultList = <Widget>[];

    filteredExpenses?.forEach((item) {
      String dateLabel = item.getDateFormatted();
      String amountLabel = currencyController.getFormattedCurrency(item.amount, currency) ?? '';

      String categoryLabel = item.getCategoryFormatted();
      String subtitle = categoryLabel.isNotEmpty ?
        '$amountLabel\n$categoryLabel' :
        amountLabel;

      List<MenuItemButton> menuItems = [
        MenuItemButton(
          onPressed: () {
            editExpense(expenseId: item.id);
          },
          child: Text(AppLocalizations.of(context)!.edit)
        ),
        MenuItemButton(
          onPressed: () async {
            await deleteExpense(item);
          },
          child: Text(
            AppLocalizations.of(context)!.delete,
            style: TextStyle(color: Colors.red)
          )
        ),
      ];

      resultList.add(
        ListTile(
          title: Text(dateLabel),
          subtitle: Text(subtitle),
          trailing: MenuAnchor(
            menuChildren: menuItems,
            builder: (_, MenuController controller, Widget? child) {
              return IconButton(
                onPressed: () {
                  if (controller.isOpen) {
                    controller.close();
                  } else {
                    controller.open();
                  }
                },
                icon: Icon(
                  Icons.more_vert,
                  semanticLabel: AppLocalizations.of(context)!.options
                )
              );
            },
          ),
          onTap: () {
            editExpense(expenseId: item.id);
          }
        )
      );
    });

    return resultList;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBarUtility(
        routeLabel: AppLocalizations.of(context)!.expenses,
        actionButtons: [
          IconButton(
            onPressed: () {
              editExpense();
            },
            icon: Icon(
              Icons.add,
              semanticLabel: AppLocalizations.of(context)!.addExpense
            )
          )
        ],
      ),
      body: Column (
        spacing: 15,
        children: displayExpenses()
      )
    );

  }
}