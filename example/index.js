import { AppRegistry } from 'react-native';
import App from './src/App';
import JuspayTopView from './src/JuspayTopView';
import JuspayTopViewAttached from './src/JuspayTopViewAttached';
import { name as appName } from './app.json';
import GlobalJuspayPaymentsSdkReact from 'global-juspay-payments-sdk-react';

AppRegistry.registerComponent(appName, () => App);

GlobalJuspayPaymentsSdkReact.notifyAboutRegisterComponent(
  GlobalJuspayPaymentsSdkReact.GlobalJuspayHeaderAttached
);
AppRegistry.registerComponent(
  GlobalJuspayPaymentsSdkReact.GlobalJuspayHeaderAttached,
  () => JuspayTopViewAttached
);
GlobalJuspayPaymentsSdkReact.notifyAboutRegisterComponent(GlobalJuspayPaymentsSdkReact.GlobalJuspayHeader);
AppRegistry.registerComponent(
  GlobalJuspayPaymentsSdkReact.GlobalJuspayHeader,
  () => JuspayTopView
);
