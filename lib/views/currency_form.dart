import 'package:flutter/material.dart';
import '../types/currency.dart';
import '../types/currency_options.dart';
import '../utilities.dart';
import '../l10n/app_localizations.dart';

/// Class for displaying the budget editing view.
class CurrencyFormView extends StatefulWidget {
  /// Widget for displaying the budget editing view.
  const CurrencyFormView({super.key});

  @override
  State<CurrencyFormView> createState() => _CurrencyFormViewState();
}

class _CurrencyFormViewState extends State<CurrencyFormView> {
  /// The form key.
  final _formKey = GlobalKey<FormState>();

  /// Controller for accessing currency information.
  late CurrencyController currencyController;

  /// The selected currency.
  String? currency;

  /// List of currency options.
  List<CurrencyOption>? currencies;

  /// `DropdownMenuEntry` items for currency options.
  List<DropdownMenuEntry> currencyOptions = <DropdownMenuEntry>[];

  @override
  void initState() {
    super.initState();

    CurrencyController controller = CurrencyController(context: context);
    setState(() {
      currencyController = controller;
    });
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
    List<CurrencyOption>? currencyList = currencyController.getCurrencies();

    setState(() {
      currency = currencySetting;
      currencies = currencyList;
    });
  }

  List<DropdownMenuEntry> getCurrencyOptions() {
    List<DropdownMenuEntry> menuEntries = <DropdownMenuEntry>[];

    if(currencies != null && currencies!.isNotEmpty) {
      menuEntries = List<DropdownMenuEntry>.generate(currencies?.length ?? 0, (int i) {
        CurrencyOption? item = currencies?[i];
        return DropdownMenuEntry(
          value: item?.code,
          label: item!.getName(Localizations.localeOf(context).languageCode) ?? '',
          leadingIcon: SizedBox(
            width: 50,
            child: Text(item.code)
          )
        );
      }).toList();
    }

    return menuEntries;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBarUtility(
          routeLabel: AppLocalizations.of(context)!.selectCurrency,
          actionButtons: [
            IconButton(
                onPressed: () async {
                  // Validate the form and save changes.
                  if(_formKey.currentState != null && _formKey.currentState!.validate()) {
                    await currencyController.setCurrency(currency).whenComplete(() {
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
                    DropdownMenu(
                      width: MediaQuery.of(context).size.width,
                      label: Text(AppLocalizations.of(context)!.currency),
                      dropdownMenuEntries: getCurrencyOptions(),
                      initialSelection: currency,
                      selectOnly: true,
                      onSelected: (value) {
                        currency = value ?? '';
                      },
                    )
                  ],
                )
            )
        )
    );

  }
}