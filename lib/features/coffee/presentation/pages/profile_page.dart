import 'package:flutter/material.dart';



class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey.shade900,
                      child:  InkWell(
                           onTap: (){
                             Navigator.pop(context);
                           },
                          child: Icon(Icons.arrow_back, color: Colors.white)),
                    ),
                    const Text(
                      "Profile",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.grey.shade900,
                      child: const Icon(Icons.more_vert, color: Colors.white),
                    ),
                  ],
                ),

                const SizedBox(height: 25),

                /// Profile Card
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade900,
                    borderRadius: BorderRadius.circular(10), // radius 10
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                          "https://i.pravatar.cc/150?img=3",
                        ),
                      ),
                      const SizedBox(width: 15),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Jon Alishon",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "alishon35",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                const Text(
                  "Terms & Condition",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),

                const SizedBox(height: 15),

                /// Settings Card 1
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade900,
                    borderRadius: BorderRadius.circular(10), // radius 10
                  ),
                  child: Column(
                    children: const [
                      ProfileTile(
                          icon: Icons.payment, title: "Payment"),
                      Divider(color: Colors.black),
                      ProfileTile(icon: Icons.local_offer, title: "Promo"),
                      Divider(color: Colors.black),
                      ProfileTile(icon: Icons.language, title: "Language"),
                      Divider(color: Colors.black),
                      ProfileTile(icon: Icons.support_agent, title: "Support"),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                const Text(
                  "Accounts & subscription",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),

                const SizedBox(height: 15),

                /// Settings Card 2
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade900,
                    borderRadius: BorderRadius.circular(10), // radius 10
                  ),
                  child: Column(
                    children: [
                      SwitchListTile(
                        value: true,
                        onChanged: (val) {},
                        title: const Text(
                          "Notification",
                          style: TextStyle(color: Colors.white),
                        ),
                        secondary: const Icon(Icons.notifications,
                            color: Colors.white),
                      ),
                      const Divider(color: Colors.black),
                      const ProfileTile(
                          icon: Icons.folder, title: "My Data"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

    )
    );
  }


}

class ProfileTile extends StatelessWidget {
  final IconData icon;
  final String title;

  const ProfileTile({
    super.key,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.white),
      onTap: () {

      },




    );
  }
}
