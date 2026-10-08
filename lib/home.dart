import 'package:flutter/material.dart';
import 'package:home_budget_app/views/app_settings.dart';
import 'package:home_budget_app/views/expenses.dart';
import 'package:home_budget_app/views/overview.dart';

import 'l10n/app_localizations.dart';

/// Class for displaying the landing page of the application.
class HomePage extends StatefulWidget {
  /// Widget for displaying the landing page of the application.
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(AppLocalizations.of(context)!.homeBudget),
        actions: [
          IconButton(
            onPressed: () async {
              await Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (context) => const AppSettingsView()
                )
              ).whenComplete(() {
                // Update state after returning to this view.
                setState(() { });
              });
            },
            icon: Icon(
              Icons.settings,
              semanticLabel: AppLocalizations.of(context)!.settings
            )
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsetsGeometry.all(20),
        child: Column(
          spacing: 20,
          children: [
            Card(
              clipBehavior: .hardEdge,
              child: InkWell(
                hoverColor: Theme.of(context).hoverColor,
                splashColor: Theme.of(context).splashColor,
                onHover: (valueChanged) {},
                onTap: () async {
                  await Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (context) => const BudgetOverview()
                    )
                  ).whenComplete(() {
                    // Update state after returning to this view.
                    setState(() { });
                  });
                },
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.15,
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)!.overview,
                      style: TextTheme.of(context).headlineSmall
                    )
                  )
                )
              )
            ),
            Card(
              clipBehavior: .hardEdge,
              child: InkWell(
                hoverColor: Theme.of(context).hoverColor,
                splashColor: Theme.of(context).splashColor,
                onHover: (valueChanged) {},
                onTap: () async {
                  await Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (context) => const ExpensesView()
                    )
                  ).whenComplete(() {
                    // Update state after returning to this view.
                    setState(() { });
                  });
                },
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.15,
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)!.expenses,
                      style: TextTheme.of(context).headlineSmall
                    )
                  )
                )
              )
            )
          ]
        )
      )
    );
  }
}
