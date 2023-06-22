class Grocery {
  final int? id;
  final String? image;
  final String? name;
  final double? rating;
  final double? newPrice;
  final double? oldPrice;

  const Grocery(
      {this.id,
      this.image,
      this.name,
      this.rating,
      this.newPrice,
      this.oldPrice});
}

class GroceryList {
  static List<Grocery> list() {
    const data = <Grocery>[
      Grocery(
        id: 1,
        image: 'assets/images/grocery/1.png',
        name: 'Cauliflower',
        rating: 5.0,
        newPrice: 30.0,
        oldPrice: 60.0,
      ),
      Grocery(
        id: 2,
        image: 'assets/images/grocery/2.png',
        name: 'Baguette Bread',
        rating: 5.0,
        newPrice: 20.0,
        oldPrice: 40.0,
      ),
      Grocery(
        id: 3,
        image: 'assets/images/grocery/3.png',
        name: 'Hand Wash',
        rating: 5.0,
        newPrice: 30.0,
        oldPrice: 30.0,
      ),
      Grocery(
        id: 4,
        image: 'assets/images/grocery/4.png',
        name: 'Meat',
        rating: 5.0,
        newPrice: 80.0,
        oldPrice: 90.0,
      ),
      Grocery(
        id: 5,
        image: 'assets/images/grocery/5.png',
        name: 'Sunflower Oil',
        rating: 5.0,
        newPrice: 120.0,
        oldPrice: 120.0,
      ),
      Grocery(
        id: 6,
        image: 'assets/images/grocery/6.png',
        name: 'Potato Chip',
        rating: 5.0,
        newPrice: 50.0,
        oldPrice: 80.0,
      ),
      Grocery(
        id: 7,
        image: 'assets/images/grocery/7.png',
        name: 'Broccoli',
        rating: 5.0,
        newPrice: 25.0,
        oldPrice: 30.0,
      ),
      Grocery(
        id: 8,
        image: 'assets/images/grocery/8.png',
        name: 'Packing Juice',
        rating: 5.0,
        newPrice: 15.0,
        oldPrice: 20.0,
      ),
      Grocery(
        id: 9,
        image: 'assets/images/grocery/9.png',
        name: 'Packaging Food',
        rating: 5.0,
        newPrice: 19.0,
        oldPrice: 35.0,
      ),
      Grocery(
        id: 10,
        image: 'assets/images/grocery/10.png',
        name: 'Milk',
        rating: 5.0,
        newPrice: 10.0,
        oldPrice: 10.0,
      ),
    ];
    return data;
  }
}
