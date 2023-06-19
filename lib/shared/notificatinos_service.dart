import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart';
import '../models/order_model.dart';
import 'components.dart';
import 'package:flutter/material.dart';

class NotificationsService {
  static final StreamController<OrderModel> _socketResponse =
      StreamController<OrderModel>.broadcast();
  static final Socket notification = io('http://172.16.6.78:3000',
      OptionBuilder().setTransports(['websocket']).build());

  static Stream<OrderModel> get getOrders =>
      _socketResponse.stream.asBroadcastStream();

  static void sendOrderNotification({required Map<String, dynamic> userOrder}) {
    notification.emit('order', userOrder);
  }

  static void sendApprovalNotification({required int userId}) {
    notification.emit('orderApproval', {'userId': userId});
  }

  static void sendDenyNotification({required int userId}) {
    notification.emit('orderDenied', {'userId': userId});
  }

  static void onUserOrder({required Function(dynamic) handleNotification}) {
    notification.on('order', handleNotification);
  }

  static void onOrderApproval({required Function(dynamic) handleNotification}) {
    notification.on('orderApproval', handleNotification);
  }

  static void onOrderDenied({required Function(dynamic) handleNotification}) {
    notification.on('orderDenied', handleNotification);
  }

  static void init({required int userId}) {
    notification.onConnect((data) {
      print('Connection established');
    });
    notification.emit('add user to room', {'userId': userId});
    notification.onConnectError((data) => print('error in connecting: $data'));
    notification.onDisconnect((data) => print('disconnect'));
  }

  static void disposeStream() {
    _socketResponse.close();
  }

  static void dispose() {
    notification.dispose();
    notification.destroy();
    notification.close();
    notification.disconnect();
  }

  static void startListeningToNotification({required String email}) {
    if (email == 'a@a.com') {
      print('pharmacy admin');
      onUserOrder(handleNotification: (data) {
        showNotification(
            id: data['userId'],
            mainTitle: 'Order',
            details:
                '${data['userName']} has requested ${data['medicineName']}');

        NotificationsService._socketResponse.sink
            .add(OrderModel.fromJson(data));
      });
    } else {
      onOrderApproval(handleNotification: (data) {
        showNotification(mainTitle: 'Order approval', details: data);
        print('the approval message: ${data.toString()}');
      });
      onOrderDenied(handleNotification: (data){
        showNotification(mainTitle: 'Order deny', details: data);
        print('the deny message: ${data.toString()}');
      });
    }
  }
}
