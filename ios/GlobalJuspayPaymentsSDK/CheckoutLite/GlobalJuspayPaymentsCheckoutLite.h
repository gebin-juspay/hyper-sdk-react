//
//  GlobalJuspayPaymentsCheckoutLite.h
//

#import <Foundation/Foundation.h>
#import <HyperSDK/HyperCheckoutLite.h>

NS_ASSUME_NONNULL_BEGIN

typedef HyperSDKCallback GlobalJuspayPaymentsCallback;

@interface GlobalJuspayPaymentsCheckoutLite : HyperCheckoutLite

+ (void)openPaymentPage:(UIViewController * _Nonnull)viewController payload:(NSDictionary * _Nonnull)sdkPayload callback:(GlobalJuspayPaymentsCallback _Nonnull)callback;

@end

NS_ASSUME_NONNULL_END
