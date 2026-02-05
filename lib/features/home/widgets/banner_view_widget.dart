import 'package:carousel_slider/carousel_slider.dart';
import 'package:demandium/feature/home/controller/banner_controller.dart';
import 'package:demandium/feature/splash/controller/splash_controller.dart';
import 'package:demandium/utils/dimensions.dart';
import 'package:demandium/utils/styles.dart';
import 'package:demandium/common/widgets/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class BannerViewWidget extends StatelessWidget {
  const BannerViewWidget({super.key});

  @override
  Widget build(BuildContext context) {

    return GetBuilder<BannerController>(builder: (bannerController) {
      return (bannerController.banners != null && bannerController.banners!.isEmpty) ? const SizedBox() : Container(
        width: MediaQuery.of(context).size.width,
        height: GetPlatform.isDesktop ? 500 : 205,
        padding: const EdgeInsets.only(top: Dimensions.paddingSizeDefault),
        child: bannerController.banners != null ? Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CarouselSlider.builder(
              options: CarouselOptions(
                aspectRatio: 2.5,
                enlargeFactor: 0.3,
                autoPlay: true,
                enlargeCenterPage: true,
                disableCenter: true,
                autoPlayInterval: const Duration(seconds: 7),
                onPageChanged: (index, reason) {
                  bannerController.setCurrentIndex(index, true);
                },
              ),
              itemCount: bannerController.banners!.isEmpty ? 1 : bannerController.banners!.length,
              itemBuilder: (context, index, _) {
                String? bannerImage = bannerController.banners![index].bannerImageFullPath;
                String? resourceType = bannerController.banners![index].resourceType ?? '';
                String? resourceId = bannerController.banners![index].resourceId ?? '';
                String? redirectLink = bannerController.banners![index].redirectLink ?? '';
                String? categoryName = bannerController.banners![index].category?.name ?? '';
                
                return InkWell(
                  onTap: () {
                    bannerController.navigateFromBanner(
                      resourceType,
                      resourceId,
                      redirectLink,
                      resourceId,
                      categoryName: categoryName,
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                      boxShadow: [BoxShadow(color: Colors.grey.withValues(alpha: 0.1), spreadRadius: 1, blurRadius: 2, offset: const Offset(0, 1))],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                      child: GetBuilder<SplashController>(builder: (splashController) {
                        return CustomImage(
                          image: bannerImage ?? '',
                          fit: BoxFit.cover,
                        );
                      },
                      ),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: Dimensions.paddingSizeExtraSmall),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: bannerController.banners!.map((bnr) {
                int index = bannerController.banners!.indexOf(bnr);
                int totalBanner = bannerController.banners!.length;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: index == bannerController.currentIndex ? Container(
                    decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                    child: Text('${(index) + 1}/$totalBanner', style: robotoRegular.copyWith(color: Colors.white, fontSize: 12)),
                  ) : Container(
                    height: 4.18, width: 5.57,
                    decoration: BoxDecoration(color: Theme.of(context).primaryColor.withValues(alpha: 0.5), borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
                  ),
                );
              }).toList(),
            ),
          ],
        ) : Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
            child: Shimmer(
              child: Container(decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                color: Theme.of(context).shadowColor,
              )),
            ),
          ),
        ),
      );
    });
  }

}
