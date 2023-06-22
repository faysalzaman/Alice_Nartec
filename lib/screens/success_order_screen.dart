import 'package:grosshop/screens/dashboard_screen.dart';
import 'package:grosshop/utils/custom_color.dart';
import 'package:grosshop/utils/dimensions.dart';
import 'package:grosshop/utils/strings.dart';
import 'package:grosshop/widgets/back_widget.dart';
import 'package:flutter/material.dart';
import 'package:grosshop/widgets/primary_button_widget.dart';

class SuccessOrderScreen extends StatefulWidget {

  @override
  _SuccessOrderScreenState createState() => _SuccessOrderScreenState();
}

class _SuccessOrderScreenState extends State<SuccessOrderScreen> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: ListView(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            children: [
              BackWidget(title: Strings.confirmOrder,),
              bodyWidget(context),
              SizedBox(height: Dimensions.heightSize,),
            ],
          ),
        ),
      ),
    );
  }

  bodyWidget(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      children: [
        statusWidget(context),
        SizedBox(height: Dimensions.heightSize * 4,),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: Dimensions.marginSize
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Strings.thanksYourOrder,
                      style: TextStyle(
                        fontSize: Dimensions.extraLargeTextSize * 1.2,
                        fontWeight: FontWeight.bold,
                        color: CustomColor.accentColor
                      ),
                    ),
                    Text(
                      Strings.youHaveSuccessfullyPlaced,
                      style: TextStyle(
                        fontSize: Dimensions.largeTextSize,
                        color: CustomColor.greyColor
                      ),
                    ),
                    SizedBox(height: Dimensions.heightSize * 2,),
                    Text(
                      Strings.trackYourOrder,
                      style: TextStyle(
                        fontSize: Dimensions.largeTextSize,
                        fontWeight: FontWeight.bold,
                        color: CustomColor.primaryColor
                      ),
                    ),
                    SizedBox(height: Dimensions.heightSize * 4,),
                    PrimaryButtonWidget(
                      title: Strings.backToHome,
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>
                            DashboardScreen()));
                      },
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Image.asset(
                'assets/images/order_success.png'
              ),
            )
          ],
        )
      ],
    );
  }

  statusWidget(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: Dimensions.heightSize * 2,
            left: Dimensions.marginSize,
            right: Dimensions.marginSize,
          ),
          child: Row(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    color: CustomColor.primaryColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: CustomColor.primaryColor
                    )
                ),
                child: Icon(
                  Icons.location_on_outlined,
                  color: Colors.white,
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  height: 3,
                  color: CustomColor.primaryColor,
                ),
              ),
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    color: CustomColor.primaryColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: CustomColor.primaryColor
                    )
                ),
                child: Icon(
                  Icons.payment,
                  color: Colors.white,
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  height: 3,
                  color: CustomColor.primaryColor,
                ),
              ),
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    color: CustomColor.primaryColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: CustomColor.primaryColor
                    )
                ),
                child: Icon(
                  Icons.done,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: Dimensions.heightSize,),
        Padding(
          padding: const EdgeInsets.only(
            left: Dimensions.marginSize,
            right: Dimensions.marginSize,
          ),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  Strings.address,
                  style: TextStyle(
                      color: Colors.black
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                    Strings.payment,
                    style: TextStyle(
                        color: Colors.black
                    ),
                    textAlign: TextAlign.center
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  Strings.confirm,
                  style: TextStyle(
                      color: Colors.black
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
