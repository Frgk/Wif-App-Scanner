import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';



// Ajoute une fenêtre volante avec couleurs et textes personnalisés
void displayToast(BuildContext context, Color toastColor, Color contentColor,
    IconData icon, String toastText) {
  FToast fToast = FToast();
  fToast.init(context);

  Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: toastColor,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: contentColor,
        ),
        SizedBox(
          width: 12.0,
        ),
        Flexible(
          child: Text(
            toastText,
            overflow: TextOverflow.visible,
            style: TextStyle(
              color: contentColor,
            ),
          ),
        ),
      ],
    ),
  );
  fToast.showToast(
    child: toast,
    gravity: ToastGravity.TOP,
    toastDuration: Duration(seconds: 2),
  );
}


Future<void> initSave(int? scan_mode, int? first_subnet, int? last_subnet, int? first_port, int? last_port, List<String>? ports_list) async {
  final _prefs = await SharedPreferences.getInstance();


  scan_mode =  _prefs.getInt('scan_mode') ?? 0;
  first_subnet = _prefs.getInt('first_subenet') ?? 1;
  last_subnet = _prefs.getInt('last_subenet') ?? 50;
  first_port = _prefs.getInt('first_port') ?? 1;
  last_port = _prefs.getInt('last_port') ?? 9400;
  ports_list = _prefs.getStringList('ports_list') ?? ['22','33'];



}

Future<void> writeSave(int? scan_mode, int? first_subnet, int? last_subnet, int? first_port, int? last_port, List<String>? ports_list) async {
  final _prefs = await SharedPreferences.getInstance();

   _prefs.setInt('scan_mode', scan_mode!);
  _prefs.setInt('first_subnet', first_subnet!);
  _prefs.setInt('last_subenet', last_subnet!);
  _prefs.setInt('first_port', first_port!);
  _prefs.setInt('last_port', last_port!);
  _prefs.setStringList('ports_list', ports_list!);


}