class Gateway {
  final int? id;
  final String? image;
  final String? name;
  final String? date;
  final double? amount;

  const Gateway({this.id, this.image, this.name, this.date, this.amount});
}

class GatewayList {
  static List<Gateway> list() {
    const data = <Gateway>[
      Gateway(
          id: 0,
          image: 'assets/images/card/american_express.png',
          name: 'American Express'),
      Gateway(
          id: 1,
          image: 'assets/images/card/mastercard.png',
          name: 'MasterCard'),
      Gateway(
          id: 2, image: 'assets/images/card/payoneer.png', name: 'Payoneer'),
      Gateway(id: 4, image: 'assets/images/card/paypal.png', name: 'PayPal'),
      Gateway(id: 5, image: 'assets/images/card/visa.png', name: 'Visa'),
    ];
    return data;
  }
}
