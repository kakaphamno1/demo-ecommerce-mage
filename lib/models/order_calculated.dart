class OrderCalculated {
  dynamic grandTotal = 0;
  dynamic subtotal = 0;
  dynamic discountAmount = 0;
  dynamic shippingTaxAmount = 0;

  OrderCalculated({this.grandTotal, this.subtotal, this.discountAmount, this.shippingTaxAmount});

  factory OrderCalculated.fromJsonCart(Map<String, dynamic> json) {
    return new OrderCalculated(
        grandTotal: json['grand_total'],
        subtotal: json['subtotal'],
        discountAmount: json['discount_amount'],
        shippingTaxAmount: json['shipping_tax_amount']);
  }
}
