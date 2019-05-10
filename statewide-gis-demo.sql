-- statewide-gis-demo.sql

---------------------------------
-- sp_help_spatial_geometry_index
---------------------------------

-- x & y min and max grid boundaries in WGS84 coordinates
--   -12780992   3675987  -12138853   4439663                                                           -- (3857) WGS84   
--   -12780992 4439663, -12138853 4439663, -12138853 3675987, -12780992 3675987, -12780992 4439663      -- (3857) WGS84 

-- first using polygon around the entire state as query sample into PLSSSECOND_AZ index 
-- 13 seconds to compute efficiency 
declare @qs geometry ='POLYGON((-12780992 4439663, -12138853 4439663, -12138853 3675987, -12780992 3675987, -12780992 4439663))';    
exec sp_help_spatial_geometry_index @tabname = "[AZBaseData].[dbo].[PLSSSECONDDIVISION_AZ]", @indexname = 'FDO_Shape', @verboseoutput = 1, @query_sample = @qs;  

--  using polygon around the entire state as query sample into PLSSSECOND_NATIONAL index 
-- 2 minutes to compute efficiency
declare @qs geometry ='POLYGON((-12780992 4439663, -12138853 4439663, -12138853 3675987, -12780992 3675987, -12780992 4439663))';    
exec sp_help_spatial_geometry_index @tabname = "[AZBaseData].[dbo].[PLSSSECONDDIVISION]", @indexname = 'FDO_Shape', @verboseoutput = 1, @query_sample = @qs;  


--  using a well point as query sample into PLSSSECOND_AZ index   (Use me in demos)
-- 3 seconds to compute efficiency 
declare @qs geometry ='POLYGON((-12162870 4086998, -12162871 4086998, -12162870 4086999, -12162870 4086998))';    
exec sp_help_spatial_geometry_index @tabname = "[AZBaseData].[dbo].[PLSSSECONDDIVISION_AZ]", @indexname = 'FDO_Shape', @verboseoutput = 1, @query_sample = @qs;  

--  using a well point as query sample into PLSSSECOND_NATIONAL index 
-- 2 minutes to compute efficiency 
declare @qs geometry ='POLYGON((-12162870 4086998, -12162871 4086998, -12162870 4086999, -12162870 4086998))';    
exec sp_help_spatial_geometry_index @tabname = "[AZBaseData].[dbo].[PLSSSECONDDIVISION]", @indexname = 'FDO_Shape', @verboseoutput = 1, @query_sample = @qs;  

-------------------------------------------------------------------------------

-- sp_help_spatial_geometry_index  ... more examples in NAD83 ASLD feature classes

-- x & y min and max grid boundaries in NAD83 coordinates
--   @xmin = 144206, @ymin = 3466600, @xmax = 685016, @ymax = 4099054                                               -- (3742) NAD83
--   144206 4099054, 685016 4099054, 685016 3466600, 144206 3466600, 144206 4099054                                 -- (3742) NAD83
--   659805.78 3811058.46, 659790.54 3811462.17, 659389.10 3811458.09, 659404.40 3811053.85, 659805.78 3811058.46   -- (3742) NAD83  NENW helium well

-- first using polygon around the entire state as query sample into ASLD_SURFACE_PARCELS index 
-- 3 seconds to compute efficiency 
declare @qs geometry ='POLYGON((144206 4099054, 685016 4099054, 685016 3466600, 144206 3466600, 144206 4099054))';    
exec sp_help_spatial_geometry_index @tabname = "[ASLDData].[dbo].[ASLD_SURFACE_PARCELS]", @indexname = 'FDO_Shape', @verboseoutput = 1, @query_sample = @qs;  


--  using small polygon as query sample into ASLD_SURFACE_PARCELS index 
-- 1 seconds to compute efficiency 
declare @qs geometry ='POLYGON ((659805.78060000017 3811058.4666000009, 659790.54279999994 3811462.1744999997, 659389.10059999954 3811458.0968999993, 659404.40940000024 3811053.8545999993, 659805.78060000017 3811058.4666000009))';    
exec sp_help_spatial_geometry_index @tabname = "[ASLDData].[dbo].[ASLD_SURFACE_PARCELS]", @indexname = 'FDO_Shape', @verboseoutput = 1, @query_sample = @qs;  


-------------------------------------------------------------------------------

