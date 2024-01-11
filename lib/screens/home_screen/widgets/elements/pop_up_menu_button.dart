import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:task_list/blocs/operation_for_task/operation_for_task_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:task_list/domain/provider/locale_provider.dart';

enum PopUpElements { deleteAll, changeLocale, signOut }

class PopUpMenuButton extends StatefulWidget {
  const PopUpMenuButton({Key? key}) : super(key: key);

  @override
  PopUpMenuButtonState createState() => PopUpMenuButtonState();
}

class PopUpMenuButtonState extends State<PopUpMenuButton> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OperationForTaskBloc, OperationForTaskState>(
      builder: (context, state) {
        return PopupMenuButton<PopUpElements>(
            itemBuilder: (BuildContext context) => [
                  PopupMenuItem(
                    value: PopUpElements.deleteAll,
                    onTap: () {
                      context
                          .read<OperationForTaskBloc>()
                          .add(ClearBoxTapped());
                    },
                    child: Text(AppLocalizations.of(context)!.clearBox),
                  ),
                  PopupMenuItem(
                    value: PopUpElements.changeLocale,
                    onTap: () {
                      setState(() {
                        Provider.of<LocaleProvider>(context, listen: false)
                            .changeLocale();
                      });
                    },
                    child: Text(AppLocalizations.of(context)!.changeLocale),
                  ),
                  PopupMenuItem(
                    value: PopUpElements.signOut,
                    onTap: () {
                      context.read<OperationForTaskBloc>().add(SignOut());
                    },
                    child: const Text('LogOuT'),
                  ),
                ]);
      },
    );
  }
}
