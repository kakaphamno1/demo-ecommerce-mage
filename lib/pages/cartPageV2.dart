import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:magento2_app/apis/CatalogAPI.dart';
import 'package:magento2_app/apis/quoteAPI.dart';
import 'package:magento2_app/configurations/clientConfig.dart';
import 'package:magento2_app/dataStorage/KeyValueStorage.dart';
import 'package:magento2_app/models/catalog.dart';
import 'package:magento2_app/pages/productDetailsPage.dart';
import 'package:magento2_app/pages/productsPage.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CartPageV2 extends StatefulWidget {
  static const routeName = 'home';

  @override
  _CartPageV2State createState() => _CartPageV2State();
}

class _CartPageV2State extends State<CartPageV2> {
  List<Product> lstCart = <Product>[];
  CancelableOperation? fetchingCart;
  CancelableOperation? fetchingCalculate;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    if (fetchingCart != null) fetchingCart!.cancel();
    if (fetchingCalculate != null) fetchingCalculate!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
        backgroundColor: Colors.blue,
      ),
      body: _buildItemsForListView(context)
    );
  }

  Future<void> _loadData() async {
    final quoteID = await KeyValueStorage().getValueWithKey(PreferenceKeys.quoteGuestID);
    lstCart.clear();
    fetchingCart = CancelableOperation.fromFuture(QuoteAPI().getItemFromCart(quoteID).then((products) => {
          setState(() => {
                if (products != null) {lstCart = products}
              })
        }));
    fetchingCalculate = CancelableOperation.fromFuture(QuoteAPI().calculateOrder(quoteID).then((orderCal) => {
          setState(() => {
                if (orderCal != null) {lstCart = orderCal}
              })
        }));
  }

  Widget _buildItemsForListView(BuildContext context) {
    if (lstCart.length > 0) {
      return Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 0),
          height: 364,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 320,
            child: ListView.builder(
                itemCount: lstCart.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final product = lstCart[index];
                  return Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: 320,
                      child: ProductView(product, onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductDetailsPage(
                                      sku: product.sku ?? "",
                                    )));
                      }));
                }),
          ));
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
