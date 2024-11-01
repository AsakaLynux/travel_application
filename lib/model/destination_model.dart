class DestinationModel {
  final String imageUrl;
  final String name;
  final double rating;
  final String location;
  final int price;
  final String createBy;
  final DateTime createAt;
  final String updateBy;
  final DateTime updateAt;

  DestinationModel({
    this.imageUrl = "",
    this.name = "",
    this.location = "",
    this.rating = 0.0,
    this.price = 0,
    this.createBy = "",
    DateTime? createAt,
    this.updateBy = "",
    DateTime? updateAt,
  })  : createAt = createAt ?? DateTime.now(),
        updateAt = updateAt ?? DateTime.now();
}
