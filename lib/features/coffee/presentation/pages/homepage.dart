import 'package:coffeeshopui/features/coffee/data/models/coffee_types_model.dart';
import 'package:coffeeshopui/features/coffee/presentation/bloc/favorite_bloc/favorite_bloc.dart';
import 'package:coffeeshopui/features/coffee/presentation/bloc/favorite_bloc/favorite_state.dart';
import 'package:coffeeshopui/features/coffee/presentation/pages/profile_page.dart';
import 'package:coffeeshopui/features/coffee/presentation/pages/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/coffee_details_model.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/coffee_tile_row.dart';
import '../widgets/coffee_types.dart';
import 'coffee_details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CoffeeTypesModel> coffeeTypes = [
    CoffeeTypesModel(coffeeType: "Cappuccino", isSelected: true),
    CoffeeTypesModel(coffeeType: "Espresso", isSelected: false),
    CoffeeTypesModel(coffeeType: "Latte", isSelected: false),
    CoffeeTypesModel(coffeeType: "Black", isSelected: false),
    CoffeeTypesModel(coffeeType: "Frappuccino", isSelected: false),
    CoffeeTypesModel(coffeeType: "Americano", isSelected: false),
  ];
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

  final searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    searchController.dispose();
    FocusManager.instance.primaryFocus?.unfocus();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: const Icon(Icons.menu),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
              child: Icon(Icons.person),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                'Find the best coffee for you',
                style: GoogleFonts.bebasNeue(fontSize: 56, color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: TextField(
                focusNode: _focusNode,
                cursorColor: Colors.orange,
                controller: searchController,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchPage()),
                  );
                  FocusManager.instance.primaryFocus?.unfocus();
                },

                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'Find your coffee...',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade600),
                  ),
                  focusedBorder: const OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 20),
            BlocBuilder<FavoriteBloc, FavoriteState>(
              builder: (context, state) {
                return SizedBox(
                  height: 60,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemCount: coffeeTypes.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => context.read<FavoriteBloc>().add(SetSelectedCoffeeTypes(index)),
                        child: CoffeeTypes(
                          coffeeType: coffeeTypes[index].coffeeType,
                          isSelected: state.selectedIndex == index,
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: 10),

            SizedBox(
              height: 280,
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: coffeeDetails.length,
                itemBuilder: (BuildContext context, index) {
                  final coffee = coffeeDetails[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CoffeeDetailsPage(
                                coffeeDetailsModel: CoffeeDetailsModel(
                                  coffeeName: coffee.coffeeName,
                                  coffeePrice: coffee.coffeePrice,
                                  coffeeImage: coffee.coffeeImage,
                                  coffeeDesc: coffee.coffeeDesc,
                                  largePrice: coffee.largePrice,
                                  smallPrice: coffee.smallPrice,
                                  mediumPrice: coffee.mediumPrice,
                                ),
                              ),
                        ),
                      );
                    },

                    child: CoffeeTileRow(coffee: coffee),
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
