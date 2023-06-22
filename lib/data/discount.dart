class Discount {
  final int? id;
  final double? discount;
  final String? image;

  const Discount({this.id, this.discount, this.image});
}

class DiscountList {
  static List<Discount> list() {
    const data = <Discount>[
      Discount(
        id: 1,
        discount: 20,
        image: 'assets/images/discount/1.png',
      ),
      Discount(
        id: 2,
        discount: 35,
        image: 'assets/images/discount/2.png',
      ),
    ];
    return data;
  }
}
