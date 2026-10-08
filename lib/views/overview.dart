import 'package:flutter/material.dart';
import 'package:home_budget_app/utilities.dart';
import 'package:home_budget_app/views/view_parts/month_filter.dart';
import 'package:home_budget_app/views/view_parts/pie_chart.dart';
import 'package:home_budget_app/views/view_parts/simple_table.dart';

import '../l10n/app_localizations.dart';
import '../types/budget.dart';
import '../types/currency.dart';
import '../types/expense.dart';
import '../types/budget_category.dart';

/// Class for displaying a summary of expenses.
class BudgetOverview extends StatefulWidget {
  /// Widget for displaying a summary of expenses.
  const BudgetOverview({super.key});

  @override
  State<BudgetOverview> createState() => _BudgetOverviewState();
}

class _BudgetOverviewState extends State<BudgetOverview> {
  /// The `Budget` that stores the budget information.
  Budget? budgetSetting;

  /// The current budget.
  double? currentBudget;

  /// Controller for accessing currency information.
  late CurrencyController currencyController;

  /// The selected currency.
  String? currency;

  /// List of all categories.
  List<BudgetCategory>? categories;

  /// List of all expenses.
  List<Expense>? allExpenses;

  /// List of expenses filtered by date.
  List<Expense>? filteredExpenses;

  /// Map for storing sums of expenses by category.
  Map totals = {};

  /// The value of the start date filter.
  DateTime? startDateFilter;

  /// The value of the end date filter.
  DateTime? endDateFilter;

