import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:pizz_lecious/core/global_set_height_width.dart';

class PaymentLandingPage extends StatefulWidget {
  const PaymentLandingPage({super.key});

  @override
  State<PaymentLandingPage> createState() => _PaymentLandingPageState();
}

class _PaymentLandingPageState extends State<PaymentLandingPage> {
  String name = '';
  String cardNumber = '';
  String cvv = '';
  String expDate = '';
  bool isCvvFocused = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: GlobalSetHeightWidth.getHeight(context),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            CreditCardWidget(
              cardBgColor: Theme.of(context).primaryColor,
              floatingConfig: const FloatingConfig(
                isGlareEnabled: true,
                isShadowEnabled: true,
                shadowConfig: FloatingShadowConfig(
                  offset: Offset(10, 10),
                  color: Colors.grey,
                  blurRadius: 15,
                ),
              ),
              enableFloatingCard: true,
              cardHolderName: name,
              cardNumber: cardNumber,
              cvvCode: cvv,
              bankName: 'YES BANK',
              isHolderNameVisible: true,
              expiryDate: expDate,
              showBackView: isCvvFocused,
              onCreditCardWidgetChange: (val) {},
            ),
            CreditCardForm(
                cvvValidationMessage: 'Please input a valid CVV',
                dateValidationMessage: 'Please input a valid date',
                numberValidationMessage: 'Please input a valid number',
                obscureCvv: true,
                obscureNumber: true,
                cardNumber: cardNumber,
                expiryDate: expDate,
                cardHolderName: name,
                cvvCode: cvv,
                onCreditCardModelChange: onCardChange,
                formKey: formKey),
            const Spacer(),
            InkWell(
              onTap: () {
                _onValidate();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: GlobalSetHeightWidth.getHeight(context) * 0.07,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: const Center(
                      child: Text(
                    "Place your Order",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  onCardChange(CreditCardModel model) {
    setState(() {
      cardNumber = model.cardNumber;
      expDate = model.expiryDate;
      cvv = model.cvvCode;
      name = model.cardHolderName;
      isCvvFocused = model.isCvvFocused;
    });
  }

  void _onValidate() {
    if (formKey.currentState?.validate() ?? false) {
    } else {}
  }
}
