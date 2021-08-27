import 'dart:async';

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/svg.dart';
import 'package:magento2_app/apis/CatalogAPI.dart';
import 'package:magento2_app/apis/quoteAPI.dart';
import 'package:magento2_app/configurations/clientConfig.dart';
import 'package:magento2_app/dataStorage/KeyValueStorage.dart';
import 'package:magento2_app/models/catalog.dart';
import 'package:magento2_app/models/order_calculated.dart';
import 'package:magento2_app/pages/order_confirm_page.dart';
import 'package:magento2_app/pages/productDetailsPage.dart';
import 'package:magento2_app/pages/productsPage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:magento2_app/res/app_themes.dart';
import 'package:magento2_app/res/string_extension.dart';
import 'package:magento2_app/widget/BadgeWidget.dart';
import 'package:magento2_app/widget/base_image_widget.dart';
import 'package:magento2_app/widget/empty_data_widget.dart';
import 'package:magento2_app/widget/label_value_widget.dart';
import 'package:magento2_app/widget/product_price_row_widget.dart';
import 'package:magento2_app/widget/quantity_widget.dart';
import 'package:magento2_app/widget/ts_utils.dart';

class CartPageV2 extends StatefulWidget {
  static const routeName = 'home';

  @override
  _CartPageV2State createState() => _CartPageV2State();
}

class _CartPageV2State extends State<CartPageV2> {
  List<Product> lstCart = <Product>[];
  OrderCalculated? orderCalculated;
  CancelableOperation? fetchingCart;
  CancelableOperation? fetchingCalculate;
  CancelableOperation? addProductToCartOperation;
  late var quoteID;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    if (fetchingCart != null) fetchingCart!.cancel();
    if (fetchingCalculate != null) fetchingCalculate!.cancel();
    if (addProductToCartOperation != null) addProductToCartOperation!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: ThemeColor.appBackground,
          centerTitle: true,
          title: Text(
            'Cart',
            style: ThemeText.default_S1_16.copyWith(color: ThemeColor.AppDark[800]),
          ),
          leading: InkWell(
            child: Icon(
              Icons.arrow_back_ios_rounded,
              size: 16,
              color: ThemeColor.AppDark[800],
            ),
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        backgroundColor: ThemeColor.AppDark[300],
        body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: bodyContent()));
  }

  Future<void> _loadData() async {
    setState(() {
      isLoading = true;
    });
    quoteID = await KeyValueStorage().getValueWithKey(PreferenceKeys.quoteGuestID);
    lstCart.clear();
    fetchingCart = CancelableOperation.fromFuture(QuoteAPI().getItemFromCart(quoteID).then((products) => {
          setState(() {
            if (products != null) {
              lstCart = products;
            }
            isLoading = false;
          })
        }));
    calculateOrder(quoteID);
  }

  void calculateOrder(quoteID) {
    setState(() {
      isLoading = true;
    });
    fetchingCalculate = CancelableOperation.fromFuture(QuoteAPI().calculateOrder(quoteID).then((orderCalculated) => {
          setState(() {
            print(orderCalculated);
            this.orderCalculated = orderCalculated;
            isLoading = false;
          })
        }));
  }

  bodyContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: orderContentWidget(),
        ),
        bottomWidgetCart(),
        Container(
          color: ThemeColor.appBackground,
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: NormalButton(context, text: 'Buy now', isOutLine: false, isLoading: isLoading, onTap: () async {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OrderConfirmPage()),
              );
            }),
          ),
        )
      ],
    );
  }

  orderContentWidget() {
    return lstCart.length > 0
        ? MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: NotificationListener<ScrollNotification>(
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: lstCartItem(),
              ),
            ),
          )
        : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                EmptyDataWidget(
                  text: 'empty cart',
                ),
                SizedBox(height: 32),
                ActionText(
                  'continue shopping',
                  horizontalPadding: 16,
                  actionTextColor: ThemeColor.primary,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: ThemeColor.primary)),
                  leftIcon: SvgPicture.asset('assets/cart.svg'),
                )
              ],
            ),
          );
  }

  List<Widget> lstCartItem() {
    List<Widget> lst = [];
    lstCart.forEach((product) {
      lst.add(CartItemWidget(product));
    });
    return lst;
  }

  Timer? _debounce;

  Widget CartItemWidget(Product product) {
    var row = Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      SizedBox(
        width: 8,
      ),
      InkWell(
        child: BaseWidgetImage.loadImageRadius8(product.imageURL ?? '', height: 86, width: 86, value: BoxFit.fill),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProductDetailsPage(
                        sku: product.sku ?? "",
                      )));
        },
      ),
      SizedBox(
        width: 12,
      ),
      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              product.name ?? '',
              maxLines: 2,
              style: ThemeText.default_C1_12.copyWith(color: ThemeColor.AppDark[900]),
            ),
            SizedBox(
              height: 8,
            ),
            ProductPriceRowWidget((product.price ?? 0).toDouble(), null),
            SizedBox(
              height: 6,
            ),
            QuantityWidget(
              canSubQuantity: (product.qty ?? 0) > 1,
              quantity: product.qty ?? 0,
              changeText: (text) async {
                if (_debounce?.isActive ?? false) _debounce?.cancel();
                _debounce = Timer(const Duration(milliseconds: 500), () {
                  if (text.isNumeric() && int.parse(text) != product.qty) {
                    int newQuantityOrder = int.parse(text);
                    setState(() {
                      product.qty = newQuantityOrder;
                      updateCart(product);
                    });
                  }
                });
              },
              removeTap: () {
                // -
                if (product.qty! > 1) {
                  setState(() {
                    product.qty = product.qty! - 1;
                    if (_debounce?.isActive ?? false) _debounce?.cancel();
                    _debounce = Timer(const Duration(milliseconds: 300), () {
                      updateCart(product);
                    });
                  });
                }
              },
              addTap: () {
                // +
                setState(() {
                  product.qty = product.qty! + 1;
                  if (_debounce?.isActive ?? false) _debounce?.cancel();
                  _debounce = Timer(const Duration(milliseconds: 300), () {
                    updateCart(product);
                  });
                });
              },
            ),
            SizedBox(
              height: 8,
            ),
          ],
        ),
      )
    ]);

    return Container(
      child: row,
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      color: ThemeColor.appBackground,
    );
  }

  void updateCart(Product product) {
    addProductToCartOperation =
        CancelableOperation.fromFuture(QuoteAPI().addSimpleProductToGuestCart(product, quoteID)).then((status) {
      calculateOrder(quoteID);
    });
  }

  bottomWidgetCart() {
    return orderCalculated != null
        ? Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 12,
                  spreadRadius: 1,
                  color: Colors.black.withOpacity(0.08),
                )
              ],
              color: ThemeColor.appBackground,
            ),
            child: Column(
              children: [
                LabelValueWidget(
                  'Total order',
                  TsUtils.formatCurrencyDynamic((orderCalculated!.subtotal ?? 0).toDouble()),
                  boldValue: true,
                ),
                LabelValueWidget('Discount', TsUtils.formatCurrencyDynamic((orderCalculated!.discountAmount) * -1)),
                LabelValueWidget('Ship', TsUtils.formatCurrencyDynamic((orderCalculated!.shippingTaxAmount) * -1)),
                LabelValueWidget('Total pay', TsUtils.formatCurrencyDynamic((orderCalculated!.grandTotal).toDouble())),
              ],
            ))
        : SizedBox();
  }
}
