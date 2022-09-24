import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

// const String baseUrl = "https://franchise-be.herokuapp.com/api";
const String baseUrl = "https://bukafranchise-api.onrender.com/api";

final formatRupiah =
    NumberFormat.simpleCurrency(locale: 'id_ID', decimalDigits: 0);

getUserId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final userId = prefs.getString('userId');
  return userId;
}

getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');
  return token;
}

getNameUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final name = prefs.getString('name');
  return name;
}

getEmailUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final name = prefs.getString('email');
  return name;
}

getRoleUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final role = prefs.getString('role');
  return role;
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

class Date {
  static String formatJam(String tanggal) {
    if (tanggal != "") {
      DateTime dt = DateTime.parse(tanggal);
      String jam = DateFormat('HH:mm').format(dt);

      return '$jam WIB';
    } else {
      return "- : -";
    }
  }

  static String formatHari(String tanggal) {
    DateTime dateTime = DateFormat("yyyy-MM-dd").parse(tanggal);

    var day = DateFormat('EEEE').format(dateTime);
    var hari = "";
    switch (day) {
      case 'Sunday':
        {
          hari = "Minggu";
        }
        break;
      case 'Monday':
        {
          hari = "Senin";
        }
        break;
      case 'Tuesday':
        {
          hari = "Selasa";
        }
        break;
      case 'Wednesday':
        {
          hari = "Rabu";
        }
        break;
      case 'Thursday':
        {
          hari = "Kamis";
        }
        break;
      case 'Friday':
        {
          hari = "Jumat";
        }
        break;
      case 'Saturday':
        {
          hari = "Sabtu";
        }
        break;
    }
    return hari;
  }

  static String formatTglIndo(String tanggal) {
    DateTime dateTime = DateFormat("yyyy-MM-dd").parse(tanggal);

    var m = DateFormat('MM').format(dateTime);
    var d = DateFormat('dd').format(dateTime).toString();
    var Y = DateFormat('yyyy').format(dateTime).toString();
    var month = "";
    switch (m) {
      case '01':
        {
          month = "Januari";
        }
        break;
      case '02':
        {
          month = "Februari";
        }
        break;
      case '03':
        {
          month = "Maret";
        }
        break;
      case '04':
        {
          month = "April";
        }
        break;
      case '05':
        {
          month = "Mei";
        }
        break;
      case '06':
        {
          month = "Juni";
        }
        break;
      case '07':
        {
          month = "Juli";
        }
        break;
      case '08':
        {
          month = "Agustus";
        }
        break;
      case '09':
        {
          month = "September";
        }
        break;
      case '10':
        {
          month = "Oktober";
        }
        break;
      case '11':
        {
          month = "November";
        }
        break;
      case '12':
        {
          month = "Desember";
        }
        break;
    }
    return "$d $month $Y";
  }
}
