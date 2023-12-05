import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:room_details_page/user_screens/HomePage.dart';
import 'package:toast/toast.dart';

class Payment extends StatefulWidget {
  String price;
  TextEditingController email;
  Payment({this.price,this.email});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Payment> {
  Razorpay razorpay;
  TextEditingController amount = new TextEditingController();

  @override
  void initState() {
    super.initState();

    razorpay = new Razorpay();
    amount.text = widget.price;
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    razorpay.clear();
  }

  void openCheckout() {
    var options = {
      "key": "rzp_test_B0RDE1tq6NFrxI",
      "amount": num.parse(amount.text) * 100,
      "name": "BashaKhuji App",
      "description": "Payment for the some random product",
      "prefill": {"contact": "+8801723312065", "email": "190212@ku.ac.bd"},
      "external": {
        "wallets": ["paytm"]
      }
    };

    try {
      razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  void handlerPaymentSuccess(PaymentSuccessResponse response) {
    print("Payment success");
    Toast.show("Payment success : ${response.paymentId}", context);
  }

  void handlerErrorFailure() {
    print("Payment error");
    Toast.show("Payment error", context);
  }

  void handlerExternalWallet() {
    print("External Wallet");
    Toast.show("External Wallet", context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Razor Pay"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.push(context,
                MaterialPageRoute(builder: (builder) => HomePage(email: widget.email,)));
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            TextField(
              controller:amount,
              decoration: InputDecoration(hintText: "amount to pay"),
            ),
            SizedBox(
              height: 12,
            ),
            RaisedButton(
              color: Colors.blue,
              child: Text(
                "Booking Confirm",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                openCheckout();
              },
            )
          ],
        ),
      ),
    );
  }
}
