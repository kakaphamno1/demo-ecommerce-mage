import 'package:async/async.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:like_button/like_button.dart';
import 'package:magento2_app/DataStorage/KeyValueStorage.dart';
import 'package:magento2_app/apis/catalogAPI.dart';
import 'package:magento2_app/apis/quoteAPI.dart';
import 'package:magento2_app/configurations/clientConfig.dart';
import 'package:magento2_app/configurations/uiConfig.dart';
import 'package:magento2_app/models/catalog.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:magento2_app/res/app_themes.dart';
import 'package:magento2_app/widget/BadgeWidget.dart';
import 'package:magento2_app/widget/MyCircleAvatar.dart';
import 'package:magento2_app/widget/product_price_column_widget.dart';
import 'package:magento2_app/widget/rating_bar_widget.dart';
import 'package:magento2_app/widget/swipper_product.dart';
import 'package:magento2_app/widget/ts_utils.dart';

class ProductDetailsPage extends StatefulWidget {
  static const routeName = 'product_details';
  String sku;

  ProductDetailsPage({Key? key, required this.sku}) : super(key: key);

  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  Product? product;
  CancelableOperation? getProductOperation;
  CancelableOperation? addProductToCartOperation;
  CancelableOperation? createEmptyCartOperation;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    _getProduct();
  }

  void _getProduct() {
    setState(() {
      loading = true;
    });
    getProductOperation = CancelableOperation.fromFuture(CatalogAPI().getProduct(widget.sku).then((product) {
      setState(() {
        loading = false;
        this.product = product;
      });
    }));
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
    ));
    return Scaffold(
        backgroundColor: ThemeColor.appBackground,
        body: product != null
            ? Stack(
                children: <Widget>[
                  Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        Expanded(
                          child: Stack(
                            children: [
                              _body(),
                              _toolbar(),
                            ],
                          ),
                        ),
                        _actionbar(),
                      ],
                    ),
                  ),
                  loading
                      ? Center(
                          child: CupertinoActivityIndicator(),
                        )
                      : Center()
                ],
              )
            : Center(
                child: CupertinoActivityIndicator(),
              ));
  }

  _toolbar() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: ThemeColor.textColor, size: 16),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }

  void _addProductToCart() async {
    setState(() {
      loading = true;
    });
    final quoteID = await KeyValueStorage().getValueWithKey(PreferenceKeys.quoteGuestID);
    if (quoteID != null) {
      addProductToCartOperation =
          CancelableOperation.fromFuture(QuoteAPI().addSimpleProductToGuestCart(product!, quoteID)).then((status) {
        if (status) {
          _settingModalBottomSheet(context);
        } else {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => AlertDialog(
                    title: Text("Fail"),
                    content: Text("Couldn't add the product to cart"),
                    actions: <Widget>[
                      FlatButton(
                        child: Text("Done"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ));
        }
        setState(() {
          loading = false;
        });
      });
    } else {
      createEmptyCartOperation = CancelableOperation.fromFuture(QuoteAPI().createAnEmptyGuestCart().then((id) {
        KeyValueStorage().set(id, PreferenceKeys.quoteGuestID);
        addProductToCartOperation =
            CancelableOperation.fromFuture(QuoteAPI().addSimpleProductToGuestCart(product!, id)).then((status) {
          print(status ? "OK" : "Fail");
          setState(() {
            loading = false;
          });
        });
      }));
    }
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return AddedToCartView(
            product: product!,
          );
        });
  }

  @override
  void dispose() {
    if (addProductToCartOperation != null) addProductToCartOperation!.cancel();
    if (createEmptyCartOperation != null) createEmptyCartOperation!.cancel();
    if (getProductOperation != null) getProductOperation!.cancel();
    super.dispose();
  }

  _body() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TsUtils.isNullOrBlank(product!.imageURLs)
                ? SizedBox(height: 300)
                : Container(height: 300, child: SwipperProduct(banners: product!.imageURLs ?? [])),
            _contentPacking(),
            Padding(
              padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: ManufactureWidget(),
            ),
            productDescription(),

          ],
        ),
      ),
    );
  }

  _actionbar() {
    return SafeArea(
      top: false,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(color: ThemeColor.textColor.withOpacity(0.08), blurRadius: 8, spreadRadius: 1, offset: Offset(0, -4))
        ], color: ThemeColor.appBackground),
        child: Row(
          children: [
            InkWell(
              onTap: () {

              },
              borderRadius: BorderRadius.circular(50),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset('assets/chat.svg'),
                      Text('chat', style: ThemeText.normal_400_14.copyWith(color: ThemeColor.captionTextColor))
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 12),
                child: NormalButton(context, text: 'Add to cart', marquee: true, onTap: () async {
                }),
              ),
            ),
            // Expanded(
            //     child: Padding(
            //   padding: const EdgeInsets.only(left: 12),
            //   child: NormalButton(context, text: 'buy_now'.tr, marquee: true, onTap: () {
            //     flyKey.currentState?.runAnimation(getFlyingWidget());
            //   },),
            // )),
          ],
        ),
      ),
    );
  }

  _contentPacking() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product!.name ?? "",
            style: ThemeText.default_P1_16.copyWith(color: ThemeColor.AppDark[900]),
          ),
          Row(
            children: [
              ProductPriceColumnWidget(
                price: (product!.price ?? 0).toDouble(),
                priceSize: 18,
                orgPriceSize: 14,
              ),
              Expanded(child: SizedBox()),
              LikeButton(
                padding: EdgeInsets.symmetric(horizontal: 8),
                circleColor: CircleColor(start: Color(0xFFFF3D4D), end: Color(0xFFFF6D79)),
                bubblesColor: BubblesColor(
                  dotPrimaryColor: Color(0xFFFF3D4D),
                  dotSecondaryColor: Color(0xFFFF6D79),
                ),
                likeBuilder: (bool isLiked) {
                  return SvgPicture.asset(
                    isLiked ? 'assets/heart_bold.svg' : 'assets/heart.svg',
                  );
                },
                isLiked: false,
                mainAxisAlignment: MainAxisAlignment.start,
              ),
              InkWell(
                borderRadius: BorderRadius.all(Radius.circular(100)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    'assets/icons/ic_share.svg',
                    color: ThemeColor.textColor,
                  ),
                ),
                onTap: () {},
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IgnorePointer(child: RatingBarProductWidget(4)),
              ActionText('5 ${'reviews'}',
                  textStyle: ThemeText.default_C2_12.copyWith(color: ThemeColor.primary),
                  rightIcon: Icon(
                    Icons.keyboard_arrow_right_rounded,
                    color: ThemeColor.primary,
                  ),
                  onTap: () => {}),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Commission by variation'),
              ActionText('Detail', onTap: () {}),
            ],
          ),
        ],
      ),
    );
  }

  ManufactureWidget() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: ThemeColor.AppDark[300]),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          children: [
            MyCircleAvatar(
              avatarSize: 48,
              avatarUrl: "https://salt.tikicdn.com/cache/400x400/ts/product/d8/3c/81/d42067cb57c8b3b0051302254c333857.png",
            ),
            SizedBox(width: 8),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  'Apple',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: ThemeText.default_S2_14.copyWith(color: ThemeColor.AppDark[900]),
                ),
                Text(
                  'online',
                  style: ThemeText.default_Small_10.copyWith(color: Color(0xFFA9A9A9)),
                ),
              ]),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('35 ${"products"}', style: ThemeText.default_C1_12.copyWith(color: Colors.black87, fontSize: 10.5)),
                SizedBox(
                  height: 2,
                ),
                ActionText('see distributor',
                    textStyle: ThemeText.default_C1_12.copyWith(color: ThemeColor.primary), onTap: () {})
              ],
            )
          ],
        ),
      ),
    );
  }

  productDescription() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Divider(color: ThemeColor.AppDark[400], height: 2),
      ),
      _labelValueWidget('Sku', product!.sku ?? ''),
      productAttributes(),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Divider(color: ThemeColor.AppDark[400], height: 2),
      ),
      Padding(
        padding: EdgeInsets.only(left: 8, right: 8, bottom: 8),
        child: Html(
          data: product!.description ?? '',
          defaultTextStyle: TextStyle(color: ThemeColor.textColor, fontSize: 14),
        ),
      ),
      SizedBox(height: 4),
      Divider(color: ThemeColor.AppDark[400], height: 2),
    ]);
  }

  productAttributes() {
    if (product!.customAttributes != null && product!.customAttributes!.length > 0) {
      List<Widget> widgets = [];
      for(CustomAttribute attr in product!.customAttributes!){
        widgets.add(_labelValueWidget(attr.code ?? "", attr.value.toString()));
      }
      return Column(
        children: widgets,
      );
    } else
      return SizedBox();
  }
}

