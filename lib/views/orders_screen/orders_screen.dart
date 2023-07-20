import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_seller_appl/constants/constants.dart';
import 'package:e_seller_appl/controller/orders_controller.dart';
import 'package:e_seller_appl/services/store_service.dart';
import 'package:e_seller_appl/views/orders_screen/order_details.dart';
import 'package:e_seller_appl/views/widgets/appbar_widet.dart';
import 'package:e_seller_appl/views/widgets/loadingindiicator.dart';
import 'package:e_seller_appl/views/widgets/text_style.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:intl/date_time_patterns.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(OrdersController());
    return Scaffold(
      appBar: appbarWidget(orders),
      body: StreamBuilder(
        stream: StoreServices.getOrders(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return loadingIndicator();
          } else {
            var data = snapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: List.generate(data.length, (index) {
                    var time = data[index]['order_date'].toDate();
                    //print(time);
                    //DateTime date = intl.DateFormat("").parse(time);

                    return ListTile(
                      onTap: () {
                        Get.to(() => OrdersDetails(
                              data: data[index],
                            ));
                      },
                      tileColor: textfieldGrey,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      title: boldText(
                          text: "${data[index]['order_code']}",
                          color: fontGrey),
                      subtitle: Column(
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.calendar_month, color: fontGrey),
                              10.widthBox,
                              boldText(
                                  text:
                                      intl.DateFormat().add_yMd().format(time),
                                  color: fontGrey)
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.payment, color: fontGrey),
                              10.widthBox,
                              boldText(text: unpaid, color: red)
                            ],
                          )
                        ],
                      ),
                      trailing: boldText(
                          text: "\$ ${data[index]['total_amount']}",
                          color: purpleColor,
                          size: 16.0),
                    ).box.margin(const EdgeInsets.only(bottom: 4)).make();
                  }),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
