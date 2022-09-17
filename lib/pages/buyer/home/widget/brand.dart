import 'package:bukafranchise/theme/style.dart';
import 'package:flutter/material.dart';

class BrandWidget extends StatefulWidget {
  const BrandWidget({super.key});

  @override
  State<BrandWidget> createState() => _BrandWidgetState();
}

class _BrandWidgetState extends State<BrandWidget> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final double itemHeight = (size.height - 270) / 2;
    final double itemWidth = size.width / 2;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Brand Partner',
          style: titleTextStyle.copyWith(letterSpacing: 1),
        ),
        SizedBox(
          height: 225,
          child: Expanded(
            child: GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              childAspectRatio: (itemWidth / itemHeight),
              children: List.generate(7, growable: false, (index) {
                return Row(
                  children: [
                    Expanded(
                      child: Container(
                        width: 90,
                        height: 110,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 15, left: 15, right: 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(
                                    'https://source.unsplash.com/random/200x200'),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Geprek Bensu asdasd asdasda asss',
                                maxLines: 2,
                                style: regularTextStyle.copyWith(
                                  fontSize: 8,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}
