import 'package:flutter/material.dart';

/// Class for displaying a table.
class SimpleTable extends StatefulWidget {
  /// Widget for displaying a table.
  const SimpleTable({
    super.key,
    this.header,
    required this.body,
    this.footer
  });

  /// Rows for the header of the table.
  final List<SimpleTableRow>? header;

  /// Rows for the body of the table.
  final List<SimpleTableRow> body;

  /// Rows for the footer of the table.
  final List<SimpleTableRow>? footer;

  @override
  State<SimpleTable> createState() => _SimpleTableState();
}

class _SimpleTableState extends State<SimpleTable> {

  /// Builds a list of table cells.
  List<TableCell> buildCells(List<SimpleTableCell> cells) {
    return cells.map((cell) {
      return TableCell(
        child: Padding(
          padding: EdgeInsetsGeometry.all(15),
          child: Text(
            cell.content,
            style: cell.style ?? (cell.isHeader ?
              TextTheme.of(context).titleSmall :
              TextTheme.of(context).bodyMedium)
          )
        )
      );
    }).toList();
  }

  /// Builds the list of rows for the header.
  List<TableRow> buildHeaderRows(List<SimpleTableRow>? rowData) {
    List<TableRow> rows = <TableRow>[];
    int rowCount = rowData!.length;

    for(int i = 0; i < rowCount; i++) {
      SimpleTableRow row = rowData[i];
      bool isLast = i == (rowCount - 1);

      rows.add(
        TableRow(
          decoration: BoxDecoration(
            border: BoxBorder.fromLTRB(
              bottom: isLast ?
                BorderSide(
                  width: 1.5,
                  color: Colors.grey
                ) :
                BorderSide.none
            )
          ),
          children: buildCells(row.cells)
        )
      );
    }

    return rows;
  }

  /// Builds the list of rows for the body.
  List<TableRow> buildBodyRows(List<SimpleTableRow> rowData) {
    return rowData.map((row) {
      return TableRow(
        children: buildCells(row.cells)
      );
    }).toList();
  }

  /// Builds the list of rows for the footer.
  List<TableRow> buildFooterRows(List<SimpleTableRow>? rowData) {
    List<TableRow> rows = <TableRow>[];
    int rowCount = rowData!.length;

    for(int i = 0; i < rowCount; i++) {
      SimpleTableRow row = rowData[i];
      bool isFirst = i == 0;

      rows.add(
        TableRow(
          decoration: BoxDecoration(
            border: BoxBorder.fromLTRB(
              top: isFirst ?
                BorderSide(
                  width: 1.5,
                    color: Colors.grey
                ) :
                BorderSide.none
            )
          ),
          children: buildCells(row.cells)
        )
      );
    }

    return rows;
  }

  /// Builds the list of rows for the entire table.
  List<TableRow> buildTableRows() {
    List<TableRow> allRows = <TableRow>[];

    if(widget.header != null && widget.header!.isNotEmpty) {
      allRows.addAll(
        buildHeaderRows(widget.header)
      );
    }

    allRows.addAll(
      buildBodyRows(widget.body)
    );

    if(widget.footer != null && widget.footer!.isNotEmpty) {
      allRows.addAll(
        buildFooterRows(widget.footer)
      );
    }

    return allRows;
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsetsGeometry.all(15),
      child: Table(
        border: TableBorder(
          top: BorderSide(
            width: 1.5,
            color: Colors.grey
          ),
          right: BorderSide(
            width: 1.5,
            color: Colors.grey
          ),
          left: BorderSide(
            width: 1.5,
            color: Colors.grey
          ),
          bottom: BorderSide(
            width: 1.5,
            color: Colors.grey
          ),
          borderRadius: BorderRadius.circular(5)
        ),
        children: buildTableRows()
      )
    );

  }
}

/// Class for defining row data for a `SimpleTable`.
class SimpleTableRow {
  /// Widget for defining row data for a `SimpleTable`.
  SimpleTableRow({
    required this.cells
  });

  /// List of cells in the row.
  final List<SimpleTableCell> cells;
}

/// Class for defining cell data for a `SimpleTableRow`.
class SimpleTableCell {
  /// Widget for defining cell data for a `SimpleTableRow`.
  const SimpleTableCell({
    required this.content,
    this.isHeader = false,
    this.style
  });

  /// The content of the cell.
  final String content;

  /// Whether the cell should be formatted as a header.
  ///
  /// The [style] property overrides this.
  final bool isHeader;

  /// `TextStyle` for the cell.
  ///
  /// Overrides the styling from the [isHeader] property.
  final TextStyle? style;
}


