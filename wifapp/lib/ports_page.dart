



import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:network_tools/network_tools.dart';
import 'package:wifapp/host.dart';

class PortsPage extends StatefulWidget{

  const PortsPage({super.key, required this.host, required this.scan_mode, required this.first_port, required this.last_port, required this.ports_list});

  final HostInfo host;
  final int scan_mode;
  final int first_port;
  final int last_port;
  final List<String> ports_list;

  @override
  State<PortsPage> createState() => PortsPageState();
}

class PortsPageState extends State<PortsPage> {





  @override
  Widget build(BuildContext context) {
    log(widget.host.ports.toString());
    return  Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text('Details'),
        leading: IconButton(
          onPressed: () {

            Navigator.pop(context);

          },
          icon: Icon(Icons.keyboard_arrow_left),
        ),

      ),

      body:   SafeArea(
        child: SingleChildScrollView(
          child :
          Column(

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

                "[+] Name : " + widget.host.name,

                  style : TextStyle(
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.aspectRatio * 40

              ),
        ),
              Divider(

                height: MediaQuery.of(context).size.aspectRatio * 40,



              ),
              Text("[+] IP Address : " + widget.host.ip,
                style : TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.aspectRatio * 40

                ),
              ),
              Divider(

                height: MediaQuery.of(context).size.aspectRatio * 40,



              ),
              Text("[*] List of open ports : ",
                style : TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.aspectRatio * 40

                ),
              ),
              Text("*---------------*",
                style : TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.aspectRatio * 40

                ),
              ),
              Divider(

                height: MediaQuery.of(context).size.aspectRatio * 20,



              ),

              widget.host.ports.length != 0
              ? ListView.builder(
    physics: const NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemBuilder: (context, index) {
      final port = widget.host.ports[index];

      return Text(
          port.toString(),
          textAlign: TextAlign.center,
          style : TextStyle(

              color: Colors.white,
              fontSize: MediaQuery.of(context).size.aspectRatio * 40,




        ),

      );
    },
    itemCount : widget.host.ports.length,

              )

              : Text("[x] No ports found :/",
                style : TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.aspectRatio * 40

                ),
              ),
              Divider(

                height: MediaQuery.of(context).size.aspectRatio * 20,



              ),

              Text("*---------------*",
                style : TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.aspectRatio * 40

                ),
              ),



            ],

          ),


        ),
      ),

    );


  }
}