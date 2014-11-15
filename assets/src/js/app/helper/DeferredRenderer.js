/**
 * @module app/app/helper/DeferredRenderer
 * @requires module:backbone
 */

/** @type {module:underscore} */
var _ = require("underscore");

/**
 * @constructor
 * @type {module:app/helper/DeferredRenderer}
 */
var DeferredRenderer = function () {};

DeferredRenderer.prototype = {

	/** @type {Object.<String, {Function|true}}>} */
	//	renderJobs: null,

	/** @type {long} */
	renderRequestId: 0,
	/**
	 * @param {String} [key]
	 * @param [value]
	 */
	requestRender: function (key, value) {
		if (undefined === this.renderJobs) {
			this.renderJobs = {};
			this.renderRequestId = _.defer(this.getRenderCallback()); //window.requestAnimationFrame(this.getRenderCallback());
		}
		if (key) {
			this.renderJobs[key] = value ? value : true;
		}
	},

	/** @private */
	getRenderCallback: function () {
		return this.renderCallback || (this.renderCallback = _.bind(this.applyRender, this));
	},

	/** @private */
	applyRender: function (timestamp) {
		this.deferredRender(timestamp);
		delete this.renderJobs;
	},

	/** @private */
	validateRender: function(key) {
		if (this.renderJobs[key]) this.renderJobs[key]();
	},

	/** @abstract */
	deferredRender: function () {},
};

module.exports = DeferredRenderer;
