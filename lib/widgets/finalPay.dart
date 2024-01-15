import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:seat_layout/screens/success_page.dart';

class FinalPay extends StatefulWidget {
  final num time;
  final num slotsNum;
  const FinalPay({super.key, required this.time, required this.slotsNum});

  @override
  State<FinalPay> createState() => _FinalPayState();
}

class _FinalPayState extends State<FinalPay> {
  num price = 0.0;
  void _calcPrice() {
    price = widget.time * 5 + widget.slotsNum * 20;
  }

  late Razorpay _razorpay;
  TextEditingController amtController = TextEditingController();

  void openCheckout(amount) async {
    amount = amount * 100;
    var options = {
      'key': 'enter key here',
      'amount': amount,
      'name': 'Sarthak',
      'prefill': {'contact': '123456789', 'email': 'test@gmail.com'},
      'external': {
        'wallets': ['paytm']
      }
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        msg: "Payment Successful " + response.paymentId!,
        toastLength: Toast.LENGTH_SHORT);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SuccessPage()),
    );
  }

  void handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "Payment Failed " + response.message!,
        toastLength: Toast.LENGTH_SHORT);
  }

  void handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "ExternalWallet " + response.walletName!,
        toastLength: Toast.LENGTH_SHORT);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
  }

  @override
  Widget build(BuildContext context) {
    _calcPrice();
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          const Text("Amount to be Paid"),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Rs. ${price.toStringAsFixed(2)}",
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              FloatingActionButton.extended(
                onPressed: () {
                  openCheckout(price);
                },
                label: const Text("Proceed to Pay"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
