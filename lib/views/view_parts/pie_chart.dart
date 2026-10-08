import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

/// Class for displaying a pie chart.
class SimplePieChart extends StatefulWidget {
  /// Widget for displaying a pie chart.
  const SimplePieChart({super.key, required this.data});

  /// Sectors in the pie chart.
  final List<ChartSection> data;

  @override
  State<SimplePieChart> createState() => _SimplePieChartState();
}

class _SimplePieChartState extends State<SimplePieChart> {

  @override
  void initState() {
    super.initState();
  }

  /// Builds the sections for the pie chart.
  List<PieChartSectionData>? buildPieChartData() {
    List<PieChartSectionData> sections = [];

    if(widget.data.isNotEmpty) {
      for(int i = 0; i < widget.data.length; i++) {
        ChartSection section = widget.data[i];
        section.color ??= ColorOptions.getColorWithIndex(i);

        sections.add(
          PieChartSectionData(
            value: section.percent,
            title: section.title,
            color: section.color,

            // Display black text with a white outline for
            // legibility over any background color.
            titleStyle: TextStyle(
              inherit: true,
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              shadows: [
                // Top right
                Shadow(
                    offset: Offset(1.4, 1.4),
                    color: Colors.white
                ),
                // Bottom right
                Shadow(
                    offset: Offset(1.4, -1.4),
                    color: Colors.white
                ),
                // Bottom left
                Shadow(
                    offset: Offset(-1.4, -1.4),
                    color: Colors.white
                ),
                // Top left
                Shadow(
                    offset: Offset(-1.4, 1.4),
                    color: Colors.white
                ),
              ]
            )
          )
        );
      }
    }

    return sections.isNotEmpty ? sections : null;
  }

  /// Builds the legends for each section.
  List<Widget> buildLegends() {
    List<Widget> legends = [];

    if(widget.data.isNotEmpty) {
      for(int i = 0; i < widget.data.length; i++) {
        ChartSection section = widget.data[i];
        section.color ??= ColorOptions.getColorWithIndex(i);

        legends.add(
          Row(
            spacing: 15,
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: section.color,
                )
              ),
              Flexible(
                child: Text(section.label)
              )
            ]
          )
        );
      }
    }

    return legends;
  }

  @override
  Widget build(BuildContext context) {

    bool isHorizontal = MediaQuery.of(context).size.width >
        MediaQuery.of(context).size.height;

    List<Widget> viewParts = [];
    viewParts.add(
      SizedBox(
        height: isHorizontal ?
          MediaQuery.of(context).size.height * 0.8 :
          MediaQuery.of(context).size.width * 0.8,
        width: isHorizontal ?
          MediaQuery.of(context).size.width * 0.4 :
          MediaQuery.of(context).size.width * 0.8,
        child: PieChart(
          PieChartData(
            sections: buildPieChartData()
          )
        )
      )
    );

    viewParts.add(
      ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: isHorizontal ?
            MediaQuery.of(context).size.width * 0.4 :
            MediaQuery.of(context).size.width,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: buildLegends()
        )
      )
    );

    return Column(
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width
          ),
          child: isHorizontal ?
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Wrap(
                    spacing: 15,
                    runSpacing: 15,
                    children: viewParts
                  )
                )
              ]
            ) :
            Column(
              spacing: 15,
              children: viewParts
            )
        )
      ]
    );

  }
}

/// Class for defining a sector of a `SimplePieChart`.
class ChartSection {
  /// Widget for defining a sector of a `SimplePieChart`.
  ChartSection({required this.percent, required this.label, this.color});

  /// The percentual size of the sector.
  double percent;

  /// The label of the sector.
  String label;

  /// The color of the sector in the pie chart.
  ///
  /// If left as empty, the color will be selected automatically.
  Color? color;

  /// The formatted percentage label, correct to 1 decimal place.
  String get title => '${_round(percent, decimalPlaces: 1)} %';

  /// Rounds the given `double` [value] correct to [decimalPlaces] decimal
  /// places.
  double _round(double value, {int decimalPlaces = 0}) {
    String roundedPercent = value.toStringAsFixed(decimalPlaces);
    return double.parse(roundedPercent);
  }
}

/// Class for automatically selecting a color from a list of predefined options.
class ColorOptions {

  /// The color options.
  static final List<Color> _colors = <Color>[
    Colors.brown,
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.lightGreen,
    Colors.teal,
    Colors.lightBlue,
    Colors.indigo,
    Colors.purple,
    Colors.pink,
    Colors.grey
  ];

  /// Returns a color from the list of options using the [index] as the seed.
  ///
  /// The [index] can be any integer.
  static Color getColorWithIndex(int index) {
    int absoluteIndex = index < 0 ? index.abs() : index;
    int adjustedIndex = absoluteIndex > (_colors.length - 1) ?
      absoluteIndex % (_colors.length) : absoluteIndex;
    return _colors[adjustedIndex];
  }

  /// Returns all color options from this class.
  static List<Color> getColorOptions() {
    return _colors;
  }

}