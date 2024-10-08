import 'package:flutter/material.dart';
import 'package:hisnate_kifele/Data/Data%20Providers/colors.dart';

class DashboardCard extends StatelessWidget {
  const DashboardCard({
    Key? key,
    required this.sizeH,
    required this.text,
    required this.icon,
    required this.onTap,
    required this.height,
  }) : super(key: key);

  final double sizeH;
  final String text;
  final IconData icon;
  final Function() onTap;
  final double height;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.white,
          border: Border.all(color: Color(0xffA3ADB6).withOpacity(0.3)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 30,
                color: ColorResources.primaryColor,
              ),
              SizedBox(height: 10),
              Expanded(
                child: Text(
                  text,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
