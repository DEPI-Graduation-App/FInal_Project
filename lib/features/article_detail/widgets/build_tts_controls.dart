import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:news_depi_final_project/features/article_detail/controller/article_detail_controller.dart';

Widget buildTtsControls(
  BuildContext context,
  Color color,
  ArticleDetailController controller,
) {
  return Obx(() {
    final state = controller.ttsState.value;
    final isStopped = state == TtsState.stopped;

    if (isStopped) {
      return _buildSimplePlayButton(controller, color);
    } else {
      return _buildSimpleControls(controller, color, state);
    }
  });
}

Widget _buildSimplePlayButton(ArticleDetailController controller, Color color) {
  return IconButton(
    onPressed: () => controller.speak(),
    icon: Icon(Icons.play_circle_fill_rounded, size: 48, color: color),
    padding: EdgeInsets.zero,
    constraints: const BoxConstraints(),
  );
}

Widget _buildSimpleControls(
  ArticleDetailController controller,
  Color color,
  TtsState state,
) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      IconButton(
        onPressed: () => controller.speak(),
        icon: Icon(Icons.replay_rounded, color: color.withOpacity(0.7)),
        iconSize: 24,
        tooltip: "Restart",
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
      ),

      const SizedBox(width: 16),
      IconButton(
        onPressed: () {
          if (state == TtsState.playing) {
            controller.pauseTts();
          } else {
            controller.speak();
          }
        },
        icon: Icon(
          state == TtsState.playing
              ? Icons.pause_circle_filled_rounded
              : Icons.play_circle_fill_rounded,
          color: color,
        ),
        iconSize: 48,
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
        tooltip: state == TtsState.playing ? "Pause" : "Resume",
      ),

      const SizedBox(width: 16),
      IconButton(
        onPressed: () => controller.stopTts(),
        icon: Icon(Icons.stop_rounded, color: Colors.red[300]),
        iconSize: 24,
        tooltip: "Stop",
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
      ),
    ],
  );
}
