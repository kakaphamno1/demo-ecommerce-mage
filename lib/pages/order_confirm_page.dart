import 'dart:convert';

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:magento2_app/apis/quoteAPI.dart';
import 'package:magento2_app/configurations/clientConfig.dart';
import 'package:magento2_app/dataStorage/KeyValueStorage.dart';
import 'package:magento2_app/models/billing_address_request.dart';
import 'package:magento2_app/models/order_request.dart';
import 'package:magento2_app/models/payment_method_request.dart';

class OrderConfirmPage extends StatefulWidget {
  @override
  _OrderConfirmPageState createState() => _OrderConfirmPageState();
}

class _OrderConfirmPageState extends State<OrderConfirmPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController phoneNameCtl, firstNameCtl, lastNameCtl, emailCtl, streetAddressCtl, countryCtl, cityCtl;
  CancelableOperation? fetchingCreateOrder;

  @override
  void initState() {
    phoneNameCtl = TextEditingController(text: '0978100100');
    firstNameCtl = TextEditingController();
    lastNameCtl = TextEditingController();
    emailCtl = TextEditingController();
    streetAddressCtl = TextEditingController();
    countryCtl = TextEditingController(text: 'VN');
    cityCtl = TextEditingController(text: 'HANOI');
    super.initState();
  }

  @override
  void dispose() {
    // if (fetchingCart != null) fetchingCart!.cancel();
    // if (fetchingCalculate != null) fetchingCalculate!.cancel();
    // if (addProductToCartOperation != null) addProductToCartOperation!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(8, 50, 8, 0),
        height: height,
        width: width,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Ship and payment',
                        style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                TextField(
                  controller: firstNameCtl,
                  decoration: InputDecoration(
                    hintText: 'First name',
                    suffixIcon: Icon(Icons.ac_unit),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextField(
                  controller: lastNameCtl,
                  decoration: InputDecoration(
                    hintText: 'Last name',
                    suffixIcon: Icon(Icons.ac_unit),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                TextField(
                  controller: emailCtl,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    suffixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                TextField(
                  controller: phoneNameCtl,
                  decoration: InputDecoration(
                    hintText: 'Phone',
                    suffixIcon: Icon(Icons.phone),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                TextField(
                  controller: streetAddressCtl,
                  decoration: InputDecoration(
                    hintText: 'Street Address',
                    suffixIcon: Icon(Icons.ac_unit),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                TextField(
                  controller: countryCtl,
                  decoration: InputDecoration(
                    hintText: 'Country - VN',
                    suffixIcon: Icon(Icons.ac_unit),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                TextField(
                  controller: cityCtl,
                  decoration: InputDecoration(
                    hintText: 'CITY',
                    suffixIcon: Icon(Icons.ac_unit),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                RaisedButton(
                  child: Text('Confirm'),
                  color: Color(0xffEE7B23),
                  onPressed: () async {
                    OrderRequest orderRequest = OrderRequest();
                    // Shipping
                    orderRequest.email = emailCtl.text;
                    orderRequest.cartId = '';
                    orderRequest.billingAddress = BillingAddressRequest();
                    orderRequest.billingAddress!.firstname = firstNameCtl.text;
                    orderRequest.billingAddress!.lastname = lastNameCtl.text;
                    orderRequest.billingAddress!.street = [streetAddressCtl.text];
                    orderRequest.billingAddress!.countryId = countryCtl.text;
                    orderRequest.billingAddress!.city = cityCtl.text;
                    orderRequest.billingAddress!.telephone = phoneNameCtl.text;
                    orderRequest.billingAddress!.postcode = '100000';
                    // Payment
                    orderRequest.paymentMethod = PaymentMethodRequest();
                    orderRequest.paymentMethod!.method = 'checkmo';
                    // Request api
                    String quoteID = await KeyValueStorage().getValueWithKey(PreferenceKeys.quoteGuestID);
                    fetchingCreateOrder = CancelableOperation.fromFuture(
                        QuoteAPI().requestShippingInformation(quoteID, orderRequest).then((isSuccess) => {
                        // setState(() {
                        //   if (products != null) {
                        //     lstCart = products;
                        //   }
                        //   isLoading = false;
                        // })
                        if(isSuccess){
                            showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) =>
                                AlertDialog(
                                  title: Text("Success"),
                                  content: Text("Create order success"),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text("Done"),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    )
                                  ],
                                ))
                    }
                    }));
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
