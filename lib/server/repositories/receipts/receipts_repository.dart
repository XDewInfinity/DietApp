import 'package:dietapp/server/repositories/receipts/models/receipt.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ReceiptsRepository{

  final String BaseUrl = "http://10.0.2.2:9999";

  Future<Receipt?> getReceiptDataFNS(String ? receipt_id) async {
    final response = await Dio().get(
      "$BaseUrl/FNS/get_cheque$receipt_id"
    );
    final data = response.data as Map<String, dynamic>;
    final receipt =  Receipt(
      ID: data["ID"], 
      Date: data["Date"], 
      Items: data["Items"], 
      Market: data["Market"].toString()
      );
    return receipt;
  }

  Future<String?> postReceipt(Future<Receipt?> rec, int user_id) async {
    Receipt? receipt = await rec;
    if (receipt != null){
      final response = await Dio().post(
        "$BaseUrl/post_cheque$user_id",
        data: {
          "ID": receipt.ID,
          "Market": receipt.Market,
          "Date": receipt.Date,
          "Items": receipt.Items
        });
    return response.statusMessage;
    }
    else{
      return "Something went wrong";
    }
  }

  Future<List<Receipt>> getReceiptList(userID) async {
    final response = await Dio().get(
      "$BaseUrl/get_cheques?user_id=$userID"
    );
    final data = response.data as Map<String, dynamic>;
    final ReceiptsList = data.entries.map((e) => Receipt(
      ID: e.key, 
      Date: (e.value as Map<String, dynamic>)["Date"], 
      Items: (e.value as Map<String, dynamic>)["Items"],
      Market: "Uknown"
      )).toList();
    return ReceiptsList;
  }
}

              // void handleRequests() async {
              //   // Получаем Receipt из первого запроса
              //   Receipt? receipt = await ReceiptsRepository().getReceiptDataFNS(result!.code);
              //   print(receipt);
              //   // Проверяем, что receipt не null, прежде чем передавать его во второй метод
              //   if (receipt != null) {
              //     await ReceiptsRepository().postReceipt(receipt, 1);
              //   } else {
              //     print('Не удалось получить Receipt.');
              //   }
              // }