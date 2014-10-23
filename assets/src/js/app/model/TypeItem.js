/**
* @module model/TypeItem
* @requires module:backbone
*/

/** @type {module:backbone} */
var Backbone = require( "backbone" );

/**
 * @constructor
 * @type {module:app/model/TypeItem}
 */
module.exports = Backbone.Model.extend({

	/**
	 * @type {Object}
	 */
	defaults: {
		name: "",
		handle: "",
		attributes: []
	},

	/** @override */
	toString: function() {
		return this.attributes["name"];
	}

});
