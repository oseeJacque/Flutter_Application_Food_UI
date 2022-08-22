import 'dart:math';

import 'package:flutter/material.dart';
import 'package:food_delivery_ui_challenge/google_icons/consts.dart';
import 'package:food_delivery_ui_challenge/google_icons/flutter_icons.dart';
import 'package:food_delivery_ui_challenge/models/TextStyler.dart';
import 'package:food_delivery_ui_challenge/models/foodModel.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:food_delivery_ui_challenge/src/widgets/PageDetail.dart';
import 'package:food_delivery_ui_challenge/src/widgets/appClipper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<FoodModel> foodList = FoodModel.list;
  PageController pagecontroller = PageController(viewportFraction: .8);
  double paddingLeft=0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 60),
            child: _buildRightSection(),
          ),

          //Section de droite 
          Container(
            color: AppColors.greenColor,
            height: MediaQuery.of(context).size.height,
            width: 60,
            padding: const EdgeInsets.only(top: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  margin: const EdgeInsets.only(bottom: 25.0),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      image: DecorationImage(
                          image: ExactAssetImage("assets/profile.jpg"), fit: BoxFit.cover,)),
                ),
                Container(
                  width: 40,
                  height: 40,
                  margin: const EdgeInsets.only(top: 15.0,bottom: 20.0),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      color: Colors.white),
                  child: const Center(
                    child: Icon(FlutterIcons.menu),
                  ),
                ),
              ],
            ),
          ),

          //La barre verticale (Le menu à l'interieur de la section de droite)
          Positioned(
            bottom: 100.0,
            child: Transform.rotate(
              angle: -pi / 2,
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _buildMenu("Vegetable",0),
                      _buildMenu("Chicken",1),
                      _buildMenu("Beef",2),
                      _buildMenu("Thai",3)
                    ],
                  ),
                  AnimatedContainer(
                    width: 150,
                    height: 70,
                    duration: const Duration(milliseconds: 250),
                    margin:  EdgeInsets.only(left: paddingLeft),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.bottomCenter, 
                          child: ClipPath(
                            clipper: AppClipper(),
                            child: Container(
                              width: 150, 
                              height: 60, 
                              color: AppColors.greenColor,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Transform.rotate(
                            angle: pi / 2,
                            child: const Padding(
                              padding: EdgeInsets.only(right: 30.0),
                              child: Icon(
                                FlutterIcons.arrow,
                                size: 16.0,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }

  Widget _buildMenu(String menu,int index) {
    return GestureDetector(
      onTap: (){
        setState(() {
          paddingLeft=index*150;
        });
      },
      child: Container(
        width: 150,
        padding: const EdgeInsets.only(top: 16.0),
        child: Center(
          child: TextStyler(
            menu,
            fonSize: 18.0,
          ),
        ),
      ),
    );
  }

//Section de droite
  Widget _buildRightSection() {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0),
      child: Column(children: <Widget>[
        _customApp(),
        Expanded(
            child: ListView(
          children: [
            Container(
              height: 300,
              child: PageView.builder(
                  physics: const ClampingScrollPhysics(),
                  itemCount: foodList.length,
                  controller: pagecontroller,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_)=> DetailPage(food: foodList[index])));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 40.0),
                        child: Stack(children: [
                          Container(
                            padding: const EdgeInsets.all(20.0),
                            margin: const EdgeInsets.only(
                                top: 40, bottom: 10, right: 40),
                            decoration: BoxDecoration(
                                color: AppColors.greenColor,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(32.0))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Expanded(child: SizedBox()),
                                Row(
                                  children: [
                                    RatingBar.builder(
                                      initialRating: 3,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemSize: 16,
                                      itemPadding: const EdgeInsets.symmetric(
                                          horizontal: 1.0),
                                      itemBuilder: (context, _) => const Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                      ),
                                      onRatingUpdate: (rating) {
                                        print(rating);
                                      },
                                    ),
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    TextStyler(
                                      "(120 Reviews)",
                                      fonSize: 12.0,
                                    )
                                  ],
                                ),
                                TextStyler(
                                  foodList[index].name,
                                  fontWeight: FontWeight.bold,
                                  fonSize: 28.0,
                                )
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Transform.rotate(
                              angle: pi / 6,
                              child: Hero(
                                tag: "image${foodList[index].imgPath}",
                                 child: Image(
                                image: AssetImage(foodList[index].imgPath),
                                width: 200,
                              ),)
                              
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 30,
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.redColor,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 10.0),
                                child: TextStyler(
                                  "\$ ${foodList[index].price.toInt()}",
                                  fonSize: 15.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ]),
                      ),
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: TextStyler(
                "Popular",
                fontWeight: FontWeight.bold,
                fonSize: 32.0,
              ),
            ),
            _buildPopularList()
          ],
        ))
      ]),
    );
  }

//Liste de foods horizontale
  ListView _buildPopularList() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: foodList.length,
        scrollDirection: Axis.vertical,
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.only(left: 40.0, bottom: 16.0, top: 20.0),
        itemBuilder: ((context, index) {
          return Container(
            padding: const EdgeInsets.all(16.0),
            margin: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(.2),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12.0),
                    bottomLeft: Radius.circular(12.0))),
            child: Row(
              children: [
                Image(
                  image: AssetImage(
                    foodList[index].imgPath,
                  ),
                  width: 100,
                ),
                const SizedBox(
                  width: 16.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextStyler(
                      foodList[index].name,
                      fonSize: 20.0,
                    ),
                    Row(
                      children: [
                        TextStyler(
                          "\$${foodList[index].price.toInt()}",
                          fontWeight: FontWeight.bold,
                          fonSize: 20.0,
                          color: AppColors.redColor,
                        ),
                        const SizedBox(
                          width: 16.0,
                        ),
                        TextStyler(
                          "${foodList[index].weight.toInt()}gm weight",
                          fonSize: 20.0,
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          );
        }));
  }

//l'entête avec la barre de recherche
  Widget _customApp() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: EdgeInsets.only(left: 5.0, right: 5.0),
      child: Row(
        children: [
          RichText(
              text: TextSpan(
                  text: "Hello,\n",
                  style: const TextStyle(color: Colors.black),
                  children: [
                TextSpan(
                    text: "Shailee Weedly",
                    style: TextStyle(
                        color: AppColors.greenColor,
                        fontWeight: FontWeight.bold,
                        height: 1.5)),
              ])),
          const SizedBox(
            width: 16.0,
          ),
          Expanded(
              child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
                color: AppColors.greenLightColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(12),
                )),
            child: Row(
              children: const [
                Expanded(
                    child: TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: "search"),
                )),
                Icon(FlutterIcons.search)
              ],
            ),
          )),
          const SizedBox(
            width: 16.0,
          ),
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(12.0))),
            child: const Center(
              child: Icon(FlutterIcons.shop),
            ),
          )
        ],
      ),
    );
  }
}
