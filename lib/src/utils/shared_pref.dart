
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SharedPref{
  //metodo para guardar datos
  void save(String key, String value)async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key,jsonEncode(value));

  }
  //metodo para leerlos
  Future<dynamic> read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString(key)== null) return null;
    return json.decode(prefs.getString(key));
  }
//nombre true- false
  //si existe un valor con un key establecida
  Future<bool> contains (String key) async {
    final prefs=await SharedPreferences.getInstance();
    return prefs.containsKey(key);


  }
  Future<bool> remove(String key) async {
    final prefs=await SharedPreferences.getInstance();
    return prefs.remove(key);


  }

}