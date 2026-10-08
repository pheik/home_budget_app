# home_budget_app

A simple application for monthly budgeting.

The application was created for tracking expenses by category and comparing total expenses to the monthly budget.

The application was developed with the Flutter SDK and targets the Android platform.

## Features

- **Budget**: Set a monthly budget
- **Categories**: Sort expenses into categories
- **Expenses**: Note down expenses
- **Overview**: View a monthly summary of expenses by category
- **Currency**: Select the currency from a list of options
- **Localizations**: English and Finnish

Please view the [demo](demo/demo.md) to see how the application works.

## Repository Structure

```text
/home_budget_app
├── /android                            # Files for running the application on the Android platform.
├── /demo                               # Demo of the application.
├── /lib
│   ├── /l10n                           # Contains files for localizations.
│   ├── /storage
│   │   ├── storage_controller.dart     # Tools for accessing the database.
│   │   └── type_controller.dart        # Parent class for data that is stored in the database.
│   ├── /types
│   │   ├── budget.dart                 # The budget data type.
│   │   ├── budget_category.dart        # The budget category data type.
│   │   ├── currency.dart               # The currency data type.
│   │   ├── currency_options.dart       # Defines currency options. 
│   │   ├── expense.dart                # The expense data type.
│   │   └── setting.dart                # The setting data type.
│   ├── /views
│   │   ├── /view_parts                 # Contains UI elements.
│   │   ├── app_settings.dart           # View for settings.
│   │   ├── budget_form.dart            # View for editing the budget.
│   │   ├── categories.dart             # View for listing all categories.
│   │   ├── category_form.dart          # View for creating or editing a category.
│   │   ├── currency_form.dart          # View for setting the currency.
│   │   ├── expense_form.dart           # View for creating or editing an expense.
│   │   ├── expenses.dart               # View for expenses.
│   │   └── overview.dart               # View for the monthly overview.
│   ├── home.dart                       # The landing page.
│   ├── main.dart                       # The entry point of the application.
│   └── utilities.dart                  # Widgets and static functions used across the application.
│
├── .gitignore
├── .metadata
├── analysis_options.yaml
├── l10n.yaml
├── pubspec.yaml
│
└── README.md
```


