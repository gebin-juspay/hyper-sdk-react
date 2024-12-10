import { AppRegistry } from 'react-native';
import App from './src/App';
import JuspayTopView from './src/JuspayTopView';
import JuspayTopViewAttached from './src/JuspayTopViewAttached';
import { name as appName } from './app.json';
import HSBCPaymentsSdkReact from 'hsbc-payments-sdk-react';

AppRegistry.registerComponent(appName, () => App);

HSBCPaymentsSdkReact.notifyAboutRegisterComponent(
  HSBCPaymentsSdkReact.HSBCHeaderAttached
);
AppRegistry.registerComponent(
  HSBCPaymentsSdkReact.HSBCHeaderAttached,
  () => JuspayTopViewAttached
);
HSBCPaymentsSdkReact.notifyAboutRegisterComponent(HSBCPaymentsSdkReact.HSBCHeader);
AppRegistry.registerComponent(
  HSBCPaymentsSdkReact.HSBCHeader,
  () => JuspayTopView
);
