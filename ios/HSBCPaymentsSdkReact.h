/*
 * Copyright (c) Juspay Technologies.
 *
 * This source code is licensed under the AGPL 3.0 license found in the
 * LICENSE file in the root directory of this source tree.
 */


#import <React/RCTBridgeModule.h>
#import <React/RCTBridge.h>
#import <React/RCTEventEmitter.h>
#import <HSBCPayment/HSBCPaymentsServices.h>
#import <React/RCTRootView.h>
#import <React/RCTViewManager.h>

@interface HSBCPaymentsSdkReact : RCTEventEmitter <RCTBridgeModule>
@property HSBCPaymentsServices *hyperInstance;
@property id <HSBCPaymentsDelegate> delegate;

@end

@interface SdkDelegate : NSObject <HSBCPaymentsDelegate>
@property (nonatomic, strong) NSMutableDictionary *rootHolder;
@property (nonatomic, strong) NSMutableDictionary *heightHolder;
@property (nonatomic, strong) NSMutableDictionary *heightConstraintHolder;
@property (nonatomic, strong) RCTBridge *bridge;
- initWithBridge: (RCTBridge *) bridge;
@end

@interface SDKRootView : RCTRootView

@property (nonatomic, strong) NSLayoutConstraint *leading;
@property (nonatomic, strong) NSLayoutConstraint *trailing;

@end

@interface HyperFragmentViewManagerIOS : RCTViewManager
@end
