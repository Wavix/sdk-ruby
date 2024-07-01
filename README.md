# Wavix Backend Public API Ruby SDK

Welcome to the Wavix Ruby SDK documentation. This guide will walk you through installing, configuring, and using the Wavix Ruby SDK to interact seamlessly with the Wavix Backend Public API.

## Installing the SDK

To include the Wavix Ruby SDK in your application, add the following line to your Gemfile:
  
    gem 'wavix-sdk-ruby'

Then, run `bundle install` to install the gem.

## Configuration
  
First, obtain your token for connecting to the API (more information [here](https://wavix.com/api#/rest/getting-started/api-key-management)). Then, configure the `WavixApi` class with the necessary variables to enable future requests:
```
  WavixApi.host = 'api.wavix.com'
  WavixApi.api_key = 'your_token'
```
Replace `your_token` with the token you received.

## Overview

The Wavix Ruby SDK uses the [Faraday](https://github.com/lostisland/faraday) gem for making HTTP requests and returns service results using [Struct](https://ruby-doc.org/core-2.5.1/Struct.html).

Response attributes:

Attribute  | Description  | Example
------------- | ------------- | -------------
status  | Response status code  | 200
status_str  | String value of response status code  | OK
body  | Response JSON body  | `"{\"success\":true}"`
parsed_body | Parsed response body | `{ "success" => true }`
success? | Boolean state of response status | `true`

The Wavix Ruby SDK uses the [json-schema](https://github.com/voxpupuli/json-schema) for body and parameter validation. Errors related to invalid data in arguments will follow the logic of `json-schema`. These errors are raised as `WavixApi::ValidationError`, allowing you to handle them using `rescue`.

    "The property '#/a' of type String did not match the following type: integer"

## Examples

Once you have set your credentials, you can use the SDK to interact with the [Wavix Public API](https://wavix.com/api).

### Getting profile data
```
> WavixApi::V1::Profile::Find.new.call
=> #<struct status=200, status_str="OK", body="{\"id\":1,\"additional_info\":\"dev\",\"attn_contact_name\":\"wavix\",\"billing_address\":\"wavix in the house\",\"company_name\":\"wavix\",\"contact_email\":\"some@email.com\",\"default_destinations\":[],\"default_short_link_endpoint\":null,\"email\":\"some@email.com\",\"first_name\":\"First\",\"last_name\":\"Last\",\"phone\":\"1234567890\",\"timezone\":\"Europe/Berlin\"}", parsed_body={"id"=>1, "additional_info"=>"dev", "attn_contact_name"=>"wavix", "billing_address"=>"wavix in the house", "company_name"=>"wavix", "contact_email"=>"some@email.com", "default_destinations"=>[{"transport"=>"sip", "value"=>"Default SIP URI"}, {"transport"=>"pstn", "value"=>"Default PSTN"}], "default_short_link_endpoint"=>nil, "phone"=>"79231234567", "timezone"=>"Europe/Berlin"}, success?=true>
```

Alternatively, you can use a more concise version to achieve identical results.
```
> WavixApi::V1::Profile::Find.call
=> #<struct status=200, status_str="OK", body="{\"id\":1,\"additional_info\":\"dev\",\"attn_contact_name\":\"wavix\",\"billing_address\":\"wavix in the house\",\"company_name\":\"wavix\",\"contact_email\":\"some@email.com\",\"default_destinations\":[],\"default_short_link_endpoint\":null,\"email\":\"some@email.com\",\"first_name\":\"First\",\"last_name\":\"Last\",\"phone\":\"1234567890\",\"timezone\":\"Europe/Berlin\"}", parsed_body={"id"=>1, "additional_info"=>"dev", "attn_contact_name"=>"wavix", "billing_address"=>"wavix in the house", "company_name"=>"wavix", "contact_email"=>"some@email.com", "default_destinations"=>[{"transport"=>"sip", "value"=>"Default SIP URI"}, {"transport"=>"pstn", "value"=>"Default PSTN"}], "default_short_link_endpoint"=>nil, "phone"=>"79231234567", "timezone"=>"Europe/Berlin"}, success?=true>
```


### Searching Available DID Numbers for Purchase with Parameters
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

### Create message with body
```
> WavixApi::V2::Messages::Create.new(
  from: '12345678901', 
  to: '12345678902', 
  message_body: { 
    text: 'Test ruby sdk' 
  }
).call
=> #<struct status=201, status_str=“Created”, body="{\"charge\":\"0.0\",\"delivered_at\":null,\"error_message\":null,\"from\":\"+12345678901\",\"mcc\":\"310\",\"message_body\":{\"text\":\"Test ruby sdk\",\"media\":[]},\"message_id\":\"27b6ed5b-3536-412e-b0e3-4f421ba54212\",\"message_type\":\"sms\",\"mnc\":\"000\",\"segments\":1,\"sent_at\":null,\"status\":\"accepted\",\"submitted_at\":\"2024-06-26T14:02:08\",\"tag\":null,\"to\":\"+12345678902\"}", parsed_body={"charge"=>"0.0", "delivered_at"=>nil, "error_message"=>nil, "from"=>"+12345678901", "mcc"=>"310", "message_body"=>{"text"=>"Test ruby sdk", "media"=>[]}, "message_id"=>"27b6ed5b-3536-412e-b0e3-4f421ba54212", "message_type"=>"sms", "mnc"=>"000", "segments"=>1, "sent_at"=>nil, "status"=>"accepted", "submitted_at"=>"2024-06-26T14:02:08", "tag"=>nil, "to"=>"+12345678902"}, success?=true>
```

Or short version

```
> WavixApi::V2::Messages::Create.call(
  from: '12345678901', 
  to: '12345678902', 
  message_body: { 
    text: 'Test ruby sdk' 
  }
)
```

### Update Sub-organizations with ID and body
```
> WavixApi::V1::SubOrganizations::Update.new(name: 'Test ruby SDK', id: 123).call
=> #<struct status=200, status_str="OK", body="{\"api_key\":\"key\",\"created_at\":\"2024-03-12T15:32:49.000Z\",\"default_destinations\":{\"sms_endpoint\":\"\",\"dlr_endpoint\":\"\"},\"id\":123,\"master_organization\":100000,\"name\":\"Test ruby SDK\",\"status\":\"enabled\"}", parsed_body={"api_key"=>"key", "created_at"=>"2024-03-12T15:32:49.000Z", "default_destinations"=>{"sms_endpoint"=>"", "dlr_endpoint"=>""}, "id"=>123, "master_organization"=>100000, "name"=>"Test ruby SDK", "status"=>"enabled"}, success?=true>
```

Or short version
```
> WavixApi::V1::SubOrganizations::Update.call(name: 'Test ruby SDK', id: 123)
```

## Download billing invoice PDF

You can specify the path to save the file

```
WavixApi::V1::Billing::Invoices::Find.new(id: 1, save_path: 'path/to/file.pdf').call
```

## Create papers with File

To upload a file, use `File.open(path)`.

```
WavixApi::V1::Papers::Create.new(did_ids: '1,2', doc_id: 3, doc_attachment: File.open('file.jpg')}).call
```
