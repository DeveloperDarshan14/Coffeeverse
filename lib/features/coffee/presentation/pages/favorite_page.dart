import 'package:coffeeshopui/core/constants/app_color.dart';
import 'package:coffeeshopui/core/constants/app_constants.dart';
import 'package:coffeeshopui/features/coffee/presentation/bloc/favorite_bloc/favorite_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/favorite_bloc/favorite_state.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorite Page',
          style: TextStyle(color: AppColors.whiteColor),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
      child: BlocBuilder<FavoriteBloc, FavoriteState>(
    builder: (context, state) {
      if (state.favorites.isNotEmpty) {
        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: state.favorites.length,
          itemBuilder: (context, index) {
            final coffee = state.favorites[index];

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
                          coffee.coffeeName ,
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

                  IconButton(
                    icon: const Icon(Icons.favorite, color: Colors.red),
                    onPressed: () {
                      context
                          .read<FavoriteBloc>()
                          .add(ToggleFavoriteEvent(coffee));
                    },
                  ),
                ],
              ),
            );
          },
        );
      }

      /// Empty State UI
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.favorite_border, size: 80, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              "No favorites yet",
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

    );
  }
}
