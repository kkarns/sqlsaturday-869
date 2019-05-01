# sqlsaturday-869

This is a repository for educational materials for a presentation at SQLSaturday #869 - Phoenix, AZ, May 4, 2019 - Statewide Geography and Spatial Computing in SQL Server.  *Github Repo* - [https://github.com/kkarns/sqlsaturday-869](https://github.com/kkarns/sqlsaturday-869)

## Links in Presentation

Here are links referenced in the presentation:
* *speaker's blog* - [www.kkarnsdba.com](https://www.kkarnsdba.com)
* *NILS - Federal lands data model* - [Image](https://github.com/kkarns/sqlsaturday-869/blob/master/federal-lands-data-model.png)
* *NILS model background - Designing Geodatabases: Case Studies in GIS Data Modeling by David Arctur* - [Amazon](https://www.amazon.com/s?k=9781589480216&i=stripbooks&linkCode=qs) 
* *The evolution of NILS (in a webmap) - BLM Geocommunicator* - [https://navigator.blm.gov/map](https://navigator.blm.gov/map)
* *AZ webmap* - [http://gis.azland.gov/webapps/parcel/](http://gis.azland.gov/webapps/parcel/)
* *NM webmap* - [http://www.nmstatelands.org/interactive-maps.aspx](http://www.nmstatelands.org/interactive-maps.aspx)
* *OGC Methods in SQL Server* - [MSDN link](https://docs.microsoft.com/en-us/sql/t-sql/spatial-geometry/ogc-methods-on-geometry-instances?view=sql-server-2017
)
* *Andy Yun's Dupe-Redund-Missing-Indexes repository* - [https://github.com/SQLbek](https://github.com/SQLbek)
* *Spatial Indexing in Microsoft SQL Server 2008* - [ACM SIGMOD paper citation](https://dl.acm.org/citation.cfm?id=1376737)
* *Technet Article on Spatial Index Internals* - [Technet link](https://social.technet.microsoft.com/wiki/contents/articles/9694.tuning-spatial-point-data-queries-in-sql-server-2012.aspx)



## Link to Presentation

*.pdf* - [Presentation](https://github.com/kkarns/sqlsaturday-869/blob/master/sqlsaturday-869-statewide-geography-and-spatial-computing-in-sql-server.pdf)

## Data sources for SQLSaturday Demos

Most of the data sources needed to recreate a statewide GIS model are freely available, and can be found at these locations for NM and AZ: 

* *BLM data - PLSS National Geospatial Data Asset* - [zipped geodatabase file](https://catalog.data.gov/dataset/blm-national-public-land-survey-system-polygons-national-geospatial-data-asset-ngda)

* *AZ data - AZGEO Clearinghouse* - [https://azgeo.az.gov/azgeo/](https://azgeo.az.gov/azgeo/)
* *NM data - NMSLO GIS Data Download* - [http://mapservice.nmstatelands.org/GISDataDownloads/](http://mapservice.nmstatelands.org/GISDataDownloads/)

An ArcGIS subscription simplifies migrations, handles intersections, clippings, projection changes, and makes pretty decent maps: 

* *ArcGIS subscription* - [https://www.esri.com/en-us/arcgis/products/arcgis-for-personal-use](https://www.esri.com/en-us/arcgis/products/arcgis-for-personal-use)

Here is an ESRI-based ETL path from the GIS clearinghouses above to SQLServer: 

* *ESRI ETL path* - [Image](https://github.com/kkarns/sqlsaturday-869/blob/master/path-from-clearinghouses-to-sqlserver.png)


## ArcGIS MXD file - Map document for SQLSaturday Demos

*.mxd* - [az-landstatus-general-map.mxd](https://github.com/kkarns/sqlsaturday-869/blob/master/az-landstatus-general-map.mxd)

## Queries for SQLSaturday Demos

*.sql* - [statewide-gis-demo.sql](https://github.com/kkarns/sqlsaturday-869/blob/master/statewide-gis-demo.sql)

## Python for SQLSaturday Demos

*.py* - [arcpy-append-test.py](https://github.com/kkarns/sqlsaturday-869/blob/master/arcpy-append-test.py)

## Questions and Answers

*Q&A* - [questions-and-answers.txt](https://github.com/kkarns/sqlsaturday-869/blob/master/questions-and-answers.txt)

## Acknowledgments

* SQL Saturday volunteers, sponsors & speakers - for making this event possible.
* SQL Saturday #869 sponsors:
  * Chandler-Gilbert Community College
  * Microsoft Azure
  * Snowflake
  * Paychex
  * DriveTime
  * Idera
  * Neudesic
  * Windocks
  * TEKsystems
  * Slalom
  * VMWare
  * PASS
* PASS Community - for years of teaching and sharing SQL Server knowledge.


