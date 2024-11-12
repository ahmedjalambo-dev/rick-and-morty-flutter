import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty/db/models/character_model.dart';

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
              child: Hero(
                tag: characterModel.id,
                child: CircleAvatar(
                  radius: 65,
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: characterModel.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/details',
                    arguments: characterModel);
                log(characterModel.name.toString());
              },
              child: Column(
                children: [
                  Text(
                    characterModel.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                    textAlign: TextAlign.center,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 8,
                        width: 8,
                        decoration: BoxDecoration(
                          color: characterModel.status == 'Alive'
                              ? Colors.green
                              : characterModel.status == 'Dead'
                                  ? Colors.red
                                  : Colors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        characterModel.status,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(255, 177, 178, 180),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ],
              ),
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
