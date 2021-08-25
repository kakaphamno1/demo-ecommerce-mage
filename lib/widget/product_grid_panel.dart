import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:magento2_app/models/catalog.dart';
import 'package:magento2_app/pages/productDetailsPage.dart';
import 'package:magento2_app/pages/productsPage.dart';
import 'package:magento2_app/widget/AppSpinLoadMore.dart';

class ProductGridPanel extends StatelessWidget {
  final double itemWidth;
  final double itemHeight;
  final List<Product> data;
  final bool showLoading;

  const ProductGridPanel({Key? key, this.itemWidth = 164, this.itemHeight = 248, this.data = const [], this.showLoading = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery.of(context).orientation == Orientation.portrait ? 2 : 3,
            // Left - right
            crossAxisSpacing: 12,
            // top - bottom
            mainAxisSpacing: 12,
            childAspectRatio: itemWidth / itemHeight,
          ),
          itemBuilder: (context, index) {
            return ProductView(data[index], onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductDetailsPage(
                            sku: data[index].sku ?? "",
                          )));
            });
          },
          itemCount: data.length,
          shrinkWrap: true,
          padding: EdgeInsets.only(top: 12, bottom: 12),
          physics: NeverScrollableScrollPhysics(),
        ),
        showLoading ? AppSpinLoadMore() : SizedBox()
      ]),
    );
  }
}
