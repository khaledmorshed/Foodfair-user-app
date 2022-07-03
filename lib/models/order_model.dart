class OrderModel{
  String? addressID;
  num? totalAmount;
  String? orderBy;
  List<String> productIDs = ['garbageValue'];
  String? paymentDetails = "Cash on Delivery";
  String? orderTime;
  bool isSuccess =  true;
  String? sellerUID;
  String? riderUID =  "";
  String? status = "normal";
  String? orderId;

  OrderModel({
      this.addressID,
      this.totalAmount,
      this.orderBy,
      required this.productIDs,
      this.paymentDetails,
      this.orderTime,
      required this.isSuccess,
      this.sellerUID,
      this.riderUID,
      this.status,
      this.orderId});

  Map<String, dynamic> toMap(){
    var map = <String, dynamic>{
      "addressID": addressID,
      "totalAmount": totalAmount,
      "orderBy": orderBy,
      "productIDs": List<String>.from(productIDs.map((x) => x)),
      "paymentDetails": paymentDetails,
      "orderTime": orderTime,
      "isSuccess": isSuccess,
      "sellerUID": sellerUID,
      "riderUID": riderUID,
      "status": status,
      "orderId": orderId,
    };
    return map;
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) => OrderModel(
    addressID: map['addressID'],
    totalAmount: map['totalAmount'],
    orderBy: map['orderBy'],
    productIDs: List<String>.from(map["productIDs"].map((x) => x)),
    paymentDetails: map['paymentDetails'],
    orderTime: map['orderTime'],
    isSuccess: map['isSuccess'],
    sellerUID: map['sellerUID'],
    riderUID: map['riderUID'],
    status: map['status'],
    orderId: map['orderId'],
  );
}