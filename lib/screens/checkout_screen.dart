import 'package:flutter/material.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:get/get.dart';

class CheckoutScreen extends StatefulWidget {
  String totalAmount;
  String itemQuantity;
  String itemName;
  String itemPrice;

  CheckoutScreen({
    Key? key,
    required this.totalAmount,
    required this.itemQuantity,
    required this.itemName,
    required this.itemPrice,
  }) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _countryController = TextEditingController();
  TextEditingController _zipCodeController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  final double deliveryFee = 4;
  double totalAmount = 0;

  @override
  void initState() {
    super.initState();
    totalAmount = double.parse(widget.totalAmount.toString()) +
        double.parse(deliveryFee.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBar(
          backgroundColor: Colors.green,
          flexibleSpace: Container(
            child: Center(
              child: Text(
                "Checkout",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // Text(
              //   "Customer Information",
              //   style: TextStyle(
              //     fontSize: 20,
              //     fontWeight: FontWeight.bold,
              //     color: Colors.green,
              //   ),
              // ),
              // SizedBox(height: 10),
              // Container(
              //   height: MediaQuery.of(context).size.height * 0.1,
              //   child: TextFormField(
              //     controller: _nameController,
              //     decoration: InputDecoration(
              //       hintText: "Full Name",
              //       border: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(10),
              //       ),
              //     ),
              //     autovalidateMode: AutovalidateMode.onUserInteraction,
              //     validator: (value) {
              //       if (value!.isEmpty) {
              //         return "Please enter your name";
              //       }
              //       return null;
              //     },
              //   ),
              // ),
              // SizedBox(height: 5),
              // Container(
              //   height: MediaQuery.of(context).size.height * 0.1,
              //   child: TextFormField(
              //     controller: _emailController,
              //     decoration: InputDecoration(
              //       hintText: "Email",
              //       border: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(10),
              //       ),
              //     ),
              //     autovalidateMode: AutovalidateMode.onUserInteraction,
              //     validator: (value) {
              //       if (value!.isEmpty) {
              //         return "Please enter your email";
              //       }
              //       return null;
              //     },
              //   ),
              // ),
              // SizedBox(height: 5),
              // Divider(
              //   color: Colors.green,
              //   thickness: 2,
              // ),
              // Text(
              //   "Delivery Information",
              //   style: TextStyle(
              //     fontSize: 20,
              //     fontWeight: FontWeight.bold,
              //     color: Colors.green,
              //   ),
              // ),
              // SizedBox(height: 5),
              // Container(
              //   height: MediaQuery.of(context).size.height * 0.1,
              //   child: TextFormField(
              //     controller: _phoneController,
              //     decoration: InputDecoration(
              //       hintText: "Phone Number",
              //       border: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(10),
              //       ),
              //     ),
              //     autovalidateMode: AutovalidateMode.onUserInteraction,
              //   ),
              // ),
              // SizedBox(height: 5),
              // Container(
              //   height: MediaQuery.of(context).size.height * 0.1,
              //   child: TextFormField(
              //     controller: _cityController,
              //     decoration: InputDecoration(
              //       hintText: "City",
              //       border: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(10),
              //       ),
              //     ),
              //     autovalidateMode: AutovalidateMode.onUserInteraction,
              //   ),
              // ),
              // SizedBox(height: 5),
              // Container(
              //   height: MediaQuery.of(context).size.height * 0.1,
              //   child: TextField(
              //     controller: _countryController,
              //     decoration: InputDecoration(
              //       hintText: "Country",
              //       border: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(10),
              //       ),
              //     ),
              //   ),
              // ),
              // SizedBox(height: 5),
              // Container(
              //   height: MediaQuery.of(context).size.height * 0.1,
              //   child: TextField(
              //     controller: _zipCodeController,
              //     decoration: InputDecoration(
              //       hintText: "Zip Code",
              //       border: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(10),
              //       ),
              //     ),
              //   ),
              // ),
              // SizedBox(height: 5),
              // Container(
              //   height: MediaQuery.of(context).size.height * 0.1,
              //   child: TextField(
              //     controller: _stateController,
              //     decoration: InputDecoration(
              //       hintText: "State",
              //       border: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(10),
              //       ),
              //     ),
              //   ),
              // ),
              // SizedBox(height: 5),
              // Container(
              //   height: MediaQuery.of(context).size.height * 0.1,
              //   child: TextField(
              //     controller: _addressController,
              //     decoration: InputDecoration(
              //       hintText: "Address",
              //       border: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(10),
              //       ),
              //     ),
              //   ),
              // ),
              SizedBox(height: 5),
              Divider(
                color: Colors.green,
                thickness: 2,
              ),
              Text(
                "Order Summary",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              SizedBox(height: 5),
              Container(
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text("SUBTOTAL"),
                        Text(
                          "SAR ${widget.totalAmount.toString()}",
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text("DELIVERY FEE"),
                        Text(
                          "SAR $deliveryFee",
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),

                    Container(
                      height: 40,
                      margin:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.green[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text("TOTAL", style: TextStyle(fontSize: 20)),
                          Text(
                            "\SAR ${(double.parse(widget.totalAmount) + deliveryFee).toStringAsFixed(2)}",
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.green,
                      thickness: 2,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) => UsePaypal(
                              sandboxMode: true,
                              clientId:
                                  "Ac1ZLk-EYKH7aVjPf6VIXDQA2yBIWwfGc3P8o2m7YX0SNp0xXXoytF0In-UJr6NaNWs4yh2Nx1puY0nw",
                              secretKey:
                                  "EDj4Jo8gLQkg-GPs-NoX2KBUySWoN96VV4TF_MgZ3ZWOFkPaCBNFqvbK3nPOkrDJp5iFO0pLojw3CIJQ",
                              returnURL: "https://samplesite.com/return",
                              cancelURL: "https://samplesite.com/cancel",

                              // transactions: [
                              //   {
                              //     "amount": {
                              //       "total": '10.12',
                              //       "currency": "USD",
                              //       "details": {
                              //         "subtotal": '10.12',
                              //         "shipping": '0',
                              //         "shipping_discount": 0
                              //       }
                              //     },
                              //     "description":
                              //         "The payment transaction description.",
                              //     // "payment_options": {
                              //     //   "allowed_payment_method":
                              //     //       "INSTANT_FUNDING_SOURCE"
                              //     // },
                              //     "item_list": {
                              //       "items": [
                              //         {
                              //           "name": "A demo product",
                              //           "quantity": 1,
                              //           "price": '10.12',
                              //           "currency": "USD"
                              //         }
                              //       ],

                              //       // shipping address is not required though
                              //       // "shipping_address": {
                              //       //   "recipient_name": "Jane Foster",
                              //       //   "line1": "Travis County",
                              //       //   "line2": "",
                              //       //   "city": "Austin",
                              //       //   "country_code": "US",
                              //       //   "postal_code": "73301",
                              //       //   "phone": "+00000000",
                              //       //   "state": "Texas"
                              //       // },
                              //     }
                              //   }
                              // ],
                              transactions: [
                                {
                                  "amount": {
                                    "total": (double.parse(widget.totalAmount) +
                                            deliveryFee)
                                        .toStringAsFixed(2),
                                    "currency": "USD",
                                    // the currency should be the Saudi Riyal
                                    // "currency": "SAR",
                                    "details": {
                                      "subtotal":
                                          (double.parse(widget.totalAmount) +
                                                  deliveryFee)
                                              .toStringAsFixed(2),
                                      "shipping": '0',
                                      "shipping_discount": 0
                                    }
                                  },
                                  "description":
                                      "The payment transaction description.",
                                  // "payment_options": {
                                  //   "allowed_payment_method":
                                  //       "INSTANT_FUNDING_SOURCE"
                                  // },
                                  "item_list": {
                                    "items": [
                                      {
                                        "name": "${widget.itemName}",
                                        "quantity": 1,
                                        "price":
                                            (double.parse(widget.totalAmount) +
                                                    deliveryFee)
                                                .toStringAsFixed(2),
                                        "currency": "USD"
                                      }
                                    ],
                                  }
                                },
                              ],
                              note:
                                  "Contact us for any questions on your order.",
                              onSuccess: (Map params) async {
                                print("onSuccess: $params");
                                Get.snackbar(
                                  "Success",
                                  "Payment Successful",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.green,
                                  colorText: Colors.white,
                                );
                              },
                              onError: (error) {
                                print("onError: $error");
                                Get.snackbar(
                                  "Error",
                                  "Payment Failed",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white,
                                );
                              },
                              onCancel: (params) {
                                print('cancelled: $params');
                                Get.snackbar(
                                  "Cancelled",
                                  "Payment Cancelled",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white,
                                );
                              },
                            ),
                          ),
                        );
                      },
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                        height: 40,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "Pay via PayPal",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // GestureDetector(
                    //   onTap: () {
                    //     orderBottomSheet();
                    //   },
                    //   child: Container(
                    //     margin:
                    //         EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                    //     height: 40,
                    //     width: double.infinity,
                    //     decoration: BoxDecoration(
                    //       color: Colors.green,
                    //       borderRadius: BorderRadius.circular(10),
                    //     ),
                    //     child: Center(
                    //       child: Text(
                    //         "Order Now",
                    //         style: TextStyle(
                    //           color: Colors.white,
                    //           fontSize: 20,
                    //           fontWeight: FontWeight.bold,
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> orderBottomSheet() {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
          height: MediaQuery.of(context).size.height * 0.5,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text(
                  "Order Summary",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Payment Type"),
                    Text(
                      "PayPal Payment",
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Bank"),
                    Text(
                      "PayPal",
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Mobile"),
                    Text(
                      "01700000000",
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Email"),
                    Text(
                      "faysal@gmail.com",
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Transaction Id"),
                    Text(
                      "1234567890",
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Amount Paid",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "\$4004",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              "Print",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              "Back",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> paymentBottomSheet() {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: 10),
                Text(
                  "Dilevery Address",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                SizedBox(height: 10),
                ListTile(
                  tileColor: Colors.green[100],
                  leading: Icon(Icons.home),
                  title: Text("Home"),
                  subtitle: Text("123, ABC Street, XYZ City"),
                  trailing: Icon(
                    Icons.check_circle,
                    color: Colors.red,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Payment Method",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                SizedBox(height: 10),
                ListTile(
                  tileColor: Colors.green[100],
                  leading: Icon(Icons.credit_card),
                  title: Text("Credit Card"),
                  subtitle: Text("1234567890"),
                  trailing: Icon(
                    Icons.check_circle,
                    color: Colors.red,
                  ),
                ),
                SizedBox(height: 10),
                ListTile(
                  tileColor: Colors.green[100],
                  leading: Icon(Icons.credit_card),
                  title: Text("Debit Card"),
                  subtitle: Text("1234567890"),
                  trailing: Icon(
                    Icons.check_circle,
                    color: Colors.red,
                  ),
                ),
                SizedBox(height: 10),
                ListTile(
                  tileColor: Colors.green[100],
                  leading: Icon(Icons.credit_card),
                  title: Text("Net Banking"),
                  subtitle: Text("1234567890"),
                  trailing: Icon(
                    Icons.check_circle,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
