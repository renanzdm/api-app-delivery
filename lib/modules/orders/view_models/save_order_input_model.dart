class SaveOrderInputModel {
  int userId;
  String address;
  String paymentType;
  List<int> itemsId;
  SaveOrderInputModel({
    this.userId,
    this.address,
    this.paymentType,
    this.itemsId,
  });
}
