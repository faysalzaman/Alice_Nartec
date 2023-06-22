class CategoryDetails {
  final int? id;
  final String? image;
  final String? name;
  final String? instructor;
  final double? rating;
  final double? price;

  const CategoryDetails(
      {this.id,
      this.image,
      this.name,
      this.instructor,
      this.rating,
      this.price});
}

class CategoryDetailsList {
  static List<CategoryDetails> list() {
    const data = <CategoryDetails>[
      CategoryDetails(
        id: 1,
        image: 'assets/images/category_details/1.png',
        name: 'Bootstrap Update Master Courses',
        instructor: 'David Luiz',
        rating: 5.0,
        price: 15.0,
      ),
      CategoryDetails(
        id: 2,
        image: 'assets/images/category_details/2.png',
        name: 'We Development Course 1.5',
        instructor: 'Robat Jhonson',
        rating: 4.5,
        price: 49.0,
      ),
      CategoryDetails(
        id: 3,
        image: 'assets/images/category_details/3.png',
        name: 'Advanced HTML Course',
        instructor: 'James Williams',
        rating: 5.0,
        price: 20.0,
      ),
      CategoryDetails(
        id: 4,
        image: 'assets/images/category_details/4.png',
        name: 'Adjust Develop HTML Courses',
        instructor: 'David Luiz',
        rating: 5.0,
        price: 15.0,
      ),
      CategoryDetails(
        id: 5,
        image: 'assets/images/category_details/5.png',
        name: 'Bootstraps5 Basic Course ',
        instructor: 'Robat Jhonson',
        rating: 4.5,
        price: 49.0,
      ),
      CategoryDetails(
        id: 6,
        image: 'assets/images/category_details/6.png',
        name: 'Marketing with Development',
        instructor: 'James Williams',
        rating: 5.0,
        price: 20.0,
      ),
      CategoryDetails(
        id: 7,
        image: 'assets/images/category_details/7.png',
        name: 'Complete HTML Basic Course',
        instructor: 'David Luiz',
        rating: 5.0,
        price: 15.0,
      ),
      CategoryDetails(
        id: 8,
        image: 'assets/images/category_details/8.png',
        name: 'Web Developer Course 2021',
        instructor: 'Robat Jhonson',
        rating: 4.5,
        price: 49.0,
      ),
      CategoryDetails(
        id: 9,
        image: 'assets/images/category_details/9.png',
        name: 'Git a web Design Mastering',
        instructor: 'James Williams',
        rating: 5.0,
        price: 20.0,
      ),
    ];
    return data;
  }
}
