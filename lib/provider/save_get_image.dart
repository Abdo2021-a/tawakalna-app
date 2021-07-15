import 'package:flutter/material.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class GetSveImage with ChangeNotifier {
  File imagee;
  String imagepath;
  String datetime;
  String datedayes;
  double dx;
  double dy;
  double dx_text;
  double dy_text;

  saveDxText() async {
    SharedPreferences preferencesdx = await SharedPreferences.getInstance();
    preferencesdx.setDouble("saveddxtext", dx_text);
    notifyListeners();
  }

  loadDxText() async {
    SharedPreferences preferencesdx = await SharedPreferences.getInstance();
    dx_text = preferencesdx.getDouble("saveddxtext");
    notifyListeners();
  }

  saveDyTrxt() async {
    SharedPreferences preferencesdy = await SharedPreferences.getInstance();
    preferencesdy.setDouble("savedytext", dy_text);
    notifyListeners();
  }

  loadDyText() async {
    SharedPreferences preferencesdy = await SharedPreferences.getInstance();
    dy_text = preferencesdy.getDouble("savedytext");
    notifyListeners();
  }

// ---------------------------------------
  saveDx() async {
    SharedPreferences preferencesdx = await SharedPreferences.getInstance();
    preferencesdx.setDouble("savedx", dx);
    notifyListeners();
  }

  loadDx() async {
    SharedPreferences preferencesdx = await SharedPreferences.getInstance();
    dx = preferencesdx.getDouble("savedx");
    notifyListeners();
  }

  saveDy() async {
    SharedPreferences preferencesdy = await SharedPreferences.getInstance();
    preferencesdy.setDouble("savedy", dy);
    notifyListeners();
  }

  loadDy() async {
    SharedPreferences preferencesdy = await SharedPreferences.getInstance();
    dy = preferencesdy.getDouble("savedy");
    notifyListeners();
  }

  chooseImage() async {
    var image = await ImagePicker().getImage(source: ImageSource.gallery);

    imagee = File(image.path);
    notifyListeners();
  }

  saveImage() async {
    SharedPreferences preferencespath = await SharedPreferences.getInstance();
    preferencespath.setString("imagepath", imagee.path);
    notifyListeners();
  }

  void loadimage() async {
    SharedPreferences preferencespath = await SharedPreferences.getInstance();

    imagepath = preferencespath.getString("imagepath");
    notifyListeners();
  }

  dateTime() {
    String datetime = DateFormat.jm('ar_SA').format(DateTime.now());

    return datetime;
  }

  dateDays() {
    String datedayes = DateFormat.MMMMEEEEd('ar_SA').format(DateTime.now());

    return datedayes;
  }

  saveDateTime() async {
    SharedPreferences preferencesdatetime =
        await SharedPreferences.getInstance();
    preferencesdatetime.setString("date_time", dateTime());
    notifyListeners();
  }

  saveDatedayes() async {
    SharedPreferences preferencesdatedays =
        await SharedPreferences.getInstance();
    preferencesdatedays.setString("date_days", dateDays());
    notifyListeners();
  }

  loadDateTime() async {
    SharedPreferences preferencesdatetime =
        await SharedPreferences.getInstance();
    datetime = preferencesdatetime.getString("date_time");
    notifyListeners();
  }

  loadDateDayes() async {
    SharedPreferences preferencesdatedays =
        await SharedPreferences.getInstance();
    datedayes = preferencesdatedays.getString("date_days");
    notifyListeners();
  }
}
