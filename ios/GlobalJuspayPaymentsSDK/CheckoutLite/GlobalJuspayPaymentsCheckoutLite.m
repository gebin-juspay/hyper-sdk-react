//
//  GlobalJuspayPaymentsCheckoutLite.m
//

#import "GlobalJuspayPaymentsCheckoutLite.h"
#import "GlobalJuspayPaymentsUtils.h"

@implementation GlobalJuspayPaymentsCheckoutLite

static NSString* tenantServiceName;

+ (void)openPaymentPage:(UIViewController * _Nonnull)viewController payload:(NSDictionary * _Nonnull)sdkPayload callback:(GlobalJuspayPaymentsCallback _Nonnull)callback {
    tenantServiceName = sdkPayload[@"service"];
    NSDictionary *updatedPayload = [GlobalJuspayPaymentsUtils updateServiceNameInPayload:sdkPayload tenantServiceName:tenantServiceName isResponse:false];
    [super openPaymentPage:viewController payload:updatedPayload callback:^(NSDictionary<NSString *,id> * _Nullable data) {
        NSDictionary *updatedResponse = [GlobalJuspayPaymentsUtils updateServiceNameInPayload:data tenantServiceName:tenantServiceName isResponse:true];
        callback(updatedResponse);
    }];
}

@end
