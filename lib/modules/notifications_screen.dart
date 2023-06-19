import 'package:dac/models/order_model.dart';
import 'package:dac/shared/notificatinos_service.dart';
import 'package:flutter/material.dart';


class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);
  static List<OrderModel> orders = [];
  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    //NotificationsService.disposeStream();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder(
        stream: NotificationsService.getOrders,
        builder: (BuildContext context, AsyncSnapshot<OrderModel> snapshot) {
          // if (snapshot.connectionState == ConnectionState.none ||
          //     snapshot.connectionState == ConnectionState.waiting) {
          //   return const Center(child: CircularProgressIndicator());
          // }
          if (snapshot.hasData && snapshot.data != null) {
            NotificationScreen.orders.add(snapshot.data!);
          }
          return ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemCount: NotificationScreen.orders.length,
            itemBuilder: (context, index) =>
                OrderViewer(
                  index: index,
                  orderModel: NotificationScreen.orders[index],
                  deleteItem: () =>
                      setState(() {
                        NotificationScreen.orders.removeAt(index);
                      }),
                ),
            separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(
              height: 10,
            ),
          );
        },
      ),
    );
  }
}

class OrderViewer extends StatefulWidget {
  final int index;
  final OrderModel orderModel;
  final void Function() deleteItem;

  const OrderViewer({Key? key,
    required this.index,
    required this.orderModel,
    required this.deleteItem})
      : super(key: key);

  @override
  State<OrderViewer> createState() => _OrderViewerState();
}

class _OrderViewerState extends State<OrderViewer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.greenAccent,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
                '${widget.orderModel.userName} has requested\n${widget
                    .orderModel.medicineName}'),
            ElevatedButton(
              onPressed: () {
                NotificationsService.sendApprovalNotification(
                    userId: widget.orderModel.userId);
                widget.deleteItem;
              },
              child: const Text('approve'),
            ),
            ElevatedButton(
                onPressed: () {
                  NotificationsService.sendDenyNotification(
                      userId: widget.orderModel.userId);
                  widget.deleteItem;
                },
                child: const Text('deny')),
          ],
        ),
      ),
    );
  }
}
