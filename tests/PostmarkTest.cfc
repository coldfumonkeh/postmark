component extends="testbox.system.BaseSpec" {

	function run() {

		describe( "Postmark transactional email component", function() {

			beforeEach( function() {
				oPostmarkService = createMock("Postmark");
			} );

			it( "should have the correct return type", function() {
				expect( oPostmarkService ).toBeInstanceOf( 'Postmark' );
				expect( oPostmarkService ).toBeTypeOf( 'component' );
			} );

			it( "should have a function called `init`", function() {
				expect( oPostmarkService ).toHaveKey( 'init' );
			} );

			it( "should have a function called `sendEmail`", function() {
				expect( oPostmarkService ).toHaveKey( 'sendEmail' );
			} );

			it( "should have a function called `getDeliveryStats`", function() {
				expect( oPostmarkService ).toHaveKey( 'getDeliveryStats' );
			} );

			it( "should have a function called `getBounces`", function() {
				expect( oPostmarkService ).toHaveKey( 'getBounces' );
			} );

			it( "should have a function called `getBounceById`", function() {
				expect( oPostmarkService ).toHaveKey( 'getBounceById' );
			} );

			it( "should have a function called `getBounceDump`", function() {
				expect( oPostmarkService ).toHaveKey( 'getBounceDump' );
			} );

			it( "should have a function called `activateBounce`", function() {
				expect( oPostmarkService ).toHaveKey( 'activateBounce' );
			} );

			it( "should have a function called `getBouncedTags`", function() {
				expect( oPostmarkService ).toHaveKey( 'getBouncedTags' );
			} );

			it( "should have a function called `getTemplate`", function() {
				expect( oPostmarkService ).toHaveKey( 'getTemplate' );
			} );

			it( "should have a function called `listTemplates`", function() {
				expect( oPostmarkService ).toHaveKey( 'listTemplates' );
			} );

			it( "should have a function called `createTemplate`", function() {
				expect( oPostmarkService ).toHaveKey( 'createTemplate' );
			} );

			it( "should have a function called `editTemplate`", function() {
				expect( oPostmarkService ).toHaveKey( 'editTemplate' );
			} );

			it( "should have a function called `deleteTemplate`", function() {
				expect( oPostmarkService ).toHaveKey( 'deleteTemplate' );
			} );

			it( "should have a function called `validateTemplate`", function() {
				expect( oPostmarkService ).toHaveKey( 'validateTemplate' );
			} );

			it( "should have a function called `sendEmailWithTemplate`", function() {
				expect( oPostmarkService ).toHaveKey( 'sendEmailWithTemplate' );
			} );

			it( "should have a function called `getServer`", function() {
				expect( oPostmarkService ).toHaveKey( 'getServer' );
			} );

			it( "should have a function called `createServer`", function() {
				expect( oPostmarkService ).toHaveKey( 'createServer' );
			} );

			it( "should have a function called `editServer`", function() {
				expect( oPostmarkService ).toHaveKey( 'editServer' );
			} );

			it( "should have a function called `listServers`", function() {
				expect( oPostmarkService ).toHaveKey( 'listServers' );
			} );

			it( "should have a function called `deleteServer`", function() {
				expect( oPostmarkService ).toHaveKey( 'deleteServer' );
			} );

			it( "should have a function called `outboundMessageSearch`", function() {
				expect( oPostmarkService ).toHaveKey( 'outboundMessageSearch' );
			} );

			it( "should have a function called `outboundMessageDetails`", function() {
				expect( oPostmarkService ).toHaveKey( 'outboundMessageDetails' );
			} );

			it( "should have a function called `inboundMessageSearch`", function() {
				expect( oPostmarkService ).toHaveKey( 'inboundMessageSearch' );
			} );

			it( "should have a function called `inboundMessageDetails`", function() {
				expect( oPostmarkService ).toHaveKey( 'inboundMessageDetails' );
			} );

			it( "should have a function called `bypassRulesForBlockedInboundMessage`", function() {
				expect( oPostmarkService ).toHaveKey( 'bypassRulesForBlockedInboundMessage' );
			} );

			it( "should have a function called `retryFailedInboundMessage`", function() {
				expect( oPostmarkService ).toHaveKey( 'retryFailedInboundMessage' );
			} );

			it( "should have a function called `messageOpens`", function() {
				expect( oPostmarkService ).toHaveKey( 'messageOpens' );
			} );

			it( "should have a function called `messageOpenById`", function() {
				expect( oPostmarkService ).toHaveKey( 'messageOpenById' );
			} );

			it( "should have a function called `listDomains`", function() {
				expect( oPostmarkService ).toHaveKey( 'listDomains' );
			} );

			it( "should have a function called `getDomainDetails`", function() {
				expect( oPostmarkService ).toHaveKey( 'getDomainDetails' );
			} );

			it( "should have a function called `createDomain`", function() {
				expect( oPostmarkService ).toHaveKey( 'createDomain' );
			} );

			it( "should have a function called `editDomain`", function() {
				expect( oPostmarkService ).toHaveKey( 'editDomain' );
			} );

			it( "should have a function called `deleteDomain`", function() {
				expect( oPostmarkService ).toHaveKey( 'deleteDomain' );
			} );

			it( "should have a function called `verifyDomainSPF`", function() {
				expect( oPostmarkService ).toHaveKey( 'verifyDomainSPF' );
			} );

			it( "should have a function called `rotateDKIMKeys`", function() {
				expect( oPostmarkService ).toHaveKey( 'rotateDKIMKeys' );
			} );

			it( "should have a function called `listSenderSignatures`", function() {
				expect( oPostmarkService ).toHaveKey( 'listSenderSignatures' );
			} );

			it( "should have a function called `getSenderSignatureDetails`", function() {
				expect( oPostmarkService ).toHaveKey( 'getSenderSignatureDetails' );
			} );

			it( "should have a function called `createSignature`", function() {
				expect( oPostmarkService ).toHaveKey( 'createSignature' );
			} );

			it( "should have a function called `editSignature`", function() {
				expect( oPostmarkService ).toHaveKey( 'editSignature' );
			} );

			it( "should have a function called `deleteSignature`", function() {
				expect( oPostmarkService ).toHaveKey( 'deleteSignature' );
			} );

			it( "should have a function called `resendConfirmation`", function() {
				expect( oPostmarkService ).toHaveKey( 'resendConfirmation' );
			} );

			it( "should have a function called `getOutboundOverview`", function() {
				expect( oPostmarkService ).toHaveKey( 'getOutboundOverview' );
			} );

			it( "should have a function called `getSentCounts`", function() {
				expect( oPostmarkService ).toHaveKey( 'getSentCounts' );
			} );

			it( "should have a function called `getBounceCounts`", function() {
				expect( oPostmarkService ).toHaveKey( 'getBounceCounts' );
			} );

			it( "should have a function called `getSpamComplaints`", function() {
				expect( oPostmarkService ).toHaveKey( 'getSpamComplaints' );
			} );

			it( "should have a function called `getTrackedEmailCounts`", function() {
				expect( oPostmarkService ).toHaveKey( 'getTrackedEmailCounts' );
			} );

			it( "should have a function called `getEmailOpenCounts`", function() {
				expect( oPostmarkService ).toHaveKey( 'getEmailOpenCounts' );
			} );

			it( "should have a function called `getEmailPlatformUsage`", function() {
				expect( oPostmarkService ).toHaveKey( 'getEmailPlatformUsage' );
			} );

			it( "should have a function called `getEmailClientUsage`", function() {
				expect( oPostmarkService ).toHaveKey( 'getEmailClientUsage' );
			} );

			it( "should have a function called `getEmailReadTimes`", function() {
				expect( oPostmarkService ).toHaveKey( 'getEmailReadTimes' );
			} );

			it( "should have a function called `getClickCounts`", function() {
				expect( oPostmarkService ).toHaveKey( 'getClickCounts' );
			} );

			it( "should have a function called `getBrowserUsage`", function() {
				expect( oPostmarkService ).toHaveKey( 'getBrowserUsage' );
			} );

			it( "should have a function called `getBrowserPlatformUsage`", function() {
				expect( oPostmarkService ).toHaveKey( 'getBrowserPlatformUsage' );
			} );

			it( "should have a function called `getClickLocation`", function() {
				expect( oPostmarkService ).toHaveKey( 'getClickLocation' );
			} );

			it( "should have a function called `createTagTrigger`", function() {
				expect( oPostmarkService ).toHaveKey( 'createTagTrigger' );
			} );

			it( "should have a function called `getTagTrigger`", function() {
				expect( oPostmarkService ).toHaveKey( 'getTagTrigger' );
			} );

			it( "should have a function called `editTagTrigger`", function() {
				expect( oPostmarkService ).toHaveKey( 'editTagTrigger' );
			} );

			it( "should have a function called `deleteTagTrigger`", function() {
				expect( oPostmarkService ).toHaveKey( 'deleteTagTrigger' );
			} );

			it( "should have a function called `searchTagTrigger`", function() {
				expect( oPostmarkService ).toHaveKey( 'searchTagTrigger' );
			} );

			it( "should have a function called `createInboundRuleTrigger`", function() {
				expect( oPostmarkService ).toHaveKey( 'createInboundRuleTrigger' );
			} );

			it( "should have a function called `deleteInboundRuleTrigger`", function() {
				expect( oPostmarkService ).toHaveKey( 'deleteInboundRuleTrigger' );
			} );

			it( "should have a function called `listInboundRuleTrigger`", function() {
				expect( oPostmarkService ).toHaveKey( 'listInboundRuleTrigger' );
      } );

      it( "should have a function called `getSuppressionDump`", function() {
				expect( oPostmarkService ).toHaveKey( 'getSuppressionDump' );
			} );

			it( "should have a function called `makeAccountRequest`", function() {
				var oPostmarkService = makePublic( oPostmarkService, 'makeAccountRequest' );
				expect( oPostmarkService ).toHaveKey( 'makeAccountRequest' );
			} );

			it( "should have a function called `makeServerRequest`", function() {
				var oPostmarkService = makePublic( oPostmarkService, 'makeServerRequest' );
				expect( oPostmarkService ).toHaveKey( 'makeServerRequest' );
			} );

			it( "should have a function called `makeRequest`", function() {
				var oPostmarkService = makePublic( oPostmarkService, 'makeRequest' );
				expect( oPostmarkService ).toHaveKey( 'makeRequest' );
			} );

			it( "should have a function called `buildParamString`", function() {
				var oPostmarkService = makePublic( oPostmarkService, 'buildParamString' );
				expect( oPostmarkService ).toHaveKey( 'buildParamString' );
			} );

			it( "should have a function called `structCleanser`", function() {
				var oPostmarkService = makePublic( oPostmarkService, 'structCleanser' );
				expect( oPostmarkService ).toHaveKey( 'structCleanser' );
			} );

			it( "should have a function called `stripServerTokenAndClean`", function() {
				var oPostmarkService = makePublic( oPostmarkService, 'stripServerTokenAndClean' );
				expect( oPostmarkService ).toHaveKey( 'stripServerTokenAndClean' );
			} );

			it( "should have a function called `getMemento`", function() {
				expect( oPostmarkService ).toHaveKey( 'getMemento' );
			} );

		} );


		describe( "Postmark method calls", function() {

			beforeEach( function() {
				serverToken 			= 'abcdefghijklmnopqrstuvwxyz';
				accountToken 			= '1234567890-qwerty-uiop-0987654321';
				baseURL						= 'https://api.postmarkapp.com/';
				oPostmarkService 	= createMock("Postmark");
			} );

			it( "should initialise with the accountToken value", function() {
				var oPostmark = oPostmarkService.init( accountToken = accountToken );
				var sMemento = oPostmark.getMemento();

				expect( oPostmark.getAccountToken() ).toBe( accountToken );
				expect( oPostmark.getBaseURL() ).toBe( baseURL );

				expect( sMemento ).toBeTypeOf( 'struct' );
				expect( sMemento ).toHaveLength( 2 );

				expect( sMemento ).toHaveKey( 'accountToken' );
				expect( sMemento ).toHaveKey( 'baseURL' );

				expect( sMemento['accountToken'] ).toBe( accountToken );
				expect( sMemento['baseURL'] ).toBe( baseURL );
			} );

			it( "should strip the server token from the provided struct argument when calling the `stripServerTokenAndClean` function", function() {
				var oPostmarkService = makePublic( oPostmarkService, 'stripServerTokenAndClean' );
				var sOriginal = {
					'serverToken' = serverToken,
					'from' 				= 'hello@there.com',
					'to'					= 'from@me.there'
				};

				expect( sOriginal ).toBeTypeOf( 'struct' );
				expect( sOriginal ).toHaveLength( 3 );
				expect( sOriginal ).toHaveKey( 'serverToken' );
				expect( sOriginal ).toHaveKey( 'from' );
				expect( sOriginal ).toHaveKey( 'to' );

				var sStripped = oPostmarkService.stripServerTokenAndClean( sOriginal );

				expect( sStripped ).toBeTypeOf( 'struct' );
				expect( sStripped ).toHaveLength( 2 );
				expect( sStripped ).toHaveKey( 'from' );
				expect( sStripped ).toHaveKey( 'to' );
			} );

			it( "should strip any empty values from the provided struct argument when calling the `structCleanser` function", function() {
				var oPostmarkService = makePublic( oPostmarkService, 'structCleanser' );
				var sOriginal = {
					'empty' 	= '',
					'from' 		= 'hello@there.com',
					'to'			= 'from@me.there'
				};

				expect( sOriginal ).toBeTypeOf( 'struct' );
				expect( sOriginal ).toHaveLength( 3 );
				expect( sOriginal ).toHaveKey( 'empty' );
				expect( sOriginal ).toHaveKey( 'from' );
				expect( sOriginal ).toHaveKey( 'to' );

				var sStripped = oPostmarkService.structCleanser( sOriginal );

				expect( sStripped ).toBeTypeOf( 'struct' );
				expect( sStripped ).toHaveLength( 2 );
				expect( sStripped ).toHaveKey( 'from' );
				expect( sStripped ).toHaveKey( 'to' );
			} );

			it( "should return the correct URL string when calling the `buildParamString` function", function() {
				var oPostmarkService = makePublic( oPostmarkService, 'buildParamString' );
				var sOriginal = {
					'q' 			= 'name',
					'foo' 		= 'bar',
					'let_it'	= 'be'
				};

				expect( sOriginal ).toBeTypeOf( 'struct' );
				expect( sOriginal ).toHaveLength( 3 );
				expect( sOriginal ).toHaveKey( 'q' );
				expect( sOriginal ).toHaveKey( 'foo' );
				expect( sOriginal ).toHaveKey( 'let_it' );

				var strURLParams = oPostmarkService.buildParamString( sOriginal );

				expect( strURLParams ).toBeTypeOf( 'string' );
				expect( strURLParams ).toBe( 'q=name&foo=bar&let_it=be' );
			} );

			it( "should fail if you try to initialise without the accountToken value", function() {
				expect( function(){ oPostmarkService.init(); } ).toThrow( message='The parameter accountToken to function init is required but was not passed in.' );
			} );

			it( "should call the correct internal functions when a request is made to the `sendEmail` function", function() {
				var oPostmark = oPostmarkService.init( accountToken = accountToken );
				oPostmark.$( 'sendEmail' );
				oPostmark.sendEmail(
					serverToken = serverToken,
					from 				= 'test@test.com',
					to 					= 'test2@test2.com'
				);
				expect( oPostmark.$once( 'sendEmail' ) ).toBeTrue();
			} );

			it( "should call the correct internal functions when a request is made to the `sendBatchEmails` function", function() {
				var oPostmark = oPostmarkService.init( accountToken = accountToken );
				oPostmark.$( 'sendBatchEmails' );
				oPostmark.sendBatchEmails(
					serverToken = serverToken,
					emailData		= [
						{
							from 				= 'test@test.com',
							to 					= 'test2@test2.com'
						},
						{
							from 				= 'test3@test3.com',
							to 					= 'test4@test4.com'
						}
					]
				);
				expect( oPostmark.$once( 'sendBatchEmails' ) ).toBeTrue();
			} );

		} );

	}

}
