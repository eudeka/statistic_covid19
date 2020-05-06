# Eudeka! Aplikasi Covid19

### Persiapan

- Laptop
- Internet
- Sudah terinstall
  - Flutter SDK
  - Android SDK
  - iOS SDK (opsional - untuk perangkat iPhone/iPad)
- Dasar logika yang kuat
- Tekad belajar yang kuat

***

**TODO 00**

Buat project Flutter baru.

**TODO 01**

Tambahkan library (dependencies) [http](https://pub.dev/packages/http), yang akan berfungsi untuk memanggil REST API atau mendapatkan data yang dibutuhkan dari internet.

Tambahkan library (dependencies) [charts_flutter](https://pub.dev/packages/charts_flutter), yang akan berfungsi untuk menampilkan data yang ada menjadi sebuah grafik dengan berbentuk pie chart, bar chart, line, dan lainnya.

**TODO 02**

(Opsional) Hapus semua kode yang ada pada file `widget_test.dart` pada folder `test`, dan ganti dengan fungsi `main` saja seperti berikut,

```dart
void main() {}
```

**TODO 03**

Buat folder atau package baru di dalam folder `bin` dengan nama `config`, folder ini nantinya akan digunakan untuk menyimpan file konfigurasi seperti url utama untuk REST API, nama rute halaman, dan lain sebagainya.

Buat file dart baru pada folder `config` dengan nama `env.dart`, isi dengan kelas `Env` dan beberapa nilai konstan seperti, `baseUrl` adalah berisi url utama untuk pemanggilan API nantinya, `homeRoute` adalah nama rute untuk halaman home, dan `detailRoute` adalah nama rute untuk halaman detail. Sedangkan `ChartsType` adalah sebuah `enum` yang akan kita gunakan untuk mengganti tampilan dari bar charts ke pie charts.

```dart
class Env {
  static final String baseUrl = "https://indonesia-covid-19.mathdro.id/api";
  static final String homeRoute = "/home";
  static final String detailRoute = "/detail";
}

enum ChartsType { BAR, PIE }
```

**TODO 04**

<!-- TODO : model meaning -->

Buat folder atau package `model` pada folder `lib`, folder ini nantinya digunakan untuk menyimpan data model yang akan digunakan untuk menyimpan nilai dari data REST API yang didapatkan.

Buka url REST API berikut [ini](https://indonesia-covid-19.mathdro.id/api/provinsi) pada browser dan copy semua kode yang muncul, buka pada tab baru aplikasi [Quicktype](https://app.quicktype.io) dan paste kode yang tadi pada bagian kiri, jangan lupa untuk mengganti nama kelasnya dan bahasanya menjadi `Dart`.

(Opsional) Kamu juga bisa mencentang beberapa opsi yang ada pada Quicktype tadi sesuai dengan kebutuhan.

![](https://i.imgur.com/kc9JkqZ.png)

Copy kode yang ada pada Quicktype bagian kanan, lalu buat file dart baru pada folder `model` dengan nama `corona_province.dart` dan paste kode tadi ke dalam file tersebut.

**TODO 05**

Buat juga file dart dengan nama `corona_cases.dart` pada folder `model` dan isi dengan sebuah kelas model `CoronaCases` untuk menyimpan `title` dan `count`, yang akan digunakan untuk model data pada grafik (charts) nantinya

```dart
class CoronaCases {
  String title;
  int count;

  CoronaCases({
    this.title,
    this.count,
  });
}
```

**TODO 06**

Buat folder atau package baru dengan nama `network` pada folder `bin`, folder ini nantinya digunakan untuk menyimpan file dart untuk koneksi ke internet.

<!-- TODO : static meaning -->
<!-- TODO : Future meaning -->
<!-- TODO : asynchronous meaning -->

Buat file dart baru pada folder `network` dengan nama `api_client.dart`, dan isi dengan fungsi untuk mendapatkan data dari internet (REST API). Buat fungsi tersebut menjadi `static` agar fungsi tersebut dapat diakses langsung dari kelas (`ApiClient.getCoronaProvince`), bukan ketika instance kelas (`ApiClient().getCoronaProvince`), untuk lebih detailnya bisa coba baca [disini](https://news.dartlang.org/2012/06/const-static-final-oh-my.html). Lalu gunakan tipe data `Future` dengan nilai `T` nya adalah kelas data model yang sesuai dengan JSON yang nanti didapatkan, tipe `Future` ini adalah tipe yang bersifat asynchronous atau nilai akan terisi setelah semua perintah di dalam fungsi dijalankan (tidak berurutan sesuai baris). Kemudian `Response` adalah berisi nilai hasil dari pemanggilan url https://indonesia-covid-19.mathdro.id/api/provinsi dengan method `GET`, lalu lakukan pengecekan jika status code dari response tersebut bernilai 200 atau artinya data berhasil didapatkan maka berikan nilai balik dari fungsi tersebut `CoronaProvince.fromJson` yang diambil dari kelas model dari nilai `T` fungsi tersebut, dan jika bukan 200 atau gagal maka lempar `Exception` error code tersebut.

```dart
class ApiClient {
  static Future<CoronaProvince> getCoronaProvince() async {
    Response _response = await get("${Env.baseUrl}/provinsi");
    if (_response.statusCode == 200) {
      return CoronaProvince.fromJson(_response.body);
    } else {
      throw Exception("error code : ${_response.statusCode}");
    }
  }
}

```

**TODO 07**

Buat folder dengan nama `view` di dalam folder `bin` dan dua folder lagi di dalam folder `view` yaitu `detail` dan `home`, folder ini nantinya digunakan untuk menyimpan file dart untuk UI atau tampilan pada aplikasi.

Tambahkan di masing-masing folder tersebut dua file dart, `home_page.dart` dan `home_content.dart` pada folder `home`, sedangkan `detail_page.dart` dan `detail_content.dart` pada folder `detail`.

Pada file `home_page.dart` buat kelas `HomePage` dengan `StatelessWidget`, dan isi fungsi `build` dengan `Scaffold`, seperti berikut,

```dart
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
      ),
    );
  }
}
```

**TODO 08**

Pada file `home_content.dart`, buat kelas `HomeContent` dengan `StatefulWidget`, tambahkan juga parameter `CoronaProvince` atau kelas model yang sebelumnya dibuat pada kelas tersebut.

```dart
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
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
```

Deklarasikan dua `List` yang akan digunakan untuk menampilkan data nantinya, dan inisialisasikan datanya pada fungsi `initState`. Dimana data pertama (`_listCoronaCases`) adalah list untuk data keseluruhan (total) positif, sembuh, meninggal, dan perawatan, sedangkan data kedua (`_listData`) adalah list data asli yang didapatkan dari REST API yang masih berupa data per provinsi. Dan untuk mendapatkan data keseluruhan (total) untuk positif, sembuh, dan meninggal, gunakan looping for in dari data per provinsi kemudian tambahkan nilainya ke dalam data keseluruhan, sedangkan untuk data perawatan didapatkan dari total positif dikurangi total sembuh dan meninggal.

```dart
[...]

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

[...]
```

**TODO 09**

Buat sebuah fungsi widget di dalam kelas `_HomeContentState`, yang nantinya digunakan untuk item yang menampilkan data keseluruhan (total), berikan pula parameter untuk mendapatkan index dari item tersebut. Gunakan widget `ListView` untuk menghindari error overflowed ketika ditampilkan pada layar yang terlalu kecil atau teks yang berlebih, berikan `primary` dengan `false` agar tidak dapat di scroll ketika ukuran mencukupi untuk ditampilkan, dan `shrinkWrap` dengan `true` agar ukuran mengikuti ukuran item di dalamnya.

```dart
[...]

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

[...]
```

**TODO 10**

Pada fungsi `build` kelas `_HomeContentState` buat agar dapat memunculkan `GridView` dan `ListView` bersamaan di dalam `Column` dan bungkus kembali dengan `SingleChildScrollView` agar dapat digulirkan. Jangan lupa untuk atur `primary` menjadi `false` dan `shrinkWrap` menjadi `true` pada `GridView` dan `ListView` agar keduanya tidak dapat digulirkan dan mengikuti ukuran item masing-masing, karena sudah menggunakan `SingleChildScrollView` untuk dapat digulirkan.

```dart
[...]

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
              child: ListTile(
                title: Text(_listData[index].province),
                trailing: Icon(Icons.chevron_right),
              ),
            );
          },
          itemCount: _listData.length,
        ),
      ],
    ),
  );
}

[...]
```

**TODO 11**

Pada file `detail_page.dart` buat kelas `DetailPage` dengan `StatefulWidget` untuk halaman detail.

```dart
class DetailPage extends StatefulWidget {
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
```

Pada kelas `_DetailPageState` inisialisasikan `_chartsType` dengan nilai `ChartsType.BAR` untuk membuat tampilan default adalah berbentuk charts bar. Pada fungsi `build` tangkap argumen yang dilempar dari halaman sebelumnya dan masukan ke dalam `_data`. Buat juga `IconButton` pada `actions` di `AppBar`, yang dimana ketika di klik ubah nilai `_chartsType`, jika `_chartsType` sebelumnya adalah `BAR` maka isi dengan `PIE` atau jika bukan isi dengan `BAR`, jangan lupa untuk gunakan `setState` setelahnya untuk trigger perubahan tampilan.

```dart
[...]

ChartsType _chartsType;

@override
void initState() {
  _chartsType = ChartsType.BAR;
  super.initState();
}

@override
Widget build(BuildContext context) {
  Datum _data = ModalRoute.of(context).settings.arguments;
  return Scaffold(
    appBar: AppBar(
      title: Text(_data?.province ?? ""),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.cached),
          onPressed: () {
            _chartsType = _chartsType == ChartsType.BAR
              ? ChartsType.PIE
              : ChartsType.BAR;
            setState(() {});
          },
        ),
      ],
    ),
    body: Card(
      margin: const EdgeInsets.all(16.0),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16.0),
      ),
    ),
  );
}

[...]
```

**TODO 12**

Pada file `detail_content.dart` buat kelas baru dengan nama `DetailContent`. Berikan parameter `data` yaitu data yang akan dimunculkan pada chats dan `chartsType` yaitu tipe charts yang dimunculkan.

```dart
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
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
```

**TODO 13**

Pada kelas `_DetailContentState` inisialisasikan `_listCases` dan `_listSeries`, dimana `_listCases` adalah data yang akan kita tampilkan pada `charts` untuk satuannya, disini kita coba untuk munculkan data positif, sembuh, dan meninggal, sedangkan `_listSeries` adalah kelompok data yang dibutuhkan untuk digunakan pada charts baik pada pie maupun bar, disini kita cukup gunakan satu kelopok atau satu `Series`, dengan `id`-nya adalah nama provinsi, lalu data yang gunakan adalah `_listCases`, `domainFn` adalah untuk judul setiap datanya (berbentuk String), `measureFn` adalah data atau angka yang akan diukur (berbentuk int), dan `labelAccessorFn` adalah untuk label setiap data (berbentuk String).

```dart
[...]

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

[...]
```

**TODO 14**

Pada fungsi `build` di `_DetailContentState` buat jika `chartsType` adalah `BAR` maka tampikan `BarCharts` dan jika bukan maka tampilkan `PieCharts`. Pada `BarCharts`, isi `barRendererDecorator` untuk menampikan label di setiap data, dan atur posisi label selalu berada pada luar bar. Pada `PieCharts`, isi `defaultRenderer` untuk menampilkan label, dan atur posisi label selalu berada pada luar pie, tambahkan juga `DatumLegend` pada `behaviors` untuk memunculkan legenda pada charts tersebut.

```dart
[...]

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
            DatumLegend(
              showMeasures: true,
              legendDefaultMeasure: LegendDefaultMeasure.sum,
            ),
          ],
        );
}

[...]
```

**TODO 15**

Balik lagi ke `DetailPage`, pada `Container` yang ada di `body` isi `child` nya dengan `DetailContent` dengan data parameter yang ada.

```dart
[...]
body: Card(
  [...]
  child: Container(
    [...]
    child: DetailContent(
      data: _data,
      chartsType: _chartsType,
    ),
  ),
),
[...]
```

**TODO 16**

Balik ke `HomeContent`, tambahkan `onTap` pada `ListTile` yang ada pada `ListView`. Dimana ketika di klik maka akan berpindah ke halaman `DetailPage` dengan melempar argumen yaitu sebuah data.

```dart
[...]
ListView.builder(
  [...]
  itemBuilder: (BuildContext context, int index) {
    return Card(
      child: ListTile(
        [...]
        onTap: () {
          Navigator.pushNamed(
            context,
            Env.detailRoute,
            arguments: _listData[index],
          );
        },
      ),
    );
  },
  [...]
),
[...]
```

**TODO 17**

Pada `HomePage` gunakan `FutureBuilder` pada `body` untuk mendapatkan dan menampilkan data dari REST API. Pada parameter `future` isi dengan fungsi yang mendapatkan data dari internet, dengan nilai `T` dari `FutureBuilder` adalah nilai balik dari fungsi yang ada pada `future` tersebut, begitu juga nilai `T` pada `AsyncSnapshot`. Pada `builder` lakukan pengecekan jika `snapshot` sudah memiliki data, maka tampilkan `HomeContent` dengan parameter `data` dari `snapshot` tersebut, namun jika `snapshot` masih kosong tampilkan `CircularProgressIndicator`.

```dart
[...]

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

[...]
```

**TODO 18**

Pada file `main.dart` ganti semua kode nya dengan kelas `MainApp`, dimana pada kelas tersebut buat sebuah `_routes` atau halaman-halaman yang ada pada aplikasi tersebut, karena kelas tersebut menggunakan `StatelessWidget` maka variabel yang ada kita buat menjadi `final`, dan isi `initialRoute` dengan halaman `HomePage`.

```dart
void main() {
  runApp(
    MainApp(),
  );
}

class MainApp extends StatelessWidget {
  final Map<String, WidgetBuilder> _routes = <String, WidgetBuilder>{
    Env.homeRoute: (BuildContext context) {
      return HomePage();
    },
    Env.detailRoute: (BuildContext context) {
      return DetailPage();
    },
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: _routes,
      initialRoute: Env.homeRoute,
    );
  }
}
```

***

Notes:  
Jangan lupa untuk menambahkan izin akses internet pada `AndroidManifest.xml` ketika ingin menjalankan atau membuat aplikasi dalam mode `release`.
