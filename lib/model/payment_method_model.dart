class PaymentMethod {
  final int id;
  final String name;

  PaymentMethod(
    this.id,
    this.name,
  );
}

List<PaymentMethod> listPayment = [
  PaymentMethod(1, "Credit Card"),
  PaymentMethod(2, "Debit Card"),
  PaymentMethod(3, "Dana"),
  PaymentMethod(4, "OVO"),
  PaymentMethod(5, "Virtual Account"),
];
