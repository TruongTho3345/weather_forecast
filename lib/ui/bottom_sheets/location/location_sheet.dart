import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stacked/stacked_annotations.dart';

import 'location_sheet.form.dart';
import 'location_sheet_model.dart';

@FormView(
  fields: [
    FormTextField(name: 'location'),
  ],
)
class LocationSheet extends StackedView<LocationSheetModel>
    with $LocationSheet {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;

  LocationSheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    LocationSheetModel viewModel,
    Widget? child,
  ) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: TextField(
                controller: locationController,
                onChanged: (value) => viewModel.searchLocation(value),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Search location',
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: viewModel.isBusy
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: viewModel.suggestions.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(viewModel.suggestions[index]),
                        onTap: () {
                          completer?.call(SheetResponse(
                            confirmed: true,
                            data: viewModel.suggestions[index],
                          ));
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  @override
  LocationSheetModel viewModelBuilder(BuildContext context) =>
      LocationSheetModel();
}
