import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_depi_final_project/features/home/presentation/pages/AppDrawer.dart';
import '../controller/HomeController.dart';
import '../../../../core/constants/assets_manager.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        // leading: Builder(builder: (context)=> IconButton(onPressed: (){
        //   Scaffold.of(context).openDrawer();
        // },
        //     icon: Icon(Icons.menu))),
      ),
    //  drawer:AppDrawer(),
     // backgroundColor: const Color(0xffF7F8FA),

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.red),
          );
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40),


              /// ===== TOP ICONS ROW =====
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 16),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //      _roundIcon(Icons.menu),
              //     ],
              //   ),
              // ),

              const SizedBox(height: 20),

              Image.asset(AssetsManager.logo, width: 140, height: 140),

              const SizedBox(height: 10),

              const SizedBox(height: 20),

              const Divider(height: 1, thickness: 1),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                child: const Text(
                  "News categories",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                   // color: Colors.black87,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.categories.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: .95,
                  ),
                  itemBuilder: (context, index) {
                    final category = controller.categories[index];

                    return GestureDetector(
                      onTap: () => controller.onCategoryTap(category, index),
                      child: Container(
                        decoration: BoxDecoration(
                      //    color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey[300]!),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            category.imageUrl != null &&
                                    category.imageUrl!.isNotEmpty
                                ? Image.asset(
                                    category.imageUrl!,
                                    width: 45,
                                    height: 45,
                                  )
                                : Text(
                                    category.icon ?? "📰",
                                    style: const TextStyle(fontSize: 32),
                                  ),
                            const SizedBox(height: 8),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                              ),
                              child: Text(
                                category.name,
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        );
      }),

    );
  }

  Widget _roundIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: Colors.grey[700], size: 20),
    );
  }
}
