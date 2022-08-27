

import 'package:network_tools/network_tools.dart';


class HostInfo{
  late String _ip;
  late List<int> _ports;
  late String _name;

  HostInfo(String ip, List<int> ports, String name){
    this._ip = ip;
    this._ports = ports;
    this._name = name;
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

  void set ip(String ip_addr){
    _ip = ip_addr;
  }

  void set ports(List<int> ports_list){
    _ports = ports_list;
  }

  void set name (String new_name){
    _name = new_name;
  }






}