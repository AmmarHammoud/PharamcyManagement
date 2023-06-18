import 'package:dac/models/user_model.dart';
import 'package:socket_io_client/socket_io_client.dart';

class NotificationsService {
  static final Socket notification = io('http://172.16.0.200:3000',
      OptionBuilder().setTransports(['websocket']).build());

  static void sendOrderNotification({required Map<String, dynamic> userOrder}) {
    notification.emit('order', userOrder);
  }

  static void onNotification({required Function(dynamic) handleNotification}) {
    notification.on('order', handleNotification);
  }

  static void init() {
    notification.onConnect((_) {
      print('Connection established');
    });
    notification.onConnectError((data) => print('error in connecting: $data'));
    notification.onDisconnect((data) => print('disconnect'));
  }

  static void dispose() {
    notification.dispose();
    notification.destroy();
    notification.close();
    notification.disconnect();
  }
}
