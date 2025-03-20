import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fvm/fvm.dart';

class LogConsoleView extends StatefulWidget {
  final bool? shouldClearLogs;
  const LogConsoleView({super.key, this.shouldClearLogs = false});

  @override
  State<LogConsoleView> createState() => _LogConsoleViewState();
}

class _LogConsoleViewState extends State<LogConsoleView> {
  final List<LogMessage> logs = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    // Listen to all streams
    consoleController.stdout.stream.listen((data) {
      _addLog(LogType.info, utf8.decode(data));
    });

    consoleController.info.stream.listen((data) {
      _addLog(LogType.info, utf8.decode(data));
    });

    consoleController.error.stream.listen((data) {
      _addLog(LogType.error, utf8.decode(data));
    });

    consoleController.warning.stream.listen((data) {
      _addLog(LogType.warning, utf8.decode(data));
    });

    consoleController.fine.stream.listen((data) {
      _addLog(LogType.detail, utf8.decode(data));
    });
  }

  void _addLog(LogType type, String message) {
    //setState(() {
      logs.add(LogMessage(type: type, message: message));
    //});

    // Auto-scroll to bottom
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void didUpdateWidget(covariant LogConsoleView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.shouldClearLogs ?? false) {
      //setState(() {
        logs.clear();
      //});
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        //color: Colors.black,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          controller: _scrollController,
          itemCount: logs.length,
          itemBuilder: (context, index) {
            final log = logs[index];
            return Text(
              log.message,
              style: TextStyle(
                color: _getColorForLogType(log.type),
                fontFamily: 'monospace',
              ),
            );
          },
        ),
      ),
    );
  }

  Color _getColorForLogType(LogType type) {
    switch (type) {
      case LogType.info:
        return Colors.white;
      case LogType.error:
        return Colors.red;
      case LogType.warning:
        return Colors.yellow;
      case LogType.detail:
        return Colors.grey;
      default:
        return Colors.white;
    }
  }
}

enum LogType {
  info,
  error,
  warning,
  detail
}

class LogMessage {
  final LogType type;
  final String message;

  LogMessage({required this.type, required this.message});
}