-------------------------------------
-- sp_help_spatial_geometry_histogram
-------------------------------------

-- histogram  PLSSSECOND_AZ index   [min&max for projection(3857)WGS84]
-- 46 seconds ... balanced since usually 16 per section
exec sp_help_spatial_geometry_histogram @tabname = "[AZBaseData].[dbo].[PLSSSECONDDIVISION_AZ]", @colname = 'shape',  @resolution = 64, @xmin = -12780992, @ymin = 3675987, @xmax = -12138853, @ymax = 4439663, @sample = 100;


-- histogram  OG_LEASES index  [min&max for projection(3742)NAD83]
--  1 seconds ... balanced, might benefit from smaller grid size with largerdata set 
exec sp_help_spatial_geometry_histogram @tabname = "[ASLDData].[dbo].[ASLD_OG_LEASES_FOO]", @colname = 'shape',  @resolution = 64, @xmin = 144206, @ymin = 3466600, @xmax = 685016, @ymax = 4099054, @sample = 100;


-- histogram  ASLD_SURFACE_PARCELS index  [min&max for projection(3742)NAD83]    -- (Use me in demos)
--  6 seconds ... balanced since usually 16 per section
exec sp_help_spatial_geometry_histogram @tabname = "[ASLDData].[dbo].[ASLD_SURFACE_PARCELS]", @colname = 'shape',  @resolution = 64, @xmin = 144206, @ymin = 3466600, @xmax = 685016, @ymax = 4099054, @sample = 100;

-- histogram   index  [min&max for projection(3742)NAD83]    -- (Use me in demos)
--  n seconds ... balanced since usually 16 per section
exec sp_help_spatial_geometry_histogram @tabname = "[NMSLOData].[dbo].[SLO_OG_LEASES_D]", @colname = 'shape',  @resolution = 64, @xmin = 144206, @ymin = 3466600, @xmax = 685016, @ymax = 4099054, @sample = 100;


-------------------------------------------------------------------------------

-----------------------------------------------------
-- is the spatial index even working? (Arizona Ridgeway Petroleum - Helium)
-----------------------------------------------------

-- [CTRL-M] Include actual execution plan

-- optional:  look at the point we're tessellating with
-- SELECT shape.ToString(),* FROM [AZBaseData].[dbo].[AZWELLS_CLIPPED_WGS84_3857] WHERE ID= 'W040000061'  -- POINT (-12162991.3749 4086580.4606000036)

-- optional:  look at the data we're tessellating into
-- SELECT shape.ToString(),* FROM [AZBaseData].[dbo].[PLSSSECONDDIVISION_AZ] WHERE SECDIVID LIKE 'AZ140120N0290E0SN220ANENW'


-- define a variable for the geometry to tessellate with, a spatial data value for a helium well 
DECLARE @point1 geometry;

-- load the geometry point value for a helium well into a variable
SELECT 
    @point1 = SHAPE 
FROM [AZBaseData].[dbo].[AZWELLS_CLIPPED_WGS84_3857] 
WHERE 
    ID = 'W040000061' -- Well W040000061 � Ridgeway Arizona 22-01X STATE

-- optional: look at the geometry, and the WKT version of it (in meters)
-- SELECT @point1, @point1.ToString();

-- find the PLSS subsections within a mile from the national blm dataset 24 million rows, 300M leaf nodes.
SELECT 
    a.SHAPE,
    round(a.Shape.STDistance(@point1),0) Distance,
    a.SECDIVID
FROM [AZBaseData].[dbo].[PLSSSECONDDIVISION] a  -- WITH(INDEX(FDO_Shape)) -- shouldn't need index hint 
WHERE
    a.Shape.STDistance(@point1) < 1609   -- 1609 meters = 1 mi.
ORDER BY Distance

