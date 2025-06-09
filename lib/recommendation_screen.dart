import 'package:flutter/material.dart';

import 'JSON/users.dart';
import 'detail_screen.dart';

class RecommendationScreen extends StatelessWidget {
  final Users? user;

  final List<Map<String, dynamic>> recommendations = [
    {"title": "Nutrition", "image": "assets/nutrition.jpg"},
    {"title": "Sports", "image": "assets/sports.jpg"},
    {"title": "Smoking", "image": "assets/smoking.jpg"},
    {"title": "Water", "image": "assets/water.jpg"},
  ];

  final List<String> recommendationsDes = [
    "Across DR Levels: Optimal and Harmful Foods.\n"
        "This article is tailored to the five stages of diabetic retinopathy (DR): No DR, Mild, Moderate, Severe, and Proliferative DR. "
        "It delves into dietary recommendations, the impact of various nutrients, and the rationale behind these guidelines. Nutrition for Diabetic Patients Across DR Levels: Optimal and Harmful Foods"
        "Introduction"
        "Diabetes mellitus, a chronic metabolic disorder characterized by hyperglycemia, can lead to various complications, one of the most significant being diabetic retinopathy (DR). DR is a progressive eye disease resulting from damage to the retinal blood vessels due to prolonged high blood sugar levels. Nutrition plays a pivotal role in managing diabetes and its complications."
        "Tailoring dietary choices according to the severity of DR can aid in glycemic control, reduce oxidative stress, and potentially slow the progression of retinal damage."
        "\n\n"
        "1. No DR (No Diabetic Retinopathy)\n\n"
        "Recommended Foods:\n"
        " •	Whole Grains: Brown rice, quinoa, and oats provide \n\t\t\t\tcomplex carbohydrates that help in maintaining \n\t\t\t\tsteady blood glucose levels.\n"
        " •	Lean Proteins: Skinless poultry, tofu, and legumes \n\t\t\t\tsupport muscle maintenance without excessive \n\t\t\t\tsaturated fats.\n"
        " •	Healthy Fats: Sources like avocados, nuts, and \n\t\t\t\tolive oil offer monounsaturated fats beneficial for \n\t\t\t\theart health.\n"
        " •	Fruits and Vegetables: A variety of colorful \n\t\t\t\tproduce supplies essential vitamins, minerals, and \n\t\t\t\tantioxidants.\n\n"
        "Foods to Limit:\n"
        "  • Refined Sugars: Confectioneries, sugary drinks, \n\t\t\t\t and desserts can cause rapid blood sugar spikes.\n"
        "  • Trans Fats: Found in some baked goods and fried \n\t\t\t\t foods, they can increase LDL cholesterol levels.\n"
        "  • High-Sodium Foods: Processed meats and canned \n\t\t\t\t soups may contribute to hypertension.\n\n"
        "Rationale:\n"
        "Adopting a balanced diet rich in whole foods helps in maintaining optimal blood glucose levels, reducing the risk of developing DR. Emphasizing fiber-rich foods can improve insulin sensitivity and promote overall vascular health.\n\n"
        "2. Mild DR\n\n"
        " Recommended Foods:\n"
        "  •	Antioxidant-Rich Produce: Berries, spinach, and \n\t\t\t\t kale are high in antioxidants like lutein and \n\t\t\t\t zeaxanthin, which support eye health.\n"
        "  •	Omega-3 Fatty Acids: Fatty fish such as salmon \n\t\t\t\t and sardines can reduce inflammation and \n\t\t\t\t support retinal function.\n"
        "  •	Low-Glycemic Index Foods: Legumes and sweet \n\t\t\t\t potatoes help in stabilizing blood sugar levels.\n\n"
        " Foods to Limit:\n"
        "  •	Processed Snacks: Chips and packaged cookies \n\t\t\t\t often contain unhealthy fats and sugars.\n"
        "  •	Sugary Beverages: Sodas and sweetened teas can \n\t\t\t\t lead to glycemic variability.\n\n"
        "Rationale:\n"
        "At this stage, incorporating foods that combat oxidative stress is crucial. Antioxidants can neutralize free radicals, potentially slowing DR progression. Omega-3s have been linked to a decreased risk of DR development.\n\n"
        "3. Moderate DR\n\n"
        "Recommended Foods:\n"
        "• High-Fiber Foods: Whole grains and legumes aid  in glycemic control.\n"
        "• Lean Proteins: Eggs and low-fat dairy support tissue repair and maintenance.\n"
        "• Vitamin C and E Sources: Citrus fruits and  almonds provide antioxidants that protect retinal cells.\n\n"
        "Foods to Limit:\n"
        "• High-Glycemic Index Foods: White bread and  pastries can cause rapid blood sugar increases.\n"
        "• Saturated Fats: Red meats and full-fat dairy may contribute to vascular inflammation.\n\n"
        "Rationale:\n"
        "Managing blood glucose becomes increasingly critical. Antioxidant vitamins can help in reducing oxidative damage to retinal vessels. Maintaining a diet that supports vascular health is essential to prevent further DR progression.\n\n"
        "4. Severe DR\n"
        "Recommended Foods:\n"
        "• Vitamin D-Rich Foods: Fortified cereals and fatty fish support immune function and may reduce inflammation.\n"
        "• Polyphenol-Rich Foods: Dark chocolate and green tea contain compounds that may protect retinal vessels.\n"
        "• Zinc Sources: Pumpkin seeds and legumes contribute to retinal health.\n\n"
        "Foods to Limit:\n"
        "• High-Sodium Foods: Excessive salt intake can exacerbate hypertension, affecting retinal vessels.\n"
        "• Alcohol: Can interfere with blood sugar control and may have toxic effects on the retina.\n"
        "Rationale:\n"
        "At this advanced stage, the focus shifts to preventing complications. Nutrients that support immune function and reduce inflammation are vital. Zinc plays a role in maintaining the structural integrity of retinal cells.\n\n"
        "5. Proliferative DR\n"
        "Recommended Foods:\n"
        "• Lutein and Zeaxanthin-Rich Foods: Corn and egg yolks support macular health.\n"
        "• Omega-3 Fatty Acids: Continued intake supports anti-inflammatory processes.\n"
        "• Vitamin A Sources: Carrots and sweet potatoes are essential for photoreceptor function.\n"
        "Foods to Limit:\n"
        "• Simple Carbohydrates: White rice and sugary cereals can destabilize blood glucose.\n"
        "• Processed Meats: Often high in sodium and preservatives that may affect vascular health.\n\n"
        "Rationale:\n"
        "In the proliferative stage, neovascularization poses significant risks. Nutrients that support retinal health and prevent further vascular damage are critical. Maintaining strict glycemic control through diet is paramount.\n\n"
        "Conclusion:\n"
        "Nutrition is a cornerstone in the management of diabetes and its complications, including diabetic retinopathy. By tailoring dietary choices to the severity of DR, patients can support retinal health, maintain glycemic control, and potentially slow disease progression. Regular consultations with healthcare providers, including dietitians and ophthalmologists, are essential to develop individualized nutrition plans that address specific needs at each stage of DR.\n",
    "Exercise and Diabetes Management: \nTailoring Physical Activity to DR Severity\n"
        "\nIntroduction\n"
        "Regular physical activity is a cornerstone in managing diabetes and its complications, including diabetic retinopathy (DR). \nExercise improves insulin sensitivity, aids in weight management, and enhances cardiovascular health. \nHowever, exercise regimens should be tailored to the individual’s DR stage to ensure safety and effectiveness.\n"
        "\nNo DR\n"
        "• Recommended Activities: Aerobic exercises like walking, cycling, or swimming for at least 150 minutes per week.\n"
        "• Benefits: Helps maintain optimal blood glucose levels, supports weight management, and promotes overall health.\n"
        "• Precautions: Monitor blood glucose levels before and after exercise to prevent hypoglycemia.\n"
        "\nMild DR\n"
        "• Recommended Activities: Moderate-intensity aerobic exercises combined with light resistance training.\n"
        "• Benefits: Supports vascular health, improves insulin sensitivity, and may slow DR progression.\n"
        "• Precautions: Avoid activities that involve straining or high impact to prevent retinal stress.\n"
        "\nModerate DR\n"
        "• Recommended Activities: Low-impact exercises such as yoga or stationary cycling.\n"
        "• Benefits: Enhances circulation, reduces blood pressure, and supports glycemic control.\n"
        "• Precautions: Consult with an ophthalmologist before starting new exercise routines to ensure safety.\n"
        "\nSevere DR\n"
        "• Recommended Activities: Gentle activities like walking or supervised physical therapy.\n"
        "• Benefits: Maintains mobility, supports cardiovascular health, and aids in glycemic control.\n"
        "• Precautions: Avoid exercises that involve bending, lifting, or straining to prevent retinal detachment.\n"
        "\nProliferative DR\n"
        "• Recommended Activities: Activities should be carefully selected and supervised by healthcare professionals.\n"
        "• Benefits: Helps in maintaining overall health and managing diabetes.\n"
        "• Precautions: Strictly avoid high-impact or strenuous exercises; focus on gentle movements under medical supervision.\n"
        "\nConclusion\n"
        "Incorporating appropriate physical activity into daily routines is essential for managing diabetes and its complications. Exercise regimens should be tailored to the individual’s DR stage to ensure safety and effectiveness. Regular consultations with healthcare providers can help in developing personalized exercise plans that support overall health and well-being.\n",
    "Smoking on Diabetic Patients:\nRisks Across DR Levels"
        "\nIntroduction\n"
        "Smoking poses significant health risks, particularly for individuals with diabetes, as it can accelerate the progression of diabetic retinopathy (DR) and other complications. The harmful effects of smoking are dose-dependent and can vary across different stages of DR.\n"
        "\nNo DR\n"
        "• Impact: Increased risk of developing type 2 diabetes and subsequent DR.\n"
        "• Mechanisms: Smoking induces insulin resistance, promotes inflammation, and damages blood vessels.\n"
        "• Recommendations: Smoking cessation is crucial to prevent the onset of DR and other diabetes-related complications.\n"
        "\nMild DR\n"
        "• Impact: Potential acceleration of DR progression due to vascular damage.\n"
        "• Mechanisms: Tobacco toxins can damage retinal blood vessels, leading to microaneurysms and hemorrhages.\n"
        "• Recommendations: Quitting smoking can slow DR progression and improve overall vascular health.\n"
        "\nModerate DR\n"
        "• Impact: Elevated risk of cardiovascular complications and further DR progression.\n"
        "• Mechanisms: Smoking exacerbates vascular issues, affecting retinal health and increasing the risk of macular edema.\n"
        "• Recommendations: Smoking cessation is imperative to prevent further retinal damage and systemic complications.\n"
        "\nSevere DR\n"
        "• Impact: Increased likelihood of vision loss and other severe complications.\n"
        "• Mechanisms: Compromised circulation from smoking can lead to retinal detachment and neovascularization.\n"
        "• Recommendations: Immediate cessation of smoking is critical to preserve remaining vision and support treatment efficacy.\n"
        "\nProliferative DR\n"
        "• Impact: Heightened risk of complete vision loss and poor response to treatments.\n"
        "• Mechanisms: Smoking can hinder treatment efficacy, promote neovascularization, and increase the risk of vitreous hemorrhage.\n"
        "• Recommendations: Smoking cessation is essential to improve treatment outcomes and prevent further vision deterioration.\n"
        "\nConclusion\n"
        "Quitting smoking is imperative for diabetic individuals to prevent or slow the progression of DR and safeguard overall health. Healthcare providers should offer resources and support to assist patients in smoking cessation efforts.\n",
    "The Crucial Role of Water Intake Across DR Stages"
        "\nIntroduction\n"
        "Proper hydration is vital for individuals with diabetes, as it aids in regulating blood glucose levels, supports kidney function, and maintains overall health. Dehydration can exacerbate hyperglycemia and increase the risk of diabetic complications, including diabetic retinopathy (DR).\n"
        "\nNo DR (No Diabetic Retinopathy)\n"
        "• Hydration Needs: Aim for at least 8–10 glasses of water daily to support metabolic functions.\n"
        "• Benefits: Adequate water intake helps in the efficient transport of nutrients and removal of waste, maintaining blood volume and circulation.\n"
        "• Risks of Dehydration: Even mild dehydration can lead to elevated blood glucose levels, increasing the risk of developing DR.\n"
        "\nMild DR\n"
        "• Hydration Needs: Maintain consistent water intake to assist in blood sugar regulation and support retinal health.\n"
        "• Benefits: Proper hydration supports kidney function, reducing the risk of complications that can affect the eyes.\n"
        "• Risks of Dehydration: Dehydration can lead to increased blood viscosity, impairing circulation to the retina.\n"
        "\nModerate DR\n"
        "• Hydration Needs: Increase water consumption to aid in blood viscosity reduction and support vascular health.\n"
        "• Benefits: Thinner blood can improve circulation, benefiting retinal health and potentially slowing DR progression.\n"
        "• Risks of Dehydration: Poor hydration can exacerbate blood pressure issues, further damaging retinal vessels.\n"
        "\nSevere DR\n"
        "• Hydration Needs: Monitor fluid intake closely, ensuring adequate hydration without overburdening the kidneys.\n"
        "• Benefits: Balancing hydration is critical to prevent further vascular complications and support overall health.\n"
        "• Risks of Dehydration: Dehydration can lead to electrolyte imbalances and increased risk of retinal hemorrhages.\n"
        "\nProliferative DR\n"
        "• Hydration Needs: Adhere to personalized hydration plans as advised by healthcare providers, considering any coexisting conditions.\n"
        "• Benefits: Managing fluid levels is vital to avoid exacerbating retinal issues and supporting treatment efficacy.\n"
        "• Risks of Dehydration: Severe dehydration can compromise treatment outcomes and increase the risk of vision loss.\n"
        "\nConclusion\n"
        "Consistent and appropriate water intake is a simple yet powerful tool in managing diabetes and its ocular complications. Tailoring hydration strategies to the severity of DR can support overall health and potentially slow disease progression.\n",
  ];

  RecommendationScreen({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Recommendation",
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1,
          ),
          itemCount: recommendations.length,
          itemBuilder: (context, index) {
            return RecommendationCard(
              title: recommendations[index]["title"],
              description: recommendationsDes[index],
              imagePath: recommendations[index]["image"],
            );
          },
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   backgroundColor: Colors.blueAccent,
      //   selectedItemColor: Colors.white,
      //   unselectedItemColor: Colors.white70,
      //   items: [
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
      //     BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
      //     BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: ""),
      //     BottomNavigationBarItem(icon: Icon(Icons.settings), label: ""),
      //   ],
      // ),
    );
  }
}

class RecommendationCard extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;

  const RecommendationCard(
      {required this.title,
      required this.description,
      required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // الانتقال إلى الصفحة الثانية عند النقر
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              title: title,
              imagePath: imagePath,
              description: description,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                child: Image.asset(
                  imagePath,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover, // لجعل الصورة تملأ المربع بالكامل
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
