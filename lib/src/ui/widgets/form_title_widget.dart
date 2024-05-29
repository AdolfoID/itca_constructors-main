import 'package:flutter/material.dart';

class FormTitleWidget extends StatelessWidget {
  final String title;
  const FormTitleWidget({
    super.key,
    this.title = "Ingresar parámetros",
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: SizedBox(
        height: 30,
        child: Stack(
          children: [
            const Center(
                child: Divider(
              height: 1,
            )),
            Container(
                decoration: BoxDecoration(
                  color: const Color(0xffef7a05),
                  borderRadius: BorderRadius.circular(60),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 2.5),
                margin: const EdgeInsets.only(left: 25, top: 3),
                child: Text(title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        )))
          ],
        ),
      ),
    );
  }
}
