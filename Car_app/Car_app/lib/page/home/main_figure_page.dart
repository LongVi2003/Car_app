import 'package:flutter/material.dart';
import 'package:food_app/controller/figure_controller.dart';
import 'package:food_app/controller/popular_product_controller.dart';
import 'package:food_app/controller/recommended_product_controller.dart';
import 'package:food_app/page/home/figure_page_body.dart';
import 'package:food_app/routes/route_helper.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/dimension.dart';
import 'package:food_app/widget/big_text.dart';
import 'package:food_app/widget/small_text.dart';
import 'package:get/get.dart';

class MainFigurePage extends StatefulWidget {
  const MainFigurePage({super.key});

  @override
  State<MainFigurePage> createState() => _MainFigurePageState();
}

class _MainFigurePageState extends State<MainFigurePage> {
  Future<void> _loadResource() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
    await Get.find<FigureController>().getAllFoodList();
  }

  @override
  Widget build(BuildContext context) {
    //height of screen
    print("current height: " + MediaQuery.of(context).size.height.toString());
    //witdh
    print("current width: " + MediaQuery.of(context).size.width.toString());

    return RefreshIndicator(
        child: Column(
          children: [
            Container(
              child: Container(
                  margin: EdgeInsets.only(
                      top: Dimensions.height45, bottom: Dimensions.height15),
                  padding: EdgeInsets.only(
                      left: Dimensions.width15, right: Dimensions.width15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          BigText(
                            text: 'Việt Nam',
                            color: AppColors.mainColor,
                          ),
                          Row(
                            children: [
                              SmallText(
                                text: 'Thái Nguyên',
                                color: Colors.black54,
                              ),
                              Icon(Icons.arrow_drop_down_rounded),
                            ],
                          )
                        ],
                      ),
                      Center(
                        child: InkWell(
                          onTap: () {
                            print("you have just clicked on search icon");
                            Get.toNamed(RouteHelper.getSearchProduct());
                          },
                          child: Container(
                            width: Dimensions.width45,
                            height: Dimensions.height45,
                            child: Icon(
                              Icons.search,
                              color: Colors.white,
                              size: Dimensions.iconSize24,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: AppColors.mainColor,
                            ),
                          ),
                        ),
                      )
                    ],
                  )),
            ),
            //showing the body
            Expanded(
              child: SingleChildScrollView(
                child: FigurePageBody(),
              ),
            ),
          ],
        ),
        onRefresh: _loadResource);
  }
}
