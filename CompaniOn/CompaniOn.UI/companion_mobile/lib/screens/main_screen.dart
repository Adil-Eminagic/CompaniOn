import 'package:companion_mobile/models/country.dart';
import 'package:companion_mobile/models/countryInsert.dart';
import 'package:companion_mobile/models/countryUpdate.dart';
import 'package:companion_mobile/models/search_result.dart';
import 'package:companion_mobile/providers/country_provider.dart';
import 'package:companion_mobile/screens/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late CountryProvider _countryProvider;
  SearchResult<Country>? resultC;
  late List<Country> allCountries;
  late Country? singleCountry;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _countryProvider = context.read<CountryProvider>();
    _loadData();
  }

  Future<void> _loadData() async {
    var dataC = await _countryProvider.getPaged();
    setState(() {
      resultC = dataC;
      allCountries = resultC!.items;
      _isLoading = false;
      });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      isJelovnikPressed: false,
      isKorpaPressed: false,
      isMojProfilPressed: false,
      isPostavkePressed: false,
      isRecenzijePressed: false,
      isRezervacijePressed: false,
      orderExists: false,
      child: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Scaffold(
                  body: Column(
                    children: [
                      _buildDataListView(),
                      _buildButtons()
                    ],
                  ),
                ),
    );
  }

  Widget  _buildDataListView() {
    return SingleChildScrollView(
          scrollDirection: Axis.vertical,
        child: 
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
          showCheckboxColumn: false,  
          columns: [
          const DataColumn(
            label: Expanded(
            child: Text(
              'Ime',
              style: TextStyle(fontStyle: FontStyle.italic),
             ),
             ),
              ),
            const DataColumn(
            label: Expanded(
            child: Text(
              'Skracenica',
              style: TextStyle(fontStyle: FontStyle.italic),
             ),
             ),
              ),
              const DataColumn(
            label: Expanded(
            child: Text(
              'Aktivna',
              style: TextStyle(fontStyle: FontStyle.italic),
             ),
             ),
              ),
              const DataColumn(
            label: Expanded(
            child: Text(
              'Kreirana',
              style: TextStyle(fontStyle: FontStyle.italic),
             ),
             ),
              ),
              const DataColumn(
            label: Expanded(
            child: Text(
              'Modificirana',
              style: TextStyle(fontStyle: FontStyle.italic),
             ),
             ),
              ),
                ], 
                rows: allCountries.map((Country e)=>
          DataRow(onSelectChanged: (selected) => {
            if(selected==true)
            {
              
            }
          },
          cells: [
              DataCell(Text("${e.name}" ?? "")),
              DataCell(Text(e.abbreviation??""),),
              DataCell(Text("${e.isActive}")),
              DataCell(Text(e.createdAt!=null? e.createdAt.toString(): ""),),
              DataCell(Text(e.modifiedAt!=null? e.modifiedAt.toString(): ""),),
              ] 
          )
                ).toList() ?? []
                ),
        ),
      );
  }

Widget _buildButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
      Expanded(
        child: Card(
          child: Column(
            children: [
            const Text("Dugmadi dolje služe da se isprobaju operacije i da vidite kako kod radi. Get ID se odnosi na ID 1 i ispisuje se u konzoli"),
            const SizedBox(height: 5.0),
            ElevatedButton(
               onPressed: () async {
                   var data = await _countryProvider.getById(1);
                   
                 setState(() {
                   singleCountry = data;
                 });

                  print(singleCountry!.name!);

                 },
               child: Text('Get By ID'),
               style: ElevatedButton.styleFrom(
                 shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(10.0),
                 ),
                 overlayColor: Colors.green,
                 padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
               ),
             ),
            const SizedBox(height: 5.0),
            ElevatedButton(
               onPressed: () async {
                
                CountryInsert newCountry=new CountryInsert(5, "Berunistan", "BA", true);

                await _countryProvider.insert(newCountry);

                Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MainScreen()
                                ),
                            );
                   
                 },
               child: Text('Dodaj novu drzavu.'),
               style: ElevatedButton.styleFrom(
                 shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(10.0),
                 ),
                 overlayColor: Colors.green,
                 padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
               ),
             ),
             const SizedBox(height: 5.0),
            ElevatedButton(
               onPressed: () async {
                await _countryProvider.delete(4);

                Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MainScreen()
                                ),
                            );
                   
                 },
               child: Text('Izbrisi crnu goru.'),
               style: ElevatedButton.styleFrom(
                 shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(10.0),
                 ),
                 overlayColor: Colors.green,
                 padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
               ),
             ),
             const SizedBox(height: 5.0),
            ElevatedButton(
               onPressed: () async {

                CountryUpdate updateCountry=new CountryUpdate(3, "SRB", "SR", true);

                await _countryProvider.update(updateCountry);

                Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MainScreen()
                                ),
                            );
                   
                 },
               child: Text('Preimenuj Srbiju u SRB.'),
               style: ElevatedButton.styleFrom(
                 shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(10.0),
                 ),
                 overlayColor: Colors.green,
                 padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
               ),
             ),
            const SizedBox(height: 5.0),
           const Text("Probajte neku od operacija!."),
            const SizedBox(height: 5.0),
            ],
          )
        )
      ),
    ],
    );
  }

}
