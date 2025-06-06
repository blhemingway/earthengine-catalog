local id = 'COPERNICUS/S5P/NRTI/L3_CLOUD';
local subdir = 'COPERNICUS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';
local COPERNICUS_S5P = import 'COPERNICUS_S5P.libsonnet';

local license = spdx.proprietary;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
  ],
  id: id,
  title: 'Sentinel-5P NRTI CLOUD: Near Real-Time Cloud Properties',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    ### NRTI/L3_CLOUD

    This dataset provides near real-time high-resolution imagery of cloud parameters.

    The TROPOMI/S5P cloud properties retrieval is based on the OCRA and ROCINN
    algorithms currently being used in the operational GOME and GOME-2 products.
    OCRA retrieves the cloud fraction using measurements in the UV/VIS spectral
    regions and ROCINN retrieves the cloud height (pressure) and optical thickness
    (albedo) using measurements in and around the oxygen A-band at 760 nm. Version 3.0
    of the algorithms are used, which are based on a more realistic
    treatment of clouds as optically uniform layers of light-scattering particles.
    Additionally, the cloud parameters are also provided for a cloud model which
    assumes the cloud to be a Lambertian reflecting boundary.
    [More information.](http://www.tropomi.eu/data-products/cloud)

    ### NRTI L3 Product

    To make our NRTI L3 products, we use [harpconvert](https://stcorp.github.io/harp/doc/html/harpconvert.html)
    to grid the data.

    Example harpconvert invocation for one tile:
    ```
    harpconvert --format hdf5 --hdf5-compression 9
    -a 'cloud_fraction>50;derive(datetime_stop {time});
    bin_spatial(2001, 50.000000, 0.01, 2001, -120.000000, 0.01);
    keep(cloud_fraction,cloud_top_pressure,cloud_top_height,
    cloud_base_pressure,cloud_base_height,cloud_optical_depth,surface_albedo,
    sensor_azimuth_angle,sensor_zenith_angle,solar_azimuth_angle,
    solar_zenith_angle)'
    S5P_NRTI_L2__CLOUD__20190208T230503_20190208T231003_06860_01_010105_20190209T005255.nc
    output.h5
    ```

    Assets between the dates 2018-07-10 and 2018-07-18 are missing due to non-standard structure
    of product files.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  'gee:categories': ['atmosphere'],
  keywords: [
    'cloud',
    'copernicus',
    'dlr',
    'esa',
    'eu',
    's5p',
    'sentinel',
    'tropomi',
  ],
  providers: [
    ee.producer_provider('European Union/ESA/Copernicus', 'https://sentinel.esa.int/web/sentinel/user-guides/sentinel-5p-tropomi'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2018-07-05T23:24:16Z', null),
  summaries: {
    'gee:schema': [
      {
        name: 'ALGORITHM_VERSION',
        description: |||
          The algorithm version used in L2 processing. It is separate from the
          processor (framework) version, to accommodate different release
          schedules for different products.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'BUILD_DATE',
        description: |||
          The date, expressed as milliseconds since 1 Jan 1970,
          when the software used to perform L2 processing was built.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'HARP_VERSION',
        description: 'The version of the HARP tool used to grid the L2 data into an L3\nproduct.',
        type: ee_const.var_type.int,
      },
      {
        name: 'INSTITUTION',
        description: 'The institution where data processing from L1 to L2 was performed.',
        type: ee_const.var_type.string,
      },
      {
        name: 'L3_PROCESSING_TIME',
        description: |||
          The date, expressed as milliseconds since 1 Jan 1970,
          when Google processed the L2 data into L3 using harpconvert.
        |||,
        type: ee_const.var_type.int,
      },
      {
        name: 'LAT_MAX',
        description: 'The maximum latitude of the asset (degrees).',
        type: ee_const.var_type.double,
      },
      {
        name: 'LAT_MIN',
        description: 'The minimum latitude of the asset (degrees).',
        type: ee_const.var_type.double,
      },
      {
        name: 'LON_MAX',
        description: 'The maximum longitude of the asset (degrees).',
        type: ee_const.var_type.double,
      },
      {
        name: 'LON_MIN',
        description: 'The minimum longitude of the asset (degrees).',
        type: ee_const.var_type.double,
      },
      {
        name: 'ORBIT',
        description: 'The orbit number of the satellite when the data was acquired.',
        type: ee_const.var_type.int,
      },
      {
        name: 'PLATFORM',
        description: 'Name of the platform which acquired the data.',
        type: ee_const.var_type.string,
      },
      {
        name: 'PROCESSING_STATUS',
        description: |||
          The processing status of the product on a global level, mainly based
          on the availability of auxiliary input data.  Possible values are
          "Nominal" and "Degraded".
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'PROCESSOR_VERSION',
        description: 'The version of the software used for L2 processing, as a string of\nthe form "major.minor.patch".',
        type: ee_const.var_type.string,
      },
      {
        name: 'PRODUCT_ID',
        description: 'Id of the L2 product used to generate this asset.',
        type: ee_const.var_type.string,
      },
      {
        name: 'PRODUCT_QUALITY',
        description: |||
          Indicator that specifies whether the product quality is degraded or
          not.  Allowed values are "Degraded" and "Nominal".
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'SENSOR',
        description: 'Name of the sensor which acquired the data.',
        type: ee_const.var_type.string,
      },
      {
        name: 'SPATIAL_RESOLUTION',
        description: |||
          Spatial resolution at nadir. For most products this is `3.5x7 km2`,
          except for `L2__O3__PR`, which uses `28x21km2`, and
          `L2__CO____` and `L2__CH4___`, which both use `7x7 km2`.
          This attribute originates from the CCI standard.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'TIME_REFERENCE_DAYS_SINCE_1950',
        description: 'Days from 1 Jan 1950 to when the data was acquired.',
        type: ee_const.var_type.int,
      },
      {
        name: 'TIME_REFERENCE_JULIAN_DAY',
        description: 'The Julian day number when the data was acquired.',
        type: ee_const.var_type.double,
      },
      {
        name: 'TRACKING_ID',
        description: 'UUID for the L2 product file.',
        type: ee_const.var_type.string,
      },
      {
        name: 'CLOUD_MODE',
        description: |||
          Tells which model was used to generate this dataset, the CAL (Clouds As
          Layers) model or the CRB (Clouds as Reflecting Boundaries) model.  Valid
          values of this property are "cal" or "crb", respectively, with "cal"
          being the default.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'STATUS_MET_2D',
        description: |||
          This dataset uses some dynamic auxiliary data from the European Centre
          for Medium-Range Weather Forecasts.  If the ECMWF data was used, this
          field will have the value 'Nominal'.  If the ECMWF data was not used, a
          fallback solution was used, and this field will have the value of
          "Fallback".
        |||,
        type: ee_const.var_type.string,
      },
    ],
    gsd: [
      1113.2,
    ],
    platform: [
      'Sentinel-5P',
    ],
    instruments: [
      'TROPOMI',
    ],
    'eo:bands': [
      {
        name: 'cloud_fraction',
        description: 'Retrieved effective radiometric cloud fraction',
        'gee:units': units.unspecified_fraction,
      },
      {
        name: 'cloud_top_pressure',
        description: 'Retrieved atmospheric pressure at the level of cloud top',
        'gee:units': units.pascal,
      },
      {
        name: 'cloud_top_height',
        description: 'Retrieved altitude of the cloud top',
        'gee:units': units.meter,
      },
      {
        name: 'cloud_base_pressure',
        description: 'Cloud base pressure',
        'gee:units': units.pascal,
      },
      {
        name: 'cloud_base_height',
        description: 'Cloud base height',
        'gee:units': units.meter,
      },
      {
        name: 'cloud_optical_depth',
        description: 'Retrieved cloud optical depth',
      },
      {
        name: 'surface_albedo',
        description: 'Surface albedo',
      },
    ] + COPERNICUS_S5P.bands_common,
    'gee:visualizations': [
      {
        display_name: 'RGB',
        lookat: {
          lat: -10.47,
          lon: -58.14,
          zoom: 2,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              0.95,
            ],
            palette: [
              'black',
              'blue',
              'purple',
              'cyan',
              'green',
              'yellow',
              'red',
            ],
            bands: [
              'cloud_fraction',
            ],
          },
        },
      },
    ],
    cloud_fraction: {
      minimum: 0.0,
      maximum: 1.0,
      'gee:estimated_range': true,
    },
    cloud_top_pressure: {
      minimum: 12109.0,
      maximum: 101299.0,
      'gee:estimated_range': true,
    },
    cloud_top_height: {
      minimum: 9.0,
      maximum: 15471.0,
      'gee:estimated_range': true,
    },
    cloud_base_pressure: {
      minimum: 14169.0,
      maximum: 101299.0,
      'gee:estimated_range': true,
    },
    cloud_base_height: {
      minimum: 9.0,
      maximum: 14545.0,
      'gee:estimated_range': true,
    },
    cloud_optical_depth: {
      minimum: 1.0,
      maximum: 250.0,
      'gee:estimated_range': true,
    },
    surface_albedo: {
      minimum: 0.0,
      maximum: 1.0,
      'gee:estimated_range': true,
    },
    sensor_azimuth_angle: {
      minimum: -180.0,
      maximum: 180.0,
      'gee:estimated_range': true,
    },
    sensor_zenith_angle: {
      minimum: 0.09,
      maximum: 67.0,
      'gee:estimated_range': true,
    },
    solar_azimuth_angle: {
      minimum: -180.0,
      maximum: 180.0,
      'gee:estimated_range': true,
    },
    solar_zenith_angle: {
      minimum: 8.0,
      maximum: 80.0,
      'gee:estimated_range': true,
    },
  },
  'gee:interval': {
    type: 'revisit_interval',
    unit: 'day',
    interval: 2,
  },
  'gee:terms_of_use': |||
    The use of Sentinel data is governed by the [Copernicus
    Sentinel Data Terms and Conditions.](https://sentinel.esa.int/documents/247904/690755/Sentinel_Data_Legal_Notice)
  |||,
}
