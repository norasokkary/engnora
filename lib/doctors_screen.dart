// import 'package:flutter/material.dart';
// import 'doctor_info_screen.dart';
//
// class DoctorsScreen extends StatelessWidget {
//   final List<Map<String, dynamic>> doctors = [
//     {
//       "name": "Dr. Alexander Bennett, Ph.D.",
//       "specialty": "Dermato-Genetics",
//       "image": "assets/doctor1.png",
//       "experience": "15 years",
//       "focus": "Focus: The impact of hormonal imbalances on skin conditions."
//     },
//     {
//       "name": "Dr. Michael Davidson, M.D.",
//       "specialty": "Solar Dermatology",
//       "image": "assets/doctor2.png",
//       "experience": "12 years",
//       "focus": "Focus: Research on UV exposure effects on skin health."
//     },
//     {
//       "name": "Dr. Olivia Turner, M.D.",
//       "specialty": "Dermato-Endocrinology",
//       "image": "assets/doctor3.png",
//       "experience": "10 years",
//       "focus": "Focus: Relationship between endocrine disorders and skin conditions."
//     },
//     {
//       "name": "Dr. Sophia Martinez, Ph.D.",
//       "specialty": "Cosmetic Bioengineering",
//       "image": "assets/doctor4.png",
//       "experience": "8 years",
//       "focus": "Focus: Development of bioengineered cosmetic treatments."
//     },
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Doctors", style: TextStyle(color: Colors.blue)),
//         backgroundColor: Colors.white,
//         iconTheme: IconThemeData(color: Colors.blue),
//         elevation: 0,
//       ),
//       body: ListView.builder(
//         padding: EdgeInsets.all(16),
//         itemCount: doctors.length,
//         itemBuilder: (context, index) {
//           final doctor = doctors[index];
//           return GestureDetector(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => DoctorInfoScreen(doctor: doctor),
//                 ),
//               );
//             },
//             child: Card(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Padding(
//                 padding: EdgeInsets.all(12),
//                 child: Row(
//                   children: [
//                     CircleAvatar(
//                       backgroundImage: AssetImage(doctor["image"]),
//                       radius: 30,
//                     ),
//                     SizedBox(width: 12),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           doctor["name"],
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         Text(
//                           doctor["specialty"],
//                           style: TextStyle(color: Colors.grey),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         backgroundColor: Colors.blue,
//         selectedItemColor: Colors.white,
//         unselectedItemColor: Colors.white70,
//         items: [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
//           BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: ""),
//           BottomNavigationBarItem(icon: Icon(Icons.settings), label: ""),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

import 'JSON/users.dart';

class DoctorsScreen extends StatelessWidget {
  final Users? user;

  const DoctorsScreen({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Doctors List"),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        children: const [
          DoctorCard(
            name: "Dr. Hossam El-Din Farouk",
            specialization: "Consultant in Diabetes and Endocrinology",
            education: "Ain Shams University – Master in Internal Medicine",
            workplace: "Dar El Fouad Hospital, 6th of October",
            hours: "Sat – Wed: 10:00 AM – 4:00 PM",
            phone: "+201001234567",
            extraInfo: "HbA1c testing, insulin plans, diabetic foot screening.",
          ),
          DoctorCard(
            name: "Dr. Mariam Samir",
            specialization: "Specialist in Diabetes & Preventive Medicine",
            education: "Alexandria University – Clinical Nutrition Diploma",
            workplace: "Al Salam International Hospital, Maadi",
            hours: "Sun, Tue, Thu: 12:00 PM – 6:00 PM",
            phone: "+201225678910",
            extraInfo: "Lifestyle & nutrition, digital glucose monitoring.",
          ),
          DoctorCard(
            name: "Dr. Youssef Abdelrahman",
            specialization: "Diabetes & Metabolism Consultant",
            education: "Cairo University – Ph.D. in Endocrinology",
            workplace: "Private Clinic – Nasr City",
            hours: "Sat – Thu: 5:00 PM – 9:00 PM",
            phone: "+201149876543",
            extraInfo: "Neuropathy & insulin pump therapy expert.",
          ),
          DoctorCard(
            name: "Dr. Nourhan Adel",
            specialization: "Diabetes and Lifestyle Medicine Specialist",
            education: "Tanta University – PGDip Diabetes, South Wales",
            workplace: "Cleopatra Hospital – Heliopolis",
            hours: "Mon, Wed, Fri: 1:00 PM – 7:00 PM",
            phone: "+201012345678",
            extraInfo: "Holistic care and physical activity programs.",
          ),
          DoctorCard(
            name: "Dr. Karim Hassan",
            specialization: "Internal Medicine & Diabetes Specialist",
            education: "Menoufia University – Diabetes Society Member",
            workplace: "Andalusia Hospital – Alexandria",
            hours: "Sun – Thu: 9:00 AM – 3:00 PM",
            phone: "+201227894321",
            extraInfo: "Insulin resistance and diabetic ulcer care.",
          ),
          DoctorCard(
            name: "Dr. Laila Mostafa",
            specialization: "Pediatric Endocrinologist (Childhood Diabetes)",
            education: "Assiut University – Pediatric Endocrinology Fellowship",
            workplace: "El Galaa Teaching Hospital",
            hours: "Sat – Wed: 2:00 PM – 6:00 PM",
            phone: "+201153458765",
            extraInfo: "Long-term diabetic care for children & teens.",
          ),
        ],
      ),
    );
  }
}

class DoctorCard extends StatelessWidget {
  final String name;
  final String specialization;
  final String education;
  final String workplace;
  final String hours;
  final String phone;
  final String extraInfo;

  const DoctorCard({
    required this.name,
    required this.specialization,
    required this.education,
    required this.workplace,
    required this.hours,
    required this.phone,
    required this.extraInfo,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(specialization,
                style: const TextStyle(color: Colors.grey, fontSize: 16)),
            const Divider(height: 20),
            Text("Education: $education"),
            Text("Workplace: $workplace"),
            Text("Working Hours: $hours"),
            Text("Phone: $phone"),
            const SizedBox(height: 8),
            Text("Note: $extraInfo",
                style: const TextStyle(color: Colors.black87)),
          ],
        ),
      ),
    );
  }
}
