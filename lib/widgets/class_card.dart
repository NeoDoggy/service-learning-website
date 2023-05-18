import 'package:flutter/material.dart';
import 'package:service_learning_website/widgets/edit_card.dart';

class ClassCard extends StatelessWidget {
  const ClassCard({
    super.key,
    required this.name,
    required this.student,
    required this.where,
    required this.addIn,
  });

  final String name;
  final String student;
  final String where;
  final bool addIn;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 435,
      width: 300,
      child: InkWell(
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        onTap: () {
          showDialog(
              context: context,
              barrierDismissible: true,
              barrierLabel:
                  MaterialLocalizations.of(context).modalBarrierDismissLabel,
              barrierColor: Colors.black54.withOpacity(0.8),
              builder: (context) {
                return AlertDialog(
                  scrollable: true,
                  backgroundColor: Colors.transparent,
                  content: EditCard(name: name,));
              });
        },
        child: Card(
          // margin: EdgeInsets.zero,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          color: const Color(0xFFf5f5f5),
          elevation: 0,
          child: Column(
            children: [
              const Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                    width: 300,
                    height: 180,
                    child: Card(
                      margin: EdgeInsets.all(5),
                      elevation: 0,
                      color: Color(0xFFfafafa),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 25, bottom: 25),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.drive_file_rename_outline_rounded,
                          color: Color(0xFF00ba7c),
                          size: 26,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          name,
                          style: const TextStyle(
                              color: Color(0xFF474747),
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.account_circle,
                          color: Color(0xFF1d9bf0),
                          size: 26,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          student,
                          style: const TextStyle(
                              color: Color(0xFF474747),
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.pin_drop_rounded,
                          color: Color(0xFFff4060),
                          size: 26,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          where,
                          style: const TextStyle(
                              color: Color(0xFF474747),
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(),
              const SizedBox(
                height: 6,
              ),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      splashFactory: NoSplash.splashFactory,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      backgroundColor:
                          addIn ? const Color(0xFFff4060) : const Color(0xFF00ba7c),
                      minimumSize: Size.zero,
                      padding: const EdgeInsets.all(10),
                    ),
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: addIn ? const Text("加入課程") : const Text("進入課程"),
                    )),
              ),
              const SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
