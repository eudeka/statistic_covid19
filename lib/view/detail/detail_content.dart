import 'package:charts_flutter/flutter.dart';
import 'package:covid19/config/env.dart';
import 'package:covid19/model/corona_cases.dart';
import 'package:covid19/model/corona_province.dart';
import 'package:flutter/material.dart';

// TODO 12

class DetailContent extends StatefulWidget {
  final Datum data;
  final ChartsType chartsType;

  const DetailContent({
    Key key,
    this.data,
    this.chartsType,
  }) : super(key: key);

  @override
  _DetailContentState createState() => _DetailContentState();
}

class _DetailContentState extends State<DetailContent> {
  // TODO 13
  List<CoronaCases> _listCases;
  List<Series<CoronaCases, String>> _listSeries;

  @override
  void initState() {
    _listCases = <CoronaCases>[
      CoronaCases(
        title: "Positif",
        count: widget.data.positiveCases,
      ),
      CoronaCases(
        title: "Sembuh",
        count: widget.data.curedCases,
      ),
      CoronaCases(
        title: "Meninggal",
        count: widget.data.deathCases,
      ),
    ];
    _listSeries = <Series<CoronaCases, String>>[
      Series(
        id: widget.data.province,
        data: _listCases,
        domainFn: (CoronaCases cases, int index) {
          return cases.title;
        },
        measureFn: (CoronaCases cases, int index) {
          return cases.count;
        },
        labelAccessorFn: (CoronaCases cases, int index) {
          return "${cases.count}";
        },
      ),
    ];
    super.initState();
  }

  // TODO 14
  @override
  Widget build(BuildContext context) {
    return widget.chartsType == ChartsType.BAR
        ? BarChart(
            _listSeries,
            barRendererDecorator: BarLabelDecorator<String>(
              labelPosition: BarLabelPosition.outside,
            ),
          )
        : PieChart(
            _listSeries,
            defaultRenderer: ArcRendererConfig(
              arcRendererDecorators: [
                ArcLabelDecorator(
                  labelPosition: ArcLabelPosition.outside,
                ),
              ],
            ),
            behaviors: [
              DatumLegend(),
            ],
          );
  }
}
