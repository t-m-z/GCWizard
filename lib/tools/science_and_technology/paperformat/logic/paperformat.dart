class FormatInfo {
  final String size;
  final String area;

  const FormatInfo(this.size, this.area);
}

const Map<String, FormatInfo> DINA_FORMAT = {
  'A0': FormatInfo('841 x 1189 mm', '1 m²'),
  'A1': FormatInfo('594 x 841 mm', '0.5 m²'),
  'A2': FormatInfo('420 x 594 mm', '0.25 m²'),
  'A3': FormatInfo('297 x 420 mm', '0.12 m²'),
  'A4': FormatInfo('210 x 297 mm', '624 cm²'),
  'A5': FormatInfo('148 x 210 mm', '311.1 cm²'),
  'A6': FormatInfo('105 x 148 mm', '155.4 cm²'),
  'A7': FormatInfo('74 x 105 mm', '77.8 cm²'),
  'A8': FormatInfo('52 x 74 mm', '38.5 cm²'),
  'A9': FormatInfo('37 x 52 mm', '19.2 cm²'),
  'A10':FormatInfo('26 x 37 mm', '9.6 cm²'),
};

const Map<String, FormatInfo> DINB_FORMAT = {
  'B0': FormatInfo('1000 x 1414 mm', '1,4 m²'),
  'B1': FormatInfo('707 x 1000 mm', '0,7 m²'),
  'B2': FormatInfo('500 x 707 mm', '0,35 m²'),
  'B3': FormatInfo('353 x 500 mm', '0,18 m²'),
  'B4': FormatInfo('250 x 353 mm', '886 cm²'),
  'B5': FormatInfo('176 x 250 mm', '440 cm²'),
  'B6': FormatInfo('125 x 176 mm', '220 cm²'),
  'B7': FormatInfo('88 x 125 mm', '110 cm²'),
  'B8': FormatInfo('62 x 88 mm', '54,6 cm²'),
  'B9': FormatInfo('44 x 62 mm', '27,3 cm²'),
  'B10': FormatInfo('31 x 44 mm', '13,6 cm²'),
};

const Map<String, FormatInfo> DINC_FORMAT = {
  'C0': FormatInfo('917 x 1297 mm', '1.19 m²'),
  'C1': FormatInfo('648 x 917 mm', '0.59 m²'),
  'C2': FormatInfo('458 x 648 mm', '0.30 m²'),
  'C3': FormatInfo('324 x 458 mm', '0.15 m²'),
  'C4': FormatInfo('229 x 324 mm', '742 cm²'),
  'C5': FormatInfo('162 x 229 mm', '371 cm²'),
  'C6': FormatInfo('114 x 162 mm', '184.7 cm²'),
  'C7': FormatInfo('81 x 114 mm', '92.3 cm²'),
  'C8': FormatInfo('57 x 81 mm', '46.2 cm²'),
  'C9': FormatInfo('40 x 57 mm', '22.8 cm²'),
  'C10': FormatInfo( '28 x 40 mm', '11.2 cm²'),
};

const Map<String, FormatInfo> DIND_FORMAT = {
  'D0': FormatInfo('771 x 1090 mm', '0.84 m²'),
  'D1': FormatInfo('545 x 771 mm', '0.42 m²'),
  'D2': FormatInfo('385 x 545 mm', '0.21 m²'),
  'D3': FormatInfo('272 x 385 mm', '0.10 m²'),
  'D4': FormatInfo('192 x 272 mm', '522 cm²'),
  'D5': FormatInfo('136 x 192 mm', '261.1 cm²'),
  'D6': FormatInfo('96 x 136 mm', '130.6 cm²'),
  'D7': FormatInfo('68 x 96 mm', '65.3 cm²'),
  'D8': FormatInfo('48 x 68 mm', '32.6 cm²'),
  'D9': FormatInfo('34 x 48 mm', '16.3 cm²'),
  'D10': FormatInfo( '24 x 34 mm', '8.2 cm²'),
};

const Map<String, FormatInfo> US_FORMAT = {
  'Tabloid': FormatInfo('17 x 11 in/ 432 x 279 mm', '1.20 m²'),
  'Ledger': FormatInfo('11 x 17 in/ 279 x 432 mm', '1.20 m²'),
  'Legal': FormatInfo('8.5 x 14 in/ 216 x 356 mm', '769 cm²'),
  'Letter': FormatInfo('8.5 x 11 in/ 216 x 279 mm', '603 cm²'),
  'Junior Legal': FormatInfo('8 x 5 in/ 203 x 127 mm', '359 cm²'),
  'Junior': FormatInfo('5 x 8 in/ 127 x 203 mm', '359 cm²'),
  'Half Letter': FormatInfo('5.5 x 8.5 in/ 140 x 216 mm', '302 cm²'),
};

const Map<String, FormatInfo> US_ANSI_FORMAT = {
  'Ansi E': FormatInfo('34 x 44 in/ 864 x 1118 mm', '0.97 m²'),
  'Ansi D': FormatInfo('22 x 34 in/ 559 x 864 mm', '0.48 m²'),
  'Ansi C': FormatInfo('17 x 22 in/ 432 x 559 mm', '0.24 m²'),
  'Ansi B': FormatInfo('11 x 17 in/ 279 x 432 mm', '0.12 m²'),
  'Ansi A': FormatInfo('8.5 x 11 in/ 216 x 279 mm', '603 cm²'),
};

const Map<String, FormatInfo> US_ARCH_FORMAT = {
  'Arch E': FormatInfo('36 x 48 in/ 914 x 1219 mm', '1,11 m²'),
  'Arch E1': FormatInfo('30 x 42 in/ 762 x 1067 mm', '0.81 m²'),
  'Arch D': FormatInfo('24 x 36 in/ 610 x 914 mm', '0.56 m²'),
  'Arch C': FormatInfo('18 x 24 in/ 457 x 610 mm', '0.28 m²'),
  'Arch B': FormatInfo('12 x 18 in/ 305 x 457 mm', '0.12 m²'),
  'Arch A': FormatInfo('9 x 12 in/ 229 x 305 mm', '698 cm²'),
};
