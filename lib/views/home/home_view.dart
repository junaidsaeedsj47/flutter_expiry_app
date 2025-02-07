import 'package:expirdate/controller/product_controller.dart';
import 'package:expirdate/utils/app_colors.dart';
import 'package:expirdate/utils/app_util.dart';
import 'package:expirdate/utils/enum.dart';
import 'package:expirdate/utils/text/app_text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  final ProductController controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton.extended(
                heroTag: "scanBarcode",
                backgroundColor: AppColors.accent,
                icon: Icon(Icons.qr_code_scanner, color: AppColors.textWhite),
                label: Text("Scan Barcode", style: AppTextStyles.button),
                onPressed: () => controller.pickImage(context, isBarcode: true),
              ),
              SizedBox(width: 10),
              FloatingActionButton.extended(
                heroTag: "scanText",
                backgroundColor: AppColors.primary,
                icon:
                    Icon(Icons.camera_alt_outlined, color: AppColors.textWhite),
                label: Text("Scan Product", style: AppTextStyles.button),
                onPressed: () =>
                    controller.pickImage(context, isBarcode: false),
              ),
            ],
          ),
          appBar: AppBar(
            centerTitle: true,
            title: Text("Food Expiry Detection",
                style: AppTextStyles.headline3
                    .copyWith(color: AppColors.textWhite)),
            backgroundColor: AppColors.primary,
          ),
          body: Container(
            margin: const EdgeInsetsDirectional.symmetric(
                horizontal: 16, vertical: 16),
            color: AppColors.backgroundLight, // Background color
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (controller.products.isNotEmpty)
                  Text(
                    "History & Storage",
                    style: AppTextStyles.headline3,
                  ),
                if (controller.products.isNotEmpty)
                  SizedBox(
                    height: 20,
                  ),
                if (controller.products.isEmpty)
                  Center(
                    child: Text(
                      "No scanned products found!",
                      style: AppTextStyles.bodyMedium,
                    ),
                  )
                else
                  Expanded(
                      child: ListView.builder(
                    itemCount: controller.products.length,
                    itemBuilder: (context, index) {
                      final product = controller.products[index];
                      ExpiryStatus? status = product.getStatus();

                      return Dismissible(
                        key: Key(product.name ?? ""),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          padding: EdgeInsets.only(right: 20),
                          alignment: Alignment.centerRight,
                          color: AppColors.dangerRed.withOpacity(0.8),
                          child:
                              Icon(Icons.delete, color: Colors.white, size: 30),
                        ),
                        confirmDismiss: (direction) async {
                          bool? shouldDelete = await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Delete Product?"),
                                content: Text(
                                    "Are you sure you want to delete \"${product.name}\"?"),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(false),
                                    child: Text("Cancel",
                                        style: TextStyle(color: Colors.grey)),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(true),
                                    child: Text("Delete",
                                        style: TextStyle(color: Colors.red)),
                                  ),
                                ],
                              );
                            },
                          );

                          if (shouldDelete == true) {
                            controller.deleteProduct(product.name);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Deleted ${product.name}"),
                                action: SnackBarAction(
                                  label: "Undo",
                                  textColor: Colors.white,
                                  onPressed: () {
                                    controller.addProduct(
                                        product.name, product.expiryDate);
                                  },
                                ),
                              ),
                            );
                          }

                          return false; // Prevents immediate dismissal before confirmation
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x20000000),
                                offset: Offset(0, 2),
                                blurRadius: 3,
                                spreadRadius: 0,
                              ),
                            ],
                            color: AppColors.textWhite,
                            borderRadius: BorderRadius.circular(13),
                          ),
                          margin: EdgeInsetsDirectional.only(bottom: 16),
                          padding: EdgeInsetsDirectional.symmetric(
                              horizontal: 16, vertical: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(product.name ?? "",
                                        style: AppTextStyles.bodyLarge
                                            .copyWith(fontSize: 20)),
                                  ),
                                  SizedBox(width: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: Text(
                                          AppUtil.getStatusText(status) ?? "",
                                          style:
                                              AppTextStyles.bodyLarge.copyWith(
                                            color:
                                                AppUtil.getStatusColor(status),
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      InkWell(
                                        child: Icon(Icons.volume_up_rounded,
                                            size: 30),
                                        onTap: () {
                                          controller.speakText(
                                              AppUtil.getStatusTextOnly(
                                                  status));
                                        },
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      "Expiry: ${AppUtil.formatDate(product.expiryDate)}",
                                      style: AppTextStyles.bodyMedium),
                                  Text(
                                    product.getCountdownMessage(),
                                    style: AppTextStyles.bodyMedium.copyWith(
                                      color: AppUtil.getStatusColor(status),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ));
  }
}
