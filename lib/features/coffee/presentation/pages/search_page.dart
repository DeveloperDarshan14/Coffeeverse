import 'package:coffeeshopui/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/coffee_details_model.dart';


class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchController = TextEditingController();
  List<CoffeeDetailsModel> filteredList = [];

  List<CoffeeDetailsModel> coffeeDetails = [
    CoffeeDetailsModel(
      coffeeDesc: "with Almond Milk",
      coffeeImage: "assets/images/cappucino.jpg",
      coffeeName: "Cappuccino",
      coffeePrice: 4.0,
      mediumPrice: 12.0,
      largePrice: 14.0,
      smallPrice: 4.0,
    ),
    CoffeeDetailsModel(
      coffeeDesc: "with Almond Milk",
      coffeeImage: "assets/images/latte.jpg",
      coffeeName: "Espresso",
      coffeePrice: 12.0,
      mediumPrice: 12.0,
      largePrice: 14.0,
      smallPrice: 4.0,
    ),
    CoffeeDetailsModel(
      coffeeDesc: "with Almond Milk",
      coffeeImage: "assets/images/milk.jpg",
      coffeeName: "Latte",
      coffeePrice: 9.0,
      mediumPrice: 12.0,
      largePrice: 14.0,
      smallPrice: 4.0,
    ),
    CoffeeDetailsModel(
      coffeeDesc: "with Almond Milk",
      coffeeImage: "assets/images/latte.jpg",
      coffeeName: "Black",
      coffeePrice: 30.0,
      mediumPrice: 12.0,
      largePrice: 14.0,
      smallPrice: 4.0,
    ),
    CoffeeDetailsModel(
      coffeeDesc: "with Almond Milk",
      coffeeImage: "assets/images/cappucino.jpg",
      coffeeName: "Frappuccino",
      coffeePrice: 14.0,
      mediumPrice: 12.0,
      largePrice: 14.0,
      smallPrice: 4.0,
    ),
    CoffeeDetailsModel(
      coffeeDesc: "with Almond Milk",
      coffeeImage: "assets/images/cappucino.jpg",
      coffeeName: "Americano",
      coffeePrice: 25.0,
      mediumPrice: 12.0,
      largePrice: 14.0,
      smallPrice: 4.0,
    ),
  ];

  @override
  void initState() {
    filteredList = coffeeDetails;
    searchController.addListener(_onSearch);
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    searchController.removeListener(_onSearch);
    FocusManager.instance.primaryFocus?.unfocus();
    super.dispose();
  }

  void _onSearch() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredList = coffeeDetails
          .where((coffee) => coffee.coffeeName!.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(height: 25),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios_new),
                ),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      height: 55,
                      child: TextField(
                        controller: searchController,
                        cursorColor: Colors.orange,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "Search coffee...",
                          hintStyle: TextStyle(color: Colors.grey.shade400),

                          prefixIcon: Icon(Icons.search, color: Colors.grey.shade400),

                          filled: true,
                          fillColor: const Color(0xFF1E1E1E),
                          // dark grey

                          contentPadding: const EdgeInsets.symmetric(vertical: 18),

                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10), // square feel
                            borderSide: BorderSide(color: Colors.grey.shade800),
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.orange,
                              width: 1.2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: filteredList.length,
                itemBuilder: (context, index) {
                  final coffee = filteredList[index];

                  return Container(
                    margin: .only(bottom: 16),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 6,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            coffee.coffeeImage ?? "",
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                        ),

                        const SizedBox(width: 16),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                coffee.coffeeName,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                coffee.coffeeDesc,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "\$${coffee.coffeePrice}",
                                style: const TextStyle(
                                  color: Colors.orange,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),

                        BlocBuilder<CartBloc,CartState>(
                          builder: (context, state) {
                            return Container(
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: InkWell(
                                  onTap: () {
                                    context.read<CartBloc>().add(
                                        AddToCart(coffee));
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text("${coffee.coffeeName} Added to the cart"),
                                          duration: Duration(seconds: 1),
                                        ));
                                  },
                                  child: Icon(Icons.add)),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
