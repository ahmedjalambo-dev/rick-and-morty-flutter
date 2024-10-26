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

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Rick and Morty',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w900,
          ),
        ),
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
      }

      // Call the _buildCharactersList and pass characters and loading status
      return _buildCharactersList(characters, isLoading);
    });
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
        if (isLoading)
          Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: LoadingWidget(
                  jsonPath: 'rick_drinking',
                  textColor: Colors.white,
                ),
              )),
      ],
    );
  }
}
