import 'package:flutter/material.dart';
import 'package:rick_and_morty/features/characters/db/models/character_model.dart';

class DetailsScreen extends StatelessWidget {
  final CharacterModel selectedCharacter;
  const DetailsScreen({
    super.key,
    required this.selectedCharacter,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          buildSliverAppaBar(context),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      characterInfo(
                        context: context,
                        value: selectedCharacter.id.toString(),
                        title: 'ID: ',
                      ),
                      const Divider(),
                      characterInfo(
                        context: context,
                        value: selectedCharacter.gender,
                        title: 'Gender: ',
                      ),
                      const Divider(),
                      characterInfo(
                        context: context,
                        value: selectedCharacter.species,
                        title: 'Species: ',
                      ),
                      const Divider(),
                      characterInfo(
                        context: context,
                        value: selectedCharacter.status,
                        title: 'Status: ',
                      ),
                      const Divider(),
                      characterInfo(
                        context: context,
                        value: selectedCharacter.firstSeenEpisode!,
                        title: 'First Seen in: ',
                      ),
                      const Divider(),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildSliverAppaBar(BuildContext context) {
    return SliverAppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back,
        ),
      ),
      expandedHeight: 450,
      pinned: true,
      stretch: true,
      centerTitle: true,
      floating: true,
      snap: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          selectedCharacter.name,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        background: Hero(
          tag: selectedCharacter.id,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                selectedCharacter.image,
                fit: BoxFit.cover,
              ),
              Container(
                height: 80,
                color: const Color.fromARGB(150, 39, 43, 51),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget characterInfo({
    required String title,
    required String value,
    required BuildContext context,
  }) {
    return RichText(
      maxLines: 3,
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          TextSpan(
            text: value,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
    );
  }
}
