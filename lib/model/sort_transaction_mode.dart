class SortTransactionMode {
  final int id;
  final String sortMethod;

  SortTransactionMode(
    this.id,
    this.sortMethod,
  );
}

List<SortTransactionMode> sortTransactionMethodList = [
  SortTransactionMode(1, "allTransaction"),
  SortTransactionMode(2, "sortDateAsc"),
  SortTransactionMode(3, "sortDateDesc"),
];
