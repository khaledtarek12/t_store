import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/images/t_circular_images.dart';
import 'package:t_store/common/widgets/loading/skeltionizer.dart';
import 'package:t_store/features/personalization/controllers/user_controller.dart';
import 'package:t_store/features/personalization/screens/profile/profile.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/image_strings.dart';

class TUserProfileTile extends StatelessWidget {
  const TUserProfileTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return ListTile(
      leading: Obx(() {
        final networklmage = controller.user.value.profilePicture;
        final image = networklmage.isNotEmpty ? networklmage : TImages.user;

        return controller.imageUploding.value
            ? const TSkeletonEffect(width: 50, height: 50, radius: 50)
            : TCircularImage(
                image: image,
                width: 50,
                height: 50,
                backgroundColor: Colors.red,
                isNetworkImage: networklmage.isNotEmpty,
              );
      }),
      title: Text(controller.user.value.fullName,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .apply(color: TColors.white)),
      subtitle: Text(controller.user.value.email,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .apply(color: TColors.white)),
      trailing: IconButton(
          onPressed: () => Get.to(() => const ProfileScreen()),
          icon: const Icon(Iconsax.edit, color: TColors.white)),
    );
  }
}
