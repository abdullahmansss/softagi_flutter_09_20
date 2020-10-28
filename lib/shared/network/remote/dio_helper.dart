import 'package:dio/dio.dart';

Dio dio;

Dio getDioInstance()
{
  if(dio == null)
  {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
        headers:
        {
          'lang':'en',
          'Content-Type':'application/json',
        },
      ),
    );
  }
  return dio;
}