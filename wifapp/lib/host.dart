

import 'package:network_tools/network_tools.dart';


class HostInfo{
  late String _ip;
  late List<int> _ports;
  late String _name;
  late bool _been_scanned;

  HostInfo(String ip, List<int> ports, String name){
    this._ip = ip;
    this._ports = ports;
    this._name = name;
    this._been_scanned = false;
  }



  String get ip{
    return _ip;
  }

  List<int> get ports{
    return _ports;
  }

  String get name{
    return _name;
  }

  bool get been_scanned{
    return _been_scanned;
  }

  void set ip(String ip_addr){
    _ip = ip_addr;
  }

  void set ports(List<int> ports_list){
    _ports = ports_list;
  }

  void set name (String new_name){
    _name = new_name;
  }

  void set been_scanned (bool new_scan){
    _been_scanned = new_scan;
  }






}