
##-------------------------------------------------------------
## 
##-------------------------------------------------------------
.getColor <- function(dta) {
	sapply(dta$ESC, function(esc)
		   {
			   if(esc == "Bad") {
				   "red"
			   } else if(esc == "Low") {
				   "purple"
			   } else if(esc == "Moderate"){
				   "orange"
			   } else if(esc == "Good"){
				   "green"
			   } else if(esc == "High"){
				   "blue"
			   }#end if
		   })
}#end getColor


##-------------------------------------------------------------
## 
##-------------------------------------------------------------
quality_map = function(dta, lng = "lng", lat = "lat", esc = "ESC", idl = "") {

	idl = parse(text=idl)
	esc = parse(text=esc)
	lng = parse(text=lng)
	lat = parse(text=lat)

	Icons <- awesomeIcons(
			  icon = 'star',
			  iconColor = 'white',
			  library = 'ion',
			  markerColor = unique(.getColor(dta))
	)#end Icons

	map = leaflet() %>%
		addTiles() %>%  
		addTiles(group = "OSM") %>%
		addTiles(group = "ESRI") %>%
		addProviderTiles("OpenStreetMap", group = "OSM") %>%
		addProviderTiles("Esri.WorldImagery", group = "ESRI",
			options = providerTileOptions(minZoom = 3, maxZoom = 17)) %>%
		addLayersControl(baseGroups = c("OSM", "ESRI"),
			options = layersControlOptions(position = "topright", collapsed = TRUE)) %>%
		addAwesomeMarkers(data = dta, 
			lng = ~unique(eval(lng)),
			lat = ~unique(eval(lat)),
			icon = ~Icons, 
			label = ~paste(toupper(unique(eval(esc))), "|", unique(eval(idl))), group = "map") %>%
		addLegend("bottomright",
			colors =c("#38a9db",  "#72af26", "#ffa748", "#de80ce", "red"),
			labels= c("High", "Good","Moderate","Low", "Bad"),
			title= "ESC",
			opacity = .8)

		return(map)
}#end mapa

