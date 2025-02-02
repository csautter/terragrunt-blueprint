```bash
AZURE_PRICE_CURRENCY=EUR
echo "Azure price currency: $AZURE_PRICE_CURRENCY"
AZURE_PRICE_REGION=germanywestcentral
echo "Azure price region: $AZURE_PRICE_REGION"
AZURE_PRICE_SKU=Standard_F2
echo "Azure price sku: $AZURE_PRICE_SKU"

AZURE_VM_PRICE=$(curl -sG https://prices.azure.com/api/retail/prices --data-urlencode "currencyCode=$AZURE_PRICE_CURRENCY" --data-urlencode "\$filter=serviceName eq 'Virtual Machines' and armRegionName eq '$AZURE_PRICE_REGION' and armSkuName eq '$AZURE_PRICE_SKU' and priceType eq 'Consumption'" | jq -r ".Items[] | select(all(.skuName; contains(\"Spot\") | not)) | select(all(.productName; contains(\"Windows\") | not)) | select(all(.meterName; contains(\"Low\") | not)) | .unitPrice")
echo "Azure VM price: $AZURE_VM_PRICE"
```