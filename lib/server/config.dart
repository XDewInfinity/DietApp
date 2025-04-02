import 'dart:convert';
import 'package:http/http.dart' as http;

class Receipt {
  final String ID;
  final String Market;
  final String Date;
  final List<dynamic> Items;
  const Receipt(this.ID, this.Market, this.Date, this.Items);

  Receipt.fromJson(Map<String, dynamic> json): 
    ID = json['ID'],
    Market = json['Market'].toString(),
    Date = json['Date'],
    Items = json['Items'];
    
  Map<String, dynamic> toJson() => {
    'ID': ID,
    'Market': Market,
    'Date': Date,
    'Items': Items
    };
  }

const String BaseUrl = "http://10.0.2.2:5000";

const String token = "30890.UGG9CHYKjBB0EpIGZ";

Future<Receipt?> getReceiptData(String ? receipt_id) async {
  final receiptDataUrl = Uri.parse('$BaseUrl/get_cheque$receipt_id');
  final receiptDataResponse = await http.get(receiptDataUrl);
  if (receiptDataResponse.statusCode != 200) {
    print('Failed to retrieve receipt data!');
    return null;  
  }
  Receipt receipt = Receipt.fromJson(jsonDecode(receiptDataResponse.body));
  print(receipt.Date);
  return receipt;
}

Future<String?> postReceipt(Future<Receipt?> rec, int user_id) async {
  Receipt? receipt = await rec;
  final receiptPostUrl = Uri.parse("${BaseUrl}/post_cheque${user_id}");
  if (receipt != null){
    final receiptPostData = receipt.toJson();
    final receiptPostResponse = await http.post(
      receiptPostUrl,       
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(receiptPostData));
      print(jsonEncode(receiptPostData));
      if (receiptPostResponse.statusCode != 200){
        print(receiptPostResponse.body);
        print('Failed to post new receipt');
        return null;
      }
    return receiptPostResponse.body;
  }
  else
    return null;
}