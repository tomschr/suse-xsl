<?xml version="1.0" encoding="UTF-8"?>
<!--
  Purpose:
    Logo SVG, chooses between color/grayscale mode itself.

  Author(s):  Stefan Knorr <sknorr@suse.de>,
              Thomas Schraitle <toms@opensuse.org>

  Copyright:  2013, Stefan Knorr, Thomas Schraitle

-->
<!DOCTYPE xsl:stylesheet
[
  <!ENTITY % fonts SYSTEM "fonts.ent">
  <!ENTITY % colors SYSTEM "colors.ent">
  <!ENTITY % metrics SYSTEM "metrics.ent">
  %fonts;
  %colors;
  %metrics;
]>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format">

  <xsl:template name="logo-image">
    <xsl:param name="geeko-color">
      <xsl:choose>
        <xsl:when test="$format.print != 1">&chamaeleon-green;</xsl:when>
        <xsl:otherwise>&darker-gray;</xsl:otherwise>
      </xsl:choose>
    </xsl:param>
    <xsl:param name="logo-text-color">&black;</xsl:param>

    <svg:svg xmlns:svg="http://www.w3.org/2000/svg" version="1.1" width="432" height="288">
    <svg:path
      d="m 0,0 0,32.943 0,0 114.69,0 0,-32.943 L 0,0 Z m 107.523,25.776 -100.353,0 0,-18.608 100.353,0 0,18.608 z"
      fill="{$geeko-color}"/>
    <svg:path
      d="m 7.169,87.393 -7.168,0 0,-32.944 7.168,0 0,13.019 12.809,0 0,-13.019 7.168,0 0,32.944 -7.168,0 0,-13.652 -12.809,0 0,13.652 z m 36.264,0.526 c -7.273,0 -12.229,-4.586 -12.229,-12.122 0,-7.328 4.85,-12.389 11.28,-12.389 7.01,0 10.488,4.692 10.488,11.703 l 0,2.636 -14.97,0 c 0.844,3.636 3.69,4.583 6.537,4.583 2.477,0 4.269,-0.525 6.482,-1.896 l 0.264,0 0,5.429 c -1.896,1.371 -4.585,2.056 -7.852,2.056 z m -5.43,-14.969 8.539,0 c -0.157,-2.424 -1.159,-4.111 -3.953,-4.111 -2.108,-0.001 -3.953,0.895 -4.586,4.111 z m 33.681,0.632 -3.689,13.811 -6.272,0 -7.169,-23.193 0,-0.263 6.852,0 3.901,13.862 3.689,-13.862 5.587,0 3.743,13.862 3.953,-13.862 6.589,0 0,0.263 -7.168,23.193 -6.273,0 -3.743,-13.811 z m 28.832,14.337 c -5.693,0 -8.012,-2.268 -8.012,-7.59 l 0,-25.88 6.958,0 0,25.406 c 0,1.635 0.632,2.214 2.002,2.214 0.476,0 1.16,-0.157 1.582,-0.317 l 0.105,0 0,5.746 c -0.579,0.21 -1.581,0.421 -2.635,0.421 z m 16.814,0 c -7.273,0 -12.228,-4.586 -12.228,-12.122 0,-7.328 4.849,-12.389 11.279,-12.389 7.01,0 10.489,4.692 10.489,11.703 l 0,2.636 -14.97,0 c 0.843,3.636 3.689,4.583 6.536,4.583 2.478,0 4.27,-0.525 6.484,-1.896 l 0.264,0 0,5.429 c -1.897,1.371 -4.586,2.056 -7.854,2.056 z m -5.429,-14.969 8.539,0 c -0.159,-2.424 -1.159,-4.111 -3.953,-4.111 -2.108,-0.001 -3.954,0.895 -4.586,4.111 z m 43.537,-9.014 5.167,0 0,5.586 -5.167,0 0,9.542 c 0,2.055 0.791,3.004 2.899,3.004 0.58,0 1.318,-0.053 2.109,-0.317 l 0.158,0 0,5.482 c -0.897,0.317 -2.267,0.686 -4.27,0.686 -5.642,0 -7.854,-2.583 -7.854,-8.539 l 0,-9.857 -8.908,0 0,9.542 c 0,2.055 0.791,3.004 2.899,3.004 0.58,0 1.318,-0.053 2.108,-0.317 l 0.159,0 0,5.482 c -0.896,0.317 -2.267,0.686 -4.27,0.686 -5.641,0 -7.854,-2.583 -7.854,-8.539 l 0,-9.857 -3.585,0 0,-5.586 3.585,0 0,-6.43 6.958,0 0,6.43 8.908,0 0,-6.43 6.958,0 0,6.428 z m 41.261,1.687 c 0,7.169 -4.797,11.07 -12.073,11.07 l -5.111,0 0,10.7 -7.166,0 0,-32.944 12.277,0 c 7.277,0 12.073,3.9 12.073,11.174 z m -12.652,5.008 c 3.639,0 5.378,-2.056 5.378,-5.008 0,-3.057 -1.739,-5.112 -5.378,-5.112 l -4.532,0 0,10.12 4.532,0 z m 28.147,14.442 c -1.528,1.844 -3.793,2.74 -6.219,2.74 -4.585,0 -8.328,-2.791 -8.328,-7.747 0,-4.586 3.743,-7.644 9.118,-7.644 1.687,0 3.428,0.265 5.219,0.791 l 0,-0.421 c 0,-2.531 -1.423,-3.637 -5.165,-3.637 -2.374,0 -4.639,0.685 -6.589,1.792 l -0.263,0 0,-5.587 c 1.791,-1.054 4.954,-1.951 8.062,-1.951 7.064,0 10.911,3.374 10.911,9.278 l 0,14.706 -6.747,0 0,-2.32 z m -0.21,-5.061 0,-2.003 c -1.055,-0.579 -2.423,-0.79 -3.848,-0.79 -2.267,0 -3.636,0.843 -3.636,2.74 0,1.952 1.369,2.795 3.425,2.795 1.95,0 3.426,-1.003 4.059,-2.742 z m 10.489,-4.321 c 0,-7.538 5.324,-12.282 12.281,-12.282 2.479,0 4.797,0.528 6.536,1.792 l 0,5.957 -0.264,0 c -1.529,-1.16 -3.321,-1.846 -5.376,-1.846 -3.479,0 -6.114,2.373 -6.114,6.378 0,4.005 2.636,6.325 6.114,6.325 2.055,0 3.847,-0.686 5.376,-1.846 l 0.264,0 0,5.956 c -1.739,1.267 -4.058,1.793 -6.536,1.793 -6.957,10e-4 -12.281,-4.689 -12.281,-12.227 z m 30.147,1.055 0,10.646 -6.955,0 0,-32.943 6.955,0 0,18.764 7.013,-9.277 7.905,0 0,0.263 -8.433,10.647 8.433,12.282 0,0.264 -7.958,0 -6.96,-10.646 z m 30.732,8.327 c -1.528,1.844 -3.796,2.74 -6.221,2.74 -4.586,0 -8.328,-2.791 -8.328,-7.747 0,-4.586 3.742,-7.644 9.12,-7.644 1.687,0 3.426,0.265 5.218,0.791 l 0,-0.421 c 0,-2.531 -1.424,-3.637 -5.165,-3.637 -2.371,0 -4.641,0.685 -6.591,1.792 l -0.262,0 0,-5.587 c 1.793,-1.054 4.954,-1.951 8.064,-1.951 7.063,0 10.911,3.374 10.911,9.278 l 0,14.706 -6.747,0 0,-2.32 z m -0.211,-5.061 0,-2.003 c -1.054,-0.579 -2.425,-0.79 -3.849,-0.79 -2.266,0 -3.637,0.843 -3.637,2.74 0,1.952 1.371,2.795 3.426,2.795 1.952,0 3.428,-1.003 4.06,-2.742 z m 18.66,-12.281 c 1.263,-2.583 3.108,-4.059 5.693,-4.059 0.947,0 1.896,0.21 2.263,0.421 l 0,6.642 -0.262,0 c -0.79,-0.317 -1.739,-0.528 -3.058,-0.528 -2.16,0 -3.847,1.266 -4.428,3.689 l 0,13.495 -6.957,0 0,-23.457 6.748,0 0,3.797 z m 26.614,17.237 c -1.474,1.897 -3.794,2.951 -6.955,2.951 -6.01,0 -9.857,-5.48 -9.857,-12.229 0,-6.747 3.848,-12.282 9.857,-12.282 3.057,0 5.27,0.95 6.745,2.689 l 0,-11.648 6.959,0 0,32.944 -6.749,0 0,-2.425 z m -0.21,-5.535 0,-7.538 c -1.159,-1.687 -2.686,-2.424 -4.427,-2.424 -3.056,0 -5.111,2.214 -5.111,6.22 0,4.006 2.056,6.167 5.111,6.167 1.742,0 3.268,-0.739 4.427,-2.425 z M 0,98.15 l 20.346,0 0,4.005 -15.76,0 0,10.066 14.284,0 0,3.901 -14.284,0 0,10.965 15.76,0 0,4.004 -20.346,0 0,-32.941 z m 37.16,9.276 c 5.218,0 8.117,3.426 8.117,9.065 l 0,14.6 -4.374,0 0,-14.493 c 0,-3.006 -1.528,-5.167 -4.849,-5.167 -2.741,0 -5.062,1.739 -5.851,4.217 l 0,15.443 -4.375,0 0,-23.19 4.375,0 0,3.372 c 1.369,-2.16 3.689,-3.847 6.957,-3.847 z m 19.871,0.475 5.955,0 0,3.743 -5.955,0 0,12.49 c 0,2.636 1.37,3.532 3.847,3.532 0.685,0 1.423,-0.104 1.95,-0.315 l 0.158,0 0,3.74 c -0.631,0.265 -1.528,0.476 -2.74,0.476 -5.429,0 -7.59,-2.479 -7.59,-7.011 l 0,-12.912 -4.005,0 0,-3.743 4.005,0 0,-6.165 4.375,0 0,6.165 z m 20.187,23.666 c -6.799,0 -11.438,-4.535 -11.438,-11.808 0,-7.274 4.322,-12.333 10.595,-12.333 6.378,0 9.699,4.586 9.699,11.384 l 0,2.003 -15.918,0 c 0.475,4.692 3.479,6.958 7.643,6.958 2.583,0 4.427,-0.579 6.483,-2.108 l 0.159,0 0,3.85 c -1.898,1.475 -4.376,2.054 -7.223,2.054 z m -6.904,-14.339 11.543,0 c -0.157,-3.424 -1.845,-6.059 -5.429,-6.059 -3.321,0 -5.482,2.476 -6.114,6.059 z m 25.299,-5.744 c 1.003,-2.476 3.216,-3.951 5.745,-3.951 1.002,0 1.898,0.157 2.267,0.368 l 0,4.32 -0.158,0 c -0.632,-0.315 -1.687,-0.473 -2.741,-0.473 -2.372,0 -4.374,1.581 -5.113,4.217 l 0,15.126 -4.375,0 0,-23.19 4.375,0 0,3.583 z m 22.876,-4.058 c 6.905,0 10.595,5.64 10.595,12.069 0,6.432 -3.689,12.071 -10.595,12.071 -2.846,0 -5.27,-1.476 -6.482,-3.058 l 0,11.492 -4.375,0 0,-32.101 4.375,0 0,2.634 c 1.212,-1.631 3.636,-3.107 6.482,-3.107 z m -0.738,20.187 c 4.323,0 6.853,-3.426 6.853,-8.117 0,-4.639 -2.53,-8.116 -6.853,-8.116 -2.372,0 -4.585,1.423 -5.745,3.688 l 0,8.91 c 1.16,2.263 3.374,3.635 5.745,3.635 z m 20.874,-16.129 c 1,-2.476 3.215,-3.951 5.745,-3.951 1.001,0 1.897,0.157 2.266,0.368 l 0,4.32 -0.158,0 c -0.632,-0.315 -1.686,-0.473 -2.741,-0.473 -2.373,0 -4.375,1.581 -5.113,4.217 l 0,15.126 -4.375,0 0,-23.19 4.375,0 0,3.583 z m 14.336,-12.965 c 1.528,0 2.794,1.211 2.794,2.741 0,1.527 -1.266,2.74 -2.794,2.74 -1.476,0 -2.793,-1.213 -2.793,-2.74 0,-1.53 1.318,-2.741 2.793,-2.741 z m -2.161,9.382 4.375,0 0,23.19 -4.375,0 0,-23.19 z m 19.977,9.646 c 3.32,1.052 7.01,2.423 7.01,6.851 0,4.744 -3.899,7.169 -8.906,7.169 -3.058,0 -6.115,-0.739 -7.854,-2.108 l 0,-4.164 0.21,0 c 1.951,1.793 4.849,2.583 7.59,2.583 2.478,0 4.691,-0.95 4.691,-2.953 0,-2.055 -1.844,-2.529 -5.482,-3.741 -3.269,-1.054 -6.905,-2.267 -6.905,-6.642 0,-4.481 3.689,-7.115 8.381,-7.115 2.741,0 5.164,0.579 7.116,1.897 l 0,4.217 -0.159,0 c -1.896,-1.528 -4.111,-2.425 -6.852,-2.425 -2.742,0 -4.27,1.212 -4.27,2.847 0,1.843 1.686,2.37 5.43,3.584 z m 22.243,14.02 c -6.8,0 -11.438,-4.535 -11.438,-11.808 0,-7.274 4.322,-12.333 10.594,-12.333 6.379,0 9.699,4.586 9.699,11.384 l 0,2.003 -15.92,0 c 0.475,4.692 3.48,6.958 7.644,6.958 2.584,0 4.428,-0.579 6.484,-2.108 l 0.157,0 0,3.85 c -1.896,1.475 -4.375,2.054 -7.22,2.054 z m -6.905,-14.339 11.541,0 c -0.156,-3.424 -1.844,-6.059 -5.427,-6.059 -3.321,0 -5.482,2.476 -6.114,6.059 z"
      fill="{$logo-text-color}"/>
    </svg:svg>

  </xsl:template>

  <xsl:template name="secondary-branding">
    <xsl:param name="geeko-color">
      <xsl:choose>
        <xsl:when test="$format.print != 1">&chamaeleon-green;</xsl:when>
        <xsl:otherwise>&darker-gray;</xsl:otherwise>
      </xsl:choose>
    </xsl:param>
    <xsl:param name="logo-text-color">&black;</xsl:param>
    <xsl:param name="opacity">0.5</xsl:param>

    <svg:svg xmlns:svg="http://www.w3.org/2000/svg" version="1.1" width="36" height="36">
      <svg:path d="M 30.357422,5.9365234 29.416016,8.2104492 C 28.335937,5.7358398 25.868164,4 23,4 l -5.5,0 c -3.518555,0 -6.431641,2.6137695 -6.919922,6 L 7.5,10 C 3.3632812,10 0,13.364258 0,17.5 c 0,2.798828 1.578125,5.345703 4.0390625,6.632812 L 4.8066406,22.28125 C 3.0908203,21.3125 2,19.492187 2,17.5 2,14.467773 4.4667969,12 7.5,12 l 11.5,0 0,-2 -6.398437,0 C 13.06543,7.7207031 15.085938,6 17.5,6 L 23,6 c 2.09668,0 3.889648,1.3012695 4.631836,3.1357422 L 25.132812,8.100586 24.367187,9.9482422 29.910156,12.245117 32.205078,6.7021484 30.357422,5.9365234 Z"
       fill="{$geeko-color}" fill-opacity="{$opacity}"/>

     <svg:path d="m 32.454102,11.126953 -0.778321,1.88086 C 33.117187,14.040039 34,15.712891 34,17.5 34,20.53125 31.533203,23 28.5,23 l -11.5,0 0,2 6.898437,0 C 23.43457,27.279297 21.414062,29 19,29 l -5.5,0 C 11.427734,29 9.6464844,27.730469 8.8896484,25.929687 L 11.546875,27.03125 12.3125,25.183594 6.7695312,22.886719 4.4726562,28.429688 6.3203124,29.195313 7.2099608,27.050781 C 8.3457031,29.382812 10.735352,31 13.5,31 l 5.5,0 c 3.518555,0 6.431641,-2.613281 6.919922,-6 L 28.5,25 c 4.136719,0 7.5,-3.365234 7.5,-7.5 0,-2.586914 -1.357422,-5.00293 -3.545898,-6.373047 z"
       fill="{$logo-text-color}" fill-opacity="{$opacity}"/>
    </svg:svg>

  </xsl:template>

</xsl:stylesheet>
