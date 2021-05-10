import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/model/car_type.dart';
import 'package:flutter_pos/model/years.dart';
import 'package:flutter_pos/service/api.dart';

class MyCars extends StatefulWidget {
  const MyCars({Key key}) : super(key: key);

  @override
  _MyCarsState createState() => _MyCarsState();
}

class _MyCarsState extends State<MyCars> {
  List<CarType> cartype;
  List<Year> years;
  @override
  void initState() {
    API(context).get('car/types/list').then((value) {
      if (value != null) {
        setState(() {
          cartype = Car_type.fromJson(value).data;
        });
      }
    });
    API(context).get('car/yearslist').then((value) {
      if (value != null) {
        setState(() {
          years = Years.fromJson(value).data;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            indicatorColor: Colors.orange,
            tabs: [
              Tab(icon: Text('مركباتي')),
              Tab(icon: Text("إختر مركبة جديدة")),
            ],
          ),
          title: Text('إختر المركبة'),
        ),
        body: TabBarView(
          children: [
            Container(child: Icon(Icons.directions_car)),
            Container(
                child: Column(
              children: [
                cartype == null
                    ? Container()
                    : GridView.builder(
                        primary: false,
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 2.3,
                          crossAxisCount: 2,
                        ),
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: cartype.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              margin: const EdgeInsets.all(15.0),
                              padding: const EdgeInsets.all(3.0),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.orange)),
                              child: Center(
                                  child: Text(
                                cartype[index].typeName,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                            ),
                          );
                        },
                      ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      years == null
                          ? Container()
                          : DropdownSearch<Year>(
                              label: " سنة الصنع ",

                              items: years,
                              //  onFind: (String filter) => getData(filter),
                              itemAsString: (Year u) => u.year,
                              onChanged: (Year data) => print(data),
                            ),
                    ],
                  ),
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
