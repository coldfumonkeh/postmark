# Postmark App ColdFusion API

---

This is a ColdFusion Wrapper written to interact with the Postmark API for transactional emails.

[![cfmlbadges](https://cfmlbadges.monkehworks.com/images/badges/tested-with-testbox.svg)](https://cfmlbadges.monkehworks.com)
[![cfmlbadges](https://cfmlbadges.monkehworks.com/images/badges/compatibility-coldfusion-9.svg)](https://cfmlbadges.monkehworks.com)
[![cfmlbadges](https://cfmlbadges.monkehworks.com/images/badges/compatibility-coldfusion-10.svg)](https://cfmlbadges.monkehworks.com)
[![cfmlbadges](https://cfmlbadges.monkehworks.com/images/badges/compatibility-lucee-45.svg)](https://cfmlbadges.monkehworks.com)
[![cfmlbadges](https://cfmlbadges.monkehworks.com/images/badges/compatibility-lucee-5.svg)](https://cfmlbadges.monkehworks.com)
[![cfmlbadges](https://cfmlbadges.monkehworks.com/images/badges/made-with-cfml.svg)](https://cfmlbadges.monkehworks.com)

## Authors

Developed by Matt Gifford (aka coldfumonkeh)

- http://www.mattgifford.co.uk
- http://www.monkehworks.com


### Share the love

Got a lot out of this package? Saved you time and money?

Share the love and visit Matt's wishlist: http://www.amazon.co.uk/wishlist/B9PFNDZNH4PY

---


## Requirements

This package requires ColdFusion 9+ or Lucee 4.5+

Please note that the tests require ColdFusion 10+ or Lucee 4.5+

You will need a valid Postmark account and an associated account token  to interact with the API.

## Examples

The API wrapper covers all of the methods available within the API. Here's a short sample of what can be achieved:

```
var oPostmark = new Postmark( accountToken='xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx' );

// List servers associated with the account
var servers = oPostmark.listServers();

// Get details on a specific server
var server = oPostmark.getServer( serverId='xxxxxxx' );

// Send an email with attachments
oPostmark.sendEmail(
  serverToken='xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx',
  From='senders@email.here',
  To='recipient@email.here',
  subject='Your awesome email subject line here',
  TextBody='This is the email email.',
  HtmlBody='<p>This is the email body</p>',
  attachments=[
    {name='Text File', srcfile='/attachments/test.txt'},
    {name='Image', srcfile='/attachments/something.png'}
  ]
);

// Send batch emails
oPostmark.sendBatchEmails(
  serverToken='xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx',
  emailData = [
    {
      From='senders@email.here',
      To='recipient@email.here',
      subject='First Batch Email',
      TextBody='This is an email.',
      attachments=[
        {name='Text File', srcfile='/attachments/test.txt'},
        {name='Image', srcfile='/attachments/something.png'}
      ]
    },
    {
      From='senders@email.here',
      To='recipient@email.here',
      subject='Second Batch Email',
      TextBody='This is an email .'
    }
  ]
);

// Validate a template
oPostmark.validateTemplate(
  servertoken = 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx',
  Subject = "{{##company}}{{name}}{{/company}} {{subjectHeadline}}",
  HtmlBody = "{{##company}}{{address}}{{/company}}{{##each person}} {{name}} {{/each}}",
  TextBody = "{{##company}}{{phone}}{{/company}}{{##each person}} {{name}} {{/each}}",
  TestRenderModel: {
    "userName": "bobby joe"
  }
);

// Send an email using a template
oPostmark.sendEmailWithTemplate(
    serverToken = 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx',
    templateId = 'xxxxxxx',
    TemplateModel = {
      'user_name' = 'John Smith',
      'company' = {
        'name' = 'ACME'
      }
    },
    from = 'senders@email.here',
    to = 'recipient@email.here'
);

```




# CommandBox Compatible

## Installation
This CF wrapper can be installed as standalone or as a ColdBox Module. Either approach requires a simple CommandBox command:

`box install postmark`

Then follow either the standalone or module instructions below.

### Standalone
This wrapper will be installed into a directory called `postmark` and then can be instantiated via `new postmark.Postmark()` with the following constructor arguments:

```
accountToken	=	'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx'
```

### ColdBox Module
This package also is a ColdBox module as well. The module can be configured by creating a `postmark` configuration structure in your application configuration file: config/Coldbox.cfc with the following settings:

```
postmark = {
  accountToken	=	'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx'
};
```
Then you can leverage the CFC via the injection DSL: `postmark@postmark"`

## License

The MIT License (MIT)

Copyright (c) 2017-2022 Matt Gifford

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

## Useful Links

- http://developer.postmarkapp.com/
