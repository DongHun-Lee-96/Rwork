data(world.cities)
head(world.cities) 
str(world.cities)
skorea.pop <- world.cities[world.cities$country.etc %in% "Korea South",]
skorea.pop <- skorea.pop[order(skorea.pop$pop),]
skorea.pop <- tail(skorea.pop,10)
skorea.pop <- skorea.pop[-10,]

korea <- map_data("world",region=c("South Korea"))

ggplot() + geom_polygon(data=korea, aes(x=long,y=lat,group=group,fill=region), color="black") + scale_fill_brewer(palette = "Blues") + geom_point(data=skorea.pop, aes(x=long-0.3, y=lat-0.3, size=pop),color="Yellow") + geom_text(data=skorea.pop, aes(x=long, y=lat, label=name))
