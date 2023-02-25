import 'package:flutter/material.dart';
import 'package:vedica_partner/utils/assets.dart';
import 'package:vedica_partner/utils/my_colors.dart';
import 'package:vedica_partner/utils/textthem.dart';

class BankCard extends StatelessWidget {
  final String name;
  final String accountNumber;
  final String ifcode;
  final String bnakUnit;
  const BankCard(
      {super.key,
      required this.name,
      required this.accountNumber,
      required this.ifcode,
      required this.bnakUnit});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      // color: Colors.red,
      height: 300,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            top: 0,
            child: Image.asset(
              ConstentsAssets.visa,
              height: 280,
              width: 350,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 10,
            child: Container(
              height: size.height * 0.2,
              width: size.width * 0.8,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  border:
                      Border.all(color: MyColor.accentWhite.withOpacity(0.5)),
                  borderRadius: BorderRadius.circular(10),
                  color: MyColor.bgcolor,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(2, 4),
                      blurRadius: 12,
                      color: MyColor.accentWhite.withOpacity(0.5),
                    )
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        name,
                        style: Texttheme.subtitle.copyWith(
                            color: MyColor.accentWhite.withOpacity(0.3)),
                      ),
                      Text(
                        "IMPS",
                        style: Texttheme.subtitle
                            .copyWith(color: MyColor.yellowColor),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        bnakUnit,
                        style: Texttheme.bodyStyleTwo.copyWith(
                            color: MyColor.accentWhite.withOpacity(0.3)),
                      ),
                      Text(
                        "IFSCCODE",
                        style: Texttheme.bodyStyleTwo.copyWith(
                            color: MyColor.accentWhite.withOpacity(0.3)),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(accountNumber, style: Texttheme.bodyStyleTwo),
                      Text(ifcode, style: Texttheme.bodyStyleTwo)
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
