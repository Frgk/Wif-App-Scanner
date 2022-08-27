


import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lan_scanner/lan_scanner.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:network_tools/network_tools.dart';

import 'dart:developer';

import 'package:wifapp/host.dart';
import 'package:wifapp/host_page.dart';
import 'package:wifapp/parameters.dart';
import 'package:shared_preferences/shared_preferences.dart';



class Accueil extends StatefulWidget{

  @override
  State<Accueil> createState() => AccueilState();
}

class AccueilState extends State<Accueil> {

  List<HostInfo> _hosts  = [];

  int scan_mode = 0;
  int first_subnet = 0;
  int last_subnet = 0;
  int first_port = 0;
  int last_port = 0;
  List<String> ports_list = [];


  final info = NetworkInfo();

  late var wifiName ; // FooNetwork
  late var wifiBSSID ; // 11:22:33:44:55:66
  late var wifiIP ; // 192.168.1.43
  late var wifiIPv6 ; // 2001:0db8:85a3:0000:0000:8a2e:0370:7334
  late var wifiSubmask; // 255.255.255.0
  late var wifiBroadcast ; // 192.168.1.255
  late var wifiGateway ; // 192.168.1.1


  @override
  void initState(){

    super.initState();

    initSave();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // do what you want here
      initSave();
    });









  }


  Future<bool> initializeDetails() async{
    wifiName = await info.getWifiName(); // FooNetwork
    wifiBSSID = await info.getWifiBSSID(); // 11:22:33:44:55:66
    wifiIP = await info.getWifiIP(); // 192.168.1.43
    wifiIPv6 = await info.getWifiIPv6(); // 2001:0db8:85a3:0000:0000:8a2e:0370:7334
    wifiSubmask = await info.getWifiSubmask(); // 255.255.255.0
    wifiBroadcast = await info.getWifiBroadcast(); // 192.168.1.255
    wifiGateway = await info.getWifiGatewayIP(); // 192.168.1.1

    return true;

  }

  Future<void> initSave() async {
    final _prefs = await SharedPreferences.getInstance();





    setState(() {
      scan_mode =  _prefs.getInt('scan_mode') ?? 0;

      first_subnet = _prefs.getInt('first_subnet') ?? 1;
      last_subnet = _prefs.getInt('last_subnet') ?? 50;

      first_port = _prefs.getInt('first_port') ?? 1;
      last_port = _prefs.getInt('last_port') ?? 9400;
      ports_list = _prefs.getStringList('ports_list') ?? ['22','33'];

    });




  }






























  Future<void> netscan() async{
    _hosts.clear();







    String address = '192.168.1.12';
    // or You can also get address using network_info_plus package
    // final String? address = await (NetworkInfo().getWifiIP());
    final String subnet = address.substring(0, address.lastIndexOf('.'));

    log(last_port.toString());


    final stream = HostScanner.getAllPingableDevices(subnet, firstSubnet: first_subnet, lastSubnet: last_subnet, timeoutInSeconds: 1,
        progressCallback: (progress) {

          log('Progress for host discovery : $progress');


        });



     stream.listen((host) async{

      String name = await host.deviceName;



      setState((){
        _hosts.add(HostInfo(host.address, [], name));


      });




      //Same host can be emitted multiple times
      //Use Set<ActiveHost> instead of List<ActiveHost>
      print('Found device: ${host}');



    }, onDone: () {
      print('Scan completed');


      log(first_port.toString());
      log(last_port.toString());




      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HostPage(hosts: _hosts,first_port: first_port,last_port: last_port,scan_mode: scan_mode,ports_list: ports_list)),
      );




     });

     // Don't forget to cancel the stream when not in use.






  }

  Future<void> portscan(HostInfo host) async{



    await PortScanner.scanPortsForSingleDevice(
      host.ip,
      // Scan will start from this port.
      // startPort: 1,
      endPort: 9400,
      progressCallback: (progress) {
        log('Progress for port discovery : $progress');
      },
    ).listen(
          (activeHost) {
        final OpenPort deviceWithOpenPort = activeHost.openPort[0];

        if (deviceWithOpenPort.isOpen) {
          log('Found open port: ${deviceWithOpenPort.port}');

          setState((){

            host.ports.add(deviceWithOpenPort.port);
          });

        }
      },
      onDone: () {
        print('Port Scan from 1 to 9400 completed');
      },
    );
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          "Wif'App Scanner",
          textAlign: TextAlign.center,
          style : TextStyle(
              fontSize: MediaQuery.of(context).size.aspectRatio * 45,


          ),
        ),

        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {

                Navigator.push(context, MaterialPageRoute(builder: (context) => ParametersPage())).then((value) {
                  setState(() {
                    // refresh state of Page1
                  });
                });

                /*
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ParametersPage()),
                );
                */

              },

            );
          },
        ),

      ),




        body:
        FutureBuilder(
          future: initializeDetails(),
          builder: (context, snapshot){
            if (snapshot.hasData){

              return SafeArea(
                child : Center(
                child: SingleChildScrollView(
                    child: Column(
                      children: [


                        Text("==============================",
                          style : TextStyle(
                              color: Colors.white,
                              fontSize: MediaQuery.of(context).size.aspectRatio * 40

                          ),
                        ),
                        Divider(

                          height: MediaQuery.of(context).size.aspectRatio * 20,



                        ),

                        Text(
                          wifiName.toString() == "null"
                              ? "[-] Wifi name not found :/"
                              : "[+] Wifi name : " + wifiName.toString(),
                          style : TextStyle(
                            color: Colors.white,
                              fontSize: MediaQuery.of(context).size.aspectRatio * 40

                          ),


                        ),

                        Divider(

                          height: MediaQuery.of(context).size.aspectRatio * 20,



                        ),
                        Text(
                          "[+] Your IP address : " + wifiIP.toString(),
                          style : TextStyle(
                              color: Colors.white,
                              fontSize: MediaQuery.of(context).size.aspectRatio * 40

                          ),
                        ),
                        Divider(

                          height: MediaQuery.of(context).size.aspectRatio * 20,



                        ),
                        Text("==============================",
                          style : TextStyle(
                              color: Colors.white,
                              fontSize: MediaQuery.of(context).size.aspectRatio * 40

                          ),
                        ),

                        Divider(

                          height: MediaQuery.of(context).size.aspectRatio * 400,



                        ),
                        ElevatedButton.icon(

                          onPressed: () async{



                            await initSave();

                            await netscan();













                          },
                          icon : Icon(Icons.search),

                          label: Text('Scan',
                            style: TextStyle(

                              fontSize: MediaQuery.of(context).size.aspectRatio * 40,
                            ),

                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black,
                            onPrimary: Colors.white,
                            shadowColor: Colors.grey,
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32.0),
                                side: BorderSide(color: Colors.white)),
                            minimumSize: Size(
                                MediaQuery.of(context).size.aspectRatio * 350,
                              MediaQuery.of(context).size.aspectRatio * 125
                            ), //////// HERE
                          ),
                        ),
























                      ],
                    )
                ),
                ),
              );

            } else{
              return CircularProgressIndicator();
            }


          },


        ),




    );


  }

}