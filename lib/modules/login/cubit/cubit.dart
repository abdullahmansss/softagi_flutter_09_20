import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_app/modules/login/cubit/states.dart';
import 'package:flutter_app/shared/network/cache/shared_pref_helper.dart';
import 'package:flutter_app/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginStates>
{
  LoginCubit() : super(LoginStateInitial());

  static LoginCubit get(context) => BlocProvider.of(context);

  login(email, password) async
  {
    emit(LoginStateLoading());

    FormData formData = FormData.fromMap({
      'email': email,
      'password': password,
    });

    await getDioInstance().post('login', data: formData).then((response) async
    {
      if(response.data['status'])
      {
        getPrefInstance().then((prefs) async
        {
          await prefs.setString('token', response.data['data']['token']).then((value)
          {
            emit(LoginStateSuccess());
          });
        });
      } else
        {
          emit(LoginStateError(
            error: response.data['message'],
          ));
        }

      return null;
    });
  }
}