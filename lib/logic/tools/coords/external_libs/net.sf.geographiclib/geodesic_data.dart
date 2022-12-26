/***********************************************************************
    Dart port of Java implementation of
    ======================
    GeographicLib
    ======================

 * Copyright (c) Charles Karney (2013-2021) <charles@karney.com> and licensed
 * under the MIT/X11 License.  For more information, see
 * https://geographiclib.sourceforge.io/
 * https://sourceforge.net/projects/geographiclib/

 **********************************************************************/

/**
 * The results of geodesic calculations.
 *
 * This is used to return the results for a geodesic between point 1
 * (<i>lat1</i>, <i>lon1</i>) and point 2 (<i>lat2</i>, <i>lon2</i>).  Fields
 * that have not been set will be filled with Double.NaN.  The returned
 * GeodesicData objects always include the parameters provided to {@link
 * Geodesic#Direct(double, double, double, double) Geodesic.Direct} and {@link
 * Geodesic#Inverse(double, double, double, double) Geodesic.Inverse} and it
 * always includes the field <i>a12</i>.
 **********************************************************************/
class GeodesicData {
  /**
   * latitude of point 1 (degrees).
   **********************************************************************/
  double lat1;
  /**
   * longitude of point 1 (degrees).
   **********************************************************************/
  double lon1;
  /**
   * azimuth at point 1 (degrees).
   **********************************************************************/
  double azi1;
  /**
   * latitude of point 2 (degrees).
   **********************************************************************/
  double lat2;
  /**
   * longitude of point 2 (degrees).
   **********************************************************************/
  double lon2;
  /**
   * azimuth at point 2 (degrees).
   **********************************************************************/
  double azi2;
  /**
   * distance between point 1 and point 2 (meters).
   **********************************************************************/
  double s12;
  /**
   * arc length on the auxiliary sphere between point 1 and point 2
   *   (degrees).
   **********************************************************************/
  double a12;
  /**
   * reduced length of geodesic (meters).
   **********************************************************************/
  double m12;
  /**
   * geodesic scale of point 2 relative to point 1 (dimensionless).
   **********************************************************************/
  double M12;
  /**
   * geodesic scale of point 1 relative to point 2 (dimensionless).
   **********************************************************************/
  double M21;
  /**
   * area under the geodesic (meters<sup>2</sup>).
   **********************************************************************/
  double S12;
}
