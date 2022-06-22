import 'package:flutter/material.dart';
import 'custom_text.dart';
import 'package:animetion/utilities/constants.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:animetion/services/networking.dart';

class TopCharactersSwiper extends StatelessWidget {
  const TopCharactersSwiper({
    Key? key,
    required this.topCharacterReference,
    required this.netWorking,
  }) : super(key: key);

  final Future topCharacterReference;
  final Networking netWorking;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return FutureBuilder(
        future: topCharacterReference,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          }
          return Swiper(
            fade: 1,
            autoplay: true,
            duration: 200,
            viewportFraction: 0.35,
            scale: 0.1,
            itemCount: netWorking.topCharactersResponse.length,
            itemBuilder: (context, index) {
              return Card(
                shadowColor: Colors.black,
                elevation: 10,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    border: Border.all(color: Colors.grey, width: 1),
                  ),
                  child: GridTile(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      child: Image.network(
                        netWorking.topCharactersResponse[index]['images']['jpg']
                            ['image_url'],
                        fit: BoxFit.fill,
                      ),
                    ),
                    footer: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: darkModePrimaryColor.withOpacity(0.5),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(15.0),
                          bottomRight: Radius.circular(
                            15.0,
                          ),
                        ),
                      ),
                      child: CustomText(
                        text: netWorking.topCharactersResponse[index]['name'],
                        size: width / 30,
                        color: Colors.white,
                        maxLines: 1,
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        });
  }
}
