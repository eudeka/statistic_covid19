import 'package:covid19/config/env.dart';
import 'package:covid19/model/corona_cases.dart';
import 'package:covid19/model/corona_province.dart';
import 'package:flutter/material.dart';

// TODO 08

class HomeContent extends StatefulWidget {
  final CoronaProvince coronaProvinceId;

  const HomeContent({
    Key key,
    this.coronaProvinceId,
  }) : super(key: key);

  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  List<CoronaCases> _listCoronaCases;
  List<Datum> _listData;

  @override
  void initState() {
    _listCoronaCases = <CoronaCases>[
      CoronaCases(
        title: "Positif",
        count: 0,
      ),
      CoronaCases(
        title: "Sembuh",
        count: 0,
      ),
      CoronaCases(
        title: "Meninggal",
        count: 0,
      ),
      CoronaCases(
        title: "Perawatan",
        count: 0,
      ),
    ];
    _listData = widget.coronaProvinceId.listData;
    for (Datum data in _listData) {
      _listCoronaCases[0].count += data.positiveCases;
      _listCoronaCases[1].count += data.curedCases;
      _listCoronaCases[2].count += data.deathCases;
    }
    _listCoronaCases[3].count = _listCoronaCases[0].count;
    _listCoronaCases[3].count -= _listCoronaCases[1].count;
    _listCoronaCases[3].count -= _listCoronaCases[2].count;
    super.initState();
  }

  // TODO 10

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          GridView.builder(
            primary: false,
            shrinkWrap: true,
            padding: const EdgeInsets.all(16.0),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 512.0,
              childAspectRatio: 1.5,
            ),
            itemBuilder: (BuildContext context, int index) {
              return _itemGrid(index);
            },
            itemCount: _listCoronaCases.length,
          ),
          ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: ListTile(
                  title: Text(_listData[index].province),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () {
                    // TODO 16
                    Navigator.pushNamed(
                      context,
                      Env.detailRoute,
                      arguments: _listData[index],
                    );
                  },
                ),
              );
            },
            itemCount: _listData.length,
          ),
        ],
      ),
    );
  }

  // TODO 09

  Widget _itemGrid(int index) {
    return Card(
      elevation: 8.0,
      margin: const EdgeInsets.all(16.0),
      color: Colors.primaries[index],
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Center(
        child: ListView(
          primary: false,
          shrinkWrap: true,
          children: <Widget>[
            Text(
              "${_listCoronaCases[index].title}",
              style: TextStyle(
                fontSize: 32.0,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            Text(
              "${_listCoronaCases[index].count}",
              style: TextStyle(
                fontSize: 64.0,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}
