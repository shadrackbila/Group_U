import 'package:flutter/material.dart';
import 'package:group_u/routesManager/routes_manager.dart';

class PopUp extends StatelessWidget {
  const PopUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 200,
      padding: EdgeInsets.all(10),

      // Student Card section
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Student Assistant",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(141, 255, 214, 64),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(5),
                child: Text(
                  "Pending",
                  style: TextStyle(
                    color: const Color.fromARGB(255, 123, 93, 2),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(141, 64, 150, 255),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(5),
                child: Text(
                  "2nd Year",
                  style: TextStyle(
                    color: const Color.fromARGB(255, 2, 91, 123),
                  ),
                ),
              ),
              SizedBox(width: 20),
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(141, 64, 150, 255),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(5),
                child: Text(
                  "SOD316C",
                  style: TextStyle(
                    color: const Color.fromARGB(255, 2, 91, 123),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          Text("Applied on: 13-05-2026"),
          SizedBox(height: 15),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    RouteManager.studentAssistantFormUpdate,
                  );
                },
                child: Text(
                  "Edit",
                  style: TextStyle(
                    color: const Color.fromARGB(255, 80, 148, 203),
                  ),
                ),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 80, 148, 203),
                ),
                onPressed: () {},
                child: Text("Reapply", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
