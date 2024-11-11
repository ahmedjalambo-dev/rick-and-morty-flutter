import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/core/widgets/loading_widget.dart';
import 'package:rick_and_morty/features/characters/cubit/characters_cubit.dart';
import 'package:rick_and_morty/features/characters/db/models/character_model.dart';
import '../widgets/character_card.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  List<CharacterModel>? characters;
  late ScrollController _scrollController;
  bool isSearchClicked = false;
  late TextEditingController _searchTextEditingController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    _searchTextEditingController = TextEditingController();

    // Load the initial set of characters
    BlocProvider.of<CharactersCubit>(context).getCharacters();
  }

  void _onScroll() {
    if (_scrollController.position.atEdge) {
      if (_scrollController.position.pixels != 0) {
        // Fetch the next page of characters when scrolled near the bottom
        BlocProvider.of<CharactersCubit>(context).getCharacters();
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isSearchClicked
            ? Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: _searchTextEditingController,
                  onChanged: (value) {
                    context
                        .read<CharactersCubit>()
                        .searchCharacters(value); // Trigger search on input
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.fromLTRB(20, 10, 16, 12),
                    fillColor: Colors.grey.shade200,
                    hintText: 'Search',
                    hintStyle: TextStyle(
                      color: Colors.grey.shade600,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              )
            : const Text(
                'Rick and Morty',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                ),
              ),
        actions: [
          IconButton(
            onPressed: () => setState(() {
              isSearchClicked = !isSearchClicked;
              if (!isSearchClicked) {
                // _searchTextEditingController.clear();
                context.read<CharactersCubit>().getCharacters(
                    characterName: ''); // Load data without search term
              }
            }),
            icon: Icon(isSearchClicked ? Icons.close : Icons.search),
          ),
        ],
      ),
      body: _buildBlocBuilderCharacters(),
    );
  }

  Widget _buildBlocBuilderCharacters() {
    return BlocBuilder<CharactersCubit, CharactersState>(
      builder: (context, state) {
        // Show loading indicator for the first fetch
        if (state is CharactersLoading && state.isFirstFetch) {
          return const LoadingWidget(jsonPath: 'morty_wigo');
        }

        // Initialize the characters list and loading flag
        List<CharacterModel> characters = [];
        bool isLoading = false;

        if (state is CharactersLoading) {
          characters = state.oldCharacters;
          isLoading = true;
        } else if (state is CharactersSuccess) {
          characters = state.characters;
        } else {
          const LoadingWidget(
            jsonPath: 'morty_crying',
          );
        }

        // Call the _buildCharactersList and pass characters and loading status
        return _buildCharactersList(characters, isLoading);
      },
    );
  }

  Widget _buildCharactersList(List<CharacterModel> characters, bool isLoading) {
    return Stack(
      children: [
        GridView.builder(
          controller: _scrollController, // Attach the scroll controller
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10, // Added spacing between rows
            childAspectRatio: 0.8, // Adjusted aspect ratio for better layout
          ),
          itemCount: characters.length, // No need for an extra item here
          padding: const EdgeInsets.all(10),
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemBuilder: (context, index) {
            return CharacterCard(characterModel: characters[index]);
          },
        ),
        // Show loading overlay when isLoading is true
        (isLoading)
            ? Container(
                color: Colors.black.withOpacity(0.5),
                child: const Center(
                  child: LoadingWidget(
                    jsonPath: 'rick_drinking',
                  ),
                ),
              )
            : Container()
      ],
    );
  }
}
