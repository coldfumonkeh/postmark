/**
* Matt Gifford, Monkeh Works
* www.monkehworks.com
* ---
* This module connects your application to the Postmark App API
**/
component {

	// Module Properties
	this.title 				= "Postmark App API";
	this.author 			= "Matt Gifford";
	this.webURL 			= "https://www.monkehworks.com";
	this.description 	= "This SDK will provide you with connectivity to the Postmark App API for any ColdFusion (CFML) application.";
	this.version			= "@version.number@+@build.number@";
	// If true, looks for views in the parent first, if not found, then in the module. Else vice-versa
	this.viewParentLookup 	= true;
	// If true, looks for layouts in the parent first, if not found, then in module. Else vice-versa
	this.layoutParentLookup = true;
	this.entryPoint			= 'postmark';
	this.modelNamespace	= 'postmark';
	this.cfmapping			= 'postmark';
	this.autoMapModels 	= false;

	/**
	 * Configure
	 */
	function configure(){

		// Settings
		settings = {
			accountToken = ''
		};
	}

	/**
	* Fired when the module is registered and activated.
	*/
	function onLoad(){
		parseParentSettings();
		var postmarkSettings = controller.getConfigSettings().postmark;

		// Map Library
		binder.map( "postmark@postmark" )
			.to( "#moduleMapping#.postmark" )
			.initArg( name="accountToken", value=postmarkSettings.accountToken );
	}

	/**
	* Fired when the module is unregistered and unloaded
	*/
	function onUnload(){
	}

	/**
	* parse parent settings
	*/
	private function parseParentSettings(){
		var oConfig 			= controller.getSetting( "ColdBoxConfig" );
		var configStruct 	= controller.getConfigSettings();
		var odDSL 				= oConfig.getPropertyMixin( "postmark", "variables", structnew() );

		//defaults
		configStruct.postmark = variables.settings;

		// incorporate settings
		structAppend( configStruct.postmark, odDSL, true );
	}

}
