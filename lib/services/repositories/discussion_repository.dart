import 'dart:io';

import 'package:gando/models/User.dart';
import 'package:gando/models/chat/chat_detail.dart';
import 'package:gando/models/chat/discussion.dart';
import 'package:gando/services/provider/api_provider.dart';
import 'package:get_it/get_it.dart';

abstract class DiscussionRepository {
  Future<bool> sendMessage({required Map<String, dynamic> data});
  Future<List<Discussion>> getListMessage({required String userId});
  Future<ChatDetailModel> getMessageDetail({required String discussionId});
}

class DiscussionRepositoryImpl implements DiscussionRepository {
  final ApiProvider apiProvider = GetIt.instance.get<ApiProvider>();

  @override
  Future<List<Discussion>> getListMessage({required String userId}) {
    return apiProvider.getListMessage(idUser: userId);
  }

  @override
  Future<bool> sendMessage({required Map<String, dynamic> data}) {
    return apiProvider.sendMessage(data: data);
  }

  @override
  Future<ChatDetailModel> getMessageDetail({required String discussionId}) {
    return apiProvider.getMessageDetail(discussionId: discussionId);
  }
}
