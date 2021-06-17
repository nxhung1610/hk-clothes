import 'package:hk_clothes/controllers/auth/auth_controller.dart';
import 'package:hk_clothes/controllers/clothes/product_controller.dart';
import 'package:hk_clothes/controllers/dashboard/account/account_controller.dart';
import 'package:hk_clothes/controllers/dashboard/account/updateinfo_controller.dart';
import 'package:hk_clothes/controllers/dashboard/dashboard_controller.dart';
import 'package:hk_clothes/controllers/dashboard/home/home_controller.dart';
import 'package:hk_clothes/controllers/dashboard/shipping/shipping_controller.dart';

AuthController authController = AuthController.instance;
DashboardController dashBoardController = DashboardController.instance;
HomeController homeController = HomeController.instance;
AccountController accountController = AccountController.instance;
UpdateInfoController updateInfoController = UpdateInfoController.instance;
ProductController productController = ProductController.instance;
ShippingController shippingController = ShippingController.instance;