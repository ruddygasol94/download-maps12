MKDIR=mkdir -p

default: all

all: dirs download download-censales merge reproject recode

dirs: 
	for file in zip zip/distrito zip/mexico zip/seccion unzip unzip/distrito unzip/mexico unzip/seccion ife map-out map-out/distritos map-out/estados map-out/localidades map-out/municipios map-out/rdata-secciones map-out/secciones-inegi ; do \
		mkdir -p $$file ; \
	done
download: dirs
	chmod +x download.sh
	./download.sh
download-censales: dirs
	chmod +x download-censales.sh
	./download-censales.sh
merge: dirs
	chmod +x merge.sh
	./merge.sh
reproject: dirs
	chmod +x reproject.sh
	./reproject.sh
recode: download download-censales merge reproject
	R CMD BATCH recode.R

clean: 
	for dirs in unzip zip ife map-out ; do \
		rm -rf $$dirs ; \
	done

clean-cache: 
	for dirs in unzip zip ife ; do \
		rm -rf $$dirs ; \
	done
