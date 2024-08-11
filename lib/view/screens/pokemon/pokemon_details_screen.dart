import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ToDoApp/view-model/utils/app_assets.dart';
import 'package:ToDoApp/view-model/utils/app_colors.dart';

class PokemonDetailsScreen extends StatelessWidget {
  // final PokemonModel pokemon;

  const PokemonDetailsScreen({ super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.babyblue2,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('the pokemon name '),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.sp),
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: 100.h, bottom: 50.h),
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(20.sp)),
              child: SingleChildScrollView(
                padding: EdgeInsets.all(12.sp),
                child: Column(
                  children: [
                    SizedBox(height: 60.h),
                    const Text(
                      'POKEMON NAME',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20.h),
                    const Text(
                      'Height: pokemon height',
                      style: TextStyle(color: AppColors.gray),
                    ),
                    SizedBox(height: 20.h),
                    const Text(
                      'Weight: pokemon weight',
                      style: TextStyle(color: AppColors.gray),
                    ),
                    SizedBox(height: 20.h),
                    const Text(
                      'Types',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20.h),
                    // start creating the pokemon type..
                    SizedBox(
                      height: 40.h,
                      child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                  color: AppColors.orange,
                                  borderRadius: BorderRadius.circular(16.r)),
                              padding: EdgeInsets.all(10.h),
                              child: const Center(child: Text('Type')),
                            );
                          },
                          separatorBuilder: (context, index) =>
                              SizedBox(width: 16.h),
                          // in the itemCount add (pokemon.type.length)
                          itemCount: 4),
                    ),
                    // end of creating pokemon type..
                    SizedBox(
                      height: 20.h,
                    ),
                    const Text(
                      'weaknesses',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20.h),
                    // start creating pokemon weaknesses ..
                    SizedBox(
                      height: 40.h,
                      child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                  color: AppColors.red,
                                  borderRadius: BorderRadius.circular(16.r)),
                              padding: EdgeInsets.all(10.h),
                              child: const Center(child: Text('Weaknesses')),
                            );
                          },
                          separatorBuilder: (context, index) =>
                              SizedBox(width: 16.h),
                          // in the itemCount add (pokemon.weaknesses.length)
                          itemCount: 4),
                    ),
                    // end creating pokemon weaknesses ..
                  ],
                ),
              ),
            ),
            PositionedDirectional(
                top: 10.h,
                start: MediaQuery.of(context).size.width / 5,
                child: Image.asset(
                  AppAssets.splashLogo,
                  width: 200.w,
                  height: 200.h,
                )),
            SizedBox(height: 80.h),
          ],
        ),
      ),
    );
  }
}
