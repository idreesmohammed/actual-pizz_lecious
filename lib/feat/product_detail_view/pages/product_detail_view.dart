import 'package:flutter/material.dart';
import 'package:pizz_lecious/core/global_set_height_width.dart';

class ProductDetailView extends StatelessWidget {
  const ProductDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              elevation: 10,
              shadowColor: Colors.grey,
              color: Colors.white,
              child: SizedBox(
                height: GlobalSetHeightWidth.getHeight(context) * 0.4,
                child: Center(
                  child: Image.asset(
                      'assets/whole-cheese-pizza-with-slice-removebg-preview.png'),
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              elevation: 10,
              shadowColor: Colors.grey,
              color: Colors.white,
              child: const Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 8, top: 5, right: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Cheesy Delight",
                            maxLines: 2,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22),
                          ),
                          Text(
                            '\$12.00',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w600,
                                fontSize: 18),
                          )
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text("\$15.00",
                            style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: Colors.red,
                                fontWeight: FontWeight.w500,
                                fontSize: 15)),
                      ),
                      SizedBox(
                        height: 50,
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
