import { AppRegistry } from 'react-native';
import App from './src/App';
import JuspayTopView from './src/JuspayTopView';
import JuspayTopViewAttached from './src/JuspayTopViewAttached';
import { name as appName } from './app.json';
import LatamJuspayPaymentsSdkReact from 'latam-juspay-payments-sdk-react';

AppRegistry.registerComponent(appName, () => App);

LatamJuspayPaymentsSdkReact.notifyAboutRegisterComponent(
  LatamJuspayPaymentsSdkReact.LatamJuspayHeaderAttached
);
AppRegistry.registerComponent(
  LatamJuspayPaymentsSdkReact.LatamJuspayHeaderAttached,
  () => JuspayTopViewAttached
);
LatamJuspayPaymentsSdkReact.notifyAboutRegisterComponent(LatamJuspayPaymentsSdkReact.LatamJuspayHeader);
AppRegistry.registerComponent(
  LatamJuspayPaymentsSdkReact.LatamJuspayHeader,
  () => JuspayTopView
);
