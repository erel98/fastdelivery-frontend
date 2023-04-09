class Delivery {
  String id;
  String status;
  String origin;
  String destination;
  String orderNr;
  int weight;
  String dimensions;
  String type;
  Map<String, dynamic> customerInfo;
  String riderID;
  String? comment;

  Delivery(
      {required this.id,
      required this.status,
      required this.origin,
      required this.destination,
      required this.orderNr,
      required this.weight,
      required this.dimensions,
      required this.type,
      required this.customerInfo,
      required this.riderID,
      this.comment});

  factory Delivery.fromJson(Map<String, dynamic> parsedJson) {
    return Delivery(
      id: parsedJson['id'] ?? "",
      status: parsedJson['status'] ?? "",
      origin: parsedJson['origin'] ?? "",
      destination: parsedJson['destination'] ?? 0,
      orderNr: parsedJson['orderNr'] ?? 0,
      weight: parsedJson['weight'] ?? 0,
      dimensions: parsedJson['dimensions'] ?? 0,
      type: parsedJson['type'] ?? 0,
      customerInfo: parsedJson['customerInfo'] ?? 0,
      riderID: parsedJson['riderID'] ?? 0,
      comment: parsedJson['comment'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'origin': origin,
      'destination': destination,
      'orderNr': orderNr,
      'weight': weight,
      'dimensions': dimensions,
      'type': type,
      'customerInfo': customerInfo,
      'riderID': riderID,
      'comment': comment,
    };
  }
}
