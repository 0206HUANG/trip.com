import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/destinations_provider.dart';
import '../widgets/destination_card.dart';
import 'destination_detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Favorites'),
        automaticallyImplyLeading: false,
      ),
      body: Consumer<DestinationsProvider>(
        builder: (context, destinationsProvider, child) {
          final favoriteDestinations = destinationsProvider.favoriteDestinations;

          if (favoriteDestinations.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 80,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No Favorites Yet',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Start exploring and add destinations to your favorites!',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[500],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: favoriteDestinations.length,
            itemBuilder: (context, index) {
              final destination = favoriteDestinations[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: DestinationCard(
                  destination: destination,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DestinationDetailScreen(
                          destination: destination,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
} 