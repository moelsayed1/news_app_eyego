import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:news_app_eyego/Core/helpers/spacing.dart';
import 'package:news_app_eyego/Features/home/data/models/article_model.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsTile extends StatelessWidget {
  const NewsTile({super.key, required this.articleModel});

  final ArticleModel articleModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: CachedNetworkImage(
              height: 200.h,
              width: double.infinity,
              fit: BoxFit.cover,
              imageUrl: articleModel.image ?? 'Unable to load image',
              placeholder: (context, url) =>
                  Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          verticalSpace(12),
          Text(
            articleModel.title,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          verticalSpace(6),
          Text(
            articleModel.subTitle ?? 'No description',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16.sp,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
      onTap: () async {
        try {
          await launch(
            '${Uri.parse(articleModel.url!)}',
            forceSafariVC: true,
          );
        } on Exception catch (e) {
          GetSnackBar(
            title: "Error",
            message: "Unable to open the link ${e.toString()}",
            duration: const Duration(seconds: 2),
            backgroundColor: Colors.red,
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      },
    );
  }
}
