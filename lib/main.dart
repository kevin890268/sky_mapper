import 'package:flutter/material.dart';
import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';

void main() {
  runApp(const MaterialApp(
    home: SimpleARPage(),
  ));
}

class SimpleARPage extends StatefulWidget {
  const SimpleARPage({super.key});

  @override
  State<SimpleARPage> createState() => _SimpleARPageState();
}

class _SimpleARPageState extends State<SimpleARPage> {
  ARSessionManager? arSessionManager;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 使用 Stack 是為了以後可以在 AR 畫面上疊加 UI
      body: Stack(
        children: [
          ARView(
            onARViewCreated: onARViewCreated,
          ),
          const Positioned(
            top: 50,
            left: 20,
            child: Text(
              "AR 模式已啟動\n請移動手機捕捉點雲",
              style: TextStyle(color: Colors.white, fontSize: 18, backgroundColor: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }

  void onARViewCreated(
      ARSessionManager arSession,
      var arObject, // 暫時不用
      var arAnchor, // 暫時不用
      var arLocation, // 暫時不用
      ) {
    arSessionManager = arSession;

    // 初始化 AR 會話
    arSessionManager!.onInitialize(
      showFeaturePoints: true, // 顯示 ARKit 捕捉到的特徵點（點雲）
      showPlanes: false,       // 天球專案不需要偵測地面平面
      customVisualizerSettings: false, // 先用預設視覺效果，確保能跑通
    );
    
    print("AR 會話初始化成功");
  }
}