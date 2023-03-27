import 'dart:io';

import 'package:gando/models/User.dart';
import 'package:gando/services/provider/api_provider.dart';
import 'package:get_it/get_it.dart';

abstract class UserRepository {
  Future<User> getUserById({required String id});
  Future<String> uploadSingleFile({required File file});
  Future<User> editProfilePicture({required Map<String, dynamic> data});
  Future<User> editNameAndDescription({required Map<String, dynamic> data});
  Future<void> verifyOwner({required Map<String, dynamic> data});
  Future<bool> verifyMail({required Map<String, dynamic> data});
  Future<bool> initEditMail({required Map<String, dynamic> data});
  Future<bool> delete({required Map<String, dynamic> data});
  Future<bool> editPassword({required Map<String, dynamic> data});
}

class UserRepositoryImpl implements UserRepository {
  final ApiProvider apiProvider = GetIt.instance.get<ApiProvider>();

  @override
  Future<User> getUserById({required String id}) {
    return apiProvider.getUserById(idUser: id);
  }

  @override
  Future<String> uploadSingleFile({required File file}) {
    return apiProvider.uploadSingleFile(file: file);
  }

  @override
  Future<User> editProfilePicture({required Map<String, dynamic> data}) {
    return apiProvider.editProfilePicture(data: data);
  }

  @override
  Future<User> editNameAndDescription({required Map<String, dynamic> data}) {
    return apiProvider.editNameAndDescription(data: data);
  }

  @override
  Future<void> verifyOwner({required Map<String, dynamic> data}) {
    return apiProvider.verifyOwner(data: data);
  }

  @override
  Future<bool> delete({required Map<String, dynamic> data}) {
    return apiProvider.delete(data: data);
  }

  @override
  Future<bool> editPassword({required Map<String, dynamic> data}) {
    return apiProvider.editPassword(data: data);
  }

  @override
  Future<bool> initEditMail({required Map<String, dynamic> data}) {
    return apiProvider.initEditMail(data: data);
  }

  @override
  Future<bool> verifyMail({required Map<String, dynamic> data}) {
    return apiProvider.verifyMail(data: data);
  }
}
