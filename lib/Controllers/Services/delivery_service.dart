import 'dart:convert';

import 'package:fastdelivery/Controllers/Services/http_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../Models/delivery.dart';

class DeliveryService {
  static Future<List<Delivery>> getDeliveries() async {
    var url = '${dotenv.get('API_URL')}/delivery';
    List<Delivery> deliveries = [];
    await HTTPService.httpGET(url, appendToken: true).then((response) {
      var jsonResponse = jsonDecode(response.body) as List<dynamic>;
      jsonResponse.forEach((element) {
        //print(element['customer_info']);
        var delivery = Delivery(
            id: element['id'],
            origin: element['origin'],
            destination: element['destination'],
            dimensions: element['dimensions'],
            weight: int.parse(element['weight']),
            orderNr: element['order_nr'],
            status: element['delivery_status'],
            type: element['type'],
            riderID: element['rider_id'],
            customerInfo: element['customer_info'],
            comment: element['comment'] ?? '');
        deliveries.add(delivery);
      });
    });
    return deliveries;
  }

  static Future<Delivery> updateDeliveryStatus(
      Map<String, dynamic> body, String id) async {
    var delivery;
    var url = '${dotenv.get('API_URL')}/delivery/$id';
    await HTTPService.httpPOST(url, body, appendToken: true).then((response) {
      var element = response.body;
      //print(element);
      delivery = Delivery(
          id: element['id'],
          origin: element['origin'],
          destination: element['destination'],
          dimensions: element['dimensions'],
          weight: int.parse(element['weight']),
          orderNr: element['order_nr'],
          status: element['delivery_status'],
          type: element['type'],
          riderID: element['rider_id'],
          customerInfo: element['customer_info'],
          comment: element['comment'] ?? '');
    });
    return delivery;
  }

  static Future<bool> checkPincode(Map<String, dynamic> body) async {
    bool isCorrect = false;
    var url = '${dotenv.get('REQUESTING_APP_URL')}/verify-order-code';
    await HTTPService.httpPOST(url, body).then((response) {
      var element = response.body;
      String message = element['message'];
      if (message.contains('not')) {
        isCorrect = false;
      } else {
        isCorrect = true;
      }
    });
    return isCorrect;
  }
}
