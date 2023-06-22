class Category {
  final int? id;
  final String? name;
  final String? image;

  const Category({this.id, this.name, this.image});
}

class CategoryList {
  static List<Category> list() {
    const data = <Category>[
      Category(
        id: 1,
        name: 'Vegetable',
        image: 'assets/images/category/1.png',
      ),
      Category(
        id: 2,
        name: 'Fruits',
        image: 'assets/images/category/2.png',
      ),
      Category(
        id: 3,
        name: 'Meat',
        image: 'assets/images/category/3.png',
      ),
      Category(
        id: 4,
        name: 'Sea Food',
        image: 'assets/images/category/4.png',
      ),
    ];
    return data;
  }
}
