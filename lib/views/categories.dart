import 'package:flutter/material.dart';
import 'package:home_budget_app/utilities.dart';
import 'package:home_budget_app/views/category_form.dart';

import '../l10n/app_localizations.dart';
import '../types/budget_category.dart';

/// Class for displaying categories.
class CategoriesView extends StatefulWidget {
  /// Widget for displaying categories.
  const CategoriesView({super.key});

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  /// The list of all categories.
  List<BudgetCategory>? categories;

  @override
  void initState() {
    super.initState();
    loadCategories();
  }

  /// Loads all categories from the settings.
  void loadCategories() {
    BudgetCategory categoryHelper = BudgetCategory(context: context);
    List<BudgetCategory> categoryList = categoryHelper.getAll();

    setState(() {
      categories = categoryList;
    });
  }

  /// Displays the form for creating or editing a category.
  ///
  /// Leaving the [categoryId] empty will display the form for creating a new
  /// category.
  Future<void> editCategory(String? categoryId) async {
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => CategoryFormView(
          id: categoryId
        )
      )
    ).then((dynamic value) {
      // Update the category list after returning to this view.
      loadCategories();
    });
  }

  /// Deletes the [categoryItem].
  ///
  /// Displays a confirmation dialog before deletion.
  void deleteCategory(BudgetCategory? categoryItem) async {
    bool didDelete = await TypeUtility.deleteItem(
      context: context,
      item: categoryItem,
      title: AppLocalizations.of(context)!.deleteCategory,
      confirmMessage: AppLocalizations.of(context)!.confirmDeletingCategory,
      onSuccess: () {
        NotificationUtility.notify(
          context,
          AppLocalizations.of(context)!.categoryDeleted
        );
      },
      onError: () {
        NotificationUtility.notify(
          context,
          AppLocalizations.of(context)!.failedToDeleteCategory,
          persist: true
        );
      }
    );

    if(didDelete) {
      // Reload categories.
      loadCategories();
    }
  }

  /// Builds the list of categories.
  Widget buildCategoryList() {

    return Flexible(
      child: ListView.builder(
        itemCount: categories != null ? categories!.length : 0,
        itemBuilder: (BuildContext context, int i) {
          BudgetCategory? categoryItem = categories != null ? (categories?[i]) : null;
          List<MenuItemButton> menuItems = [
            // Menu item for editing the category.
            MenuItemButton(
              onPressed: () {
                editCategory(categoryItem?.id);
              },
              child: Text(AppLocalizations.of(context)!.edit)
            ),
            // Menu item for deleting the category.
            MenuItemButton(
              onPressed: () {
                deleteCategory(categoryItem);
              },
              child: Text(
                AppLocalizations.of(context)!.delete,
                style: TextStyle(color: Colors.red)
              )
            ),
          ];

          return ListTile(
            title: Text(
              categoryItem?.name ??
              AppLocalizations.of(context)!.unnamedCategory
            ),
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
                  ),
                );
              },
            ),
            onTap: () {
              editCategory(categoryItem?.id);
            }
          );
        }
      )
    );

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBarUtility(
        routeLabel: AppLocalizations.of(context)!.categories,
        actionButtons: [
          IconButton(
            onPressed: () {
              // Display the form for adding a new category.
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (context) => const CategoryFormView()
                )
              ).then((dynamic value) {
                // Update the category list after returning to this view.
                loadCategories();
              });
            },
            icon: Icon(
              Icons.add,
              semanticLabel: AppLocalizations.of(context)!.addCategory
            )
          )
        ],
      ),
      body: Column (
        children: [
          (categories == null || categories!.isEmpty) ?
            Padding(
              padding: EdgeInsetsGeometry.all(15),
              child: Text(
                AppLocalizations.of(context)!.categoriesHaveNotBeenAdded
              )
            ) :
            buildCategoryList()
        ]
      ),
    );

  }
}