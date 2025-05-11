import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty/db/models/character_model.dart';

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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      characterInfo(
                        context: context,
                        value: selectedCharacter.id.toString(),
                        title: 'ID: ',
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
                        value: selectedCharacter.gender,
                        title: 'Gender: ',
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
                        value: "\n${selectedCharacter.lastKnownLocation}",
                        title: 'Last Known Location: ',
                      ),
                      const Divider(),
                      characterInfo(
                        context: context,
                        value: "\n${selectedCharacter.firstSeenEpisode}",
                        title: 'First Seen in: ',
                      ),
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
      expandedHeight: 400,
      pinned: true,
      stretch: true,
      centerTitle: true,
      floating: true,
      snap: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: const BoxDecoration(
            color: Color(0xff272b33),
          ),
          child: Text(
            selectedCharacter.name,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
            textAlign: TextAlign.center,
          ),
        ),
        background: Hero(
          tag: selectedCharacter.id,
          child: CachedNetworkImage(
            imageUrl: selectedCharacter.image,
            fit: BoxFit.cover,
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
      // textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: 18,
                  color: const Color.fromARGB(255, 177, 178, 180),
                ),
          ),
          // const TextSpan(text: '\n'),
          TextSpan(
            text: value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: 24,
                ),
          ),
        ],
      ),
    );
  }
}
