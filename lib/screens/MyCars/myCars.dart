import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/screens/product/products_page.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/widget/ResultOverlay.dart';
import 'package:flutter_pos/model/car_made.dart';
import 'package:flutter_pos/model/car_type.dart';
import 'package:flutter_pos/model/carmodel.dart';
import 'package:flutter_pos/model/favourite.dart';
import 'package:flutter_pos/model/transmission.dart';
import 'package:flutter_pos/model/years.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/widget/not_login.dart';
import 'package:provider/provider.dart';
import '../../utils/navigator.dart';

class MyCars extends StatefulWidget {
  int checkboxType = 0;

  MyCars(this.checkboxType);

  @override
  _MyCarsState createState() => _MyCarsState();
}

class _MyCarsState extends State<MyCars> with SingleTickerProviderStateMixin {
  List<CarType> cartype;
  List<Year> years;
  List<Fav> favourite;
  List<CarMade> car_mades;
  List<CarModel> carmodels;
  List<Transmissions> transmissions;
  int checkboxValue;
  TabController _controller;

  //int checkboxType = 0;
  int car_mades_id;

  TextEditingController yearsID, carMadeID, CarmodelsID, transimionsID;

  @override
  void initState() {
    _controller = TabController(vsync: this, length: 2, initialIndex: 1);

    Provider.of<Provider_control>(context, listen: false).isLogin
        ? getFavorit()
        : null;
    yearsID = TextEditingController();
    carMadeID = TextEditingController();
    CarmodelsID = TextEditingController();
    transimionsID = TextEditingController();
    API(context).get('car/types/list').then((value) {
      if (value != null) {
        setState(() {
          cartype = Car_type.fromJson(value).data;
          getData(cartype[widget.checkboxType].id);
        });
      }
    });
    super.initState();
  }

