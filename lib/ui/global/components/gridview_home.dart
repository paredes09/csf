import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

Widget gridViewHome(
    Function()? ontap,
    String titulo, HugeIcon icon, String cantidad, String detalle) {
  return InkWell(
    borderRadius: BorderRadius.circular(20),
    onTap: ontap,
    child: Ink(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 67,
                  child: Text(titulo,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis)),
                ),
                CircleAvatar(
                    backgroundColor: Colors.grey[300], radius: 15, child: icon)
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(cantidad,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text(detalle,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 11,
                )),
          ],
        )),
  );
}
