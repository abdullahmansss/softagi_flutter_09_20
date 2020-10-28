
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences prefs;

Future<SharedPreferences> getPrefInstance() async
{
  if(prefs == null)
  {
    prefs = await SharedPreferences.getInstance();
  }

  return prefs;
}