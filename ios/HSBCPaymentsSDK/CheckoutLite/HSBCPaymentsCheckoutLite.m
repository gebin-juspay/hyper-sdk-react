//
//  HSBCPaymentsCheckoutLite.m
//

#import "HSBCPaymentsCheckoutLite.h"
#import "HSBCPaymentsUtils.h"

@implementation HSBCPaymentsCheckoutLite

static NSString* tenantServiceName;

+ (void)openPaymentPage:(UIViewController * _Nonnull)viewController payload:(NSDictionary * _Nonnull)sdkPayload callback:(HSBCPaymentsCallback _Nonnull)callback {
    tenantServiceName = sdkPayload[@"service"];
    NSDictionary *updatedPayload = [HSBCPaymentsUtils updateServiceNameInPayload:sdkPayload tenantServiceName:tenantServiceName isResponse:false];
    [super openPaymentPage:viewController payload:updatedPayload callback:^(NSDictionary<NSString *,id> * _Nullable data) {
        NSDictionary *updatedResponse = [HSBCPaymentsUtils updateServiceNameInPayload:data tenantServiceName:tenantServiceName isResponse:true];
        callback(updatedResponse);
    }];
}

@end
