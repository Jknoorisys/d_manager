import 'package:d_manager/api/inventory_services.dart';
import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/constants/routes.dart';
import 'package:d_manager/generated/l10n.dart';
import 'package:d_manager/helpers/helper_functions.dart';
import 'package:d_manager/models/inventory_models/add_update_inventory_model.dart';
import 'package:d_manager/models/inventory_models/inventory_detail_model.dart';
import 'package:d_manager/screens/widgets/buttons.dart';
import 'package:d_manager/screens/widgets/snackbar.dart';
import 'package:d_manager/screens/widgets/text_field.dart';
import 'package:flutter/material.dart';

class AddInventory extends StatefulWidget {
  String? inventoryId;
  AddInventory({Key? key, this.inventoryId}) : super(key: key);

  @override
  _AddInventoryState createState() => _AddInventoryState();
}

class _AddInventoryState extends State<AddInventory> {
  final TextEditingController rotoController = TextEditingController();
  final TextEditingController zeroController = TextEditingController();
  final TextEditingController reasonController = TextEditingController();
  bool submitted = false;

  bool isLoading = false;
  ManageInventoryServices inventoryServices = ManageInventoryServices();

  @override
  void dispose() {
    rotoController.dispose();
    zeroController.dispose();
    reasonController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.inventoryId != null) {
      _getInventoryDetails();
    }
  }
  @override
  Widget build(BuildContext context) {
    var errorRoto = submitted == true ? _validateRoto(rotoController.text) : null;
    var errorZero = submitted == true ? _validateZero(zeroController.text) : null;
    return SingleChildScrollView(
      child: AlertDialog(
        alignment: Alignment.center,
        backgroundColor: AppTheme.white,
        elevation: 10,
        surfaceTintColor: AppTheme.white,
        shadowColor: AppTheme.primary.withOpacity(0.5),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.inventoryId == null ? S.of(context).addInventory : S.of(context).updateInventory,
              style: AppTheme.heading2,
            ),
            IconButton(
              icon: const Icon(Icons.close, color: AppTheme.primary),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextField(
              controller: rotoController,
              labelText: "Enter Roto",
              keyboardType: TextInputType.number,
              borderRadius: Dimensions.radius10,
              errorText: errorRoto.toString() != 'null' ? errorRoto.toString() : '',
            ),
            SizedBox(height: Dimensions.height15),
            CustomTextField(
              controller: zeroController,
              labelText: "Enter Zero",
              keyboardType: TextInputType.number,
              borderRadius: Dimensions.radius10,
              errorText: errorZero.toString() != 'null' ? errorZero.toString() : '',
            ),
            SizedBox(height: Dimensions.height15),
            CustomTextField(
              controller: reasonController,
              labelText: "Enter Reason",
              keyboardType: TextInputType.text,
              borderRadius: Dimensions.radius10,
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          CustomElevatedButton(
            onPressed: () {
              setState(() {
                submitted = true;
              });
              if (_isFormValid()) {
                setState(() {
                  isLoading = !isLoading;
                });
                Map<String, dynamic> body = {
                  "cloth_inventory_id": widget.inventoryId != null ? widget.inventoryId.toString() : "",
                  "user_id" : HelperFunctions.getUserID(),
                  "roto": rotoController.text,
                  "zero": zeroController.text,
                  "reason": reasonController.text,
                };
                if (widget.inventoryId == null) {
                  _addInventory(body);
                } else {
                  _updateInventory(body);
                }
              }
            },
            buttonText: "Submit",
          )
        ],
      ),
    );
  }

  String? _validateRoto(String value) {
    if (value.isEmpty) {
      return 'Roto is required';
    }
    return null;
  }

  String? _validateZero(String value) {
    if (value.isEmpty) {
      return 'Zero is required';
    }
    return null;
  }

  bool _isFormValid() {
    String errorRoto = _validateRoto(rotoController.text) ?? '';
    String errorZero = _validateZero(zeroController.text) ?? '';
    return errorRoto.isEmpty || errorZero.isEmpty ? true : false;
  }

  Future<void> _addInventory(Map<String, dynamic> body) async {
    if (await HelperFunctions.isPossiblyNetworkAvailable()) {
      AddUpdateInventoryModel? addInventoryModel = await inventoryServices.addInventory(body);
      if (addInventoryModel?.message != null) {
        if (addInventoryModel?.success == true) {
          CustomApiSnackbar.show(
            context,
            'Success',
            addInventoryModel!.message.toString(),
            mode: SnackbarMode.success,
          );
          Navigator.of(context).popAndPushNamed(AppRoutes.inventoryDashboard);
        }  else {
          CustomApiSnackbar.show(
            context,
            'Error',
            addInventoryModel!.message.toString(),
            mode: SnackbarMode.error,
          );
        }

        setState(() {
          isLoading = false;
        });
      } else {
        CustomApiSnackbar.show(
          context,
          'Error',
          'Something went wrong, please try again',
          mode: SnackbarMode.error,
        );
        setState(() {
          isLoading = false;
        });
      }
    } else {
      CustomApiSnackbar.show(
        context,
        'Warning',
        'No Internet Connection',
        mode: SnackbarMode.warning,
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _updateInventory(Map<String, dynamic> body) async {
    if (await HelperFunctions.isPossiblyNetworkAvailable()) {
      AddUpdateInventoryModel? updateInventoryModel = await inventoryServices.updateInventory(body);
      if (updateInventoryModel?.message != null) {
        if (updateInventoryModel?.success == true) {
          CustomApiSnackbar.show(
            context,
            'Success',
            updateInventoryModel!.message.toString(),
            mode: SnackbarMode.success,
          );
          Navigator.of(context).popAndPushNamed(AppRoutes.inventoryDashboard);
        }  else {
          CustomApiSnackbar.show(
            context,
            'Error',
            updateInventoryModel!.message.toString(),
            mode: SnackbarMode.error,
          );
        }

        setState(() {
          isLoading = false;
        });
      } else {
        CustomApiSnackbar.show(
          context,
          'Error',
          'Something went wrong, please try again',
          mode: SnackbarMode.error,
        );
        setState(() {
          isLoading = false;
        });
      }
    } else {
      CustomApiSnackbar.show(
        context,
        'Warning',
        'No Internet Connection',
        mode: SnackbarMode.warning,
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _getInventoryDetails() async {
    setState(() {
      isLoading = true;
    });
    if (await HelperFunctions.isPossiblyNetworkAvailable()) {
      InventoryDetailModel? yarnDetailModel = await inventoryServices.viewInventory(widget.inventoryId!);
      if (yarnDetailModel?.message != null) {
        if (yarnDetailModel?.success == true) {
          rotoController.text = yarnDetailModel!.data!.roto.toString();
          zeroController.text = yarnDetailModel.data!.zero.toString();
          reasonController.text = yarnDetailModel.data!.reason == null ? '' : yarnDetailModel.data!.reason.toString();
          setState(() {
            isLoading = false;
          });
        } else {
          CustomApiSnackbar.show(
            context,
            'Error',
            yarnDetailModel!.message.toString(),
            mode: SnackbarMode.error,
          );
        }
      } else {
        CustomApiSnackbar.show(
          context,
          'Error',
          'Something went wrong, please try again',
          mode: SnackbarMode.error,
        );
      }
    } else {
      CustomApiSnackbar.show(
        context,
        'Warning',
        'No Internet Connection',
        mode: SnackbarMode.warning,
      );
      setState(() {
        isLoading = false;
      });
    }
  }
}
