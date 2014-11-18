/**
 * @module app/view/AppView
 * @requires module:backbone
 */

/** @type {module:underscore} */
var _ = require("underscore");
/** @type {module:backbone} */
var Backbone = require("backbone");

/** @type {module:app/view/component/CollectionPagerView} */
// var CollectionPagerView = require("./component/CollectionPagerView");
/** @type {module:app/view/NavigationView} */
var NavigationView = require("./NavigationView");
/** @type {module:app/view/ContentView} */
var ContentView = require("./ContentView");

/** @type {module:app/model/collection/BundleList} */
var bundles = require("../model/collection/BundleList");
/** @type {module:app/control/Presenter} */
var presenter = require("../control/Presenter");

/**
 * @constructor
 * @type {module:app/view/AppView}
 */
module.exports = Backbone.View.extend({
	/** @override */
	el: "body",
	/** @type {module:app/model/collection/BundleList} */
	bundles: bundles,
	/** @type {module:app/control/Presenter} */
	presenter: presenter,
	/** @override */
	events: {
		"click #site-name": "onSitenameClick"
	},

	/** Setup listening to model changes */
	initialize: function (options) {
		/* initialize views */
		this.navigationView = new NavigationView({
			el: "#navigation"
		});
		this.contentView = new ContentView({
			el: "#content"
		});

		this.listenTo(Backbone, "all", this.onApplicationEvent);
		/* start router, which will request appropiate state */
		Backbone.history.start({ pushState: false, hashChange: true });
	},

	onSitenameClick: function (ev) {
		if (!ev.isDefaultPrevented()) {
			ev.preventDefault();
			this.presenter.deselectBundle();
		}
	},

	onApplicationEvent: function(eventName) {
		console.log("AppView.onApplicationEvent " + eventName);
		switch (eventName){
			case "app:error":
				console.log("AppView.showError - not implemented");
				this.presenter.deselectBundle();
				break;
			// case "app:bundle:item":
			// case "app:bundle:list":
			default:
				this.el.className = eventName.split(":").join("-");
				break;
		}
	},

	// createBundlePager: function () {
	// 	this.bundlePagerView = new CollectionPagerView({
	// 		id: "bundle-pager",
	// 		collection: this.bundles,
	// 		className: "fontello-pill-pager",
	// 		labelAttribute: "name"
	// 	});
	// 	// append at the bottom of <body/>
	// 	this.$el.append(this.bundlePagerView.render().el);
	// 	this.listenTo(this.bundlePagerView, "view:select:one", this.selectBundle);
	// 	this.listenTo(this.bundlePagerView, "view:select:none", this.deselectBundle);
	// 	return this.bundlePagerView;
	// },

});
