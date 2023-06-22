import 'package:flutter/material.dart';
import 'package:grosshop/data/message.dart';
import 'package:grosshop/widgets/back_widget.dart';

import 'package:grosshop/utils/custom_color.dart';
import 'package:grosshop/utils/dimensions.dart';
import 'package:grosshop/utils/strings.dart';
import 'package:grosshop/utils/custom_style.dart';

class MessagingScreen extends StatefulWidget {
  @override
  _MessagingScreenState createState() => _MessagingScreenState();
}

class _MessagingScreenState extends State<MessagingScreen> {
  TextEditingController messageController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              BackWidget(
                title: Strings.helpSupport,
              ),
              bodyWidget(context),
              typeMessageWidget(context)
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
        SizedBox(
          height: Dimensions.heightSize,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  color: CustomColor.primaryColor,
                  borderRadius: BorderRadius.circular(Dimensions.radius * 0.5)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.call,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              width: Dimensions.widthSize,
            ),
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(Dimensions.radius * 0.5)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.video_call,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        detailsWidget(context),
      ],
    );
  }

  detailsWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: Dimensions.heightSize, bottom: Dimensions.topHeight),
      child: messagingWidget(context),
    );
  }

  Widget messagingWidget(BuildContext context) {
    return ListView.builder(
        itemCount: MessageList.list().length,
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          Message message = MessageList.list()[index];
          return Padding(
              padding: const EdgeInsets.only(
                bottom: Dimensions.heightSize,
              ),
              child: message.type != 'sender'
                  ? Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              right: Dimensions.marginSize,
                              left: Dimensions.marginSize),
                          child: Container(
                            decoration: BoxDecoration(
                                color: CustomColor.greenLightColor,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30.0),
                                    bottomLeft: Radius.circular(30.0),
                                    bottomRight: Radius.circular(30.0))),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: Dimensions.marginSize,
                                    right: Dimensions.marginSize,
                                    top: Dimensions.heightSize,
                                    bottom: Dimensions.heightSize),
                                child: Text(
                                  message.text!,
                                  style: TextStyle(
                                    color: CustomColor.greyColor,
                                    fontSize: Dimensions.defaultTextSize,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: Dimensions.marginSize),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              'seen message',
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.3),
                                fontSize: Dimensions.extraSmallTextSize,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        )
                      ],
                    )
                  : Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: ClipRRect(
                                child: Image.asset(
                                  'assets/images/profile.png',
                                  height: 20,
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  message.name!,
                                  style: TextStyle(
                                    color: CustomColor.redColor,
                                    fontSize: Dimensions.smallTextSize,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                                Text(
                                  message.time!,
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.3),
                                    fontSize: Dimensions.extraSmallTextSize,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ],
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: Dimensions.marginSize,
                              right: Dimensions.marginSize),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: CustomColor.yellowLightColor,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(30.0),
                                    bottomLeft: Radius.circular(30.0),
                                    bottomRight: Radius.circular(30.0))),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: Dimensions.marginSize,
                                    right: Dimensions.marginSize,
                                    top: Dimensions.heightSize,
                                    bottom: Dimensions.heightSize),
                                child: Text(
                                  message.text!,
                                  style: TextStyle(
                                    color: CustomColor.greyColor,
                                    fontSize: Dimensions.defaultTextSize,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ));
        });
  }

  Widget typeMessageWidget(BuildContext context) {
    return Positioned(
        bottom: 0,
        right: 0,
        left: 0,
        child: Padding(
          padding: const EdgeInsets.only(
            left: Dimensions.marginSize,
            right: Dimensions.marginSize,
          ),
          child: Container(
            height: 60,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                border: Border.all(
                  color: Colors.black.withOpacity(0.1),
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: Dimensions.marginSize),
                  child: Row(
                    children: [
                      Icon(
                        Icons.emoji_emotions_outlined,
                        color: CustomColor.redColor,
                        size: 20,
                      ),
                      Icon(
                        Icons.image,
                        color: CustomColor.redColor,
                        size: 20,
                      ),
                      Form(
                          key: formKey,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: TextFormField(
                              style: CustomStyle.textStyle,
                              controller: messageController,
                              keyboardType: TextInputType.name,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return Strings.typeSomething;
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                hintText: Strings.typeMessage,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 10.0),
                                labelStyle: CustomStyle.textStyle,
                                filled: true,
                                fillColor: Colors.white,
                                hintStyle: CustomStyle.textStyle,
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
                IconButton(
                    icon: Icon(
                      Icons.send,
                      color: CustomColor.primaryColor,
                      size: 18,
                    ),
                    onPressed: () {})
              ],
            ),
          ),
        ));
  }
}
