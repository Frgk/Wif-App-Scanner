





import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';



class ParametersPage extends StatefulWidget{
  @override
  State<ParametersPage> createState() => ParametersPageState();


}

class ParametersPageState extends State<ParametersPage>{

  final Uri _url = Uri.parse('https://github.com/Frgk/Wif-App-Scanner');


  final first_subnet_controller = TextEditingController();
  final last_subnet_controller = TextEditingController();

  final first_port_controller = TextEditingController();
  final last_port_controller = TextEditingController();

  final ports_list_controller = TextEditingController();

  int scan_mode = 0;
  int first_subnet = 0;
  int last_subnet = 0;
  int first_port = 0;
  int last_port = 0;
  List<String> ports_list = [];





  @override
  void initState(){
    super.initState();


    initSave();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // do what you want here
      initSave();
    });



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



  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }


  List<DropdownMenuItem<String>> get dropdownItems{
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text(">> Range of ports"),value: "0"),
      DropdownMenuItem(child: Text(">> Specific ports"),value: "1"),

    ];
    return menuItems;
  }

  String selectedValue = "0";


  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text('Parameters'),
        leading: IconButton(
          onPressed: () {

            Navigator.pop(context, true);



          },
          icon: Icon(Icons.keyboard_arrow_left),
        ),

      ),
    body: SafeArea(

    child: SingleChildScrollView(
      physics: ClampingScrollPhysics(),
    child: Column(
    children: [
    Text("===========================",
    style : TextStyle(
    color: Colors.white,
    fontSize: MediaQuery.of(context).size.aspectRatio * 40

    ),
    ),
    Divider(

    height: MediaQuery.of(context).size.aspectRatio * 40,



    ),

      Text("// Hosts Scan //",
        style : TextStyle(
            color: Colors.white,
            fontSize: MediaQuery.of(context).size.aspectRatio * 40

        ),
      ),
      Divider(

        height: MediaQuery.of(context).size.aspectRatio * 40,



      ),





        Row(
          mainAxisAlignment: MainAxisAlignment.center,

          children: <Widget>[

            Text("[*] First subnet >> ",
              style : TextStyle(
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.aspectRatio * 40

              ),
            ),
            Divider(

              indent: 10,
              endIndent: 10,




            ),



            SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              height: MediaQuery.of(context).size.height / 20,



              child:  TextField(
              onChanged: (text){
                first_subnet = int.parse(text);

                },



                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),



                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade600, width: 2.0),
                    ),

                    hintText: first_subnet.toString(),
                    hintStyle: TextStyle(fontSize: 15.0, color: Colors.grey.shade700),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.teal,
                      ),
                    ),
                  )
              ),
            ),
          ],
        ),
      Divider(

        height: MediaQuery.of(context).size.aspectRatio * 40,



      ),

      Row(
        mainAxisAlignment: MainAxisAlignment.center,

        children: <Widget>[

          Text("[*] Last subnet >> ",
            style : TextStyle(
                color: Colors.white,
                fontSize: MediaQuery.of(context).size.aspectRatio * 40

            ),
          ),
          Divider(

            indent: 10,
            endIndent: 10,




          ),



          SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            height: MediaQuery.of(context).size.height / 20,



            child:  TextField(
                textAlign: TextAlign.center,

                onChanged: (text){
                  last_subnet = int.parse(text);
                },

                style: TextStyle(color: Colors.white),



                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade600, width: 2.0),
                  ),

                  hintText: last_subnet.toString(),
                  hintStyle: TextStyle(fontSize: 15.0, color: Colors.grey.shade700),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.teal,
                    ),
                  ),
                )
            ),
          ),
        ],
      ),
      Divider(

        height: MediaQuery.of(context).size.aspectRatio * 20,



      ),
      Text("*-*-*-*-*-*-*-*-*-*",
        style : TextStyle(
            color: Colors.white,
            fontSize: MediaQuery.of(context).size.aspectRatio * 60

        ),
      ),

      Divider(

        height: MediaQuery.of(context).size.aspectRatio * 100,



      ),

      Text("// Ports Scan //",
        style : TextStyle(
            color: Colors.white,
            fontSize: MediaQuery.of(context).size.aspectRatio * 40

        ),
      ),
      Divider(

        height: MediaQuery.of(context).size.aspectRatio * 40,



      ),

        DropdownButton(


            value: scan_mode.toString(),
            icon: Icon(Icons.arrow_drop_down_sharp,
            color: Colors.white,),

            dropdownColor: Colors.black,
            style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.aspectRatio * 40),
            onChanged: (String? newValue){
              setState(() {
                selectedValue = newValue!;
                scan_mode = int.parse(newValue);
              });
            },
            items: dropdownItems
        ),
      Divider(

        height: MediaQuery.of(context).size.aspectRatio * 40,



      ),


      (scan_mode.toString() == '0')
       ? Row(
        mainAxisAlignment: MainAxisAlignment.center,

        children: <Widget>[

          Text("[*] From port ",
            style : TextStyle(
                color: Colors.white,
                fontSize: MediaQuery.of(context).size.aspectRatio * 40

            ),
          ),




          SizedBox(
            width: MediaQuery.of(context).size.width / 6,
            height: MediaQuery.of(context).size.height / 20,



            child:  TextField(
                textAlign: TextAlign.center,

                onChanged: (text){
                  first_port = int.parse(text);

                },
                style: TextStyle(color: Colors.white),



                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade600, width: 2.0),
                  ),

                  hintText: first_port.toString(),
                  hintStyle: TextStyle(fontSize: 15.0, color: Colors.grey.shade700),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.teal,
                    ),
                  ),
                )
            ),
          ),

          Text(" to port ",
            style : TextStyle(
                color: Colors.white,
                fontSize: MediaQuery.of(context).size.aspectRatio * 40

            ),
          ),

          SizedBox(
            width: MediaQuery.of(context).size.width / 6,
            height: MediaQuery.of(context).size.height / 20,



            child:  TextField(
                textAlign: TextAlign.center,

                onChanged: (text){
                  last_port = int.parse(text);

                },
                style: TextStyle(color: Colors.white),



                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade600, width: 2.0),
                  ),

                  hintText: last_port.toString(),
                  hintStyle: TextStyle(fontSize: 15.0, color: Colors.grey.shade700),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.teal,
                    ),
                  ),
                )
            ),
          ),



        ],
      )
    : Row(
        mainAxisAlignment: MainAxisAlignment.center,

        children: <Widget>[

          Text("[*] List of ports : ",
            style : TextStyle(
                color: Colors.white,
                fontSize: MediaQuery.of(context).size.aspectRatio * 40

            ),
          ),




          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.height / 20,



            child:  TextField(
                textAlign: TextAlign.center,
                onChanged: (text){
                  ports_list = text.split(',');
                },

                style: TextStyle(color: Colors.white),



                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade600, width: 2.0),
                  ),

                  hintText: ports_list.join(','),
                  hintStyle: TextStyle(fontSize: 15.0, color: Colors.grey.shade700),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.teal,
                    ),
                  ),
                )
            ),
          ),





        ],
      ),




      Divider(

        height: MediaQuery.of(context).size.aspectRatio * 20,



      ),
      Text("*-*-*-*-*-*-*-*-*-*",
        style : TextStyle(
            color: Colors.white,
            fontSize: MediaQuery.of(context).size.aspectRatio * 60

        ),
      ),

      Divider(

        height: MediaQuery.of(context).size.aspectRatio * 150,



      ),

      ElevatedButton.icon(
        icon: Icon(Icons.save),
          onPressed: () async {
          final _prefs = await SharedPreferences.getInstance();


          log(last_port.toString());

          setState(() {
            _prefs.setInt('first_subnet', first_subnet);
            _prefs.setInt('last_subnet', last_subnet);
            _prefs.setInt('first_port', first_port);
            _prefs.setInt('last_port', last_port);
            _prefs.setInt('scan_mode', scan_mode);
            _prefs.setStringList('ports_list', ports_list);

          });

          },
        label: Text('Save settings',
          style: TextStyle(

            fontSize: MediaQuery.of(context).size.aspectRatio * 30,
          ),

        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.black,
          onPrimary: Colors.white,
          shadowColor: Colors.grey,
          elevation: 3,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
              side: BorderSide(color: Colors.white)),
          minimumSize: Size(
              MediaQuery.of(context).size.aspectRatio * 250,
              MediaQuery.of(context).size.aspectRatio * 75
          ), //////// HERE
        ),
          ),

      Divider(

        height: MediaQuery.of(context).size.aspectRatio * 40,



      ),
      Text("===========================",
        style : TextStyle(
            color: Colors.white,
            fontSize: MediaQuery.of(context).size.aspectRatio * 40

        ),
      ),
      Divider(

        height: MediaQuery.of(context).size.aspectRatio * 40,



      ),







    Column(
    children: [
    Text("Developped by Frgk",
    style: TextStyle(
      color: Colors.white,
        fontSize: MediaQuery.of(context).size.aspectRatio * 25,
    ),
    ),


      TextButton(
        style: TextButton.styleFrom(
          textStyle: TextStyle(
            fontSize: MediaQuery.of(context).size.aspectRatio * 25,
          color: Colors.blueGrey,

          ),
        ),
        onPressed: () {
          _launchUrl();

        },
        child: const Text('See the project on GitHub'),
      ),

    ],
    ),

      Divider(

        height: MediaQuery.of(context).size.aspectRatio * 40,



      ),
      Text("===========================",
        style : TextStyle(
            color: Colors.white,
            fontSize: MediaQuery.of(context).size.aspectRatio * 40

        ),
      ),
      Divider(

        height: MediaQuery.of(context).size.aspectRatio * 40,



      ),

    ],
    ),// Populate the Drawer in the next step.
    ),

    ),
    );


  }


}