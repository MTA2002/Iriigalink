class MarketPrice {
  final String cropName;
  final int currentPrice;
  final int priceUnit;
  final String updateTime;
  final String cropImage;

  MarketPrice({
    required this.cropName,
    required this.currentPrice,
    required this.priceUnit,
    required this.updateTime,
    required this.cropImage,
  });
  factory MarketPrice.fromMap(Map<String, dynamic> json) {
    String updateTime = "";
    DateTime dt = json['updateTime'].toDate();
    print("json${json}");
    num weekDiff = DateTime.now().weekday - dt.weekday;
    num monthDiff = DateTime.now().month - dt.month;
    num yearDiff = DateTime.now().year - dt.year;
    if (yearDiff == 0) {
      if (monthDiff == 0) {
        if (weekDiff == 0) {
          updateTime = "This Week";
        } else {
          updateTime = "Last Week";
        }
      } else {
        updateTime = "Last Month";
      }
    } else {
      updateTime = "Last Year";
    }
    return MarketPrice(
      cropName: json["product_name"],
      currentPrice: json['currentPrice'],
      priceUnit: json['priceUnit'],
      updateTime: updateTime,
      cropImage:
          'images/crops/${json['product_name'].toString().toLowerCase().trim()}.jpeg',
    );
  }
}
