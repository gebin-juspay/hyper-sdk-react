//
//  HSBCPaymentsUtils.m
//

#import "HSBCPaymentsUtils.h"
#import "HSBCPaymentsConstants.h"

@implementation HSBCPaymentsUtils

+ (NSDictionary *)updateServiceNameInPayload:(NSDictionary *)payload tenantServiceName:(NSString *)tenantServiceName isResponse:(BOOL)isResponse {
    NSString *serviceName = payload[@"service"];
    if (serviceName) {
        BOOL serviceNameChanged = false;
        if (isResponse && ![tenantServiceName containsString:HSBC_HK_HYPER_SERVICE_PREFIX]) {
            serviceName = [serviceName stringByReplacingOccurrencesOfString:HSBC_HK_HYPER_SERVICE_PREFIX withString:@""];
            serviceNameChanged = true;
        } else if (![serviceName containsString:HSBC_HK_HYPER_SERVICE_PREFIX]) {
            serviceName = [NSString stringWithFormat:@"%@%@", HSBC_HK_HYPER_SERVICE_PREFIX, serviceName];
            serviceNameChanged = true;
        }
        
        if (!serviceNameChanged) {
            return payload;
        }
        
        NSMutableDictionary *updatedPayload = [NSMutableDictionary dictionaryWithDictionary:payload];
        updatedPayload[@"service"] = serviceName;
        
        return updatedPayload;
    }
    return payload;
}

@end
