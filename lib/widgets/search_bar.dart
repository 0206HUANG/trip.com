import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/destinations_provider.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({super.key});

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DestinationsProvider>(
      builder: (context, provider, child) {
        return TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search destinations...',
            prefixIcon: const Icon(Icons.search),
            suffixIcon: provider.searchQuery.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                      provider.clearSearch();
                    },
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            filled: true,
            fillColor: Theme.of(context).cardColor,
          ),
          onChanged: (value) {
            provider.updateSearchQuery(value);
          },
        );
      },
    );
  }
} 