import 'dart:io';
import 'dart:typed_data';

enum IPAddressMode {
  controlHubIP('Control Hub (192.168. 43.1)'), // 1
  localhost('localhost (127.0.0.1)'), // 2
  custom('Custom'); // 3

  const IPAddressMode(this.displayName);

  final String displayName;

  @override
  String toString() {
    return displayName;
  }

  static IPAddressMode fromIndex(int? index) {
    if (index == null || index >= values.length) {
      return IPAddressMode.controlHubIP;
    }

    return values[index];
  }
}

class IPAddressUtil {
  static bool isTeamNumber(String ipAddress) {
    return int.tryParse(ipAddress) != null;
  }

  static String teamNumberToRIOmDNS(int teamNumber) {
    return 'roboRIO-$teamNumber-FRC.local';
  }

  static String teamNumberToIP(int teamNumber) {
    String te = (teamNumber ~/ 100).toString();
    String am = (teamNumber % 100).toString().padLeft(2, '0');

    return '10.$te.$am.2';
  }

  static String getIpFromInt32Value(int value) =>
      InternetAddress.fromRawAddress(
              (ByteData(4)..setInt32(0, value)).buffer.asUint8List())
          .address;
}
