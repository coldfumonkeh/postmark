component output="false" accessors="true" {

  property name="accountToken"  type="string";
  property name="baseURL"       type="string";

  /**
  * Constructor
  */
  public Postmark function init(
    string accountToken = '',
    string baseURL = 'https://api.postmarkapp.com/'
  ){
    setAccountToken( arguments.accountToken );
    setBaseURL( arguments.baseURL );
    return this;
  }

  /*
  * EMAIL
  */

  /**
  * Sends a single email
  * @serverToken The server token.
  * @From	The sender email address. Must have a registered and confirmed Sender Signature.
  * @To	Recipient email address. Multiple addresses are comma separated. Max 50.
  * @Cc Cc recipient email address. Multiple addresses are comma separated. Max 50.
  * @Bcc Bcc recipient email address. Multiple addresses are comma separated. Max 50.
  * @Subject Email subject
  * @Tag Email tag that allows you to categorize outgoing emails and get detailed statistics.
  * @HtmlBody	REQUIRED - If no TextBody specified. HTML email message
  * @TextBody REQUIRED - If no HtmlBody specified. Plain text email message
  * @ReplyTo Reply To override email address. Defaults to the Reply To set in the sender signature.
  * @Headers List of custom headers to include.
  * @TrackOpens Activate open tracking for this email.
  * @TrackLinks Activate link tracking for links in the HTML or Text bodies of this email. Possible options: None HtmlAndText HtmlOnly TextOnly
  * @Metadata Custom metadata key/value pairs.
  * @Attachments List of attachments as an array.
  */
  public function sendEmail(
    required string serverToken,
    required string From,
    required string To,
    string CC,
    string Bcc,
    string Subject,
    string Tag,
    string HtmlBody,
    string TextBody,
    string ReplyTo,
    array Headers,
    boolean TrackOpens,
    string TrackLinks,
    struct Metadata,
    array Attachments
  ){
    var emailData = stripServerTokenAndClean( arguments );
    var aAttachments = [];
    if( structKeyExists(emailData, 'attachments' ) && arrayLen( emailData.attachments ) ){
      for( var attachment in emailData.attachments ){
        arrayAppend(
          aAttachments,
          {
            'Name'        = attachment.name,
            'Content'     = toBase64( fileReadBinary( attachment.srcfile ) ),
            'ContentType' = fileGetMimeType( attachment.srcfile )
          }
        );
      }
      structUpdate( emailData, 'Attachments', aAttachments );
    }
    var sBody = serializeJSON( emailData );
    return makeServerRequest( endpoint='email', body=sBody, serverToken=arguments.serverToken, method='POST' );
  }

  /**
  * Send batch emails
  * @serverToken The server token.
  * @emailData An array of required and optional information for each email. Please see properties in sendEmail for details.
  */
  public function sendBatchEmails(
    required string serverToken,
    required array emailData
  ){
    for( var email in arguments.emailData ){
      var aAttachments = [];
      if( structKeyExists(email, 'attachments' ) && arrayLen( email.attachments ) ){
        for( var attachment in email.attachments ){
          arrayAppend(
            aAttachments,
            {
              'Name'        = attachment.name,
              'Content'     = toBase64( fileReadBinary( attachment.srcfile ) ),
              'ContentType' = fileGetMimeType( attachment.srcfile )
            }
          );
        }
        structUpdate( email, 'Attachments', aAttachments );
      }
    }
    var sBody = serializeJSON( emailData );
    return makeServerRequest( endpoint='email/batch', body=sBody, serverToken=arguments.serverToken, method='POST' );
  }

  /*
  * BOUNCE
  */

  /**
  * Get delivery stats
  * @serverToken The server token.
  */
  public function getDeliveryStats(
      required string serverToken
  ){
    return makeServerRequest( endpoint='deliverystats', serverToken=arguments.serverToken, method='GET' );
  }

  /**
  * Get bounces
  * @serverToken The server token.
  * @count Number of bounces to return per request. Max 500. Defaults to 10,
  * @offset Number of bounces to skip. Defaults to 0.
  * @type	Filter by type of bounce
  * @inactive	Filter by emails that were deactivated by Postmark due to the bounce. Set to true or false. If this isn’t specified it will return both active and inactive.
  * @emailFilter Filter by email address
  * @tag Filter by tag
  * @messageID Filter by messageID
  * @fromdate	Filter messages starting from the date specified (inclusive). e.g. 2014-02-01
  * @todate	Filter messages up to the date specified (inclusive). e.g. 2014-02-01
  */
  public function getBounces(
      required string serverToken,
      required numeric count = 10,
      required numeric offset = 0,
      string type,
      boolean inactive,
      string emailFilter,
      string tag,
      numeric messageID,
      string fromdate,
      string todate
  ){
    var sParams = structCopy( arguments );
    structDelete( sParams, 'serverToken' );
    return makeServerRequest( endpoint='bounces', serverToken=arguments.serverToken, method='GET', params=sParams );
  }

  /**
  * @serverToken The server token.
  * @bounceId The bounce id.
  */
  public function getBounceById(
      required string serverToken,
      required numeric bounceId
  ){
    return makeServerRequest( endpoint='bounces/#arguments.bounceId#', serverToken=arguments.serverToken, method='GET' );
  }

  /**
  * Get bounce dump
  * @serverToken The server token.
  * @bounceId The bounce id.
  */
  public function getBounceDump(
    required string serverToken,
    required string bounceId
  ){
    return makeServerRequest( endpoint='bounces/#arguments.bounceId#/dump', serverToken=arguments.serverToken, method='GET' );
  }

  /**
  * Activate a bounce
  * @serverToken The server token.
  * @bounceId The bounce id.
  */
  public function activateBounce(
    required string serverToken,
    required string bounceId
  ){
    return makeServerRequest( endpoint='bounces/#arguments.bounceId#/activate', serverToken=arguments.serverToken, method='PUT' );
  }

  /**
  * Get bounced tags
  * @serverToken The server token.
  */
  public function getBouncedTags(
    required string serverToken
  ){
    return makeServerRequest( endpoint='bounces/tags', serverToken=arguments.serverToken, method='GET' );
  }


  /*
  * TEMPLATES
  */

  /**
  * Get a template
  * @serverToken The server token.
  * @templateId The template id.
  */
  public function getTemplate(
    required string serverToken,
    required numeric templateId
  ){
    return makeServerRequest( endpoint='templates/#arguments.templateId#', serverToken=arguments.serverToken, method='GET' );
  }

  /**
  * List templates
  * @serverToken The server token.
  * @count Number of templates to return. Defaults to 10,
  * @offset Number of templates to skip before returning results. Defaults to 0.
  */
  public function listTemplates(
    required string serverToken,
    required numeric count = 10,
    required numeric offset = 0
  ){
    var sParams = structCopy( arguments );
    structDelete( sParams, 'serverToken' );
    return makeServerRequest( endpoint='templates', serverToken=arguments.serverToken, method='GET', params=sParams );
  }

  /**
  * Creates a new template
  * @serverToken The server token.
  * @Name Name of template
  * @Subject The content to use for the Subject when this template is used to send email. See our template language documentation for more information on the syntax for this field.
  * @HtmlBody The content to use for the HtmlBody when this template is used to send email. Required if TextBody is not specified. See our template language documentation for more information on the syntax for this field.
  * @TextBody The content to use for the TextBody when this template is used to send email. Required if HtmlBody is not specified. See our template language documentation for more information on the syntax for this field.
  */
  public function createTemplate(
    required string serverToken,
    required string Name,
    required string Subject,
    string HtmlBody,
    string TextBody
  ){
    var sBody = serializeJSON( structCleanser( arguments ) );
    return makeServerRequest( endpoint='templates', serverToken=arguments.serverToken, method='POST', body=sBody );
  }

  /**
  * Edit a template
  * @serverToken The server token.
  * @templateId The template id.
  * @Name Name of template
  * @Subject The content to use for the Subject when this template is used to send email. See our template language documentation for more information on the syntax for this field.
  * @HtmlBody The content to use for the HtmlBody when this template is used to send email. Required if TextBody is not specified. See our template language documentation for more information on the syntax for this field.
  * @TextBody The content to use for the TextBody when this template is used to send email. Required if HtmlBody is not specified. See our template language documentation for more information on the syntax for this field.
  */
  public function editTemplate(
    required string serverToken,
    required numeric templateId,
    required string Name,
    required string Subject,
    string HtmlBody,
    string TextBody
  ){
    var sBody = serializeJSON( structCleanser( arguments ) );
    return makeServerRequest( endpoint='templates/#arguments.templateId#', serverToken=arguments.serverToken, method='PUT', body=sBody );
  }

  /**
  * Delete a template
  * @serverToken The server token.
  * @templateId The template id.
  */
  public function deleteTemplate(
    required string serverToken,
    required numeric templateId
  ){
    return makeServerRequest( endpoint='templates/#arguments.templateId#', serverToken=arguments.serverToken, method='DELETE' );
  }

  /**
  * Validate a template
  * @serverToken The server token.
  * @Subject The content to use for the Subject when this template is used to send email. See our template language documentation for more information on the syntax for this field.
  * @HtmlBody The content to use for the HtmlBody when this template is used to send email. Required if TextBody is not specified. See our template language documentation for more information on the syntax for this field.
  * @TextBody The content to use for the TextBody when this template is used to send email. Required if HtmlBody is not specified. See our template language documentation for more information on the syntax for this field.
  * @TestRenderModel The model to be used when rendering test content.
  * @InlineCssForHtmlTestRender When HtmlBody is specified, the test render will have style blocks inlined as style attributes on matching html elements. You may disable the css inlining behavior by passing false for this parameter.
  */
  public function validateTemplate(
    required string serverToken,
    required string Subject,
    required string HtmlBody,
    required string TextBody,
    struct TestRenderModel,
    boolean InlineCssForHtmlTestRender
  ){
    var sBody = serializeJSON( structCleanser( arguments ) );
    return makeServerRequest( endpoint='templates/validate', serverToken=arguments.serverToken, method='POST', body=sBody );
  }

  /**
  * Send email with template
  * @serverToken The server token.
  * @templateId The template to use when sending this message.
  * @TemplateModel The model to be applied to the specified template to generate HtmlBody, TextBody, and Subject.
  * @InlineCss By default, if the specified template contains an HTMLBody, we will apply the style blocks as inline attributes to the rendered HTML content. You may opt-out of this behavior by passing false for this request field.
  * @From	The sender email address. Must have a registered and confirmed Sender Signature.
  * @To	Recipient email address. Multiple addresses are comma separated. Max 50.
  * @Cc Cc recipient email address. Multiple addresses are comma separated. Max 50.
  * @Bcc Bcc recipient email address. Multiple addresses are comma separated. Max 50.
  * @Tag Email tag that allows you to categorize outgoing emails and get detailed statistics.
  * @ReplyTo Reply To override email address. Defaults to the Reply To set in the sender signature.
  * @Headers List of custom headers to include.
  * @TrackOpens Activate open tracking for this email.
  * @TrackLinks Activate link tracking for links in the HTML or Text bodies of this email. Possible options: None HtmlAndText HtmlOnly TextOnly
  * @Attachments List of attachments as an array.
  */
  public function sendEmailWithTemplate(
    required string serverToken,
    required numeric templateId,
    required struct TemplateModel,
    boolean InlineCss,
    required string From,
    required string To,
    string CC,
    string Bcc,
    string Tag,
    string ReplyTo,
    array Headers,
    boolean TrackOpens,
    string TrackLinks,
    array Attachments
  ){
    var sBody = serializeJSON( structCleanser( arguments ) );
    return makeServerRequest( endpoint='email/withTemplate', serverToken=arguments.serverToken, method='POST', body=sBody );
  }


  /*
  * SERVERS
  */

  /**
  * Get a server
  * @serverId The id of the server.
  */
  public function getServer(
    required string serverId
  ){
    return makeAccountRequest( endpoint='servers/#arguments.serverId#' );
  }

  /**
  * Creates a new server
  * @Name Name of the server
  * @Color Color of the server in the rack screen. Purple, Blue, Turqoise, Green, Red, Yellow, Grey.
  * @RawEmailEnabled Enable raw email to be sent with inbound
  * @SmtpApiActivated Specifies whether or not SMTP is enabled on this server.
  * @DeliveryHookUrl URL to POST to every time email is delivered.
  * @InboundHookUrl URL to POST to every time an inbound event occurs.
  * @BounceHookUrl URL to POST to every time a bounce event occurs.
  * @IncludeBounceContentInHook Include bounce content in webhook.
  * @OpenHookUrl URL to POST to every time an open event occurs.
  * @PostFirstOpenOnly If set to true, only the first open by a particular recipient will initiate the open webhook. Any subsequent opens of the same email by the same recipient will not initiate the webhook.
  * @TrackOpens Indicates if all emails being sent through this server have open tracking enabled.
  * @TrackLinks Indicates if all emails being sent through this server should have link tracking enabled for links in their HTML or Text bodies. Possible options: None HtmlAndText HtmlOnly TextOnly
  * @InboundDomain Inbound domain for MX setup
  * @InboundSpamThreshold The maximum spam score for an inbound message before it's blocked.
  */
  public function createServer(
    required string Name,
    string Color,
    boolean RawEmailEnabled,
    boolean SmtpApiActivated,
    string DeliveryHookUrl,
    string InboundHookUrl,
    string BounceHookUrl,
    boolean IncludeBounceContentInHook,
    string OpenHookUrl,
    boolean PostFirstOpenOnly,
    boolean TrackOpens,
    string TrackLinks,
    string InboundDomain,
    numeric InboundSpamThreshold
  ){
    var sBody = serializeJSON( structCleanser( arguments ) );
    return makeAccountRequest( endpoint='servers', method='POST', body=sBody );
  }

  /**
  * Edits a server
  * @serverId The id of the server.
  * @Name Name of the server
  * @Color Color of the server in the rack screen. Purple, Blue, Turqoise, Green, Red, Yellow, Grey.
  * @RawEmailEnabled Enable raw email to be sent with inbound
  * @SmtpApiActivated Specifies whether or not SMTP is enabled on this server.
  * @DeliveryHookUrl URL to POST to every time email is delivered.
  * @InboundHookUrl URL to POST to every time an inbound event occurs.
  * @BounceHookUrl URL to POST to every time a bounce event occurs.
  * @IncludeBounceContentInHook Include bounce content in webhook.
  * @OpenHookUrl URL to POST to every time an open event occurs.
  * @PostFirstOpenOnly If set to true, only the first open by a particular recipient will initiate the open webhook. Any subsequent opens of the same email by the same recipient will not initiate the webhook.
  * @TrackOpens Indicates if all emails being sent through this server have open tracking enabled.
  * @TrackLinks Indicates if all emails being sent through this server should have link tracking enabled for links in their HTML or Text bodies. Possible options: None HtmlAndText HtmlOnly TextOnly
  * @InboundDomain Inbound domain for MX setup
  * @InboundSpamThreshold The maximum spam score for an inbound message before it's blocked.
  */
  public function editServer(
    required string serverId,
    string Name,
    string Color,
    boolean RawEmailEnabled,
    boolean SmtpApiActivated,
    string DeliveryHookUrl,
    string InboundHookUrl,
    string BounceHookUrl,
    boolean IncludeBounceContentInHook,
    string OpenHookUrl,
    boolean PostFirstOpenOnly,
    boolean TrackOpens,
    string TrackLinks,
    string InboundDomain,
    numeric InboundSpamThreshold
  ){
    var sBody = serializeJSON( structCleanser( arguments ) );
    return makeAccountRequest( endpoint='servers/#arguments.serverId#', method='PUT', body=sBody );
  }

  /**
  * Returns all servers associated with the account
  * @count Number of servers to return per request. Defaults to 10.
  * @offset Number of servers to skip. Defaults to 0.
  * @name Filter by a specific server name.
  */
  public function listServers(
      required numeric count = 10,
      required numeric offset = 0,
      string name
  ){
    return makeAccountRequest( endpoint='servers', params=arguments );
  }

  /**
  * Delete a server
  * @serverId The id of the server.
  */
  public function deleteServer(
    required string serverId
  ){
    return makeAccountRequest( endpoint='servers/#arguments.serverId#', method='DELETE' );
  }

  /*
  * MESSAGES
  */

  /**
  * Outbound message search.
  * @serverToken The server token.
  * @count Number of messages to return per request. Max 500. Defaults to 10.
  * @offset Number of messages to skip. Defaults to 0.
  * @recipient Filter by the user who was receiving the email
  * @fromemail Filter by the sender email address
  * @tag Filter by tag
  * @status	Filter by status (queued or sent)
  * @todate	Filter messages up to the date specified (inclusive). e.g. 2014-02-01
  * @fromdate	Filter messages starting from the date specified (inclusive). e.g. 2014-02-01
  */
  public function outboundMessageSearch(
    required string serverToken,
    required numeric count = 10,
    required numeric offset = 0,
    string recipient,
    string fromemail,
    string tag,
    string status,
    string todate,
    string fromdate
  ){
    var sParams = structCopy( arguments );
    structDelete( sParams, 'serverToken' );
    return makeServerRequest( endpoint='messages/outbound', serverToken=arguments.serverToken, method='GET', params=sParams );
  }

  /**
  * Outbound message details
  * @serverToken The server token.
  * @messageId The message id.
  */
  public function outboundMessageDetails(
    required string serverToken,
    required string messageId
  ){
    return makeServerRequest( endpoint='messages/outbound/#arguments.messageId#/details', serverToken=arguments.serverToken, method='GET' );
  }

  /**
  * Outbound message dump
  * @serverToken The server token.
  * @messageId The message id.
  */
  public function outboundMessageDump(
    required string serverToken,
    required string messageId
  ){
    return makeServerRequest( endpoint='messages/outbound/#arguments.messageId#/dump', serverToken=arguments.serverToken, method='GET' );
  }

  /**
  * Inbound message search.
  * @serverToken The server token.
  * @count Number of messages to return per request. Max 500. Defaults to 10.
  * @offset Number of messages to skip. Defaults to 0.
  * @recipient Filter by the user who was receiving the email
  * @fromemail Filter by the sender email address
  * @tag Filter by tag
  * @status	Filter by status (queued or sent)
  * @todate	Filter messages up to the date specified (inclusive). e.g. 2014-02-01
  * @fromdate	Filter messages starting from the date specified (inclusive). e.g. 2014-02-01
  */
  public function inboundMessageSearch(
    required string serverToken,
    required numeric count = 10,
    required numeric offset = 0,
    string recipient,
    string fromemail,
    string tag,
    string status,
    string todate,
    string fromdate
  ){
    var sParams = structCopy( arguments );
    structDelete( sParams, 'serverToken' );
    return makeServerRequest( endpoint='messages/inbound', serverToken=arguments.serverToken, method='GET', params=sParams );
  }

  /**
  * Inbound message details
  * @serverToken The server token.
  * @messageId The message id.
  */
  public function inboundMessageDetails(
    required string serverToken,
    required string messageId
  ){
    return makeServerRequest( endpoint='messages/inbound/#arguments.messageId#/details', serverToken=arguments.serverToken, method='GET' );
  }

  /**
  * Bypass rules for a blocked inbound message
  * @serverToken The server token.
  * @messageId The message id.
  */
  public function bypassRulesForBlockedInboundMessage(
    required string serverToken,
    required string messageId
  ){
    return makeServerRequest( endpoint='messages/inbound/#arguments.messageId#/bypass', serverToken=arguments.serverToken, method='PUT' );
  }

  /**
  * Retry a failed inbound message for processing
  * @serverToken The server token.
  * @messageId The message id.
  */
  public function retryFailedInboundMessage(
    required string serverToken,
    required string messageId
  ){
    return makeServerRequest( endpoint='messages/inbound/#arguments.messageId#/retry', serverToken=arguments.serverToken, method='PUT' );
  }

  /**
  * Message opens
  * @serverToken The server token.
  * @count Number of message opens to return per request. Max 500. Defaults to 10.
  * @offset Number of messages to skip. Defaults to 0.
  * @recipient Filter by To, Cc, Bcc
  * @tag Filter by tag
  * @client_name	Filter by client name, i.e. Outlook, Gmail
  * @client_company	Filter by company, i.e. Microsoft, Apple, Google
  * @client_family Filter by client family, i.e. OS X, Chrome
  * @os_name Filter by full OS name and specific version, i.e. OS X 10.9 Mavericks, Windows 7
  * @os_family Filter by kind of OS used without specific version, i.e. OS X, Windows
  * @os_company	Filter by company which produced the OS, i.e. Apple Computer, Inc., Microsoft Corporation
  * @platform	Filter by platform, i.e. webmail, desktop, mobile
  * @country Filter by country messages were opened in, i.e. Denmark, Russia
  * @region	Filter by full name of region messages were opened in, i.e. Moscow, New York
  * @city	Filter by full name of city messages were opened in, i.e. Minneapolis, Philadelphia
  */
  public function messageOpens(
    required string serverToken,
    required numeric count = 10,
    required numeric offset = 0,
    string recipient,
    string tag,
    string client_name,
    string client_company,
    string client_family,
    string os_name,
    string os_family,
    string os_company,
    string platform,
    string country,
    string region,
    string city
  ){
    var sParams = structCopy( arguments );
    structDelete( sParams, 'serverToken' );
    return makeServerRequest( endpoint='messages/outbound/opens', serverToken=arguments.serverToken, method='GET', params=sParams );
  }

  /**
  * Opens for a single message
  * @serverToken The server token.
  * @messageId The message id.
  * @count Number of message opens to return per request. Max 500. Defaults to 10.
  * @offset Number of messages to skip. Defaults to 0.
  */
  public function messageOpenById(
    required string serverToken,
    required string messageId,
    required numeric count = 10,
    required numeric offset = 0
  ){
    var sParams = structCopy( arguments );
    structDelete( sParams, 'serverToken' );
    return makeServerRequest( endpoint='messages/outbound/opens/#arguments.messageId#', serverToken=arguments.serverToken, method='GET', params=sParams );
  }

  /*
  * DOMAINS
  */

  /**
  * Gets a list of domains containing an overview of the domain and authentication status.
  * @count Number of records to return per request. Max 500. Defaults to 10.
  * @offset Number of records to skip. Defaults to 0.
  */
  public function listDomains(
    required numeric count = 10,
    required numeric offset = 0
  ){
    return makeAccountRequest( endpoint='domains', params=arguments );
  }

  /**
  * Gets all the details for a specific domain.
  * @domainId The domain id.
  */
  public function getDomainDetails(
    required numeric domainId
  ){
    return makeAccountRequest( endpoint='domains/#arguments.domainId#', params=arguments );
  }

  /**
  * Gets all the details for a specific domain.
  * @Name Domain name.
  * @ReturnPathDomain A custom value for the Return-Path domain. It is an optional field, but it must be a subdomain of your From Email domain and must have a CNAME record that points to pm.mtasv.net.
  */
  public function createDomain(
    required string Name,
    string ReturnPathDomain
  ){
    var sBody = serializeJSON( arguments );
    return makeAccountRequest( endpoint='domains', method='POST', body=sBody );
  }

  /**
  * Edit a domain.
  * @domainId The domain id.
  * @ReturnPathDomain A custom value for the Return-Path domain. It must be a subdomain of your From Email domain and must have a CNAME record that points to pm.mtasv.net.
  */
  public function editDomain(
    required numeric domainId,
    string ReturnPathDomain = ''
  ){
    var sBody = structCopy( arguments );
    structDelete( sBody, 'domainId' );
    sBody = serializeJSON( sBody );
    return makeAccountRequest( endpoint='domains/#arguments.domainId#', method='PUT', body=sBody );
  }

  /**
  * Delete a domain.
  * @domainId The domain id.
  */
  public function deleteDomain(
    required numeric domainId
  ){
    return makeAccountRequest( endpoint='domains/#arguments.domainId#', method='DELETE' );
  }

  /**
  * Will query DNS for your domain and attempt to verify the SPF record contains the information for Postmark's servers.
  * @domainId The domain id.
  */
  public function verifyDomainSPF(
    required numeric domainId
  ){
    return makeAccountRequest( endpoint='domains/#arguments.domainId#/verifyspf', method='POST' );
  }

  /**
  * Creates a new DKIM key to replace your current key. Until the new DNS entries are confirmed, the pending values will be in DKIMPendingHost and DKIMPendingTextValue fields. After the new DKIM value is verified in DNS, the pending values will migrate to DKIMTextValue and DKIMPendingTextValue and Postmark will begin to sign emails with the new DKIM key.
  * @domainId The domain id.
  */
  public function rotateDKIMKeys(
    required numeric domainId
  ){
    return makeAccountRequest( endpoint='domains/#arguments.domainId#/rotatedkim', method='POST' );
  }

  /*
  * SIGNATURES
  */

  /**
  * Gets a list of sender signatures containing brief details associated with your account.
  * @count Number of records to return per request. Max 500. Defaults to 10.
  * @offset Number of records to skip. Defaults to 0.
  */
  public function listSenderSignatures(
    required numeric count = 10,
    required numeric offset = 0
  ){
    return makeAccountRequest( endpoint='senders', params=arguments );
  }

  /**
  * Gets all the details for a specific sender signature.
  * @signatureId The signature id.
  */
  public function getSenderSignatureDetails(
    required numeric signatureId
  ){
    return makeAccountRequest( endpoint='senders/#arguments.signatureId#', params=arguments );
  }

  /**
  * Create a new sender signature.
  * @FromEmail From email associated with sender signature.
  * @Name From name associated with sender signature.
  * @ReplyToEmail Override for reply-to address.
  * @ReturnPathDomain A custom value for the Return-Path domain. It is an optional field, but it must be a subdomain of your From Email domain and must have a CNAME record that points to pm.mtasv.net.
  */
  public function createSignature(
    required string FromEmail,
    required string Name,
    string ReplyToEmail,
    string ReturnPathDomain
  ){
    var sBody = serializeJSON( structCleanser( arguments ) );
    return makeAccountRequest( endpoint='senders', method='POST', body=sBody );
  }

  /**
  * Edit a sender signature.
  * @signatureId The signature id.
  * @Name From name associated with sender signature.
  * @ReplyToEmail Override for reply-to address.
  * @ReturnPathDomain A custom value for the Return-Path domain. It is an optional field, but it must be a subdomain of your From Email domain and must have a CNAME record that points to pm.mtasv.net.
  */
  public function editSignature(
    required numeric signatureId,
    required string Name,
    string ReplyToEmail,
    string ReturnPathDomain
  ){
    var sBody = structCopy( arguments );
    structDelete( sBody, 'signatureId' );
    sBody = serializeJSON( structCleanser( sBody ) );
    return makeAccountRequest( endpoint='senders/#arguments.signatureId#', method='PUT', body=sBody );
  }

  /**
  * Delete a sender signature.
  * @signatureId The signature id.
  */
  public function deleteSignature(
    required numeric signatureId
  ){
    return makeAccountRequest( endpoint='senders/#arguments.signatureId#', method='DELETE' );
  }

  /**
  * Resend a confirmation.
  * @signatureId The signature id.
  */
  public function resendConfirmation(
    required numeric signatureId
  ){
    return makeAccountRequest( endpoint='senders/#arguments.signatureId#/resend', method='POST' );
  }

  /*
  * STATS
  */

  /**
  * Gets a brief overview of statistics for all of your outbound email.
  * @serverToken The server token.
  * @tag Filter by tag
  * @fromdate Filter stats starting from the date specified (inclusive). e.g. 2014-01-01
  * @todate Filter stats up to the date specified (inclusive). e.g. 2014-02-01
  */
  public function getOutboundOverview(
      required string serverToken,
      string tag,
      string fromdate,
      string todate
  ){
    return makeServerRequest( endpoint='stats/outbound', serverToken=arguments.serverToken, method='GET' );
  }

  /**
  * Gets a total count of emails you’ve sent out.
  * @serverToken The server token.
  * @tag Filter by tag
  * @fromdate Filter stats starting from the date specified (inclusive). e.g. 2014-01-01
  * @todate Filter stats up to the date specified (inclusive). e.g. 2014-02-01
  */
  public function getSentCounts(
      required string serverToken,
      string tag,
      string fromdate,
      string todate
  ){
    return makeServerRequest( endpoint='stats/outbound/sends', serverToken=arguments.serverToken, method='GET' );
  }

  /**
  * Gets total counts of emails you’ve sent out that have been returned as bounced.
  * @serverToken The server token.
  * @tag Filter by tag
  * @fromdate Filter stats starting from the date specified (inclusive). e.g. 2014-01-01
  * @todate Filter stats up to the date specified (inclusive). e.g. 2014-02-01
  */
  public function getBounceCounts(
      required string serverToken,
      string tag,
      string fromdate,
      string todate
  ){
    return makeServerRequest( endpoint='stats/outbound/bounces', serverToken=arguments.serverToken, method='GET' );
  }

  /**
  * Gets a total count of recipients who have marked your email as spam.
  * @serverToken The server token.
  * @tag Filter by tag
  * @fromdate Filter stats starting from the date specified (inclusive). e.g. 2014-01-01
  * @todate Filter stats up to the date specified (inclusive). e.g. 2014-02-01
  */
  public function getSpamComplaints(
      required string serverToken,
      string tag,
      string fromdate,
      string todate
  ){
    return makeServerRequest( endpoint='stats/outbound/spam', serverToken=arguments.serverToken, method='GET' );
  }

  /**
  * Gets a total count of emails you’ve sent with open tracking or link tracking enabled.
  * @serverToken The server token.
  * @tag Filter by tag
  * @fromdate Filter stats starting from the date specified (inclusive). e.g. 2014-01-01
  * @todate Filter stats up to the date specified (inclusive). e.g. 2014-02-01
  */
  public function getTrackedEmailCounts(
      required string serverToken,
      string tag,
      string fromdate,
      string todate
  ){
    return makeServerRequest( endpoint='stats/outbound/tracked', serverToken=arguments.serverToken, method='GET' );
  }

  /**
  * Gets total counts of recipients who opened your emails. This is only recorded when open tracking is enabled for that email.
  * @serverToken The server token.
  * @tag Filter by tag
  * @fromdate Filter stats starting from the date specified (inclusive). e.g. 2014-01-01
  * @todate Filter stats up to the date specified (inclusive). e.g. 2014-02-01
  */
  public function getEmailOpenCounts(
      required string serverToken,
      string tag,
      string fromdate,
      string todate
  ){
    return makeServerRequest( endpoint='stats/outbound/opens', serverToken=arguments.serverToken, method='GET' );
  }

  /**
  * Gets an overview of the platforms used to open your emails. This is only recorded when open tracking is enabled for that email.
  * @serverToken The server token.
  * @tag Filter by tag
  * @fromdate Filter stats starting from the date specified (inclusive). e.g. 2014-01-01
  * @todate Filter stats up to the date specified (inclusive). e.g. 2014-02-01
  */
  public function getEmailPlatformUsage(
      required string serverToken,
      string tag,
      string fromdate,
      string todate
  ){
    return makeServerRequest( endpoint='stats/outbound/platforms', serverToken=arguments.serverToken, method='GET' );
  }

  /**
  * Gets an overview of the email clients used to open your emails. This is only recorded when open tracking is enabled for that email.
  * @serverToken The server token.
  * @tag Filter by tag
  * @fromdate Filter stats starting from the date specified (inclusive). e.g. 2014-01-01
  * @todate Filter stats up to the date specified (inclusive). e.g. 2014-02-01
  */
  public function getEmailClientUsage(
      required string serverToken,
      string tag,
      string fromdate,
      string todate
  ){
    return makeServerRequest( endpoint='stats/outbound/emailclients', serverToken=arguments.serverToken, method='GET' );
  }

  /**
  * Gets the length of time that recipients read emails along with counts for each time. This is only recorded when open tracking is enabled for that email. Read time tracking stops at 20 seconds, so any read times above that will appear in the 20s+ field.
  * @serverToken The server token.
  * @tag Filter by tag
  * @fromdate Filter stats starting from the date specified (inclusive). e.g. 2014-01-01
  * @todate Filter stats up to the date specified (inclusive). e.g. 2014-02-01
  */
  public function getEmailReadTimes(
      required string serverToken,
      string tag,
      string fromdate,
      string todate
  ){
    return makeServerRequest( endpoint='stats/outbound/readtimes', serverToken=arguments.serverToken, method='GET' );
  }

  /**
  * Gets total counts of unique links that were clicked.
  * @serverToken The server token.
  * @tag Filter by tag
  * @fromdate Filter stats starting from the date specified (inclusive). e.g. 2014-01-01
  * @todate Filter stats up to the date specified (inclusive). e.g. 2014-02-01
  */
  public function getClickCounts(
      required string serverToken,
      string tag,
      string fromdate,
      string todate
  ){
    return makeServerRequest( endpoint='stats/outbound/clicks', serverToken=arguments.serverToken, method='GET' );
  }

  /**
  * Gets an overview of the browsers used to open links in your emails. This is only recorded when Link Tracking is enabled for that email.
  * @serverToken The server token.
  * @tag Filter by tag
  * @fromdate Filter stats starting from the date specified (inclusive). e.g. 2014-01-01
  * @todate Filter stats up to the date specified (inclusive). e.g. 2014-02-01
  */
  public function getBrowserUsage(
      required string serverToken,
      string tag,
      string fromdate,
      string todate
  ){
    return makeServerRequest( endpoint='stats/outbound/clicks/browserfamilies', serverToken=arguments.serverToken, method='GET' );
  }

  /**
  * Gets an overview of the browser platforms used to open your emails. This is only recorded when Link Tracking is enabled for that email.
  * @serverToken The server token.
  * @tag Filter by tag
  * @fromdate Filter stats starting from the date specified (inclusive). e.g. 2014-01-01
  * @todate Filter stats up to the date specified (inclusive). e.g. 2014-02-01
  */
  public function getBrowserPlatformUsage(
      required string serverToken,
      string tag,
      string fromdate,
      string todate
  ){
    return makeServerRequest( endpoint='stats/outbound/clicks/platforms', serverToken=arguments.serverToken, method='GET' );
  }

  /**
  * Gets an overview of which part of the email links were clicked from (HTML or Text). This is only recorded when Link Tracking is enabled for that email.
  * @serverToken The server token.
  * @tag Filter by tag
  * @fromdate Filter stats starting from the date specified (inclusive). e.g. 2014-01-01
  * @todate Filter stats up to the date specified (inclusive). e.g. 2014-02-01
  */
  public function getClickLocation(
      required string serverToken,
      string tag,
      string fromdate,
      string todate
  ){
    return makeServerRequest( endpoint='stats/outbound/clicks/location', serverToken=arguments.serverToken, method='GET' );
  }

  /*
  * TRIGGERS
  */

  /**
  * Create a trigger for a tag
  * @serverToken The server token
  * @MatchName Name of the tag that will activate this trigger.
  * @TrackOpens Indicates if this trigger activates open tracking.
  */
  public function createTagTrigger(
      required string serverToken,
      required string MatchName,
      string TrackOpens
  ){
    var sBody = stripServerTokenAndClean( arguments );
    return makeServerRequest( endpoint='triggers/tags', serverToken=arguments.serverToken, method='POST', body=sBody );
  }

  /**
  * Get a specific tag trigger
  * @serverToken The server token
  * @triggerId The trigger id.
  */
  public function getTagTrigger(
      required string serverToken,
      required numeric triggerId
  ){
    return makeServerRequest( endpoint='triggers/tags/#arguments.triggerId#', serverToken=arguments.serverToken, method='GET' );
  }

  /**
  * Edit a trigger for a tag
  * @serverToken The server token
  * @triggerId The trigger id.
  * @MatchName Name of the tag that will activate this trigger.
  * @TrackOpens Indicates if this trigger activates open tracking.
  */
  public function editTagTrigger(
      required string serverToken,
      required numeric triggerId,
      required string MatchName,
      string TrackOpens
  ){
    var sParams = structCopy( arguments );
    structDelete( sParams, 'triggerId' );
    var sBody = stripServerTokenAndClean( sParams );
    return makeServerRequest( endpoint='triggers/tags/#arguments.triggerId#', serverToken=arguments.serverToken, method='PUT', body=sBody );
  }

  /**
  * Delete a trigger for a tag
  * @serverToken The server token
  * @triggerId The trigger id.
  * @MatchName Name of the tag that will activate this trigger.
  * @TrackOpens Indicates if this trigger activates open tracking.
  */
  public function deleteTagTrigger(
      required string serverToken,
      required numeric triggerId
  ){
    return makeServerRequest( endpoint='triggers/tags/#arguments.triggerId#', serverToken=arguments.serverToken, method='DELETE' );
  }

  /**
  * Search tag triggers
  * @serverToken The server token
  * @count Number of records to return per request. Max 500. Defaults to 10,
  * @offset Number of records to skip. Defaults to 0.
  * @match_name Filter by delivery tag.
  */
  public function searchTagTrigger(
      required string serverToken,
      required numeric count = 10,
      required numeric offset = 0,
      string match_name
  ){
    var sParams = structCopy( arguments );
    structDelete( sParams, 'serverToken' );
    return makeServerRequest( endpoint='triggers/tags/#arguments.triggerId#', serverToken=arguments.serverToken, method='GET', params=sParams );
  }

  /**
  * Create an inbound rule trigger
  * @serverToken The server token
  * @Rule Email address (or domain) that you would like to block from sending.
  */
  public function createInboundRuleTrigger(
      required string serverToken,
      required string Rule
  ){
    var sBody = stripServerTokenAndClean( arguments );
    return makeServerRequest( endpoint='triggers/inboundrules', serverToken=arguments.serverToken, method='POST', body=sBody );
  }

  /**
  * Delete an inbound rule trigger
  * @serverToken The server token
  * @triggerId The trigger id
  * @Rule Email address (or domain) that you would like to block from sending.
  */
  public function deleteInboundRuleTrigger(
      required string serverToken,
      required numeric triggerId
  ){
    return makeServerRequest( endpoint='triggers/inboundrules/#arguments.triggerId#', serverToken=arguments.serverToken, method='DELETE' );
  }

  /**
  * List inbound rule triggers
  * @serverToken The server token
  * @count Number of records to return per request. Max 500. Defaults to 10,
  * @offset Number of records to skip. Defaults to 0.
  */
  public function listInboundRuleTrigger(
      required string serverToken,
      required numeric count = 10,
      required numeric offset = 0
  ){
    var sParams = structCopy( arguments );
    structDelete( sParams, 'serverToken' );
    return makeServerRequest( endpoint='triggers/inboundrules', serverToken=arguments.serverToken, method='GET', params=sParams );
  }



  /*
  * UTILS
  */

  /**
  * Makes a request that requires the account token to be sent.
  * @endpoint The API endpoint.
  * @method The HTTP method to use for the request.
  * @body The body of any POST / PUT request.
  * @params The parameters to send to the request.
  */
  private function makeAccountRequest(
    required string endpoint,
    required string method = 'GET',
    required string body = '',
    required struct params = {}
  ){
    return makeRequest(
        endpoint  = arguments.endpoint,
        method    = arguments.method,
        body      = arguments.body,
        params    = arguments.params,
        xHeader   = {
          'name'  = 'X-Postmark-Account-Token',
          'value' = getAccountToken()
        }
    );
  }

  /**
  * Makes a request that requires the server token to be sent.
  * @serverToken The server token.
  * @endpoint The API endpoint.
  * @method The HTTP method to use for the request.
  * @body The body of any POST / PUT request.
  * @params The parameters to send to the request.
  */
  private function makeServerRequest(
    required string serverToken,
    required string endpoint,
    required string method,
    required string body = '',
    required struct params = {}
  ){
    return makeRequest(
        endpoint  = arguments.endpoint,
        method    = arguments.method,
        body      = arguments.body,
        params    = arguments.params,
        xHeader   = {
          'name'  = 'X-Postmark-Server-Token',
          'value' = arguments.servertoken
        }
    );
  }

  /**
  * Makes a request to the API.
  * @endpoint The API endpoint.
  * @method The HTTP method to use for the request.
  * @body The body of any POST / PUT request.
  * @params The parameters to send to the request.
  * @xHeader Struct containing values for the XAuth header
  */
  private function makeRequest(
    required string endpoint,
    required string method = 'GET',
    required string body = '',
    required struct params = {},
    required struct xHeader
  ){
    var strURL = getBaseURL() & arguments.endpoint;
    if( structCount( arguments.params ) ){
      strURL = strURL & '?' & buildParamString( arguments.params );
    }
    var httpService = new http( method=arguments.method, url=strURL );
    httpService.addParam( type='header', name=arguments.xHeader[ 'name' ], value=arguments.xHeader[ 'value' ] );
    httpService.addParam( type='header', name='Content-Type', value='application/json' );
    if( len( arguments.body ) ){
      httpService.addParam( type='body', value=arguments.body );
    }
    result = httpService.send().getPrefix();
    return deserializeJSON( result[ 'fileContent' ] );
  }

  /**
  * Builds up a query parameter string from provided values.
  * @params Struct of parameters to convert into name=value query parameter pairs.
  */
  private function buildParamString(
      required struct params
  ){
    var sParams = arguments.params;
    var strParams = '';
    for( var key in sParams ){
      if( len( sParams[ key ] ) ){
        if( listLen( strParams ) ){
          strParams = strParams & '&';
        }
        strParams = strParams & lcase( key ) & '=' & sParams[ key ];
      }
    }
    return strParams;
  }

  /**
  * Strips out empty key values from a struct
  * @params Struct of parameters to clean.
  */
  private function structCleanser(
    required struct params
  ){
    var sParams = arguments.params;
    for( var key in sParams ){
      if( structKeyExists( sParams, key ) && !hasValue( sParams[ key ] ) ){
        structDelete( sParams, key );
      }
    }
    return sParams;
  }

  /**
  * Helper to ensure variables aren't empty
  */
  private boolean function hasValue( any value ) {
    if ( isNull( value ) ) return false;
    if ( isSimpleValue( value ) ) return len( value );
    if ( isStruct( value ) ) return !structIsEmpty( value );
    if ( isArray( value ) ) return arrayLen( value );
    if ( isQuery( value ) ) return value.recordcount;

    return false;
  }

  /**
  * Removes the server token from the provided struct and cleans any empty key values.
  */
  private function stripServerTokenAndClean(
    required struct emailData
  ){
    var sBody = structCopy( arguments.emailData );
    structDelete( sBody, 'serverToken' );
    sBody = structCleanser( sBody );
    return sBody;
  }

  /**
  * Returns the properties as a struct
  */
  struct function getMemento(){
    var result = {};
    for( var thisProp in getMetaData( this ).properties ){
      if( structKeyExists( variables, thisProp[ 'name' ] ) ){
        result[ thisProp[ 'name' ] ] = variables[ thisProp[ 'name' ] ];
      }
    }
    return result;
  }

}
