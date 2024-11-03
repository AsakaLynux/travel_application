class TransactionModel {
  final int amountOfTraveler;
  final String selectedSeat;
  final bool insurance;
  final bool refundable;
  final double vat;
  final int price;
  final double grandTotal;
  final String status;
  final String createBy;
  final DateTime createAt;
  final String updateBy;
  final DateTime updateAt;

  TransactionModel({
    this.amountOfTraveler = 0,
    this.selectedSeat = "",
    this.insurance = false,
    this.refundable = false,
    this.vat = 0.0,
    this.price = 0,
    this.grandTotal = 0.0,
    this.status = "",
    this.createBy = "",
    DateTime? createAt,
    this.updateBy = "",
    DateTime? updateAt,
  })  : createAt = createAt ?? DateTime.now(),
        updateAt = updateAt ?? DateTime.now();
}
