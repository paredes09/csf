import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

Widget cardHomeGeneral(
  Function()? ontap,
  IconData icon1,
  String title,
  String subtitle,
) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    color: Colors.white,
    margin: const EdgeInsets.all(10),
    child: InkWell(
      borderRadius: BorderRadius.circular(5),
      splashColor: const Color.fromARGB(255, 217, 215, 215),
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: HugeIcon(
                    icon: icon1, color: Colors.blue.shade600, size: 25.0),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                Text(subtitle,
                    style: const TextStyle(fontSize: 11, color: Colors.grey)),
              ],
            ),
            const Spacer(),
            Icon(Icons.arrow_forward_ios_rounded, color: Colors.blue.shade600)
          ],
        ),
      ),
    ),
  );
}
