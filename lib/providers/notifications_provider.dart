import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

  void setNotificationsList(jsonNotifyList) {
    List<Widget> dummyList = [];
    for (var item in jsonNotifyList) {
      Widget newCard = Card(
        child: ListTile(
          leading: const FlutterLogo(size: 50.0),
          title: const Text('Ahmed Mostafa'),
          subtitle: Text(item['content']),
          trailing: const Icon(Icons.more_vert),
          isThreeLine: true,
        ),
      );

      dummyList.add(newCard);
    }
    _notificationsList = dummyList;
    notifyListeners();
  }
}
