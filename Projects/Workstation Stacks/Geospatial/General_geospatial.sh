#!/bin/bash

Install_libs(){
	#sudo dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm -y
	#sudo dnf install git -y
	
       
    sudo dnf install make automake gcc gcc-c++ kernel-devel -y
    sudo dnf install python3-pip -y
    sudo pip3 install --upgrade pip
    pip3 install pandas
    
}    
    
Install_geospatial_python_libs(){
	# Install geopandas
	pip3 install geopandas

	# Install pysal
	pip3 install pysal

    # Install matplotlib
    pip3 install matplotlib

    # Install mapclassify
    pip3 install mapclassify 

    # Install geoCAT-comp
    pip3 install geoCAT-comp 

    # Install xarray
    pip3 install xarray

    # Install dask
    pip3 install dask

}
   
Install_other_spatial_tools(){

    # Install GDAL
    sudo dnf install gdal -y
    #also installs geos and proj plus a bunch of other things
    
    # Install udunits2
    sudo dnf install udunits2 -y 
}
    
#Install_OracleR_and_Packages(){
	# Install OracleR
    sudo dnf install dnf-plugins-core -y 
    # may need sudo dnf config-manager --set-enabled "ol8_codeready_builder"
    sudo dnf install R.x86_64 -y 
    
    #download and install packages
    sudo wget https://cran.r-project.org/src/contrib/RNetCDF_2.6-1.tar.gz
    R CMD INSTALL RNetCDF_2.6-1.tar.gz

    sudo yum install netcdf -y -y 

    #sudo dnf install rstudio-2022.07.1-554-x86_64.rpm

Install_postgresql(){
	# Install repository RPM 
	sudo dnf install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-8-x86_64/pgdg-redhat-repo-latest.noarch.rpm
    
    # Disable the built-in PostgreSQL module:
    sudo dnf -qy module disable postgresql

    # Install PostgreSQL:
    sudo dnf install -y postgresql14-server

    # Optionally initialize the database and enable automatic start:
    sudo /usr/pgsql-14/bin/postgresql-14-setup initdb
    sudo systemctl enable postgresql-14
    sudo systemctl start postgresql-14
    
}

Install_PostGIS(){
    # Just install from dnf

    sudo dnf install postgis -y 

}

#Install QGIS(){
    # Install repository RPM 
	sudo dnf install -y https://github.com/qgis/QGIS/tree/release-3.26/rpm
    
    #Not suported on RHEL / OEL 8 as of 8-19-22
   

Install_libs
Install_geospatial_python_libs
Install_other_spatial_tools
Install_postgresql
Install_PostGIS

echo "+++++++++++++++++++ Done +++++++++++++++++++ "