  @override
  void initState() {
    super.initState();

    CurrencyController controller = CurrencyController(context: context);
    setState(() {
      currencyController = controller;
    });

    loadBudget();
    loadCategories();
    loadExpenses();

    // Set the current month and year as the defaults.
    DateTime now = DateTime.now();
    updateFilters(month: now.month, year: now.year);
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

  /// Loads the budget information from the settings.
  void loadBudget() {
    budgetSetting = Budget(context: context);
    budgetSetting?.load();

    setState(() {
      currentBudget = budgetSetting?.value;
    });
  }

  /// Loads all categories.
  void loadCategories() {
    BudgetCategory categoryHelper = BudgetCategory(context: context);
    List<BudgetCategory> categoryList = categoryHelper.getAll();

    setState(() {
      categories = categoryList;
    });
  }

  /// Loads all expenses.
  void loadExpenses() {
    Expense expenseHelper = Expense(context: context);
    List<Expense>? resultList = expenseHelper.getAll();
    resultList = expenseHelper.sortByDate(resultList, ascending: false);

    setState(() {
      allExpenses = resultList;
    });
  }

  /// Updates the date filters.
  void updateFilters({ required int month, required int year }) {
    DateTime startDate = DateTimeUtility.getStartOfMonth(year, month);
    DateTime endDate = DateTimeUtility.getEndOfMonth(year, month);

    setState(() {
      startDateFilter = startDate;
      endDateFilter = endDate;
    });
    filterExpenses();
  }

  /// Filters expenses by date.
  void filterExpenses() {
    Expense expenseHelper = Expense(context: context);
    List<Expense>? resultList = (allExpenses != null && allExpenses!.isNotEmpty) ?
      expenseHelper.filterByDate(allExpenses!, startDateFilter, endDateFilter) :
      null;
    setState(() {
      filteredExpenses = resultList;
    });
    calculateTotals();
  }

  /// Calculates total expenses by category.
  ///
  /// Includes only the expenses that have been filtered by date.
  void calculateTotals() {
    Map resultMap = {
      'null': 0.0,
      'all': 0.0
    };

    filteredExpenses?.forEach((expense) {
      String? categoryId = expense.category?.id;

      // Check if the category still exists.
      BudgetCategory? category;
      try {
        category = categories?.firstWhere((item) => item.id == categoryId);
      }
      catch(e) {
        category = null;
      }

      if(category != null) {
        if(!resultMap.containsKey(categoryId)) {
          resultMap[categoryId] = 0.0;
        }
        resultMap[categoryId] += expense.amount ?? 0.0;
      }
      else {
        resultMap['null'] += expense.amount ?? 0.0;
      }

      resultMap['all'] += expense.amount ?? 0.0;
    });

    setState(() {
      totals = resultMap;
    });
  }

  /// Returns a list of `ChartSection` items for expenses in each category.
  List<ChartSection> getPieChartData() {
    List<ChartSection> sections = <ChartSection>[];

    double totalSum = totals['all'];
    if(totalSum > 0) {
      categories?.forEach((category) {
        double? categorySum = totals[category.id];
        if (categorySum != null) {
          String categoryName = category.name ??
            AppLocalizations.of(context)!.unnamedCategory;
          sections.add(
            ChartSection(
              percent: categorySum / totalSum * 100,
              label: categoryName
            )
          );
        }
      });

      double emptyCategorySum = totals['null'];
      if(emptyCategorySum > 0) {
        sections.add(
          ChartSection(
            percent: emptyCategorySum / totalSum * 100,
            label: AppLocalizations.of(context)!.noCategory
          )
        );
      }
    }

    return sections;
  }

  /// Returns a list of `SimpleTableRow` items for expenses in each category.
  List<SimpleTableRow> getTableBodyData() {
    List<SimpleTableRow> rows = <SimpleTableRow>[];

    double totalSum = totals['all'];
    if(totalSum > 0) {
      // Add rows for each category.
      categories?.forEach((category) {
        double? categorySum = totals[category.id];
        if (categorySum != null) {
          String categoryName = category.name ??
            AppLocalizations.of(context)!.unnamedCategory;
          rows.add(
            SimpleTableRow(
              cells: [
                SimpleTableCell(
                  content: categoryName,
                  isHeader: true
                ),
                SimpleTableCell(
                  content: '${currencyController.getFormattedCurrency(categorySum, currency)}'
                )
              ]
            ),
          );
        }
      });

      double emptyCategorySum = totals['null'];
      if(emptyCategorySum > 0) {
        rows.add(
          SimpleTableRow(
            cells: [
              SimpleTableCell(
                content: AppLocalizations.of(context)!.noCategory,
                isHeader: true
              ),
              SimpleTableCell(
                content: '${currencyController.getFormattedCurrency(emptyCategorySum, currency)}'
              )
            ]
          ),
        );
      }
    }

    return rows;
  }

  /// Returns a list of `SimpleTableRow` items for displaying the total
  /// expenses and their effect on the budget.
  List<SimpleTableRow> getTableFooterData() {
    List<SimpleTableRow> rows = <SimpleTableRow>[];

    double totalSum = totals['all'];
    double roundedTotalSum = TypeUtility.round(totalSum, decimalPlaces: 2);
    double remainingBudget = (currentBudget ?? 0.0) - totalSum;
    double roundedRemainingBudget = TypeUtility.round(
      remainingBudget,
      decimalPlaces: 2
    );

    if(totalSum > 0) {
      // Add rows for the total and the remaining budget.
      rows.addAll([
        SimpleTableRow(
          cells: [
            SimpleTableCell(
              content: AppLocalizations.of(context)!.totalExpenses,
              isHeader: true
            ),
            SimpleTableCell(
              content: '${currencyController.getFormattedCurrency(roundedTotalSum, currency)}'
            )
          ]
        ),
        SimpleTableRow(
          cells: [
            SimpleTableCell(
              content: AppLocalizations.of(context)!.budget,
              isHeader: true
            ),
            SimpleTableCell(
              content: '${currencyController.getFormattedCurrency(currentBudget ?? 0.0, currency)}'
            )
          ]
        ),
        SimpleTableRow(
          cells: [
            SimpleTableCell(
              content: AppLocalizations.of(context)!.remainingBudget,
              isHeader: true
            ),
            SimpleTableCell(
              content: '${currencyController.getFormattedCurrency(roundedRemainingBudget, currency)}',
              // Display the value with red letters if the budget has been exceeded.
              style: roundedRemainingBudget < 0 ?
                TextStyle(color: Color.fromRGBO(225, 0, 21, 1)) :
                null
            )
          ]
        ),
      ]);
    }

    return rows;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBarUtility(
        routeLabel: AppLocalizations.of(context)!.overview,
      ),
      body: SingleChildScrollView (
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 15,
          children: [
            MonthFilterMenu(onChangeCallback: updateFilters),

            // Display the pie chart if expenses were found with the given filters.
            ?(filteredExpenses != null && filteredExpenses!.isNotEmpty) ?
              Padding(
                padding: EdgeInsetsGeometry.all(15),
                child: SimplePieChart(
                  data: getPieChartData()
                )
              ) : null,

            ?(filteredExpenses != null && filteredExpenses!.isNotEmpty) ?
              SimpleTable(
                body: getTableBodyData(),
                footer: getTableFooterData()
              ) : null,

            // Display a message if expenses were not found with the given filters.
            ?(filteredExpenses == null || filteredExpenses!.isEmpty) ?
              Padding(
                padding: EdgeInsetsGeometry.all(15),
                child: Text(
                  AppLocalizations.of(context)!.noExpensesFoundWithFilters
                )
              ) : null
          ]
        )
      )
    );

  }
}