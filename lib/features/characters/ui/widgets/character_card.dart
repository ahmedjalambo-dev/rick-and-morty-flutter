import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:rick_and_morty/features/characters/db/models/character_model.dart';

class CharacterCard extends StatelessWidget {
  final CharacterModel characterModel;

  const CharacterCard({
    super.key,
    required this.characterModel,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(65),
              onLongPress: () =>
                  _showZoomedImage(context, characterModel.image),
              onTap: () {
                Navigator.pushNamed(context, '/details',
                    arguments: characterModel);
                log(characterModel.name.toString());
              },
              child: Hero(
                tag: characterModel.id,
                child: CircleAvatar(
                  radius: 65,
                  backgroundImage: NetworkImage(characterModel.image),
                ),
              ),
            ),
            Text(
              characterModel.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _showZoomedImage(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: CircleAvatar(
                radius: 120,
                backgroundImage: NetworkImage(characterModel.image),
              ),
            ),
          ),
        );
      },
    );
  }
}
