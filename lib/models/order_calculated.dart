class OrderCalculated {
  int? grandTotal;
  int? subtotal;
  int? discountAmount;
  int? shippingTaxAmount;

  OrderCalculated({this.grandTotal, this.subtotal, this.discountAmount, this.shippingTaxAmount});

  factory OrderCalculated.fromJsonCart(Map<String, dynamic> json) {
    return new OrderCalculated(
        grandTotal: json['grand_total'],
        subtotal: json['subtotal'],
        discountAmount: json['discount_amount'],
        shippingTaxAmount: json['shipping_tax_amount']);
  }
}
