import 'package:coffeeshopui/core/constants/app_constants.dart';
import 'package:coffeeshopui/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:coffeeshopui/features/cart/presentation/pages/cart_page.dart';
import 'package:coffeeshopui/features/coffee/data/models/coffee_details_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_color.dart';
import '../../../cart/data/models/coffee_price_model.dart';
import '../bloc/favorite_bloc/favorite_bloc.dart';
import '../bloc/favorite_bloc/favorite_state.dart';

class CoffeeDetailsPage extends StatefulWidget {
  final CoffeeDetailsModel coffeeDetailsModel;


  const CoffeeDetailsPage({super.key, required this.coffeeDetailsModel});

  @override
  State<CoffeeDetailsPage> createState() => _CoffeeDetailsPageState();
}

class _CoffeeDetailsPageState extends State<CoffeeDetailsPage> {
  bool isExpanded = false;
  final String shortText = AppConstants.shortText;
  final String longText = AppConstants.longText;

  late CoffeePriceModel selectedCoffeePrice;

  List sizeList = [
    {"sizeName": "S", "isSelected": true},
    {"sizeName": "M", "isSelected": false},
    {"sizeName": "L", "isSelected": false},
  ];

  late double currentPrice;
  String selectedSize = "S";

  @override
  void initState() {
    super.initState();
    currentPrice=widget.coffeeDetailsModel.smallPrice;
  }

  void setSelectedSize(int index) {
    setState(() {
      for (int i = 0; i < sizeList.length; i++) {
        sizeList[i]['isSelected'] = false;
      }
      sizeList[index]['isSelected'] = true;

      selectedSize = sizeList[index]['sizeName'];

      switch(selectedSize){
        case "S":
          currentPrice =widget.coffeeDetailsModel.smallPrice;

        case "M":
          currentPrice = widget.coffeeDetailsModel.mediumPrice;

        case "L":
          currentPrice = widget.coffeeDetailsModel.largePrice;

        default:
          currentPrice = widget.coffeeDetailsModel.smallPrice;
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return BlocListener<FavoriteBloc, FavoriteState>(
      listener: (context, state) {
        if (state.coffee == widget.coffeeDetailsModel) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.isAdded
                    ? "${state.coffee?.coffeeName} added to favorites"
                    : "${state.coffee?.coffeeName} removed from favorites",
              ),
              duration: const Duration(seconds: 1),
            ),
          );
        }
            },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.black,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
        child: SafeArea(
          child: Scaffold(
            bottomNavigationBar: Container(
              height: 110,
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              child: Row(
                children: [
                  Column(
                    children: [
                      Text('Price', style: TextStyle(color: Colors.white70)),
                      SizedBox(height: 5),
                      Text(
                        '\$${currentPrice.toStringAsFixed(2)}',

                        style: TextStyle(
                          color: Color(0xffD37A2E),
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 15),
                  BlocBuilder<CartBloc, CartState>(
                    builder: (context, state) {
                      return Expanded(
                        child: InkWell(
                          onTap: () {
                            context.read<CartBloc>().add(AddToCart(widget.coffeeDetailsModel));
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("${widget.coffeeDetailsModel.coffeeName} Added to the cart"),
                                  duration: Duration(seconds: 1),
                                ));

                          },
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: const Center(
                              child: Text(
                                'Add To Cart',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            body: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Image.asset(
                        widget.coffeeDetailsModel.coffeeImage.toString(),
                        height: height * 0.50,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        top: 15,
                        left: 15,
                        child: _iconBtn(
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.arrow_back_ios_new),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 15,
                        right: 15,
                        child: _iconBtn(
                          BlocBuilder<FavoriteBloc, FavoriteState>(
                            builder: (context, state) {
                              bool isFavorite = false;

                              isFavorite = state.favorites.contains(
                                widget.coffeeDetailsModel,
                              );
                                                          return IconButton(
                                onPressed: () {
                                  context.read<FavoriteBloc>().add(
                                    ToggleFavoriteEvent(
                                      widget.coffeeDetailsModel,
                                    ),
                                  );
                                },
                                icon: Icon(
                                  isFavorite
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: isFavorite ? Colors.red : Colors.white,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: -60,
                        left: 0,
                        right: 0,
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(0, 0, 0, 0.75),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.coffeeDetailsModel.coffeeName
                                        .toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    widget.coffeeDetailsModel.coffeeDesc
                                        .toString(),
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        color: Color(0xffD37A2E),
                                        size: 20,
                                      ),
                                      const SizedBox(width: 5),
                                      const Text(
                                        '4.6',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                      ),
                                      const SizedBox(width: 3),
                                      const Text(
                                        '(6,986)',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      featureTag(Icons.coffee, "Coffee"),
                                      const SizedBox(width: 10),
                                      featureTag(Icons.local_drink, "Milk"),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.black87,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Colors.white24,
                                        width: 0.8,
                                      ),
                                    ),
                                    child: const Text(
                                      'Medium Roast',
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 70),

                  Padding(
                    padding: .symmetric(horizontal: 25.0),
                    child: Row(children: [Text('Description')]),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: isExpanded ? longText : shortText,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              height: 1.5,
                            ),
                          ),
                          TextSpan(
                            text: isExpanded ? " Read Less" : "... Read More",
                            style: const TextStyle(
                              color: Color(0xffD37A2E),
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                setState(() => isExpanded = !isExpanded);
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Padding(
                    padding: .symmetric(horizontal: 25.0),
                    child: Row(children: [Text('Size')]),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: SizedBox(
                      height: 40,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: sizeList.length,
                        itemBuilder: (context, index) {
                          final size = sizeList[index];

                          return GestureDetector(
                            onTap: () => setSelectedSize(index),
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: sizeBox(
                                label: size['sizeName'],
                                isSelected: size['isSelected'],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _iconBtn(Widget icon) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.baseBlackColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: icon,
    );
  }

  Widget sectionTitle(String t) => Padding(
    padding: const EdgeInsets.only(left: 25),
    child: Text(
      t,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  );

  Widget sectionText(String t) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
    child: Text(t, style: const TextStyle(color: Colors.white70, height: 1.4)),
  );

  Widget sizeBox({required String label, required bool isSelected}) {
    return Container(
      width: 120,
      decoration: BoxDecoration(
        color: AppColors.baseBlackColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isSelected ? const Color(0xffD37A2E) : Colors.transparent,
          width: 1,
        ),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isSelected ? const Color(0xffD37A2E) : Colors.white70,
          ),
        ),
      ),
    );
  }

  Widget featureTag(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white24, width: .9),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Color(0xffD37A2E)),
          const SizedBox(width: 5),
          Text(
            text,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
