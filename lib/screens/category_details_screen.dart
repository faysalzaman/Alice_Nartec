import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:grosshop/data/grocery.dart';
import 'package:grosshop/utils/custom_color.dart';
import 'package:grosshop/utils/dimensions.dart';
import 'package:grosshop/widgets/back_widget.dart';

class CategoryDetailsScreen extends StatefulWidget {
  final String? name;

  const CategoryDetailsScreen({Key? key, this.name}) : super(key: key);
  @override
  _CategoryDetailsScreenState createState() => _CategoryDetailsScreenState();
}

class _CategoryDetailsScreenState extends State<CategoryDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            //shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            children: [
              BackWidget(
                title: widget.name!,
              ),
              SizedBox(
                height: Dimensions.heightSize,
              ),
              _todayGroceryDealsWidget(context),
              _bannerWidget(context),
              _groceryMemberDealsWidget(context)
            ],
          ),
        ),
      ),
    );
  }

  _todayGroceryDealsWidget(BuildContext context) {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 3,
      itemCount: GroceryList.list().length,
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        Grocery grocery = GroceryList.list()[index];
        return Container(
            height: 120,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.withOpacity(0.2))),
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset(grocery.image!),
                    SizedBox(
                      height: Dimensions.heightSize * 0.5,
                    ),
                    Text(
                      grocery.name!,
                      style: TextStyle(
                          color: CustomColor.accentColor,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: Dimensions.widthSize * 0.5,
                        right: Dimensions.widthSize * 0.5,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                '\$${grocery.oldPrice.toString()}',
                                style: TextStyle(
                                    color: CustomColor.accentColor
                                        .withOpacity(0.8),
                                    decoration: TextDecoration.lineThrough,
                                    fontSize: Dimensions.smallTextSize),
                              ),
                              SizedBox(
                                width: Dimensions.widthSize * 0.5,
                              ),
                              Text(
                                '\$${grocery.newPrice.toString()}',
                                style: TextStyle(
                                    color: CustomColor.accentColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: Dimensions.smallTextSize),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                size: 15,
                                color: Colors.orange,
                              ),
                              Text(
                                '\$${grocery.rating.toString()}',
                                style: TextStyle(
                                    color: CustomColor.accentColor
                                        .withOpacity(0.8),
                                    decoration: TextDecoration.lineThrough,
                                    fontSize: Dimensions.smallTextSize),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  right: Dimensions.marginSize * 0.5,
                  top: Dimensions.heightSize * 0.5,
                  child: Icon(
                    Icons.favorite_border,
                    size: 18,
                    color: Colors.grey,
                  ),
                )
              ],
            ));
      },
      staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
      mainAxisSpacing: 0.0,
      crossAxisSpacing: 0.0,
    );
  }

  _bannerWidget(BuildContext context) {
    return Image.asset(
      'assets/images/banner.png',
      width: MediaQuery.of(context).size.width,
      fit: BoxFit.fitWidth,
    );
  }

  _groceryMemberDealsWidget(BuildContext context) {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 3,
      itemCount: GroceryList.list().length,
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        Grocery grocery = GroceryList.list()[index];
        return Container(
            height: 120,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.withOpacity(0.2))),
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset(grocery.image!),
                    SizedBox(
                      height: Dimensions.heightSize * 0.5,
                    ),
                    Text(
                      grocery.name!,
                      style: TextStyle(
                          color: CustomColor.accentColor,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: Dimensions.widthSize * 0.5,
                        right: Dimensions.widthSize * 0.5,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                '\$${grocery.oldPrice.toString()}',
                                style: TextStyle(
                                    color: CustomColor.accentColor
                                        .withOpacity(0.8),
                                    decoration: TextDecoration.lineThrough,
                                    fontSize: Dimensions.smallTextSize),
                              ),
                              SizedBox(
                                width: Dimensions.widthSize * 0.5,
                              ),
                              Text(
                                '\$${grocery.newPrice.toString()}',
                                style: TextStyle(
                                    color: CustomColor.accentColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: Dimensions.smallTextSize),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                size: 15,
                                color: Colors.orange,
                              ),
                              Text(
                                '\$${grocery.rating.toString()}',
                                style: TextStyle(
                                    color: CustomColor.accentColor
                                        .withOpacity(0.8),
                                    decoration: TextDecoration.lineThrough,
                                    fontSize: Dimensions.smallTextSize),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  right: Dimensions.marginSize * 0.5,
                  top: Dimensions.heightSize * 0.5,
                  child: Icon(
                    Icons.favorite_border,
                    size: 18,
                    color: Colors.grey,
                  ),
                )
              ],
            ));
      },
      staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
      mainAxisSpacing: 0.0,
      crossAxisSpacing: 0.0,
    );
  }
}
