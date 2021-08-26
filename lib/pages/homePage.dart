import 'package:async/async.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:magento2_app/apis/CatalogAPI.dart';
import 'package:magento2_app/models/catalog.dart';
import 'package:magento2_app/pages/productDetailsPage.dart';
import 'package:magento2_app/pages/productsPage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:magento2_app/res/app_themes.dart';
import 'package:magento2_app/widget/BadgeWidget.dart';
import 'package:magento2_app/widget/base_image_widget.dart';
import 'package:magento2_app/widget/icon_title.dart';
import 'package:magento2_app/widget/product_grid_panel.dart';
import 'package:magento2_app/widget/swipper_banner.dart';

class HomePage extends StatefulWidget {
  static const routeName = 'home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Product> _newestProducts = <Product>[];
  List<Category> _categories = <Category>[];
  CancelableOperation? fetchingCategoriesOperation;
  CancelableOperation? fetchingProductsOperation;
  bool isExpand = true;
  ScrollController scrollController = ScrollController();
  Offset offset = Offset(0, 0);

  @override
  void initState() {
    super.initState();
    _loadData();
    scrollController.addListener(() {
      if (scrollController.offset <= 180) {
        print('reRender');
        if (offset.dy <= MediaQuery.of(context).padding.top + 140) {
          offset = Offset(offset.dx, MediaQuery.of(context).padding.top + 140);
        }
        setState(() {
          isExpand = true;
        });
      } else {
        setState(() {
          isExpand = false;
        });
      }
    });
  }

  @override
  void dispose() {
    if (fetchingCategoriesOperation != null) fetchingCategoriesOperation!.cancel();
    if (fetchingProductsOperation != null) fetchingProductsOperation!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: ThemeColor.AppDark[100],
        child: Column(
          children: [
            appbarTransaction(),
            Expanded(child: buildHome3()),
          ],
        ),
      ),
    );
  }

  void _loadData() {
    fetchingCategoriesOperation = CancelableOperation.fromFuture(CatalogAPI().getCategoryList().then((categoryList) => {
          setState(() => {_categories = categoryList})
        }));
    fetchingProductsOperation = CancelableOperation.fromFuture(CatalogAPI().getNewestProducts(currentPage: 0).then((products) => {
          setState(() => {_newestProducts = products})
        }));
  }

  appbarTransaction() {
    return AnimatedContainer(
      decoration: BoxDecoration(color: ThemeColor.appBackground, boxShadow: [
        BoxShadow(color: ThemeColor.textColor.withOpacity(0.08), blurRadius: 8, spreadRadius: 1, offset: Offset(0, 4))
      ]),
      padding: EdgeInsets.symmetric(vertical: 8),
      duration: Duration(milliseconds: 200),
      height: isExpand ? 121 : 61,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            height: 60,
            padding: EdgeInsets.only(left: 8, right: 8),
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                Image.asset(
                  "assets/logo_mstore.png",
                  width: 80,
                  height: 44,
                ),
                Expanded(child: SizedBox()),
                BadgeWidget("0", 'assets/cart.svg', onTap: () => {}),
                BadgeWidget('', 'assets/chat.svg', onTap: () async {}),
              ],
            ),
          ),
          AnimatedPositioned(
              left: 0,
              duration: Duration(milliseconds: 200),
              width: isExpand ? MediaQuery.of(context).size.width : MediaQuery.of(context).size.width - 88,
              top: isExpand ? 60 : 0,
              child: Container(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 40,
                  margin: EdgeInsets.only(left: 16, right: 16, top: 4),
                  decoration: BoxDecoration(color: ThemeColor.AppDark[300], borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  child: InkWell(
                    onTap: () {},
                    child: Row(children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 16.0, right: 10.0),
                        child: Icon(Icons.search, color: ThemeColor.AppDark[800]),
                      ),
                      Expanded(
                        child: Text(
                          'search',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: ThemeText.default_P2_14.copyWith(color: ThemeColor.AppDark[800]),
                        ),
                      )
                    ]),
                  ),
                ),
              )),
        ],
      ),
    );
  }

  buildHome3() {
    return SingleChildScrollView(
      controller: scrollController,
      child: Column(
        children: [
          SwipperBanner(banners: [
            "https://salt.tikicdn.com/cache/w1080/ts/banner/1e/af/79/a0201597b21768edccd49f765d8bb929.png",
            "https://salt.tikicdn.com/cache/w1080/ts/banner/79/8c/2e/849ba73a8ffadda2199f4501e7ff902c.jpg",
            "https://salt.tikicdn.com/cache/w1080/ts/banner/82/63/97/59816a632d6c5472c62bf7a8397d7d36.png"
          ], height: 150),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  _categories.length,
                  (index) {
                    final category = _categories[index];
                    return Container(
                        margin: EdgeInsets.all(8),
                        width: 70,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            BaseWidgetImage.loadImageRadius(category.imageURL ?? "",
                                height: 70, width: 70, fit: BoxFit.cover, radius: 35),
                            SizedBox(height: 8),
                            Text(
                              category.name ?? "",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ));
                  },
                ),
              ),
            ),
          ),
          // SwipperBanner(banners: [
          //   "https://salt.tikicdn.com/cache/w1080/ts/banner/1e/af/79/a0201597b21768edccd49f765d8bb929.png",
          //   "https://salt.tikicdn.com/cache/w1080/ts/banner/79/8c/2e/849ba73a8ffadda2199f4501e7ff902c.jpg",
          //   "https://salt.tikicdn.com/cache/w1080/ts/banner/82/63/97/59816a632d6c5472c62bf7a8397d7d36.png"
          // ], height: 150),
          SizedBox(height: 8),
          Row(children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: IconTitle(
                iconSize: 18,
                iconAsset: "assets/love.png",
                text: 'Newest products',
              ),
            ),
          ]),
          Center(
            child: ProductGridPanel(
              data: _newestProducts.length > 0 ? _newestProducts : [],
              showLoading: _newestProducts.length == 0,
            ),
          ),
        ],
      ),
    );
  }
}