-----------------------------------------------------
-- is the spatial index even working? (NM Prolific Well - KF STATE COM #002)
-----------------------------------------------------

-- [CTRL-M] Include actual execution plan

-- optional:  look at the point we're tessellating with
SELECT shape.ToString(),* FROM [NMBaseData].[dbo].[NM_WELLS_DISTRICT_ALL_WGS84_3857] WHERE API = '30-025-38720'   -- POINT (-11507621.1022 3829466.936999999)

-- optional:  look at the data we're tessellating into
SELECT shape.ToString(),* FROM [AZBaseData].[dbo].[PLSSSECONDDIVISION] WHERE SECDIVID = 'NM230210S0350E0SN040ASESW'


-- define a variable for the geometry to tessellate with, a spatial data value for a prolific well  
DECLARE @point1 geometry;

-- load the geometry point value for a prolific well into a variable
SELECT 
    @point1 = SHAPE 
FROM [NMBaseData].[dbo].[NM_WELLS_DISTRICT_ALL_WGS84_3857]
WHERE 
    API = '30-025-38720' -- Well API = '30-025-38720' prolific well KF STATE COM #002 - CHEVRON U S A INC

-- optional: look at the geometry, and the WKT version of it (in meters)
-- SELECT @point1, @point1.ToString();

-- find the PLSS subsections within a mile from the national blm dataset 24 million rows, 300M leaf nodes.
SELECT 
    a.SHAPE,
    round(a.Shape.STDistance(@point1),0) Distance,
    a.SECDIVID
FROM [AZBaseData].[dbo].[PLSSSECONDDIVISION] a  -- WITH(INDEX(FDO_Shape)) -- shouldn't need index hint 
WHERE
    a.Shape.STDistance(@point1) < 1609   -- 1609 meters = 1 mi.
ORDER BY Distance






------------------------------------------------------
-- bone pile of random dead code at the end of the script
------------------------------------------------------

-- index definition after rebuild with more accurate bounding box ... ArcCatalog originally borrowed the bounding box from the larger dataset
CREATE SPATIAL INDEX [FDO_Shape] ON [dbo].[PLSSSECONDDIVISION_AZ]
(
    [Shape]
)USING  GEOMETRY_AUTO_GRID 
WITH (BOUNDING_BOX =(-12780992.5676, 3675987.8932, -12138853.0284, 4439663.027), 
CELLS_PER_OBJECT = 16, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


-- work in progress on a new spatial index test query aroud Ridgeway petroleum helium well


--SELECT shape.ToString(),* FROM [AZBaseData].[dbo].[PLSSSECONDDIVISION_AZ] WHERE SECDIVID LIKE 'AZ140120N0290E0SN220ANENW'
--SELECT shape.ToString(),* FROM [AZBaseData].[dbo].[PLSSSECONDDIVISION_AZ_NAD83] WHERE SECDIVID LIKE 'AZ140120N0290E0SN220ANENW'
--SELECT shape.ToString(),* FROM [ASLDData].[dbo].ASLD_OG_LEASES_FOO WHERE SECDIVID LIKE 'AZ140120N0290E0SN220ANENW'

--SELECT shape.ToString(),* FROM [AZBaseData].[dbo].[AZWELLS_CLIPPED] WHERE ID= 'W040000061'  -- POINT (-109.26201052696422 34.429205404905588)
--SELECT shape.ToString(),* FROM [AZBaseData].[dbo].[AZWELLS_CLIPPED_WGS84_3857] WHERE ID= 'W040000061'  -- POINT (-12162991.3749 4086580.4606000036)


DECLARE @point1 geometry;
SELECT @point1 = SHAPE 
    --SHAPE.STCentroid()
FROM [AZBaseData].[dbo].[AZWELLS_CLIPPED_WGS84_3857] 
--FROM [ASLDData].[dbo].[ASLD_OG_LEASES] a -- WITH(INDEX(S125_IDX))
WHERE 
    ID= 'W040000061'
     -- SHAPE.STDistance(@point1) < 1609   -- 1609 meters = 1 mi.
     --LEASE_ = '115709'
      


SELECT @point1, @point1.ToString();


SELECT 
    --SHAPE.STCentroid().STDistance(@point1) AS Distance,
    --SHAPE.STCentroid().ToString() AS center,
    SHAPE,
    Shape.STDistance(@point1)
    
--FROM [ASLDData].[dbo].ASLD_OG_LEASES_FOO      --    WITH(INDEX(FDO_Shape))
FROM [AZBaseData].[dbo].[PLSSSECONDDIVISION] a  --  WITH(INDEX(FDO_Shape))
where
    --Shape.STDistance(@point1) IS NOT NULL
    Shape.STDistance(@point1) < 1609   -- 1609 meters = 1 mi.
    -- UNIQUEKEY = 'V070630003'
--ORDER BY Distance



