# Postmark App ColdFusion API

---

This is a ColdFusion Wrapper written to interact with the Postmark API for transactional emails.

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
    '/attachments/test.txt',
    '/attachments/something.png'
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
        '/attachments/test.txt',
        '/attachments/something.png'
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

## Useful Links

- http://developer.postmarkapp.com/
