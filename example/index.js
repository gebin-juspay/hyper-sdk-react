import { AppRegistry } from 'react-native';
import App from './src/App';
import JuspayTopView from './src/JuspayTopView';
import JuspayTopViewAttached from './src/JuspayTopViewAttached';
import { name as appName } from './app.json';
import _JuspaySDKReact from '_juspay-payment-sdk-react';

AppRegistry.registerComponent(appName, () => App);

_JuspaySDKReact.notifyAboutRegisterComponent(
  _JuspaySDKReact.JuspayHeaderAttached
);
AppRegistry.registerComponent(
  _JuspaySDKReact.JuspayHeaderAttached,
  () => JuspayTopViewAttached
);
_JuspaySDKReact.notifyAboutRegisterComponent(_JuspaySDKReact.JuspayHeader);
AppRegistry.registerComponent(
  _JuspaySDKReact.JuspayHeader,
  () => JuspayTopView
);
