import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_seller_appl/constants/constants.dart';
import 'package:e_seller_appl/services/store_service.dart';
import 'package:e_seller_appl/views/product_screen/product_details.dart';
import 'package:e_seller_appl/views/widgets/appbar_widet.dart';
import 'package:e_seller_appl/views/widgets/dashboard_button.dart';
import 'package:e_seller_appl/views/widgets/loadingindiicator.dart';
import 'package:e_seller_appl/views/widgets/text_style.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarWidget(dashboard),
      body: StreamBuilder(
        stream: StoreServices.getProducts(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return loadingIndicator();
          } else {
            var data = snapshot.data!.docs;
            data = data.sortedBy((a, b) =>
                b['p_wishlist'].length.compareTo(a['p_wishlist'].length));
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        dashboardButton(context,
                            title: products,
                            count: "${data.length}",
                            icon: icProducts),
                        dashboardButton(context,
                            title: orders, count: "15", icon: icOrders),
                      ],
                    ),
                    10.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        dashboardButton(context,
                            title: rating, count: "60", icon: icStar),
                        dashboardButton(context,
                            title: totalSales, count: "15", icon: icOrders),
                      ],
                    ),
                    10.heightBox,
                    const Divider(),
                    10.heightBox,
                    boldText(text: popular, color: darkGrey, size: 16.0),
                    20.heightBox,
                    ListView(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      children: List.generate(
                        data.length,
                        (index) => data[index]['p_wishlist'].length == 0
                            ? const SizedBox()
                            : ListTile(
                                onTap: () {
                                  Get.to(() => ProductDetails(
                                        data: data[index],
                                      ));
                                },
                                leading: Image.network(data[index]['p_imgs'][0],
                                    width: 100, height: 100, fit: BoxFit.cover),
                                title: boldText(
                                    text: "${data[index]['p_name']}",
                                    color: fontGrey),
                                subtitle: normalText(
                                    text: "\$${data[index]['p_price']}",
                                    color: darkGrey),
                              ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }
        },
      ),
      // body: Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: SingleChildScrollView(
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.start,
      //       children: [
      //         Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceAround,
      //           children: [
      //             dashboardButton(context,
      //                 title: products, count: "60", icon: icProducts),
      //             dashboardButton(context,
      //                 title: orders, count: "15", icon: icOrders),
      //           ],
      //         ),
      //         10.heightBox,
      //         Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceAround,
      //           children: [
      //             dashboardButton(context,
      //                 title: rating, count: "60", icon: icStar),
      //             dashboardButton(context,
      //                 title: totalSales, count: "15", icon: icOrders),
      //           ],
      //         ),
      //         10.heightBox,
      //         const Divider(),
      //         10.heightBox,
      //         boldText(text: popular, color: darkGrey, size: 16.0),
      //         20.heightBox,
      //         ListView(
      //           physics: const BouncingScrollPhysics(),
      //           shrinkWrap: true,
      //           children: List.generate(
      //             3,
      //             (index) => ListTile(
      //               onTap: () {},
      //               leading: Image.asset(imgProduct,
      //                   width: 100, height: 100, fit: BoxFit.cover),
      //               title: boldText(text: "Product title", color: fontGrey),
      //               subtitle: normalText(text: "\$40.0", color: darkGrey),
      //             ),
      //           ),
      //         )
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
