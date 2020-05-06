import 'package:covid19/model/corona_province.dart';
import 'package:covid19/network/api_client.dart';
import 'package:covid19/view/home/home_content.dart';
import 'package:flutter/material.dart';

// TODO 07

class HomePage extends StatelessWidget {
  // TODO 17
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Eudeka! Flutter x Corona"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: FutureBuilder<CoronaProvince>(
          future: ApiClient.getCoronaProvinceId(),
          builder: (
            BuildContext context,
            AsyncSnapshot<CoronaProvince> snapshot,
          ) {
            if (snapshot.hasData) {
              return HomeContent(
                coronaProvinceId: snapshot.data,
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
