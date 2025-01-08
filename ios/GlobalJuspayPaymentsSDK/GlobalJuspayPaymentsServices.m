//
//  GlobalJuspayPaymentsServices.m
//

#import "GlobalJuspayPaymentsServices.h"
#import "GlobalJuspayPaymentsUtils.h"
#import "GlobalJuspayPaymentsConstants.h"

@interface GlobalJuspayPaymentsServices()

@property (nonatomic, strong) NSString *tenantServiceName;

@end

@implementation GlobalJuspayPaymentsServices

- (instancetype)init
{
    HyperTenantParams *tenantParams = [[HyperTenantParams alloc] init];
    tenantParams.tenantId = JP_GLOBAL_HYPER_TENANT_ID;
    tenantParams.releaseConfigURL = JP_GLOBAL_HYPER_RELEASE_CONFIG_URL;
    
    self = [super initWithTenantParams:tenantParams];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithClientId:(NSString *)clientId {
    HyperTenantParams *tenantParams = [[HyperTenantParams alloc] init];
    tenantParams.clientId = clientId;
    tenantParams.tenantId = JP_GLOBAL_HYPER_TENANT_ID;
    tenantParams.releaseConfigURL = JP_GLOBAL_HYPER_RELEASE_CONFIG_URL;
    
    self = [super initWithTenantParams:tenantParams];
    if (self) {
        
    }
    return self;
}

- (void)initiate:(UIViewController *)viewController payload:(NSDictionary *)initiationPayload callback:(GlobalJuspayPaymentsCallback)callback {
    self.tenantServiceName = initiationPayload[@"service"];
    NSDictionary *updatedPayload = [GlobalJuspayPaymentsUtils updateServiceNameInPayload:initiationPayload tenantServiceName:self.tenantServiceName isResponse:false];
    __weak GlobalJuspayPaymentsServices *weakSelf = self;
    [super initiate:viewController payload:updatedPayload callback:^(NSDictionary<NSString *,id> * _Nullable data) {
        NSDictionary *updatedResponse = [GlobalJuspayPaymentsUtils updateServiceNameInPayload:data tenantServiceName:weakSelf.tenantServiceName isResponse:true];
        callback(updatedResponse);
    }];
}

- (void)process:(UIViewController *)viewController processPayload:(NSDictionary *)processPayload {
    NSDictionary *updatedPayload = [GlobalJuspayPaymentsUtils updateServiceNameInPayload:processPayload tenantServiceName:self.tenantServiceName isResponse:false];
    [super process:viewController processPayload:updatedPayload];
}

- (void)process:(NSDictionary *)processPayload {
    NSDictionary *updatedPayload = [GlobalJuspayPaymentsUtils updateServiceNameInPayload:processPayload tenantServiceName:self.tenantServiceName isResponse:false];
    [super process:updatedPayload];
}

- (GlobalJuspayPaymentsEventsCallback)merchantEvent {
    return [super merchantEvent];
}

- (void)setDelegate:(id<GlobalJuspayPaymentsDelegate>)delegate {
    [super setHyperDelegate:delegate];
    _delegate = delegate;
}

@end
