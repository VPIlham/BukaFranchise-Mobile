import 'package:bukafranchise/bloc/transaction/transaction_cubit.dart';
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
import 'package:flutter_bloc/flutter_bloc.dart';
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
    {"id": 1, "label": "VA BNI", "value": "bni", "image": Assets.logoBNI},
    {"id": 2, "label": "VA BRI", "value": "bri", "image": Assets.logoBRI},
    {"id": 3, "label": "VA BCA", "value": "bca", "image": Assets.logoBCA},
  ];

  String? _paymentType, _currentBankValue;
  int? _currentBankId;

  num priceCalculated = 0;

  void onChangePaymentType({dynamic value, int? price = 0}) {
    print("Bank VALUE = $_currentBankValue");
    print("MY CLICK = $value");
    switch (value) {
      case "dp":
        setState(() {
          priceCalculated = (price! * 0.25);
          _paymentType = value;
        });
        print("Value@@@ = ${priceCalculated.toInt()}");
        break;
      case "cicilan":
        print("Value@@@ = ${priceCalculated.toInt()}");
        setState(() {
          priceCalculated = price! / 36;
          _paymentType = value;
        });
        break;
      case "cash":
        print("Value@@@ = $price");
        setState(() {
          _paymentType = value;
          priceCalculated = price!;
        });
        break;
      default:
    }
  }

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
                  items: paymentTypes.map((type) {
                    return DropdownMenuItem(
                      value: type["value"],
                      child: Text(type["label"]),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      onChangePaymentType(
                          price: int.parse(widget.item.price ?? "0"),
                          value: value);
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
                        _currentBankValue = banks[index]["value"];
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
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    title: Text(banks[index]["label"]),
                  );
                },
              ),
              const SizedBox(
                height: 24,
              ),
              BottomSheetDetailBrandItem(
                isFilled: _currentBankId != null && _paymentType != null
                    ? true
                    : false,
                paymentType: _paymentType.toString(),
                price: int.parse(widget.item.price!),
                fee: 50000,
                totalPrice: priceCalculated,
                itemId: widget.item.id,
              ),
              const SizedBox(
                height: 24,
              ),
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

class BottomSheetDetailBrandItem extends StatelessWidget {
  const BottomSheetDetailBrandItem(
      {Key? key,
      this.itemId,
      this.paymentType,
      this.price,
      this.fee,
      this.totalPrice,
      this.isFilled})
      : super(key: key);

  final String? paymentType;
  final int? price, fee;
  final num? totalPrice;
  final bool? isFilled;
  final int? itemId;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Harga",
                  style: regularTextStyle.copyWith(fontSize: 12),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      formatRupiah.format(price),
                      style: paymentType == 'cicilan'
                          ? labelTextStyle.copyWith(
                              decoration: TextDecoration.lineThrough)
                          : paymentType == 'dp'
                              ? labelTextStyle.copyWith(
                                  decoration: TextDecoration.lineThrough)
                              : labelTextStyle,
                    ),
                    paymentType == 'cicilan'
                        ? Text(
                            'Cicilan 36bln : ${formatRupiah.format(totalPrice)}/bln',
                            style: regularTextStyle.copyWith(
                              color: Colors.green,
                              fontSize: 10,
                            ),
                          )
                        : paymentType == 'dp'
                            ? Text(
                                'Uang Muka 25% : ${formatRupiah.format(totalPrice)}',
                                style: regularTextStyle.copyWith(
                                  color: Colors.green,
                                  fontSize: 10,
                                ),
                              )
                            : const SizedBox()
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Biaya Sistem",
                  style: regularTextStyle.copyWith(fontSize: 12),
                ),
                Text(
                  formatRupiah.format(fee),
                  style: labelTextStyle,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Harga",
                  style: regularTextStyle.copyWith(fontSize: 12),
                ),
                Text(
                  totalPrice == 0
                      ? formatRupiah.format(totalPrice)
                      : formatRupiah.format(totalPrice! + fee!),
                  style: labelTextStyle,
                )
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 24,
        ),
        BlocConsumer<TransactionCubit, TransactionState>(
          listener: (context, state) {},
          builder: (context, state) {
            print('STATE TRANSACTION : $state');
            return InkWell(
              onTap: isFilled == false
                  ? null
                  : isFilled == true &&
                          state.transactionStatus ==
                              TransactionStatus.submitting
                      ? null
                      : () async {
                          final total = totalPrice! + fee!;
                          final data = {
                            "userId": await getUserId(),
                            "itemId": itemId,
                            "price": total,
                            "fee": 50000,
                            "statusPayment": paymentType,
                            "paymentMethod": "bank_transfer",
                            "paymentChannel": "bni"
                          };
                          // ignore: use_build_context_synchronously
                          context
                              .read<TransactionCubit>()
                              .createTransaction(data: data);
                          print('data terkirim');
                        },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: isFilled == true ? mainColor : textDateGray,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                    child: Text(
                  state.transactionStatus == TransactionStatus.submitting
                      ? 'Loading'
                      : 'Bayar Sekarang',
                  style: labelTextStyle.copyWith(
                      color: Colors.white, letterSpacing: 1, fontSize: 14),
                )),
              ),
            );
          },
        ),
      ],
    );
  }
}
