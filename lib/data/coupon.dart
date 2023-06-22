class Coupon {
  final int? id;
  final String? image;
  final String? voucher;
  final String? title;
  final double? discount;

  const Coupon({this.id, this.image, this.voucher, this.title, this.discount});
}

class CouponList {
  static List<Coupon> list() {
    const data = <Coupon>[
      Coupon(
          id: 0,
          image: 'assets/images/grocery/1.png',
          voucher: 'AHGGZFZA',
          title: 'Black Friday',
          discount: 5.0),
      Coupon(
          id: 1,
          image: 'assets/images/grocery/2.png',
          voucher: 'PLIJKTGJ',
          title: 'Star Sunday',
          discount: 4.5),
      Coupon(
          id: 2,
          image: 'assets/images/grocery/3.png',
          voucher: 'JSWEDU',
          title: 'Special Discount',
          discount: 5.0),
    ];
    return data;
  }
}
