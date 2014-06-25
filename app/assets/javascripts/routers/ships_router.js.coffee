SitsApp.Routers.Ships = Backbone.Router.extend(
	routes: 
		"(/)(#)": "index"
		"ships/detail/:id(/)": "detail"
	index: ->
		console.log('router.index')
		indexView = new SitsApp.Views.ShipsIndex { collection: SitsApp.ships, className: "col-md-12" }
		$('#shipListRow').html(indexView.render().$el)
	detail: (id) ->
		console.log('router.detail')
		# copied from index
		# seems to break when I try to naively cache it. look into this. 
		indexView = new SitsApp.Views.ShipsIndex { collection: SitsApp.ships, className: "col-md-12" }
		$('#shipListRow').html(indexView.render().$el)
		# the navigation section
		SitsApp.loadedShips ?= {}
		# cache our current ship
		if SitsApp.currentShip?
			unless SitsApp.loadedShips[SitsApp.currentShip.get('id')]? 
				console.log('caching ship')
				SitsApp.loadedShips[SitsApp.currentShip.get('id')] = SitsApp.currentShip
		if SitsApp.loadedShips[id]?
			console.log('load from cache')
			SitsApp.currentShip = SitsApp.loadedShips[id]
		else
			console.log('creating new model')
			SitsApp.currentShip = new SitsApp.Models.ShipDetail({id: id})
		SitsApp.currentShip.fetch()
		navView = new SitsApp.Views.ShipDetailNavigation({model: SitsApp.currentShip})
		$('#navigationRow').html(navView.render().$el)
	)