class ProductImagesView extends StatelessWidget {
  final _controller = PageController(initialPage: 0);
  List<String> imageURLs;

  ProductImagesView({Key? key, required this.imageURLs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _controller,
      scrollDirection: Axis.horizontal,
      children: imageURLs
          .map((url) => CachedNetworkImage(
                imageUrl: url,
              ))
          .toList(),
    );
  }
}

Widget _labelValueWidget(String label, String value) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(16, 6, 16, 6),
    child: Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(label, style: ThemeText.default_C1_12.copyWith(color: ThemeColor.captionTextColor)),
        ),
        Expanded(
          flex: 2,
          child: Text(value, style: ThemeText.default_C2_12.copyWith(color: ThemeColor.textColor)),
        ),
      ],
    ),
  );
}

class AddedToCartView extends StatelessWidget {
  final Product product;

  AddedToCartView({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              height: 44,
              color: Colors.blue,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.only(left: 16),
                      child: Text(
                        "Added Product To Cart",
                        style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      )),
                  Flex(
                    direction: Axis.horizontal,
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            ),
            Wrap(
              direction: Axis.horizontal,
              children: <Widget>[
                Row(children: <Widget>[
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                          padding: EdgeInsets.all(8),
                          width: 84,
                          height: 84,
                          child: CachedNetworkImage(imageUrl: product.imageURLs?.first))),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            product.name ?? "",
                            style: AppTextStyle.title,
                          )),
                      Container(
                        height: 8,
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            product.sku ?? "",
                            style: AppTextStyle.normal,
                          )),
                      Container(
                        height: 8,
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            product.price.toString(),
                            style: AppTextStyle.normal,
                          )),
                      Container(
                        height: 8,
                      )
                    ],
                  )
                ])
              ],
            ),
            RaisedButton(
              onPressed: () {},
              child: Text("Go To Cart"),
            )
          ],
        )
      ],
    );
  }
}
