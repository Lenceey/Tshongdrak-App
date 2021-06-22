import 'package:AdminTshongdrak/Services/Manage.dart';
import 'package:AdminTshongdrak/Services/seller.dart';
import 'package:flutter/material.dart';
import 'package:AdminTshongdrak/Adminpanel/Admin_drawer.dart';
class AdminHome extends StatefulWidget {
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  String name;
  String cid;
  String address;

  Widget _buildSingleContainer(
    {IconData icon,int count, String name, BuildContext context}) {
        return Card(
                  child: Container(
                     padding: EdgeInsets.symmetric(vertical: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                            icon,
                            color: Colors.grey,
                            size: 30,
                            ),
                            SizedBox(
                             width: 15,
                             ),
                            Text(
                            name,
                            style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20,),
                         Text(
                            count.toString(),
                            style: TextStyle(
                            fontSize: 50,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                            ),
                            ),
                      ],
                    ),
                  ),
                );
    }
  // This widget is the root of your application. 
  @override 
  Widget build(BuildContext context) {
    return DefaultTabController(
     length: 3,
      child: Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          indicatorColor: Theme.of(context).primaryColor,
          indicatorWeight: 3,
          unselectedLabelColor: Colors.white,
          tabs: [
            Text("Dashboard",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),),
            Text("Sellers",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),),
            Text("Manage",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),),
          ],
        ),
        backgroundColor: Colors.lightBlue,
        title: Text("Tshongdrak App",style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        ),
        centerTitle: true,elevation: 0.0,
      ),
      body: Container(
      child: TabBarView(
        children: [

          //Dashboard part
          Container(
            padding: const EdgeInsets.all(0.5),
            child: GridView.count(
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              crossAxisCount: 2,
              children: [
                _buildSingleContainer(
                  context: context,
                  count: 1,
                  icon: Icons.people,
                  name: "Customer",
                ),
                 _buildSingleContainer(
                  context: context,
                  count: 4,
                  icon: Icons.person,
                  name: "Shopkeeper",
                ),
                 _buildSingleContainer(
                  context: context,
                  count: 1,
                  icon: Icons.track_changes,
                  name: "Products",
                ),
                 _buildSingleContainer(
                  context: context,
                  count: 1,
                  icon: Icons.shopping_bag,
                  name: "Orders",
                ),
              ],
            ),
          ),
        
        //Sellers part
        Container(
          padding: EdgeInsets.all(10),
          child: Seller(),
          
        ),

        //It is for manage part  
         Container(
           padding: EdgeInsets.all(10),
          child: Manage(),
              ),
              ],
              ),
              ),
              drawer: AdminMainDrawer(),
              ),
              );
            }
              }