import 'package:coffeeshopui/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:coffeeshopui/features/coffee/presentation/pages/homepage.dart';
import 'package:coffeeshopui/features/coffee/presentation/pages/navigation_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_constants.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  late Razorpay _razorpay;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _razorpay=Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _makePayment(int totalAmt) {
    var options = {
      'key': 'rzp_test_Ran8ybqg1nyOoy',
      'amount': totalAmt * 100,
      'name': 'CoffeeVerse App',
      'description': 'Order Payment',
      'prefill': {
        'contact': '9999999999',
        'email': 'test@example.com',
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    if (!mounted) return;

    context.read<CartBloc>().add(ClearCartEvent());

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   Navigator.pushAndRemoveUntil(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => NavigationPage(child: ,
    //       ),
    //     ),
    //         (route) => false,
    //   );
    // });
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Payment Failed: ${response.message}')),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('External Wallet: ${response.walletName}')),
    );
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Cart',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),

      body: SafeArea(
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartUpdated && state.carts.isNotEmpty) {
              return ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: state.carts.length,
                itemBuilder: (context, index) {
                  final coffee = state.carts[index];

                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade900,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [

                        /// IMAGE
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            coffee.coffeeImage ?? "",
                            height: 90,
                            width: 90,
                            fit: BoxFit.cover,
                          ),
                        ),

                        const SizedBox(width: 16),

                        /// DETAILS
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                coffee.coffeeName ?? "",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                coffee.coffeeDesc ?? "",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "\$${coffee.coffeePrice}",
                                style: const TextStyle(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),

                        /// QTY BUTTON
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: coffee.qty == 0
                              ? Container(
                            key: const ValueKey("add"),
                            decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: IconButton(
                              icon: const Icon(Icons.add,
                                  color: Colors.white),
                              onPressed: () {
                                context
                                    .read<CartBloc>()
                                    .add(AddToCart(coffee));
                              },
                            ),
                          )
                              : Container(
                            key: const ValueKey("qty"),
                            padding:
                            const EdgeInsets.symmetric(horizontal: 6),
                            decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove,
                                      color: Colors.white),
                                  onPressed: () {
                                    context
                                        .read<CartBloc>()
                                        .add(DecreaseQty(coffee));
                                  },
                                ),
                                Text(
                                  coffee.qty.toString(),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add,
                                      color: Colors.white),
                                  onPressed: () {
                                    context
                                        .read<CartBloc>()
                                        .add(IncreaseQty(coffee));
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }


            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined,
                      size: 80, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    "Your cart is empty",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),


      bottomNavigationBar: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartUpdated && state.carts.isNotEmpty) {
            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _priceRow("Sub Total", state.subTotal),
                  const SizedBox(height: 6),
                  _priceRow("GST (5%)", state.gst),
                  const Divider(color: Colors.grey),
                  _priceRow("Total", state.total, isBold: true),
                  const SizedBox(height: 12),


                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        _makePayment(state.total.toInt());

                      },
                      child: const Text(
                        "Proceed to Checkout",
                        style: TextStyle(
                          color: Colors.white,
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  Widget _priceRow(String title, double amount, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          "\$${amount.toStringAsFixed(2)}",
          style: TextStyle(
            color: Colors.white,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
