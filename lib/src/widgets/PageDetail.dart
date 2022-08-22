import 'package:flutter/material.dart';
import 'package:food_delivery_ui_challenge/google_icons/consts.dart';
import 'package:food_delivery_ui_challenge/google_icons/flutter_icons.dart';
import 'package:food_delivery_ui_challenge/models/TextStyler.dart';
import 'package:food_delivery_ui_challenge/models/foodModel.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key, required this.food}) : super(key: key);
  final FoodModel food;
  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int compteur = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greenColor,
      body: Column(
        children: [
          const SizedBox(
            height: 30.0,
          ),
          _custumAppBar(),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 300,
            child: Stack(
              children: [
                const Align(
                  alignment: Alignment.center,
                  child:Image(image: AssetImage("assets/bg.png")), 
                ),
                
                Align(
                    alignment: Alignment.center,
                    child: Hero(
                        tag: "image${widget.food.imgPath}",
                        child: Image(image: AssetImage(widget.food.imgPath))))
              ],
            ),
          ),
          Expanded(
              child: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40))),
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextStyler(
                  widget.food.name,
                  fonSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Row(
                  children: [
                    TextStyler(
                      "\$${widget.food.price.toInt()}",
                      fonSize: 30.0,
                      color: AppColors.redColor,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(
                      width: 35.0,
                    ),
                    _buildCounter(),
                  ],
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildInfos("Weight", " ${widget.food.weight.toInt()}gm"),
                    _buildInfos(
                        "Calories", "${widget.food.calory.toInt()} ccal"),
                    _buildInfos("Protein", "${widget.food.protein}gm")
                  ],
                ),
                const SizedBox(
                  height: 16.0,
                ),
                TextStyler(
                  "Items",
                  fonSize: 25.0,
                  
                  fontWeight: FontWeight.bold,
                  align: TextAlign.center,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                TextStyler(widget.food.item,fonSize: 20.0,),
                const Expanded(child: SizedBox()),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(AppColors.greenColor),
                            padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(vertical: 25.0),
                            ),
                            shape: MaterialStateProperty.all(
                                const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(18.0))))),
                        child: TextStyler(
                          "Add to Cart",
                          fonSize: 18.0,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ))
        ],
      ),
    );
  }

  Widget _buildInfos(String title, String val) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextStyler(
          title,
          fonSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
        TextStyler(
          val,
          fonSize: 16.0,
          color: AppColors.redColor,
        )
      ],
    );
  }

  Widget _custumAppBar() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: _buttonRadius(FlutterIcons.left),
          ),
          GestureDetector(
            onTap: () {},
            child: _buttonRadius(FlutterIcons.shop),
          )
        ],
      ),
    );
  }

  Widget _buttonRadius(IconData btn) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
      child: Icon(
        btn,
        size: 20.0,
      ),
    );
  }

  Widget _buildCounter() {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.greenColor,
          borderRadius: const BorderRadius.all(Radius.circular(12.0))),
      child: Row(
        children: [
          IconButton(
              onPressed: () {
                setState(() {
                  if (compteur > 1) {
                    compteur -= 1;
                  } else {
                    compteur = 1;
                  }
                });
              },
              icon: const Icon(
                Icons.remove,
                color: Colors.black,
              )),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            child: TextStyler(
              compteur.toString(),
              fonSize: 20.0,
            ),
          ),
          IconButton(
              onPressed: () {
                setState(() {
                  compteur += 1;
                });
              },
              icon: const Icon(
                Icons.add,
                color: Colors.black,
              )),
        ],
      ),
    );
  }
}
