import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:network_tools/network_tools.dart';
import 'package:wifapp/host.dart';
import 'package:wifapp/ports_page.dart';

import 'package:intl/intl.dart';

class HostPage extends StatefulWidget {
  const HostPage(
      {super.key,
      required this.hosts,
      required this.scan_mode,
      required this.first_port,
      required this.last_port,
      required this.ports_list});

  final List<HostInfo> hosts;
  final int scan_mode;
  final int first_port;
  final int last_port;
  final List<String> ports_list;

  @override
  State<HostPage> createState() => HostPageState();
}

class HostPageState extends State<HostPage> {
  Future<void> portscan(HostInfo host) async {
    //host.ports.clear();

    // log(widget.first_port.toString());
    // log(widget.last_port.toString());

    // If the host hasn't be scanned
    if (!host.been_scanned) {
      // If the scan mode choose in parameters page is equal to 0 (corresponding to the port scan in a range)
      if (widget.scan_mode == 0) {
        PortScanner.scanPortsForSingleDevice(
          host.ip,
          // Scan will start from this port.
          startPort: widget.first_port,
          endPort: widget.last_port,
          progressCallback: (progress) {
            // log('Progress for port discovery : $progress');
          },
        ).listen(
          (activeHost) {
            final OpenPort deviceWithOpenPort = activeHost.openPort[0];

            // If the port found is open
            if (deviceWithOpenPort.isOpen) {
              // log('Found open port: ${deviceWithOpenPort.port}');

              // Add it to the list of open ports of the host
              setState(() {
                host.ports.add(deviceWithOpenPort.port);
              });
            }
          },
          onDone: () {
            // print('Port Scan from 1 to 9400 completed');

            // log(host.ports.toString());

            // After the ports scan, the host is considered has scanned
            host.been_scanned = true;

            // Navigate to the details page of the host
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PortsPage(
                        host: host,
                        first_port: widget.first_port,
                        last_port: widget.last_port,
                        scan_mode: widget.scan_mode,
                        ports_list: widget.ports_list,
                      )),
            );
          },
        );
        // Else the scan_mode is equal to 1, corresponding to a specific list of ports to scan
      } else {
        PortScanner.customDiscover(host.ip,
                portList: widget.ports_list.map(int.parse).toList())
            .listen(
          (activeHost) {
            final OpenPort deviceWithOpenPort = activeHost.openPort[0];

            if (deviceWithOpenPort.isOpen) {
              // print('Found open port: ${deviceWithOpenPort.port}');

              setState(() {
                host.ports.add(deviceWithOpenPort.port);
              });
            }
          },
          onDone: () {
            // print('Port Scan from 1 to 9400 completed');
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PortsPage(
                        host: host,
                        first_port: widget.first_port,
                        last_port: widget.last_port,
                        scan_mode: widget.scan_mode,
                        ports_list: widget.ports_list,
                      )),
            );
          },
        );
      }
      // Else the host has alreday been scanned, so no need to rescan it again
    } else {
      // Navigate to the details page, because the list of open ports of the host has already been done
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PortsPage(
                  host: host,
                  first_port: widget.first_port,
                  last_port: widget.last_port,
                  scan_mode: widget.scan_mode,
                  ports_list: widget.ports_list,
                )),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text('Results of the scan'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.keyboard_arrow_left),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "==============================",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.aspectRatio * 40),
              ),
              Divider(
                height: MediaQuery.of(context).size.aspectRatio * 40,
              ),

              // If there is no hosts found on the network
              widget.hosts.length == 0
                  ? Text(
                      "[x] No hosts found :/",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize:
                              MediaQuery.of(context).size.aspectRatio * 40),
                    )
                  : ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index_host) {
                        final host = widget.hosts.elementAt(index_host);

                        return ExpansionTile(
                          title: Text(
                            "[+] " + host.name,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.of(context).size.aspectRatio *
                                        30),
                          ),
                          subtitle: Text(
                            ">> " + host.ip,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.of(context).size.aspectRatio *
                                        30),
                          ),
                          children: [
                            Text(
                              // If the hots has already been scanned
                              host.been_scanned ? "[*] Already scanned" : "",

                              style: TextStyle(
                                  color: Colors.green.shade900,
                                  fontSize:
                                      MediaQuery.of(context).size.aspectRatio *
                                          30),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                // log("TEST");

                                // Realize the ports scan of the host
                                await portscan(host);
                              },
                              child: Text(
                                "More Details",
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.aspectRatio *
                                          25,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.black,
                                onPrimary: Colors.white,
                                shadowColor: Colors.grey,
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: BorderSide(color: Colors.white)),
                                minimumSize: Size(
                                  MediaQuery.of(context).size.aspectRatio * 150,
                                  MediaQuery.of(context).size.aspectRatio * 60,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                      itemCount: widget.hosts.length,
                    ),

              Divider(
                height: MediaQuery.of(context).size.aspectRatio * 40,
              ),
              Text(
                "==============================",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.aspectRatio * 40),
              ),

              Divider(
                height: MediaQuery.of(context).size.aspectRatio * 100,
              ),
              Text(
                "Realized at " + DateFormat.jm().format(DateTime.now()),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.aspectRatio * 30),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
