library(rgdal)
library(maptools)
library(rgeos)

# Departamentos -----------------------------------------------------------

shape_depto <- readOGR(dsn = "data/shapes/shape_depto", 
                layer = "depto",
                encoding = "UTF-8",
                stringsAsFactors = FALSE)

centroides_depto<-gCentroid(shape_depto, byid = T)

centroides_depto<-proj4::project(centroides_depto@coords,
                                 proj = proj4string(shape_depto), inverse = T)

dist_depto<-geosphere::distm(centroides_depto) #dist en metros
colnames(dist_depto)<-as.character(shape_depto@data$NOMBRE_DPT)
rownames(dist_depto)<-as.character(shape_depto@data$NOMBRE_DPT)

write.csv(dist_depto, "output/dist_deptos.csv", row.names = TRUE)

# Municipios --------------------------------------------------------------

shape_mun <-readOGR(dsn = "data/shapes/shape_municipal", 
                    layer = "mpio",
                    encoding = "UTF-8",
                    stringsAsFactors = FALSE)

centroides_mun <- gCentroid(shape_mun, byid = TRUE)

centroides_mun<-proj4::project(centroides_mun@coords,
                                 proj = proj4string(shape_mun), inverse = T)

dist_mun<-geosphere::distm(centroides_mun) #dist en metros
colnames(dist_mun)<-as.character(shape_mun@data$MPIOS)
rownames(dist_mun)<-as.character(shape_mun@data$MPIOS)

write.csv(dist_mun, "output/dist_mun.csv", row.names = TRUE)
