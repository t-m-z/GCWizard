enum CLOUD_COVER {
  CLEAR_0,
  FEW_1,
  FEW_2,
  SCATTERED_3,
  SCATTERED_4,
  BROKEN_5,
  BROKEN_6,
  BROKEN_7,
  OVERCAST_8,
  OBSCURED_9,
  NULL
}

Map<CLOUD_COVER, String> CLOUD_COVER_LIST = {
  CLOUD_COVER.CLEAR_0: 'weathersymbols_n_0',
  CLOUD_COVER.FEW_1: 'weathersymbols_n_1',
  CLOUD_COVER.FEW_2: 'weathersymbols_n_2',
  CLOUD_COVER.SCATTERED_3: 'weathersymbols_n_3',
  CLOUD_COVER.SCATTERED_4: 'weathersymbols_n_4',
  CLOUD_COVER.BROKEN_5: 'weathersymbols_n_5',
  CLOUD_COVER.BROKEN_6: 'weathersymbols_n_6',
  CLOUD_COVER.BROKEN_7: 'weathersymbols_n_7',
  CLOUD_COVER.OVERCAST_8: 'weathersymbols_n_8',
  CLOUD_COVER.OBSCURED_9: 'weathersymbols_n_9',
};

class CloudCoverConfig {
  final String image;
  final String title;
  final String subtitle;

  const CloudCoverConfig({
    required this.image,
    required this.title,
    required this.subtitle,
  });
}

const Map<CLOUD_COVER, CloudCoverConfig> CLOUD_COVER_MAP = {
  CLOUD_COVER.CLEAR_0: CloudCoverConfig(image: '0', title: 'weathersymbols_n_0', subtitle: ''),
  CLOUD_COVER.FEW_1: CloudCoverConfig(image: '1', title: 'weathersymbols_n_1', subtitle: ''),
  CLOUD_COVER.FEW_2: CloudCoverConfig(image: '2', title: 'weathersymbols_n_2', subtitle: ''),
  CLOUD_COVER.SCATTERED_3: CloudCoverConfig(image: '3', title: 'weathersymbols_n_3', subtitle: ''),
  CLOUD_COVER.SCATTERED_4: CloudCoverConfig(image: '4', title: 'weathersymbols_n_4', subtitle: ''),
  CLOUD_COVER.BROKEN_5: CloudCoverConfig(image: '5', title: 'weathersymbols_n_5', subtitle: ''),
  CLOUD_COVER.BROKEN_6: CloudCoverConfig(image: '6', title: 'weathersymbols_n_6', subtitle: ''),
  CLOUD_COVER.BROKEN_7: CloudCoverConfig(image: '7', title: 'weathersymbols_n_7', subtitle: ''),
  CLOUD_COVER.OVERCAST_8: CloudCoverConfig(image: '8', title: 'weathersymbols_n_8', subtitle: ''),
  CLOUD_COVER.OBSCURED_9: CloudCoverConfig(image: '9', title: 'weathersymbols_n_9', subtitle: ''),
};

Map<CLOUD_COVER, double> CLOUD_COVER_VALUE = {
  // https://geo.libretexts.org/Bookshelves/Meteorology_and_Climate_Science/Practical_Meteorology_(Stull)/06%3A_Clouds/6.05%3A_Sky_Cover_(Cloud_Amount)
  // https://earthscience.stackexchange.com/questions/16471/how-do-i-interpret-this-sky-cover-chart
  // sunny - clear - CLR - 1/8 or less - 0.000 to 0.125
  CLOUD_COVER.CLEAR_0: 0.0,
  // mostly sunny - mostly clear - FEW - 1/8 - 3/8 - 0.125 to 0.375
  CLOUD_COVER.FEW_1: 0.125,
  CLOUD_COVER.FEW_2: 0.250,
  // partly sunny - partly cloudy - SCT - 3/8 - 5/8 - 0.375 to 0.625
  CLOUD_COVER.SCATTERED_3: 0.375,
  CLOUD_COVER.SCATTERED_4: 0.500,
  // mostly cloudy - mostly cloudy - BKN - 5/8 - 7/8 - 0.625 to 0.875
  CLOUD_COVER.BROKEN_5: 0.625,
  CLOUD_COVER.BROKEN_6: 0.750,
  CLOUD_COVER.BROKEN_7: 0.875,
  // cloudy - cloudy - OVC - 7/8 - 9/8 - 0.875 to 1.000
  CLOUD_COVER.OVERCAST_8: 1.0,
  CLOUD_COVER.OBSCURED_9: 1.0,
};