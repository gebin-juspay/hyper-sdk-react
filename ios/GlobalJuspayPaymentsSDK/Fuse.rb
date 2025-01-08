require 'json'

tenantParams = {
    resource_url: "https://payments.juspay.io/hyper/bundles/in.juspay.merchants/%@client_id/ios/release/assets.zip",
    sandbox_resource_url: "https://payments.juspay.io/hyper/bundles/in.juspay.merchants/%@client_id/ios/release/assets.zip",
    versioned_resource_url: "https://payments.juspay.io/hyper-sdk/in/juspay/merchants/hyper.assets.%@client_id/%@asset_version/hyper.assets.%@client_id-%@asset_version.zip",
    merchant_config_json: "GlobalJuspayPaymentsConfig.json",
    tenant_id: "jp_global"
}

system("ruby", "./Pods/HyperSDK/Fuse.rb", "true", "xcframework", JSON.generate(tenantParams))
