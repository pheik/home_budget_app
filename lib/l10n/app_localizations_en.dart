// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get settings => 'Settings';

  @override
  String get back => 'Back';

  @override
  String get currency => 'Currency';

  @override
  String get budget => 'Budget';

  @override
  String get create => 'Create';

  @override
  String get startDate => 'Start Date';

  @override
  String get endDate => 'End Date';

  @override
  String get optional => 'optional';

  @override
  String get amount => 'Amount';

  @override
  String get startDateMustNotBeEmpty => 'Start date must not be empty';

  @override
  String get endDateBeforeStartDate => 'End date must not be before start date';

  @override
  String get save => 'Save';

  @override
  String get homeBudget => 'Home Budget';

  @override
  String get monthAbbreviation => 'mo';

  @override
  String get categories => 'Categories';

  @override
  String get editAvailableCategories => 'Edit available categories';

  @override
  String get addCategory => 'Add Category';

  @override
  String get categoriesHaveNotBeenAdded => 'Categories have not been added.';

  @override
  String get edit => 'Edit';

  @override
  String get delete => 'Delete';

  @override
  String get unnamedCategory => '(Unnamed category)';

  @override
  String get createCategory => 'Create Category';

  @override
  String get editCategory => 'Edit Category';

  @override
  String get add => 'Add';

  @override
  String get viewStatus => 'View status';

  @override
  String get expenses => 'Expenses';

  @override
  String get name => 'Name';

  @override
  String get nameMustNotBeEmpty => 'Name must not be empty';

  @override
  String get deleteCategory => 'Delete Category';

  @override
  String get confirmDeletingCategory =>
      'Are you sure you want to delete the category? This cannot be undone.';

  @override
  String get cancel => 'Cancel';

  @override
  String get ok => 'OK';

  @override
  String get changesSaved => 'Changes saved.';

  @override
  String get categoryDeleted => 'Category deleted.';

  @override
  String get setMonthlyBudget => 'Set a monthly budget';

  @override
  String get editBudget => 'Edit Budget';

  @override
  String get budgetIsInvalid => 'Budget is invalid';

  @override
  String get budgetMustNotBeEmpty => 'Budget must not be empty';

  @override
  String get failedToSaveChanges => 'Failed to save changes';

  @override
  String get deleteExpense => 'Delete Expense';

  @override
  String get confirmDeletingExpense =>
      'Are you sure you want to delete the expense? This cannot be undone.';

  @override
  String get addExpense => 'Add Expense';

  @override
  String get expensesHaveNotBeenAdded => 'Expenses have not been added.';

  @override
  String get expenseDeleted => 'Expense deleted';

  @override
  String get amountIsInvalid => 'Amount is invalid';

  @override
  String get date => 'Date';

  @override
  String get dateMustNotBeEmpty => 'Date must not be empty';

  @override
  String get category => 'Category';

  @override
  String get noCategory => 'No category';

  @override
  String get createCategoriesFromSettings =>
      'You can create categories for expenses from the settings menu.';

  @override
  String get editExpense => 'Edit Expense';

  @override
  String get deleteItem => 'Delete Item';

  @override
  String get confirmDeletingItem =>
      'Are you sure you want to delete the item? This cannot be undone.';

  @override
  String get failedToDeleteExpense => 'Failed to delete expense';

  @override
  String get failedToDeleteCategory => 'Failed to delete category';

  @override
  String get filters => 'Filters';

  @override
  String get thisMonth => 'This month';

  @override
  String get thisYear => 'This year';

  @override
  String get all => 'All';

  @override
  String get noExpensesFoundWithFilters =>
      'Expenses were not found with the applied filters.';

  @override
  String get overview => 'Overview';

  @override
  String get month => 'Month';

  @override
  String get year => 'Year';

  @override
  String get color => 'Color';

  @override
  String get totalExpenses => 'Total expenses';

  @override
  String get remainingBudget => 'Remaining budget';

  @override
  String get options => 'Options';

  @override
  String get about => 'About';

  @override
  String get informationAboutApplication => 'Information about the application';

  @override
  String get selectCurrency => 'Select Currency';

  @override
  String get monthlyBudget => 'Monthly budget';
}
