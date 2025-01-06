import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pizz_lecious/core/global_set_height_width.dart';
import 'package:pizz_lecious/feat/order_placed_successful_page.dart';

class AddressDetailsView extends StatefulWidget {
  final String paymentType;
  const AddressDetailsView({super.key, required this.paymentType});

  @override
  State<AddressDetailsView> createState() => _AddressDetailsViewState();
}

class _AddressDetailsViewState extends State<AddressDetailsView> {
  bool isSelectedOne = false;
  bool isSelectedTwo = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                FontAwesomeIcons.plus,
                color: Theme.of(context).primaryColor,
              ))
        ],
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('Please select your address',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 20)),
                  const SizedBox(height: 15),
                  InkWell(
                    onTap: () {
                      setState(() {
                        isSelectedOne = !isSelectedOne;
                        isSelectedTwo = false;
                      });
                    },
                    child: SizedBox(
                      height: GlobalSetHeightWidth.getHeight(context) * 0.2,
                      width: GlobalSetHeightWidth.getWidth(context) * 0.9,
                      child: Card(
                        elevation: 15,
                        color: isSelectedOne
                            ? Theme.of(context).primaryColor.withOpacity(0.3)
                            : null,
                        child: const Center(
                          child: Text(
                            textAlign: TextAlign.left,
                            "Test1\ncalle 52,\nLas Augilas,\nMexico - 45080",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        isSelectedTwo = !isSelectedTwo;
                        isSelectedOne = false;
                      });
                    },
                    child: SizedBox(
                      height: GlobalSetHeightWidth.getHeight(context) * 0.2,
                      width: GlobalSetHeightWidth.getWidth(context) * 0.9,
                      child: Card(
                        elevation: 15,
                        color: isSelectedTwo
                            ? Theme.of(context).primaryColor.withOpacity(0.3)
                            : null,
                        child: const Center(
                          child: Text(
                            textAlign: TextAlign.left,
                            "Test2\ncalle 52,\nLa Calma,\nMexico - 45080",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: GlobalSetHeightWidth.getHeight(context) * 0.15,
                width: GlobalSetHeightWidth.getWidth(context),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColorLight,
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Payment Method - ${widget.paymentType}",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: GlobalSetHeightWidth.getHeight(context) * 0.05,
                      width: GlobalSetHeightWidth.getWidth(context) * 0.8,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(15)),
                      child: InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const OrderPlacedSuccessfulPage()));
                          },
                          child: const Center(
                            child: Text(
                              "Proceed to Place Order",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                          )),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
