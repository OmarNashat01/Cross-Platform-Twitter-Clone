import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:twitter/models/user_model.dart';
import 'package:twitter/providers/user_provider.dart';

import '../constants.dart';

class NotificationsProvider with ChangeNotifier {
  List<Widget> _notificationsList = [];

  List<Widget> get notificationsList => _notificationsList;

  Future<http.Response> fetch() async {
    final queryParameters = {
      'user_id': Auth.userId,
    };
    final uri = Uri.http(
      Http().getBaseUrl(),
      '/users/notifications/all',
      queryParameters,
    );

    final response = await http.get(
      uri,
      headers: {
        "Content-Type": "application/json; charset=UTF-8",
        'x-access-token': Auth.token
      },
    );

    return response;
  }

  void setNotificationsList(jsonNotifyList, context) {
    List<Widget> dummyList = [];
    for (var item in jsonNotifyList) {
      // Provider.of<UserProvider>(context, listen: false)
      //     .fetchUserByUserId(item['_id'])
      //     .then((user) {
      //   log(item['_id']);

        Widget newCard = Card(
          child: ListTile(
            // leading: ,
            title: Text(''),
            subtitle: Text(item['message']),
            isThreeLine: true,

          ),
        );

        dummyList.add(newCard);
      // });
    }
    _notificationsList = dummyList;
    notifyListeners();
  }
}
