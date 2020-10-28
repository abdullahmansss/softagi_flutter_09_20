import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_app/modules/profile/cubit/states.dart';
import 'package:flutter_app/shared/network/cache/shared_pref_helper.dart';
import 'package:flutter_app/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ProfileCubit extends Cubit<ProfileStates>
{
  ProfileCubit() : super(ProfileStatesInitial());

  static ProfileCubit get(context) => BlocProvider.of(context);

  var data;
  var file;

  getProfile() async
  {
    emit(ProfileStatesLoading());

    getPrefInstance().then((prefs) async
    {
      var token = prefs.getString('token');

      getDioInstance().options.headers = {
        'Authorization': token,
      };

      await getDioInstance().get('profile').then((response)
      {
        data = response.data['data'];
        emit(ProfileStatesSuccess());
      });
    });
  }

  logOut() async
  {
    await getPrefInstance().then((value) async
    {
      await value.setString('token', '').then((value)
      {
        emit(ProfileStatesLogout());
      });
    });
  }

  pickImage() async
  {
    var image = await ImagePicker().getImage(source: ImageSource.gallery);
    file = File(image.path);

    print(file.path);

    emit(ProfileStatesSelectImage());
  }

  uploadImage() async
  {
    FormData formData = FormData.fromMap({
      "name": 'gado',
      "email": 'mustafa@gmail.com',
      "phone": '5675675',
      "image": await MultipartFile.fromFile(
        file.path,
        filename: Uri.file(file.path).pathSegments.last,
      ),
    });

    getDioInstance().post('path', data: formData);
  }
}