import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class NetworkErrorPage extends StatelessWidget {
  final VoidCallback onRetry;

  const NetworkErrorPage({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Network Error')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.wifi_off, size: 100, color: Colors.red),
            const SizedBox(height: 20),
            const Text(
              'No Internet Connection',
              style: TextStyle(fontSize: 24, color: Colors.red),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: onRetry,
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}

// class NetworkLostWidget extends ConsumerWidget{
//   final Widget child;
//
//   const NetworkLostWidget({super.key, required this.child});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final connectivityResult = ref.watch(connectivityProvider);
//     return connectivityResult.when(
//       data: (result) {
//         if (result == ConnectivityResult.none) {
//           return NoInternetWidget();  // Show no internet widget if no connection
//         } else {
//           return child;  // Show the actual UI when connected
//         }
//       },
//       loading: () => CircularProgressIndicator(),
//       error: (err, stack) => Text('Error checking network connection'),
//     );
//   }
// }
//
// class NoInternetWidget extends StatelessWidget {
//   const NoInternetWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.wifi_off, size: 50, color: Colors.red),
//           SizedBox(height: 20),
//           Text('No Internet Connection', style: TextStyle(fontSize: 18, color: Colors.red)),
//           SizedBox(height: 20),
//           ElevatedButton(
//             onPressed: () {
//               // Retry button logic here (e.g., check connection or reload)
//             },
//             child: Text('Retry'),
//           ),
//         ],
//       ),
//     );
//   }
// }

class MyNetworkRequestWidget extends StatefulWidget {
  const MyNetworkRequestWidget({super.key});

  @override
  MyNetworkRequestWidgetState createState() => MyNetworkRequestWidgetState();
}

class MyNetworkRequestWidgetState extends State<MyNetworkRequestWidget> {
  bool isConnected = false;

  @override
  void initState() {
    super.initState();
    // Listen for connectivity changes
    Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> result) {
      setState(() {
        isConnected = !result.contains(ConnectivityResult.none);
      });
    });
  }

  void retryNetworkRequest() {
    if (isConnected) {
      // Perform network request
    } else {
      // Show retry message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No internet, please check your connection.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Network Request')),
      body: Center(
        child: ElevatedButton(
          onPressed: retryNetworkRequest,
          child: const Text('Retry Request'),
        ),
      ),
    );
  }
}

// class ConnectivityListenerWidget extends StatefulWidget {
//   @override
//   _ConnectivityListenerWidgetState createState() => _ConnectivityListenerWidgetState();
// }
//
// class _ConnectivityListenerWidgetState extends State<ConnectivityListenerWidget> {
//   late Stream<List<ConnectivityResult>> _connectivityStream;
//
//   @override
//   void initState() {
//     super.initState();
//     _connectivityStream = Connectivity().onConnectivityChanged;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Connectivity Listener')),
//       body: StreamBuilder<List<ConnectivityResult>>(
//         stream: _connectivityStream,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }
//
//           if (snapshot.hasData) {
//             final connectivityResult = snapshot.data;
//             if (connectivityResult == ConnectivityResult.mobile) {
//               return Center(child: Text('Connected to Mobile Data'));
//             } else if (connectivityResult == ConnectivityResult.wifi) {
//               return Center(child: Text('Connected to Wi-Fi'));
//             } else {
//               return Center(child: Text('No Internet Connection'));
//             }
//           }
//
//           return Center(child: Text('Failed to get connectivity status'));
//         },
//       ),
//     );
//   }
// }
//
// void main() => runApp(MaterialApp(home: ConnectivityListenerWidget()));
