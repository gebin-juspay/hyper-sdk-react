import { AppRegistry } from 'react-native';
import App from './src/App';
import JuspayTopView from './src/JuspayTopView';
import JuspayTopViewAttached from './src/JuspayTopViewAttached';
import { name as appName } from './app.json';
import _JuspaySDKReact from '_juspay-payment-sdk-react';

AppRegistry.registerComponent(appName, () => App);

_JuspaySDKReact.notifyAboutRegisterComponent(
  _JuspaySDKReact._JuspayHeaderAttached
);
AppRegistry.registerComponent(
  _JuspaySDKReact._JuspayHeaderAttached,
  () => JuspayTopViewAttached
);
_JuspaySDKReact.notifyAboutRegisterComponent(_JuspaySDKReact._JuspayHeader);
AppRegistry.registerComponent(
  _JuspaySDKReact._JuspayHeader,
  () => JuspayTopView
);
