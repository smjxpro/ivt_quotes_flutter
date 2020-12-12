import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:quotes_flutter/models/quote.dart';

class StatsScreen extends StatefulWidget {
  final List<Quote> quotes;
  final List<String> authors;

  StatsScreen({this.quotes, this.authors});

  @override
  _StatsScreenState createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  Map<String, double> populateData() {
    Map<String, double> dataMap = Map();
    for (int i = 0; i < widget.authors.length; i++) {
      int count = 0;
      for (var q in widget.quotes) {
        if (q.author == widget.authors[i]) {
          count++;
        }
      }
      if (widget.authors[i] != null && count >= 12) {
        dataMap[widget.authors[i]] = count.ceilToDouble();
      }
    }

    return dataMap;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Author Stats'),
      ),
      body: ListView(
        children: [
          PieChart(
            dataMap: populateData(),
            animationDuration: Duration(milliseconds: 800),
            chartLegendSpacing: 32,
            chartRadius: MediaQuery.of(context).size.width / 1.5,
            initialAngleInDegree: 0,
            chartType: ChartType.disc,
            ringStrokeWidth: 32,
            centerText: "No. of quotes",
            legendOptions: LegendOptions(
              showLegendsInRow: true,
              legendPosition: LegendPosition.bottom,
              showLegends: true,
              legendTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            chartValuesOptions: ChartValuesOptions(
              showChartValueBackground: true,
              showChartValues: true,
              showChartValuesInPercentage: false,
              showChartValuesOutside: false,
            ),
          ),
        ],
      ),
    );
  }
}
