class SortDestinationModel {
  final int id;
  final String sortMethod;

  SortDestinationModel(
    this.id,
    this.sortMethod,
  );
}

List<SortDestinationModel> sortDestinationMethodList = [
  SortDestinationModel(1, "allDestination"),
  SortDestinationModel(2, "sortPriceAsc"),
  SortDestinationModel(3, "sortPriceDesc"),
  SortDestinationModel(4, "sortNameAsc"),
  SortDestinationModel(5, "sortNameDesc"),
  SortDestinationModel(6, "sortLocationAsc"),
  SortDestinationModel(7, "sortLocationDesc"),
  SortDestinationModel(8, "sortRatingAsc"),
  SortDestinationModel(9, "sortRatingDesc"),
];


// "allDestination": allDestination,
//       "sortPriceAsc": sortPriceAsc,
//       "sortPriceDesc": sortPriceDesc,
//       "sortNameAsc": sortNameAsc,
//       "sortNameDesc": sortNameDesc,
//       "sortLocationAsc": sortLocationAsc,
//       "sortLocationDesc": sortLocationDesc,
