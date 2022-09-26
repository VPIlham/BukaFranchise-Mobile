import 'package:bukafranchise/models/brand_item.dart';
import 'package:bukafranchise/pages/buyer/widget/custom_radio_button.dart';
import 'package:bukafranchise/theme/style.dart';
import 'package:bukafranchise/utils/assets.dart';
import 'package:bukafranchise/utils/constant.dart';
import 'package:bukafranchise/utils/helpers.dart';
import 'package:bukafranchise/widgets/custom_app_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DetailBrandItemPage extends StatefulWidget {
  const DetailBrandItemPage({super.key, required this.item});

  final BrandItem item;

  @override
  State<DetailBrandItemPage> createState() => _DetailBrandItemPageState();
}

class _DetailBrandItemPageState extends State<DetailBrandItemPage> {
  final List<Map> paymentTypes = [
    {"label": "Uang Muka", "value": "dp"},
    {"label": "Lunas", "value": "cash"},
    {"label": "Cicilan", "value": "cicilan"},
  ];

  final List<Map> banks = [
    {"id": 1, "label": "BNI", "value": "bni", "image": Assets.logoBNI},
    {"id": 2, "label": "BRI", "value": "bri", "image": Assets.logoBRI},
    {"id": 3, "label": "BCA", "value": "bca", "image": Assets.logoBCA},
  ];

  String? _paymentType;
  int? _currentBankId;

  @override
  Widget build(BuildContext context) {
    print("ITEM DETAIL = ${widget.item.upload?.path}");
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: DefaultAppBar.build(
        context: context,
        title: const Text(''),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CardBrandItemWidget(
                image: "$URL_WEB${widget.item.upload?.path}",
                name: "${widget.item.name}",
                price:
                    "Rp. ${kmbGenerator(int.parse(widget.item.price ?? "0"))}",
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                "Deskripsi",
                style: labelTextStyle,
              ),
              const SizedBox(
                height: 16,
              ),
              ExpandableText(
                "${widget.item.description}",
                style: regularTextStyle,
                expandText: "Selengkapnya",
                maxLines: 5,
                textAlign: TextAlign.justify,
                collapseText: "Lebih sedikit",
                linkColor: mainColor,
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                "Pembayaran",
                style: labelTextStyle,
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: inputColorGray,
                ),
                child: DropdownButtonFormField(
                  isExpanded: true,
                  hint: const Text("Jenis Pembayaran"),
                  value: _paymentType,
                  decoration: const InputDecoration(
                    enabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.all(18),
                  ),
                  validator: (value) {
                    if (value == null || value == '') {
                      return 'Role wajib diisi!';
                    }
                    return null;
                  },
                  items: paymentTypes.map((type) {
                    return DropdownMenuItem(
                      value: type["value"],
                      child: Text(type["label"]),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _paymentType = value.toString();
                      });
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              ListView.builder(
                itemCount: banks.length,
                shrinkWrap: true,
                primary: false,
                itemBuilder: (BuildContext context, int index) {
                  return CustomRadioButton(
                    value: banks[index]["id"],
                    groupValue: _currentBankId ?? 0,
                    onChanged: (value) {
                      setState(() {
                        _currentBankId = banks[index]["id"];
                      });
                    },
                    additionalLeading: Container(
                      width: 60,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF8F92A1).withOpacity(0.03),
                            blurRadius: 3,
                            spreadRadius: 1,
                            offset: const Offset(0, 0),
                          ),
                        ],
                        color: Colors.white,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.asset(
                          "${banks[index]["image"]}",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Text(banks[index]["label"]),
                  );
                },
              ),
              const SizedBox(
                height: 24,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CardBrandItemWidget extends StatelessWidget {
  final String image;
  final String name;
  final String price;

  const CardBrandItemWidget({
    Key? key,
    required this.image,
    required this.name,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: inputColorGray,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                child: CachedNetworkImage(
                  placeholder: (context, url) => Image.asset(
                    Assets.imgBrandPlaceholder,
                    height: 130,
                    width: 117,
                    fit: BoxFit.cover,
                  ),
                  imageUrl: image,
                  imageBuilder: (context, imageProvider) => Container(
                    height: 130,
                    width: 117,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover),
                    ),
                  ),
                  errorWidget: (context, url, error) => Image.asset(
                    Assets.imgBrandPlaceholder,
                    height: 130,
                    width: 117,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width /
                      3, //this is the total width of your screen
                  child: Text(
                    name,
                    maxLines: 2,
                    style: labelTextStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width /
                      3, //this is the total width of your screen
                  child: Text(
                    price,
                    maxLines: 2,
                    style: regularTextStyle.copyWith(fontSize: 15),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
