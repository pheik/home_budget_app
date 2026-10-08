import 'package:flutter/material.dart';
import 'package:home_budget_app/utilities.dart';

import '../l10n/app_localizations.dart';
import '../types/budget_category.dart';

/// Class for displaying the category editing view.
class CategoryFormView extends StatefulWidget {
  /// Widget for displaying the category editing view.
  const CategoryFormView({super.key, this.id});

  /// The ID of the category.
  ///
  /// Set as `null` to create a new category.
  final String? id;

  @override
  State<CategoryFormView> createState() => _CategoryFormViewState();
}

class _CategoryFormViewState extends State<CategoryFormView> {
  /// The form key.
  final _formKey = GlobalKey<FormState>();

  /// The category.
  BudgetCategory? category;

  @override
  void initState() {
    super.initState();
    loadCategory();
  }

  /// Loads the category information.
  void loadCategory() {
    category = BudgetCategory(context: context, id: widget.id);
    category?.load();
  }

  /// Deletes the [categoryItem].
  ///
  /// Displays a confirmation dialog before deletion.
  void deleteCategory(BudgetCategory? categoryItem) async {
    var _ = await TypeUtility.deleteItem(
      context: context,
      item: categoryItem,
      title: AppLocalizations.of(context)!.deleteCategory,
      confirmMessage: AppLocalizations.of(context)!.confirmDeletingCategory,
      onSuccess: () {
        NotificationUtility.notify(
          context,
          AppLocalizations.of(context)!.categoryDeleted
        );

        // Return to the previous view.
        if(Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }
      },
      onError: () {
        NotificationUtility.notify(
          context,
          AppLocalizations.of(context)!.failedToDeleteCategory,
          persist: true
        );
      }
    );
  }

  /// Returns a list of actions buttons for saving and deleting the category.
  List<IconButton> buildEditingButtons(BuildContext context) {
    List<IconButton> buttons = <IconButton>[];

    buttons.add(
      IconButton(
        onPressed: () async {
          // Validate the form and save changes.
          if(_formKey.currentState != null && _formKey.currentState!.validate()) {
            await category?.save().whenComplete(() {
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
            } );
          }
        },
        icon: Icon(
          Icons.check,
          semanticLabel: AppLocalizations.of(context)!.save
        )
      )
    );

    if(category?.id != null) {
      buttons.add(
        IconButton(
          onPressed: () async {
            deleteCategory(category);
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
      AppLocalizations.of(context)!.editCategory :
      AppLocalizations.of(context)!.addCategory;

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
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.name
                ),
                keyboardType:TextInputType.text,
                initialValue: category?.name ?? '',
                validator: (value) {
                  if(value != null && value.isNotEmpty) {
                    category?.name = value;
                    return null;
                  }
                  else {
                    return AppLocalizations.of(context)!.nameMustNotBeEmpty;
                  }
                }
              )
            ],
          )
        )
      )
    );

  }
}