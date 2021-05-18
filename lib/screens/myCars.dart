import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/ResultOverlay.dart';
import 'package:flutter_pos/model/car_made.dart';
import 'package:flutter_pos/model/car_type.dart';
import 'package:flutter_pos/model/carmodel.dart';
import 'package:flutter_pos/model/favourite.dart';
import 'package:flutter_pos/model/transmission.dart';
import 'package:flutter_pos/model/years.dart';
import 'package:flutter_pos/screens/productCarPage.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:provider/provider.dart';

import '../model/product_model.dart';
import '../utils/navigator.dart';

class MyCars extends StatefulWidget {
  const MyCars({Key key}) : super(key: key);

  @override
  _MyCarsState createState() => _MyCarsState();
}

class _MyCarsState extends State<MyCars> {
  List<CarType> cartype;
  List<Year> years;
  List<Fav> favourite;
  List<CarMade> car_mades;
  List<CarModel> carmodels;
  List<Transmissions> transmissions;
  int checkboxValue = 0;
  int car_mades_id;

  TextEditingController yearsID, carMadeID, CarmodelsID, transimionsID;
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
    API(context).get('car/madeslist').then((value) {
      if (value != null) {
        setState(() {
          car_mades = Car_made.fromJson(value).data;
        });
      }
    });
    API(context).get('transmissions/list').then((value) {
      if (value != null) {
        setState(() {
          transmissions = Transmission.fromJson(value).data;
        });
      }
    });
    getFavorit();
    yearsID = TextEditingController();
    carMadeID = TextEditingController();
    CarmodelsID = TextEditingController();
    transimionsID = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<Provider_control>(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            indicatorColor: Colors.orange,
            tabs: [
              Tab(icon: Text('مركباتى')),
              Tab(icon: Text("إختر مركبة جديدة")),
            ],
          ),
          title: Text('إختر المركبة'),
        ),
        body: TabBarView(
          children: [
            Container(
              child: favourite == null
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: favourite.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                                child: Row(
                              children: [
                                Radio<int>(
                                  value: index,
                                  groupValue: checkboxValue,
                                  activeColor: themeColor.getColor(),
                                  focusColor: themeColor.getColor(),
                                  hoverColor: themeColor.getColor(),
                                  onChanged: (int value) {
                                    setState(() {
                                      checkboxValue = value;
                                    });
                                    Navigator.pop(context);
                                    themeColor.setCar_made(
                                        favourite[index].carMadeName);
                                  },
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      checkboxValue = index;
                                    });
                                    themeColor.setCar_made(
                                        favourite[index].carMadeName);
                                    API(context).post('user/select/products', {
                                      "car_made_id": favourite[index].carMadeId,
                                    }).then((value) {
                                      if (value != null) {
                                        if (value['status_code'] == 200) {
                                          Nav.route(
                                              context,
                                              ProductCarPage(
                                                name: favourite[index]
                                                    .carMadeName,
                                                product: Product_model.fromJson(
                                                        value)
                                                    .data,
                                              ));
                                        } else {
                                          showDialog(
                                              context: context,
                                              builder: (_) => ResultOverlay(
                                                  value['message']));
                                        }
                                      }
                                    });
                                  },
                                  child: Text(
                                    favourite[index].carMadeName,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ),
                                Expanded(
                                    child: SizedBox(
                                  height: 1,
                                )),
                                IconButton(
                                  icon: Icon(Icons.clear),
                                  onPressed: () {
                                    API(context).post('remove/favourite/car', {
                                      "id": favourite[index].id
                                    }).then((value) {
                                      if (value != null) {
                                        if (value['status_code'] == 200) {
                                          showDialog(
                                              context: context,
                                              builder: (_) => ResultOverlay(
                                                  value['message']));
                                          getFavorit();
                                        }
                                      }
                                    });
                                  },
                                )
                              ],
                            )),
                          );
                        },
                      ),
                    ),
            ),
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
                  padding: const EdgeInsets.only(right: 24, left: 24),
                  child: Column(
                    children: [
                      years == null
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownSearch<Year>(
                                label: " سنة الصنع ",

                                items: years,
                                //  onFind: (String filter) => getData(filter),
                                itemAsString: (Year u) => u.year,
                                onChanged: (Year data) =>
                                    yearsID.text = data.id.toString(),
                              ),
                            ),
                      car_mades == null
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownSearch<CarMade>(
                                label: "الماركة",
                                items: car_mades,
                                //  onFind: (String filter) => getData(filter),
                                itemAsString: (CarMade u) => u.carMade,
                                onChanged: (CarMade data) {
                                  getcarModels(data.id);
                                  car_mades_id = data.id;
                                  carMadeID.text = data.id.toString();
                                },
                              ),
                            ),
                      carmodels == null
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownSearch<CarModel>(
                                label: " الموديل ",

                                items: carmodels,
                                //  onFind: (String filter) => getData(filter),
                                itemAsString: (CarModel u) => u.carmodel,
                                onChanged: (CarModel data) =>
                                    CarmodelsID.text = data.id.toString(),
                              ),
                            ),
                      transmissions == null
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownSearch<Transmissions>(
                                label: " ناقل الحركة ",
                                items: transmissions,
                                //  onFind: (String filter) => getData(filter),
                                itemAsString: (Transmissions u) =>
                                    u.transmissionName,
                                onChanged: (Transmissions data) =>
                                    transimionsID.text = data.id.toString(),
                              ),
                            ),
                      InkWell(
                        onTap: () {
                          API(context).post('user/select/products', {
                            "car_made_id": car_mades_id,
                            "car_model_id": CarmodelsID.text,
                            "car_year_id": yearsID.text,
                            "transmission_id": transimionsID.text,
                          }).then((value) {
                            if (value != null) {
                              if (value['status_code'] == 200) {
                                Nav.route(
                                    context,
                                    ProductCarPage(
                                      product:
                                          Product_model.fromJson(value).data,
                                    ));
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (_) =>
                                        ResultOverlay(value['message']));
                              }
                            }
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.all(15.0),
                          padding: const EdgeInsets.all(3.0),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.orange)),
                          child: Center(
                              child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.search,
                                color: Colors.orange,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'إعرض منتجات المركبة',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange),
                              ),
                            ],
                          )),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          car_mades_id == null
                              ? showDialog(
                                  context: context,
                                  builder: (_) =>
                                      ResultOverlay('Please select Car Made'))
                              : API(context).post(
                                  'user/select/products/add/favourite/car', {
                                  "car_made_id": car_mades_id,
                                }).then((value) {
                                  if (value != null) {
                                    if (value['status_code'] == 200) {
                                      showDialog(
                                          context: context,
                                          builder: (_) =>
                                              ResultOverlay(value['message']));
                                      getFavorit();
                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (_) =>
                                              ResultOverlay(value['message']));
                                    }
                                  }
                                });
                        },
                        child: Container(
                          margin: const EdgeInsets.all(15.0),
                          padding: const EdgeInsets.all(3.0),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.orange)),
                          child: Center(
                              child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add,
                                color: Colors.orange,
                              ),
                              Text(
                                'أضف إلى مركباتي',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange),
                              ),
                            ],
                          )),
                        ),
                      )
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

  void getcarModels(int car_made_id) {
    API(context).get('car/modelslist/$car_made_id').then((value) {
      if (value != null) {
        setState(() {
          carmodels = Carmodel.fromJson(value).data;
        });
      }
    });
  }

  void getFavorit() {
    API(context).get('show/favourite/cars').then((value) {
      if (value != null) {
        setState(() {
          favourite = Favourite.fromJson(value).data;
        });
      }
    });
  }
}
