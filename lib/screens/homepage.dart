import 'dart:io';
import 'dart:typed_data';
import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pos/screens/cards.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/hidden_menu.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;
  List<BluetoothDevice> _devices = [];
  BluetoothDevice _device;
  bool _connected = false;
  String pathImage;

  @override
  void initState() {
    super.initState();
    initPlatformState();
    initSavetoPath();

  }
  Future<void> writeToFile(ByteData data, String path) {
    final buffer = data.buffer;
    return  File(path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }
  initSavetoPath()async{
    //read and write
    //image max 300px X 300px
    final filename = 'logo.jpg';
    var bytes = await rootBundle.load("assets/images/logo.jpg");
    String dir = (await getApplicationDocumentsDirectory()).path;
    writeToFile(bytes,'$dir/$filename');
    setState(() {
      pathImage='$dir/$filename';
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: HiddenMenu(),
      body: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  _scaffoldKey.currentState.openDrawer();
                },
                icon: Icon(
                  Icons.menu,
                  size: 30,
                ),
                color: Colors.blue,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 35),
                  child: Image.asset(
                    'assets/images/logo.png',
                    height: ScreenUtil.getHeight(context) / 5,
                    width: ScreenUtil.getWidth(context) / 2,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(width: 50,height: 10,),
            ],
          ),
          Container(
            height: ScreenUtil.getHeight(context) / 5,
            width: ScreenUtil.getWidth(context) / 2.5,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blueAccent, width: 5),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AutoSizeText(
                  'الرصيد',
                  style: TextStyle(color: Colors.blue,),
                ),
                AutoSizeText(
                  '110.0',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                AutoSizeText('ريال',
                    style: TextStyle(color: Colors.blue, )),
              ],
            )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  'مرحبا بك , ',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'أحمد فوقى',
                  style: TextStyle(color: Colors.black, fontSize: 22),
                ),
              ],
            ),
          ),
          FlatButton(
            textColor: Colors.white,
            color: Colors.blue,
            onPressed: () {Nav.route(context, Cardnet());},
            child: Text('البطاقات'),
            minWidth: ScreenUtil.getWidth(context) / 2.5,
          ),
          FlatButton(
            textColor: Colors.white,
            color: Colors.red,
            minWidth: ScreenUtil.getWidth(context) / 2.5,
            onPressed: () {},
            child: Text('تسجبل الخروج'),
          ),
          SizedBox(
            height: ScreenUtil.getHeight(context) / 30,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FlatButton(
                textColor: Colors.white,
                color: Colors.blueGrey,
                minWidth: ScreenUtil.getWidth(context) / 4.5,
                onPressed: () {
                  _tesPrint();
                },
                child: Text('اختبار الطابعة'),
              ),
              FlatButton(
                textColor: Colors.white,
                color: Colors.orange,
                minWidth: ScreenUtil.getWidth(context) / 4.5,
                onPressed: () async {
                   await showDialog(
                    context: this.context,
                    child: AlertDialog(
                      content: _devices.isEmpty?Container():Container(
                        height: ScreenUtil.getHeight(context)/2,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: _devices.length,
                            itemBuilder: (context, i){
                                return ListTile(
                                  title: Text("${_devices[i].name}"),onTap: (){
                                  setState(() => _device = _devices[i]);
                                  _connect();
                                  Navigator.pop(context);
                                },
                                );

                            },),
                      )),

                  );
                },
                child: Text(
                  'تحديد الطابعة',
                  style: TextStyle(),
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _makePhoneCall('tel:0552299488');
        },
        child: const Icon(Icons.call),
        backgroundColor: Colors.green,
      ),
    );
  }
  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  Future<void> initPlatformState() async {
    bool isConnected=await bluetooth.isConnected;
    List<BluetoothDevice> devices = [];
    try {
      devices = await bluetooth.getBondedDevices();
    } on PlatformException {
      // TODO - Error
    }

    bluetooth.onStateChanged().listen((state) {
      switch (state) {
        case BlueThermalPrinter.CONNECTED:
          setState(() {
            _connected = true;
          });
          break;
        case BlueThermalPrinter.DISCONNECTED:
          setState(() {
            _connected = false;
          });
          break;
        default:
          print(state);
          break;
      }
    });

    if (!mounted) return;
    setState(() {
      _devices = devices;
    });

    if(isConnected) {
      setState(() {
        _connected=true;
      });
    }
  }
  void _tesPrint() async {
    bluetooth.isConnected.then((isConnected) {
      if (isConnected) {
        bluetooth.printCustom("Card Net",3,1);
        bluetooth.printNewLine();
        bluetooth.printImage(pathImage);
        bluetooth.printNewLine();
        bluetooth.printNewLine();
        bluetooth.printCustom("CardNet@2019",2,1);
        bluetooth.printNewLine();
        bluetooth.printNewLine();
        bluetooth.printNewLine();
        bluetooth.paperCut();
      }
    });
  }
  void _connect() {
    if (_device == null) {
    } else {
      bluetooth.isConnected.then((isConnected) {
        if (!isConnected) {
          bluetooth.connect(_device).catchError((error) {
            setState(() => _connected = false);
          });
          setState(() => _connected = true);
        }
      });
    }
  }
}
