require 'json'

tenantParams = {
    resource_url: "https://api.dms.gbm.hsbc.com/hyper/bundles/in.juspay.merchants/%@client_id/ios/release/assets.zip",
    sandbox_resource_url: "https://api.dms.gbm.hsbc.com/hyper/bundles/in.juspay.merchants/%@client_id/ios/release/assets.zip",
    versioned_resource_url: "https://api.dms.gbm.hsbc.com/hyper-sdk/in/juspay/merchants/hyper.assets.%@client_id/%@asset_version/hyper.assets.%@client_id-%@asset_version.zip",
    merchant_config_json: "HSBCConfig.json",
    tenant_id: "hsbc_hk"
}

system("ruby", "./Pods/HyperSDK/Fuse.rb", "true", "xcframework", JSON.generate(tenantParams))
