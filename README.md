# Wavix Backend Public API Ruby SDK

This topic describes how to install, configure and use Wavix Ruby SDK.

## Installing the SDK

You can require it to your application
  
    gem 'wavix-sdk-ruby'


## Configure
  
First you need to get token for connecting to API. Then you need to define those variables to `WavixApi` class so they can be used in future requests.
```
  WavixApi.host = 'api.wavix.com'
  WavixApi.api_key = 'token'
```

## Overview

- SDK uses gem [Faraday](https://github.com/lostisland/faraday) for **requests** and returns service result using [Struct](https://ruby-doc.org/core-2.5.1/Struct.html)

    Attribute  | Description  | Example
    ------------- | ------------- | -------------
    status  | Response status code  | 200
    status_str  | String value of response status code  | OK
    body  | Response JSON body  | `"{\"success\":true}"`
    parsed_body | Parsed response body | `{ "success" => true }`
    success? | Boolean state of response status | `true`

- SDK uses [json-schema](https://github.com/voxpupuli/json-schema) for body/params **validation**. Thus, errors about invalid data in arguments will be displayed in accordance with the logic of the `json-schema`. Errors are raised with `WavixApi::ValidationError` so you can use `rescue` to handle them.

        "The property '#/a' of type String did not match the following type: integer"


## Examples
Now when you set your creds you can use SDK according to [Wavix Public API Documentation](https://wavix.com/api)

### Getting profile data
```
> WavixApi::V1::Profile::Find.new.call
=> #<struct status=200, status_str="OK", body="{\"id\":1,\"additional_info\":\"dev\",\"attn_contact_name\":\"wavix\",\"billing_address\":\"wavix in the house\",\"company_name\":\"wavix\",\"contact_email\":\"some@email.com\",\"default_destinations\":[],\"default_short_link_endpoint\":null,\"email\":\"some@email.com\",\"first_name\":\"First\",\"last_name\":\"Last\",\"phone\":\"1234567890\",\"timezone\":\"Europe/Berlin\"}", parsed_body={"id"=>1, "additional_info"=>"dev", "attn_contact_name"=>"wavix", "billing_address"=>"wavix in the house", "company_name"=>"wavix", "contact_email"=>"some@email.com", "default_destinations"=>[{"transport"=>"sip", "value"=>"Default SIP URI"}, {"transport"=>"pstn", "value"=>"Default PSTN"}], "default_short_link_endpoint"=>nil, "phone"=>"79231234567", "timezone"=>"Europe/Berlin"}, success?=true>
```

Also you can use shorter version to get the same result
```
> WavixApi::V1::Profile::Find.call
=> #<struct status=200, status_str="OK", body="{\"id\":1,\"additional_info\":\"dev\",\"attn_contact_name\":\"wavix\",\"billing_address\":\"wavix in the house\",\"company_name\":\"wavix\",\"contact_email\":\"some@email.com\",\"default_destinations\":[],\"default_short_link_endpoint\":null,\"email\":\"some@email.com\",\"first_name\":\"First\",\"last_name\":\"Last\",\"phone\":\"1234567890\",\"timezone\":\"Europe/Berlin\"}", parsed_body={"id"=>1, "additional_info"=>"dev", "attn_contact_name"=>"wavix", "billing_address"=>"wavix in the house", "company_name"=>"wavix", "contact_email"=>"some@email.com", "default_destinations"=>[{"transport"=>"sip", "value"=>"Default SIP URI"}, {"transport"=>"pstn", "value"=>"Default PSTN"}], "default_short_link_endpoint"=>nil, "phone"=>"79231234567", "timezone"=>"Europe/Berlin"}, success?=true>
```


### Search available DID numbers to buy with params
```
> WavixApi::V1::Buy::Dids::Search.new(type_filter: '', text_enabled_only: false, country_id: 1, city_id: 2}).call
=> #<struct status=200, status_str="OK", body="{\"dids\":[],\"pagination\":{\"total\":0,\"total_pages\":1,\"current_page\":1,\"per_page\":50}}", parsed_body={"dids"=>[], "pagination"=>{"total"=>0, "total_pages"=>1, "current_page"=>1, "per_page"=>50}}, success?=true>
```

Or short version
```
> WavixApi::V1::Buy::Dids::Search.call(type_filter: '', text_enabled_only: false, country_id: 1, city_id: 2)
```


### Destroy call recording by ID
```
> WavixApi::V1::Call::Recordings::Destroy.new(id: 123).call
=> #<struct status=400, status_str="Bad Request", body="{\"error\":true,\"message\":\"deleted due to the retention policy settings\",\"deleted_at\":\"2023-12-17T00:01:08.000Z\"}", parsed_body={"error"=>true, "message"=>"deleted due to the retention policy settings", "deleted_at"=>"2023-12-17T00:01:08.000Z"}, success?=false>
```

### Create E911 record with body
```
> WavixApi::V1::E911Records::Create.new(
  name: "Test ruby sdk",
  phone_number: "1234567890",
  address: {
    street_number: "550",
    street: "W Adams St",
    location: "2 floor",
    city: "Chicago",
    state: "Il",
    zip_code: "60661",
    zip_plus_four: "112"
  }
).call
=> #<struct status=200, status_str="OK", body="{\"e911_record\":{\"address\":{\"street_number\":\"550\",\"street\":\"W Adams St\",\"location\":\"2 floor\",\"city\":\"Chicago\",\"state\":\"IL\",\"zip_code\":\"60661\",\"zip_plus_four\":\"\"},\"name\":\"Test ruby sdk\",\"phone_number\":\"1234567890\"}}", parsed_body={"e911_record"=>{"address"=>{"street_number"=>"550", "street"=>"W Adams St", "location"=>"2 floor", "city"=>"Chicago", "state"=>"IL", "zip_code"=>"60661", "zip_plus_four"=>""}, "name"=>"Test ruby sdk", "phone_number"=>"1234567890"}}, success?=true>
```

Or short version

```
> WavixApi::V1::E911Records::Create.call(
  name: "Test ruby sdk",
  phone_number: "1234567890",
  address: {
    street_number: "550",
    street: "W Adams St",
    location: "2 floor",
    city: "Chicago",
    state: "Il",
    zip_code: "60661",
    zip_plus_four: "112"
  }
)
```

### Update sub organizations with ID and body
```
> WavixApi::V1::SubOrganizations::Update.new(name: 'Test ruby SDK', id: 123).call
=> #<struct status=200, status_str="OK", body="{\"api_key\":\"key\",\"created_at\":\"2024-03-12T15:32:49.000Z\",\"default_destinations\":{\"sms_endpoint\":\"\",\"dlr_endpoint\":\"\"},\"id\":123,\"master_organization\":100000,\"name\":\"Test ruby SDK\",\"status\":\"enabled\"}", parsed_body={"api_key"=>"key", "created_at"=>"2024-03-12T15:32:49.000Z", "default_destinations"=>{"sms_endpoint"=>"", "dlr_endpoint"=>""}, "id"=>123, "master_organization"=>100000, "name"=>"Test ruby SDK", "status"=>"enabled"}, success?=true>
```

Or short version
```
> WavixApi::V1::SubOrganizations::Update.call(name: 'Test ruby SDK', id: 123)
```

## Download billing invoice PDF

You can specify path to save the file

```
WavixApi::V1::Billing::Invoices::Find.new(id: 1).call(save_path: 'path/to/file.pdf')
```

## Papers creation with file

Use `File.open(path)` to upload the file

```
WavixApi::V1::Papers::Create.new(did_ids: '1,2', doc_id: 3, doc_attachment: File.open('file.jpg')}).call
```
