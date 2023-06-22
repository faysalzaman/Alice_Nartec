import 'package:grosshop/utils/custom_color.dart';
import 'package:grosshop/utils/custom_style.dart';
import 'package:grosshop/utils/dimensions.dart';
import 'package:grosshop/utils/strings.dart';
import 'package:grosshop/widgets/back_widget.dart';
import 'package:flutter/material.dart';
import 'package:grosshop/widgets/primary_button_widget.dart';
import 'package:grosshop/screens/payment_screen.dart';

class AddressScreen extends StatefulWidget {
  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final cityController = TextEditingController();
  final zipController = TextEditingController();
  final stateController = TextEditingController();
  final phoneController = TextEditingController();

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
              BackWidget(
                title: Strings.address,
              ),
              bodyWidget(context),
              buttonWidget(context)
            ],
          ),
        ),
      ),
    );
  }

  bodyWidget(BuildContext context) {
    return Column(
      children: [
        statusWidget(context),
        SizedBox(
          height: Dimensions.heightSize * 2,
        ),
        formWidget(context),
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
                    color: CustomColor.accentColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: CustomColor.primaryColor)),
                child: Icon(
                  Icons.location_on_outlined,
                  color: CustomColor.primaryColor,
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
                    color: CustomColor.accentColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: CustomColor.primaryColor)),
                child: Icon(
                  Icons.payment,
                  color: CustomColor.primaryColor,
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  height: 3,
                  color: Colors.grey,
                ),
              ),
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    color: CustomColor.accentColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: CustomColor.primaryColor)),
                child: Icon(
                  Icons.done,
                  color: CustomColor.primaryColor,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: Dimensions.heightSize,
        ),
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
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(Strings.payment,
                    style: TextStyle(color: Colors.black),
                    textAlign: TextAlign.center),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  Strings.confirm,
                  style: TextStyle(color: Colors.black),
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  formWidget(BuildContext context) {
    return Container(
      //height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Dimensions.radius * 2),
          topRight: Radius.circular(Dimensions.radius * 2),
        ),
        boxShadow: [
          BoxShadow(
            color: CustomColor.primaryColor.withOpacity(0.1),
            spreadRadius: 4,
            blurRadius: 7,
            offset: Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
      child: Form(
        child: Padding(
          padding: const EdgeInsets.only(
            top: Dimensions.heightSize,
            left: Dimensions.marginSize,
            right: Dimensions.marginSize,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(Strings.name),
              TextFormField(
                style: CustomStyle.textStyle,
                controller: nameController,
                keyboardType: TextInputType.name,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return Strings.pleaseFillOutTheField;
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  hintText: Strings.demoName,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  labelStyle: CustomStyle.textStyle,
                  filled: true,
                  fillColor: Colors.transparent,
                  hintStyle: CustomStyle.textStyle,
                ),
              ),
              SizedBox(
                height: Dimensions.heightSize * 2,
              ),
              Text(Strings.email),
              TextFormField(
                style: CustomStyle.textStyle,
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return Strings.pleaseFillOutTheField;
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  hintText: Strings.demoEmail,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  labelStyle: CustomStyle.textStyle,
                  filled: true,
                  fillColor: Colors.transparent,
                  hintStyle: CustomStyle.textStyle,
                ),
              ),
              SizedBox(
                height: Dimensions.heightSize * 2,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(Strings.city),
                        TextFormField(
                          style: CustomStyle.textStyle,
                          controller: cityController,
                          keyboardType: TextInputType.text,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return Strings.pleaseFillOutTheField;
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            hintText: Strings.demoCity,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
                            labelStyle: CustomStyle.textStyle,
                            filled: true,
                            fillColor: Colors.transparent,
                            hintStyle: CustomStyle.textStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: Dimensions.widthSize,
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(Strings.zipCode),
                        TextFormField(
                          style: CustomStyle.textStyle,
                          controller: zipController,
                          keyboardType: TextInputType.number,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return Strings.pleaseFillOutTheField;
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            hintText: Strings.demoZipCode,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
                            labelStyle: CustomStyle.textStyle,
                            filled: true,
                            fillColor: Colors.transparent,
                            hintStyle: CustomStyle.textStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Dimensions.heightSize * 2,
              ),
              Text(Strings.phoneNumber),
              TextFormField(
                style: CustomStyle.textStyle,
                controller: phoneController,
                keyboardType: TextInputType.number,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return Strings.pleaseFillOutTheField;
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  hintText: Strings.demoNumber,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  labelStyle: CustomStyle.textStyle,
                  filled: true,
                  fillColor: Colors.transparent,
                  hintStyle: CustomStyle.textStyle,
                ),
              ),
              SizedBox(
                height: Dimensions.heightSize * 2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  buttonWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: Dimensions.marginSize,
        right: Dimensions.marginSize,
      ),
      child: PrimaryButtonWidget(
        title: Strings.saveAddress,
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => PaymentScreen()));
        },
      ),
    );
  }
}
