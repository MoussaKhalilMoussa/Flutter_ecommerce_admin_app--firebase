import 'package:e_seller_appl/constants/constants.dart';
import 'package:e_seller_appl/controller/profile_controller.dart';
import 'package:e_seller_appl/views/widgets/custom_textfield.dart';
import 'package:e_seller_appl/views/widgets/loadingindiicator.dart';
import 'package:e_seller_appl/views/widgets/text_style.dart';
import 'package:get/get.dart';

class ShopSttings extends StatelessWidget {
  const ShopSttings({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();
    return Obx(
      () => Scaffold(
        backgroundColor: purpleColor,
        appBar:
            AppBar(title: boldText(text: shopSettings, size: 16.0), actions: [
          controller.isLoading.value
              ? loadingIndicator(circleColor: white)
              : TextButton(
                  onPressed: () async {
                    controller.isLoading(true);
                    await controller.updateShop(
                        shopname: controller.shopNameController.text,
                        shopaddress: controller.shopAddressController.text,
                        shopmobile: controller.shopMobileController.text,
                        shopwebsite: controller.shopWebsiteController.text,
                        shopdesc: controller.shopDescController.text);
                    // ignore: use_build_context_synchronously
                    VxToast.show(context, msg: "Shop updated");
                  },
                  child: normalText(text: save)),
        ]),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              customTextField(
                  label: shopName,
                  hint: nameHint,
                  controller: controller.shopNameController),
              10.heightBox,
              customTextField(
                  label: address,
                  hint: shopAddressHint,
                  controller: controller.shopAddressController),
              10.heightBox,
              customTextField(
                  label: mobile,
                  hint: shopMobileHint,
                  controller: controller.shopMobileController),
              10.heightBox,
              customTextField(
                  label: shopName,
                  hint: shopWebsiteHint,
                  controller: controller.shopWebsiteController),
              10.heightBox,
              customTextField(
                  label: description,
                  hint: shopWebsiteHint,
                  isDesc: true,
                  controller: controller.shopDescController),
            ],
          ),
        ),
      ),
    );
  }
}
