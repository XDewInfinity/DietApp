class Receipt {
  const Receipt({
    required this.ID, 
    required this.Date, 
    required this.Items,
    required this.Market
  });
  final String ID;
  final String Market;
  final String Date;
  final List<dynamic> Items;
}