  getData(int id) {

    API(context).get('car/madeslist/filter/$id').then((value) {
      if (value != null) {
        setState(() {
          car_mades = null;
          car_mades = Car_made.fromJson(value).data;
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
    API(context).get('transmissions/list').then((value) {
      if (value != null) {
        setState(() {
          transmissions = Transmission.fromJson(value).data;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<Provider_control>(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          bottom: TabBar(
            controller: _controller,
            indicatorColor: Colors.orange,
            tabs: [
              Tab(icon: Text('${getTransrlate(context, 'MyCars')}')),
              Tab(icon: Text("${getTransrlate(context, 'ChooseAnewVehicle')}")),
            ],
          ),
          title: Text('${getTransrlate(context, 'selectCar')}'),
        ),
        body: TabBarView(
          controller: _controller,
          children: [
            themeColor.isLogin
                ? Container(
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

                                          themeColor.setCar_made(
                                              favourite[index].carMadeName);
                                          Nav.route(
                                              context,
                                              Products_Page(
                                                id: favourite[index].carMadeId,
                                                name: favourite[index]
                                                    .carMadeName,
                                                Url:
                                                    "user/select/from/favourites/${favourite[index].id}",
                                              ));
                                        },
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            checkboxValue = index;
                                          });
                                          themeColor.setCar_made(
                                              favourite[index].carMadeName);
                                          Nav.route(
                                              context,
                                              Products_Page(
                                                id: favourite[index].carMadeId,
                                                name: favourite[index]
                                                    .carMadeName,
                                                Url:
                                                    "user/select/from/favourites/${favourite[index].id}",
                                              ));
                                        },
                                        child: Text(
                                          "${favourite[index].carMadeName} ${favourite[index].carModelName??''} ${favourite[index].carYearIdName??''}",
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
                                          API(context).post(
                                              'remove/favourite/car', {
                                            "id": favourite[index].id
                                          }).then((value) {
                                            if (value != null) {
                                              if (value['status_code'] == 200) {
                                                showDialog(
                                                    context: context,
                                                    builder: (_) =>
                                                        ResultOverlay(
                                                            value['message']));
                                                getFavorit();
                                              } else {
                                                showDialog(
                                                    context: context,
                                                    builder: (_) =>
                                                        ResultOverlay(
                                                            value['message']));
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
                  )
                : Notlogin(),
            Column(
              children: [
                cartype == null
                    ? Container()
                    : GridView.builder(
                        primary: false,
                        padding: const EdgeInsets.only(right: 20, left: 20),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 2.3,
                          crossAxisCount: 2,
                        ),
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: cartype.length,
                        itemBuilder: (BuildContext context, int index) {
                          bool selected = widget.checkboxType == index;
                          return InkWell(
                            onTap: () {
                              setState(() {
                                widget.checkboxType = index;
                                car_mades = null;
                                car_mades_id = null;
                                carmodels = null;
                                years = null;
                                transmissions = null;
                              });
                              getData(cartype[widget.checkboxType].id);
                            },
                            child: Container(
                              margin: const EdgeInsets.all(15.0),
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: selected
                                          ? Colors.orange
                                          : Colors.grey)),
                              child: Center(
                                  child: Text(
                                cartype[index].typeName,
                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),
                              )),
                            ),
                          );
                        },
                      ),
                Padding(
                  padding: const EdgeInsets.only(right: 24, left: 24),
                  child: Column(
                    children: [
                      car_mades == null
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownSearch<CarMade>(
                                showSearchBox: true,
                                showClearButton: true,

                                label: "  ${getTransrlate(context, 'brand')}",
                                items: car_mades,
                                //  onFind: (String filter) => getData(filter),
                                itemAsString: (CarMade u) => u.carMade,
                                onChanged: (CarMade data) {
                                  setState(() {
                                    carmodels = null;
                                  });
                                  getcarModels(data.id);
                                  car_mades_id = data.id;
                                  carMadeID.text = data.id.toString();
                                },
                              ),
                            ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownSearch<CarModel>(
                          label: "  ${getTransrlate(context, 'Model')} ",
                          showSearchBox: true,
                          showClearButton: true,
                          enabled: carmodels != null,
                          items: carmodels,
                          //  onFind: (String filter) => getData(filter),
                          itemAsString: (CarModel u) => u.carmodel,
                          onChanged: (CarModel data) =>
                              CarmodelsID.text = data.id.toString(),
                        ),
                      ),
                      years == null
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownSearch<Year>(
                                showSearchBox: true,
                                showClearButton: true,
                                label: "  ${getTransrlate(context, 'manufacturingYear')} ",
                                validator: (Year item) {
                                  if (item == null) {
                                    return "Required field";
                                  } else
                                    return null;
                                },
                                items: years,
                                //  onFind: (String filter) => getData(filter),
                                itemAsString: (Year u) => u.year,
                                onChanged: (Year data) {
                                  yearsID.text = data.id.toString();
                                },
                              ),
                            ),
                      transmissions == null
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownSearch<Transmissions>(
                                showSearchBox: true,
                                showClearButton: true,
                                label: "  ${getTransrlate(context, 'transmissionName')}",
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
                          Nav.routeReplacement(
                              context,
                              Products_Page(
                                Url: "display/search/results/mobile?"
                                    "car_type_id=${cartype[widget.checkboxType].id}"
                                    "${carMadeID.text.isEmpty ? '' : '&car_made_id=${carMadeID.text}'}"
                                    "${CarmodelsID.text.isEmpty ? '' : '&car_model_id=${CarmodelsID.text}'}"
                                    "${yearsID.text.isEmpty ? '' : '&car_year_id=${yearsID.text}'}"
                                    "${transimionsID.text.isEmpty ? '' : '&transmission_id=${yearsID.text}'}",
                              ));
                        },
                        child: Container(
                          margin: const EdgeInsets.all(8.0),
                          padding: const EdgeInsets.all(8.0),
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
                                '${getTransrlate(context, 'vehicleProducts')}',
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
                                  "car_type_id": cartype[widget.checkboxType].id,
                                  "car_made_id": car_mades_id,
                                  "car_year_id": yearsID.text,
                                  "car_model_id": CarmodelsID.text,
                                  "transmission_id": transimionsID.text,
                                }).then((value) {
                                  if (value != null) {
                                    if (value['status_code'] == 200) {
                                      showDialog(
                                          context: context,
                                          builder: (_) =>
                                              ResultOverlay(value['message']));
                                      _controller.index = 0;
                                      getFavorit();
                                    } else {
                                      _controller.index = 0;
                                      showDialog(
                                          context: context,
                                          builder: (_) =>
                                              ResultOverlay(value['message']));
                                    }
                                  }
                                });
                        },
                        child: Container(
                          margin: const EdgeInsets.all(8.0),
                          padding: const EdgeInsets.all(8.0),
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
                                '${getTransrlate(context, 'AddtoMyCars')}',
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
            ),
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
    API(context, Check: false).get('show/favourite/cars').then((value) {
      if (value != null) {
        setState(() {
          favourite = Favourite.fromJson(value).data;
        });
      }
    });
  }
}
