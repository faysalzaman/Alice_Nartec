class Order {
  final int? id;
  final String? name;
  final String? image;
  final String? discount;
  final String? oldPrice;
  final String? newPrice;
  final String? rating;
  final String? piece;
  final String? orderId;
  final String? status;
  final String? date;

  const Order(
      {this.id,
      this.name,
      this.image,
      this.discount,
      this.oldPrice,
      this.newPrice,
      this.rating,
      this.piece,
      this.orderId,
      this.status,
      this.date});
}

class OrderList {
  static List<Order> list() {
    const data = <Order>[
      Order(
          id: 1,
          name: 'Shampoo',
          image: 'assets/images/grocery/3.png',
          discount: '45',
          oldPrice: '100.00',
          newPrice: '55.00',
          rating: '5.0',
          piece: '50',
          orderId: 'SGW124578',
          status: 'Picked',
          date: '27 jan, 2021'),
      Order(
          id: 2,
          name: 'Mango Juice',
          image: 'assets/images/grocery/2.png',
          discount: '20',
          oldPrice: '80.00',
          newPrice: '64.00',
          rating: '5.0',
          piece: '150',
          orderId: 'RFA124578',
          status: 'Pending',
          date: '19 jan, 2021'),
      Order(
          id: 3,
          name: 'Cauliflower',
          image: 'assets/images/grocery/1.png',
          discount: '45',
          oldPrice: '100.00',
          newPrice: '55.00',
          rating: '5.0',
          piece: '50',
          orderId: 'RAF424578',
          status: 'Delivered',
          date: '07 jan, 2021'),
    ];
    return data;
  }
}
