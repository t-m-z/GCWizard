import 'package:flutter/material.dart';
import 'package:gc_wizard/application/category_views/gcc/tables/gcc_symbols_selection.dart';
import 'package:gc_wizard/application/category_views/gcc/tables/gcc_tables_selection.dart';
import 'package:gc_wizard/application/category_views/gcc/tables/table_ascii_set.dart';
import 'package:gc_wizard/application/category_views/gcc/tables/table_morse.dart';
import 'package:gc_wizard/application/category_views/gcc/tables/table_numeralbases.dart';
import 'package:gc_wizard/application/category_views/gcc/tables/table_resistor_4.dart';
import 'package:gc_wizard/application/category_views/gcc/tables/table_resistor_5.dart';
import 'package:gc_wizard/application/category_views/gcc/tables/table_roman.dart';
import 'package:gc_wizard/application/category_views/selector_lists/apparent_temperature_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/astronomy_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/babylon_numbers_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/base_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/bcd_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/beaufort_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/braille_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/bundeswehr_talkingboard.dart';
import 'package:gc_wizard/application/category_views/selector_lists/ccitt_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/checkdigits/checkdigits_creditcard_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/checkdigits/checkdigits_de_taxid_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/checkdigits/checkdigits_ean_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/checkdigits/checkdigits_euro_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/checkdigits/checkdigits_iban_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/checkdigits/checkdigits_imei_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/checkdigits/checkdigits_isbn_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/checkdigits/checkdigits_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/checkdigits/checkdigits_uic_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/cistercian_numbers_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/colors_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/combinatorics_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/coords_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/countries_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/crosssum_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/cryptography_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/dates_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/dna_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/e_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/easter_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/esoteric_programminglanguages_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/games_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/general_codebreakers_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/hash_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/icecodes_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/imagesandfiles_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/keyboard_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/language_games_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/maya_calendar_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/maya_numbers_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/miscellaneous_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/morse_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/number_sequences/numbersequence_bell_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/number_sequences/numbersequence_busybeaver_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/number_sequences/numbersequence_catalan_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/number_sequences/numbersequence_factorial_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/number_sequences/numbersequence_fermat_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/number_sequences/numbersequence_fibonacci_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/number_sequences/numbersequence_happynumbers_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/number_sequences/numbersequence_jacobsthal_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/number_sequences/numbersequence_jacobsthallucas_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/number_sequences/numbersequence_jacobsthaloblong_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/number_sequences/numbersequence_lucas_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/number_sequences/numbersequence_luckynumbers_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/number_sequences/numbersequence_lychrel_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/number_sequences/numbersequence_mersenne_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/number_sequences/numbersequence_mersenneexponents_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/number_sequences/numbersequence_mersennefermat_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/number_sequences/numbersequence_mersenneprimes_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/number_sequences/numbersequence_pell_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/number_sequences/numbersequence_pelllucas_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/number_sequences/numbersequence_perfectnumbers_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/number_sequences/numbersequence_permutableprimes_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/number_sequences/numbersequence_primarypseudoperfectnumbers_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/number_sequences/numbersequence_primes_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/number_sequences/numbersequence_recaman_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/number_sequences/numbersequence_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/number_sequences/numbersequence_sublimenumbers_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/number_sequences/numbersequence_superperfectnumbers_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/number_sequences/numbersequence_weirdnumbers_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/numeral_words_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/periodic_table_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/phi_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/pi_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/predator_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/primes_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/resistor_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/roman_numbers_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/rotation_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/rsa_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/scienceandtechnology_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/scrabble_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/segmentdisplay_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/shadoks_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/silverratio_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/slash_and_pipe_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/spelling_alphabets_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/sqrt2_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/sqrt3_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/sqrt5_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/symbol_table_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/telegraph_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/teletypewriter_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/tomtom_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/uic_wagoncode_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/vanity_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/vigenere_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/wherigo_urwigo_selection.dart';
import 'package:gc_wizard/application/category_views/selector_lists/zodiac_selection.dart';
import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/application/main_menu/about.dart';
import 'package:gc_wizard/application/main_menu/call_for_contribution.dart';
import 'package:gc_wizard/application/main_menu/changelog.dart';
import 'package:gc_wizard/application/main_menu/licenses.dart';
import 'package:gc_wizard/application/main_menu/nightly.dart';
import 'package:gc_wizard/application/searchstrings/logic/search_strings.dart';
import 'package:gc_wizard/application/settings/widget/settings_coordinates.dart';
import 'package:gc_wizard/application/settings/widget/settings_general.dart';
import 'package:gc_wizard/application/settings/widget/settings_saverestore.dart';
import 'package:gc_wizard/application/settings/widget/settings_tools.dart';
import 'package:gc_wizard/application/tools/widget/gcw_tool.dart';
import 'package:gc_wizard/application/tools/widget/tool_licenses.dart';
import 'package:gc_wizard/tools/coords/antipodes/widget/antipodes.dart';
import 'package:gc_wizard/tools/coords/centerpoint/center_three_points/widget/center_three_points.dart';
import 'package:gc_wizard/tools/coords/centerpoint/center_two_points/widget/center_two_points.dart';
import 'package:gc_wizard/tools/coords/centroid/centroid_arithmetic_mean/widget/centroid_arithmetic_mean.dart';
import 'package:gc_wizard/tools/coords/centroid/centroid_center_of_gravity/widget/centroid_center_of_gravity.dart';
import 'package:gc_wizard/tools/coords/coordinate_averaging/widget/coordinate_averaging.dart';
import 'package:gc_wizard/tools/coords/cross_bearing/widget/cross_bearing.dart';
import 'package:gc_wizard/tools/coords/distance_and_bearing/widget/distancebearing_geodetic.dart';
import 'package:gc_wizard/tools/coords/dmm_offset/widget/dmm_offset.dart';
import 'package:gc_wizard/tools/coords/ellipsoid_transform/widget/ellipsoid_transform.dart';
import 'package:gc_wizard/tools/coords/equilateral_triangle/widget/equilateral_triangle.dart';
import 'package:gc_wizard/tools/coords/format_converter/widget/format_converter.dart';
import 'package:gc_wizard/tools/coords/geohashing/widget/geohashing.dart';
import 'package:gc_wizard/tools/coords/intersect_bearing_and_circle/widget/intersect_bearing_and_circle.dart';
import 'package:gc_wizard/tools/coords/intersect_lines/intersect_bearings/widget/intersect_bearings.dart';
import 'package:gc_wizard/tools/coords/intersect_lines/intersect_four_points/widget/intersect_four_points.dart';
import 'package:gc_wizard/tools/coords/intersect_three_circles/widget/intersect_three_circles.dart';
import 'package:gc_wizard/tools/coords/intersect_two_circles/widget/intersect_two_circles.dart';
import 'package:gc_wizard/tools/coords/intersection/widget/intersection.dart';
import 'package:gc_wizard/tools/coords/map_view/widget/map_view.dart';
import 'package:gc_wizard/tools/coords/resection/widget/resection.dart';
import 'package:gc_wizard/tools/coords/rhumb_line/widget/rhumbline_distancebearing.dart';
import 'package:gc_wizard/tools/coords/rhumb_line/widget/rhumbline_waypoint_projection.dart';
import 'package:gc_wizard/tools/coords/segment_bearings/widget/segment_bearings.dart';
import 'package:gc_wizard/tools/coords/segment_line/widget/segment_line.dart';
import 'package:gc_wizard/tools/coords/variable_coordinate/widget/variable_coordinate_formulas.dart';
import 'package:gc_wizard/tools/coords/what3words/widget/w3w.dart';
import 'package:gc_wizard/tools/coords/waypoint_projection/widget/waypoint_projection_geodetic.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/abaddon/widget/abaddon.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/adfgvx/widget/adfgvx.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/affine/widget/affine.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/alphabet_values/widget/alphabet_values.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/amsco/widget/amsco.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/atbash/widget/atbash.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/avemaria/widget/avemaria.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/babylon_numbers/widget/babylon_numbers.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/bacon/widget/bacon.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/base/base122/widget/base122.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/base/base16/widget/base16.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/base/base32/widget/base32.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/base/base58/widget/base58.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/base/base64/widget/base64.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/base/base85/widget/base85.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/base/base91/widget/base91.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/battleship/widget/battleship.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/bcd/bcd1of10/widget/bcd1of10.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/bcd/bcd20f5postnet/widget/bcd20f5postnet.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/bcd/bcd2of5/widget/bcd2of5.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/bcd/bcd2of5planet/widget/bcd2of5planet.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/bcd/bcdaiken/widget/bcdaiken.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/bcd/bcdbiquinary/widget/bcdbiquinary.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/bcd/bcdglixon/widget/bcdglixon.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/bcd/bcdgray/widget/bcdgray.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/bcd/bcdgrayexcess/widget/bcdgrayexcess.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/bcd/bcdhamming/widget/bcdhamming.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/bcd/bcdlibawcraig/widget/bcdlibawcraig.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/bcd/bcdobrien/widget/bcdobrien.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/bcd/bcdoriginal/widget/bcdoriginal.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/bcd/bcdpetherick/widget/bcdpetherick.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/bcd/bcdstibitz/widget/bcdstibitz.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/bcd/bcdtompkins/widget/bcdtompkins.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/beghilos/widget/beghilos.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/bifid/widget/bifid.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/book_cipher/widget/book_cipher.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/braille/braille/widget/braille.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/braille/braille_dot_numbers/widget/braille_dot_numbers.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/bundeswehr_talkingboard/bundeswehr_auth/widget/bundeswehr_auth.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/bundeswehr_talkingboard/bundeswehr_code/widget/bundeswehr_code.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/burrows_wheeler/widget/burrows_wheeler.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/caesar/widget/caesar.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/chao/widget/chao.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/charsets/ascii_values/widget/ascii_values.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/cipher_wheel/widget/cipher_wheel.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/cistercian_numbers/widget/cistercian_numbers.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/enclosed_areas/widget/enclosed_areas.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/enigma/widget/enigma.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/esoteric_programming_languages/beatnik_language/widget/beatnik_language.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/esoteric_programming_languages/befunge/widget/befunge.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/esoteric_programming_languages/brainfk/widget/brainfk.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/esoteric_programming_languages/chef_language/widget/chef_language.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/esoteric_programming_languages/cow/widget/cow.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/esoteric_programming_languages/deadfish/widget/deadfish.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/esoteric_programming_languages/hohoho/widget/hohoho.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/esoteric_programming_languages/karol_robot/widget/karol_robot.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/esoteric_programming_languages/malbolge/widget/malbolge.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/esoteric_programming_languages/ook/widget/ook.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/esoteric_programming_languages/piet/widget/piet.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/esoteric_programming_languages/whitespace_language/widget/whitespace_language.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/fox/widget/fox.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/gade/widget/gade.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/gc_code/widget/gc_code.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/multi_decoder/widget/multi_decoder.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/substitution_breaker/widget/substitution_breaker.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/vigenere_breaker/widget/vigenere_breaker.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/gray/widget/gray.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/gronsfeld/widget/gronsfeld.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/hashes/hash_breaker/widget/hash_breaker.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/hashes/hashes/widget/hashes.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/hashes/hashes_identification/widget/hashes_identification.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/hashes/hashes_overview/widget/hashes_overview.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/homophone/widget/homophone.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/houdini/widget/houdini.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/judoon/widget/judoon.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/kamasutra/widget/kamasutra.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/kenny/widget/kenny.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/language_games/chicken_language/widget/chicken_language.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/language_games/duck_speak/widget/duck_speak.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/language_games/pig_latin/widget/pig_latin.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/language_games/robber_language/widget/robber_language.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/language_games/spoon_language/widget/spoon_language.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/leetspeak/widget/leetspeak.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/maya_numbers/widget/maya_numbers.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/mexican_army_cipher_wheel/widget/mexican_army_cipher_wheel.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/morbit/widget/morbit.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/morse/widget/morse.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/navajo/widget/navajo.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/numeral_words/numeral_words_converter/widget/numeral_words_converter.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/numeral_words/numeral_words_identify_languages/widget/numeral_words_identify_languages.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/numeral_words/numeral_words_lists/widget/numeral_words_lists.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/numeral_words/numeral_words_text_search/widget/numeral_words_text_search.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/one_time_pad/widget/one_time_pad.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/playfair/widget/playfair.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/pokemon/widget/pokemon.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/pollux/widget/pollux.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/polybios/widget/polybios.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/predator/widget/predator.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/prime_alphabet/widget/prime_alphabet.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/rabbit/widget/rabbit.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/ragbaby/widget/ragbaby.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/rail_fence/widget/rail_fence.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/rc4/widget/rc4.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/reverse/widget/reverse.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/roman_numbers/chronogram/widget/chronogram.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/roman_numbers/roman_numbers/widget/roman_numbers.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/rotation/rot123/widget/rot123.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/rotation/rot13/widget/rot13.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/rotation/rot18/widget/rot18.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/rotation/rot47/widget/rot47.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/rotation/rot5/widget/rot5.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/rotation/rotation_general/widget/rotation_general.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/rotation/rotation_weird/widget/rotation_weird.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/rsa/rsa/widget/rsa.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/rsa/rsa_d_calculator/widget/rsa_d_calculator.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/rsa/rsa_d_checker/widget/rsa_d_checker.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/rsa/rsa_e_checker/widget/rsa_e_checker.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/rsa/rsa_n_calculator/widget/rsa_n_calculator.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/rsa/rsa_phi_calculator/widget/rsa_phi_calculator.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/rsa/rsa_primes_calculator/widget/rsa_primes_calculator.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/shadoks_numbers/widget/shadoks_numbers.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/skytale/widget/skytale.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/slash_and_pipe/widget/slash_and_pipe.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/solitaire/widget/solitaire.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/straddling_checkerboard/widget/straddling_checkerboard.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/substitution/widget/substitution.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/tap_code/widget/tap_code.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/tapir/widget/tapir.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/text_analysis/widget/text_analysis.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/tomtom/widget/tomtom.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/trifid/widget/trifid.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/trithemius/widget/trithemius.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/universal_product_code/widget/universal_product_code.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/vigenere/widget/vigenere.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/wasd/widget/wasd.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/zamonian_numbers/widget/zamonian_numbers.dart';
import 'package:gc_wizard/tools/formula_solver/widget/formula_solver_formulagroups.dart';
import 'package:gc_wizard/tools/games/bowling/widget/bowling.dart';
import 'package:gc_wizard/tools/games/catan/widget/catan.dart';
import 'package:gc_wizard/tools/games/game_of_life/widget/game_of_life.dart';
import 'package:gc_wizard/tools/games/logical_solver/widget/logical_solver.dart';
import 'package:gc_wizard/tools/games/nonogram/widget/nonogram_solver.dart';
import 'package:gc_wizard/tools/games/number_pyramid/widget/number_pyramid_solver.dart';
import 'package:gc_wizard/tools/games/scrabble/scrabble/widget/scrabble.dart';
import 'package:gc_wizard/tools/games/scrabble/scrabble_overview/widget/scrabble_overview.dart';
import 'package:gc_wizard/tools/games/sudoku/sudoku_solver/widget/sudoku_solver.dart';
import 'package:gc_wizard/tools/games/word_search/widget/word_search.dart';
import 'package:gc_wizard/tools/general_tools/grid_generator/grid/widget/grid.dart';
import 'package:gc_wizard/tools/images_and_files/animated_image/widget/animated_image.dart';
import 'package:gc_wizard/tools/images_and_files/animated_image_morse_code/widget/animated_image_morse_code.dart';
import 'package:gc_wizard/tools/images_and_files/binary2image/widget/binary2image.dart';
import 'package:gc_wizard/tools/images_and_files/exif_reader/widget/exif_reader.dart';
import 'package:gc_wizard/tools/images_and_files/hex_viewer/widget/hex_viewer.dart';
import 'package:gc_wizard/tools/images_and_files/hexstring2file/widget/hexstring2file.dart';
import 'package:gc_wizard/tools/images_and_files/hidden_data/widget/hidden_data.dart';
import 'package:gc_wizard/tools/images_and_files/image_colorcorrections/widget/image_colorcorrections.dart';
import 'package:gc_wizard/tools/images_and_files/image_flip_rotate/widget/image_flip_rotate.dart';
import 'package:gc_wizard/tools/images_and_files/image_stretch_shrink/widget/image_stretch_shrink.dart';
import 'package:gc_wizard/tools/images_and_files/magic_eye_solver/widget/magic_eye_solver.dart';
import 'package:gc_wizard/tools/images_and_files/qr_code/widget/qr_code.dart';
import 'package:gc_wizard/tools/images_and_files/stegano/widget/stegano.dart';
import 'package:gc_wizard/tools/images_and_files/visual_cryptography/widget/visual_cryptography.dart';
import 'package:gc_wizard/tools/miscellaneous/openai/widget/openai.dart';
import 'package:gc_wizard/tools/miscellaneous/gcwizardscript/widget/gcwizard_script.dart';
import 'package:gc_wizard/tools/science_and_technology/alcohol_mass/widget/alcohol_mass.dart';
import 'package:gc_wizard/tools/science_and_technology/alphabet_number_systems/hebrew/widget/hebrew_number_system.dart';
import 'package:gc_wizard/tools/science_and_technology/alphabet_number_systems/milesian/widget/milesian_number_system.dart';
import 'package:gc_wizard/tools/science_and_technology/apparent_temperature/heat_index/widget/heat_index.dart';
import 'package:gc_wizard/tools/science_and_technology/apparent_temperature/humidex/widget/humidex.dart';
import 'package:gc_wizard/tools/science_and_technology/apparent_temperature/summer_simmer/widget/summer_simmer.dart';
import 'package:gc_wizard/tools/science_and_technology/apparent_temperature/wet_bulb_temperature/widget/wet_bulb_temperature.dart';
import 'package:gc_wizard/tools/science_and_technology/apparent_temperature/windchill/widget/windchill.dart';
import 'package:gc_wizard/tools/science_and_technology/astronomy/easter/easter_date/widget/easter_date.dart';
import 'package:gc_wizard/tools/science_and_technology/astronomy/easter/easter_years/widget/easter_years.dart';
import 'package:gc_wizard/tools/science_and_technology/astronomy/iau_constellation/widget/iau_all_constellations.dart';
import 'package:gc_wizard/tools/science_and_technology/astronomy/iau_constellation/widget/iau_single_constellations.dart';
import 'package:gc_wizard/tools/science_and_technology/astronomy/moon_position/widget/moon_position.dart';
import 'package:gc_wizard/tools/science_and_technology/astronomy/moon_rise_set/widget/moon_rise_set.dart';
import 'package:gc_wizard/tools/science_and_technology/astronomy/right_ascension_to_degree/widget/right_ascension_to_degree.dart';
import 'package:gc_wizard/tools/science_and_technology/astronomy/seasons/widget/seasons.dart';
import 'package:gc_wizard/tools/science_and_technology/astronomy/shadow_length/widget/shadow_length.dart';
import 'package:gc_wizard/tools/science_and_technology/astronomy/sun_position/widget/sun_position.dart';
import 'package:gc_wizard/tools/science_and_technology/astronomy/sun_rise_set/widget/sun_rise_set.dart';
import 'package:gc_wizard/tools/science_and_technology/ballistics/widget/ballistics.dart';
import 'package:gc_wizard/tools/science_and_technology/beaufort/widget/beaufort.dart';
import 'package:gc_wizard/tools/science_and_technology/binary/widget/binary.dart';
import 'package:gc_wizard/tools/science_and_technology/blood_alcohol_content/widget/blood_alcohol_content.dart';
import 'package:gc_wizard/tools/science_and_technology/checkdigits/widget/checkdigits_creditcard.dart';
import 'package:gc_wizard/tools/science_and_technology/checkdigits/widget/checkdigits_de_taxid.dart';
import 'package:gc_wizard/tools/science_and_technology/checkdigits/widget/checkdigits_ean.dart';
import 'package:gc_wizard/tools/science_and_technology/checkdigits/widget/checkdigits_euro.dart';
import 'package:gc_wizard/tools/science_and_technology/checkdigits/widget/checkdigits_iban.dart';
import 'package:gc_wizard/tools/science_and_technology/checkdigits/widget/checkdigits_imei.dart';
import 'package:gc_wizard/tools/science_and_technology/checkdigits/widget/checkdigits_isbn.dart';
import 'package:gc_wizard/tools/science_and_technology/checkdigits/widget/checkdigits_uic.dart';
import 'package:gc_wizard/tools/science_and_technology/colors/color_tool/widget/color_tool.dart';
import 'package:gc_wizard/tools/science_and_technology/colors/pantone_color_codes/widget/pantone_color_codes.dart';
import 'package:gc_wizard/tools/science_and_technology/colors/ral_color_codes/widget/ral_color_codes.dart';
import 'package:gc_wizard/tools/science_and_technology/combinatorics/combination/widget/combination.dart';
import 'package:gc_wizard/tools/science_and_technology/combinatorics/combination_permutation/widget/combination_permutation.dart';
import 'package:gc_wizard/tools/science_and_technology/combinatorics/permutation/widget/permutation.dart';
import 'package:gc_wizard/tools/science_and_technology/complex_numbers/widget/complex_numbers.dart';
import 'package:gc_wizard/tools/science_and_technology/compound_interest/widget/compound_interest.dart';
import 'package:gc_wizard/tools/science_and_technology/countries/countries_calling_codes/widget/countries_calling_codes.dart';
import 'package:gc_wizard/tools/science_and_technology/countries/countries_embassycodes_ger/widget/countries_embassycodes_ger.dart';
import 'package:gc_wizard/tools/science_and_technology/countries/countries_ioc_codes/widget/countries_ioc_codes.dart';
import 'package:gc_wizard/tools/science_and_technology/countries/countries_iso_codes/widget/countries_iso_codes.dart';
import 'package:gc_wizard/tools/science_and_technology/countries/countries_vehicle_codes/widget/countries_vehicle_codes.dart';
import 'package:gc_wizard/tools/science_and_technology/countries/country_flags/widget/country_flags.dart';
import 'package:gc_wizard/tools/science_and_technology/cross_sums/cross_sum/widget/cross_sum.dart';
import 'package:gc_wizard/tools/science_and_technology/cross_sums/cross_sum_range/widget/cross_sum_range.dart';
import 'package:gc_wizard/tools/science_and_technology/cross_sums/cross_sum_range_frequency/widget/cross_sum_range_frequency.dart';
import 'package:gc_wizard/tools/science_and_technology/cross_sums/iterated_cross_sum_range/widget/iterated_cross_sum_range.dart';
import 'package:gc_wizard/tools/science_and_technology/cross_sums/iterated_cross_sum_range_frequency/widget/iterated_cross_sum_range_frequency.dart';
import 'package:gc_wizard/tools/science_and_technology/date_and_time/calendar/widget/calendar.dart';
import 'package:gc_wizard/tools/science_and_technology/date_and_time/calendar_week/widget/calendar_week.dart';
import 'package:gc_wizard/tools/science_and_technology/date_and_time/day_calculator/widget/day_calculator.dart';
import 'package:gc_wizard/tools/science_and_technology/date_and_time/day_of_the_year/widget/day_of_the_year.dart';
import 'package:gc_wizard/tools/science_and_technology/date_and_time/excel_time/widget/excel_time.dart';
import 'package:gc_wizard/tools/science_and_technology/date_and_time/time_calculator/widget/time_calculator.dart';
import 'package:gc_wizard/tools/science_and_technology/date_and_time/unix_time/widget/unix_time.dart';
import 'package:gc_wizard/tools/science_and_technology/date_and_time/weekday/widget/weekday.dart';
import 'package:gc_wizard/tools/science_and_technology/decabit/widget/decabit.dart';
import 'package:gc_wizard/tools/science_and_technology/divisor/widget/divisor.dart';
import 'package:gc_wizard/tools/science_and_technology/dna/dna_aminoacids/widget/dna_aminoacids.dart';
import 'package:gc_wizard/tools/science_and_technology/dna/dna_aminoacids_table/widget/dna_aminoacids_table.dart';
import 'package:gc_wizard/tools/science_and_technology/dna/dna_nucleicacidsequence/widget/dna_nucleicacidsequence.dart';
import 'package:gc_wizard/tools/science_and_technology/dtmf/widget/dtmf.dart';
import 'package:gc_wizard/tools/science_and_technology/gcd/widget/gcd.dart';
import 'package:gc_wizard/tools/science_and_technology/guitar_strings/widget/guitar_strings.dart';
import 'package:gc_wizard/tools/science_and_technology/hexadecimal/widget/hexadecimal.dart';
import 'package:gc_wizard/tools/science_and_technology/iata_icao_search/widget/iata_icao_search.dart';
import 'package:gc_wizard/tools/science_and_technology/icecodes/widget/icecodes.dart';
import 'package:gc_wizard/tools/science_and_technology/ieee754/widget/ieee754.dart';
import 'package:gc_wizard/tools/science_and_technology/ip_codes/widget/ip_codes.dart';
import 'package:gc_wizard/tools/science_and_technology/irrational_numbers/e/widget/e.dart';
import 'package:gc_wizard/tools/science_and_technology/irrational_numbers/phi/widget/phi.dart';
import 'package:gc_wizard/tools/science_and_technology/irrational_numbers/pi/widget/pi.dart';
import 'package:gc_wizard/tools/science_and_technology/irrational_numbers/silver_ratio/widget/silver_ratio.dart';
import 'package:gc_wizard/tools/science_and_technology/irrational_numbers/sqrt2/widget/sqrt2.dart';
import 'package:gc_wizard/tools/science_and_technology/irrational_numbers/sqrt3/widget/sqrt3.dart';
import 'package:gc_wizard/tools/science_and_technology/irrational_numbers/sqrt5/widget/sqrt5.dart';
import 'package:gc_wizard/tools/science_and_technology/keyboard/keyboard_layout/widget/keyboard_layout.dart';
import 'package:gc_wizard/tools/science_and_technology/keyboard/keyboard_numbers/widget/keyboard_numbers.dart';
import 'package:gc_wizard/tools/science_and_technology/lcm/widget/lcm.dart';
import 'package:gc_wizard/tools/science_and_technology/mathematical_constants/widget/mathematical_constants.dart';
import 'package:gc_wizard/tools/science_and_technology/maya_calendar/widget/maya_calendar.dart';
import 'package:gc_wizard/tools/science_and_technology/music_notes/music_notes/widget/music_notes.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/bell/widget/bell.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/busybeaver/widget/busybeaver.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/catalan/widget/catalan.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/factorial/widget/factorial.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/fermat/widget/fermat.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/fibonacci/widget/fibonacci.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/happy_numbers/widget/happy_numbers.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/jacobsthal/widget/jacobsthal.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/jacobsthal_lucas/widget/jacobsthal_lucas.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/jacobsthal_oblong/widget/jacobsthal_oblong.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/lucas/widget/lucas.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/lucky_numbers/widget/lucky_numbers.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/lychrel/widget/lychrel.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/mersenne/widget/mersenne.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/mersenne_exponents/widget/mersenne_exponents.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/mersenne_primes/widget/mersenne_primes.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/mersennefermat/widget/mersennefermat.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/pell/widget/pell.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/pell_lucas/widget/pell_lucas.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/perfect_numbers/widget/perfect_numbers.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/permutable_primes/widget/permutable_primes.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/primarypseudoperfect_numbers/widget/primarypseudoperfect_numbers.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/primes/widget/primes.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/recaman/widget/recaman.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/sublime_numbers/widget/sublime_numbers.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/superperfect_numbers/widget/superperfect_numbers.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/weird_numbers/widget/weird_numbers.dart';
import 'package:gc_wizard/tools/science_and_technology/numeral_bases/widget/numeral_bases.dart';
import 'package:gc_wizard/tools/science_and_technology/paperformat/widget/paperformat.dart';
import 'package:gc_wizard/tools/science_and_technology/periodic_table/atomic_numbers_to_text/widget/atomic_numbers_to_text.dart';
import 'package:gc_wizard/tools/science_and_technology/periodic_table/periodic_table/widget/periodic_table.dart';
import 'package:gc_wizard/tools/science_and_technology/periodic_table/periodic_table_data_view/widget/periodic_table_data_view.dart';
import 'package:gc_wizard/tools/science_and_technology/physical_constants/widget/physical_constants.dart';
import 'package:gc_wizard/tools/science_and_technology/piano/widget/piano.dart';
import 'package:gc_wizard/tools/science_and_technology/primes/primes_integerfactorization/widget/primes_integerfactorization.dart';
import 'package:gc_wizard/tools/science_and_technology/primes/primes_isprime/widget/primes_isprime.dart';
import 'package:gc_wizard/tools/science_and_technology/primes/primes_nearestprime/widget/primes_nearestprime.dart';
import 'package:gc_wizard/tools/science_and_technology/primes/primes_nthprime/widget/primes_nthprime.dart';
import 'package:gc_wizard/tools/science_and_technology/primes/primes_primeindex/widget/primes_primeindex.dart';
import 'package:gc_wizard/tools/science_and_technology/projectiles/widget/projectiles.dart';
import 'package:gc_wizard/tools/science_and_technology/quadratic_equation/widget/quadratic_equation.dart';
import 'package:gc_wizard/tools/science_and_technology/recycling/widget/recycling.dart';
import 'package:gc_wizard/tools/science_and_technology/resistor/resistor_colorcodecalculator/widget/resistor_colorcodecalculator.dart';
import 'package:gc_wizard/tools/science_and_technology/resistor/resistor_eia96/widget/resistor_eia96.dart';
import 'package:gc_wizard/tools/science_and_technology/segment_display/14_segment_display/widget/fourteen_segments.dart';
import 'package:gc_wizard/tools/science_and_technology/segment_display/16_segment_display/widget/sixteen_segments.dart';
import 'package:gc_wizard/tools/science_and_technology/segment_display/7_segment_display/widget/seven_segments.dart';
import 'package:gc_wizard/tools/science_and_technology/sort/widget/sort.dart';
import 'package:gc_wizard/tools/science_and_technology/spelling_alphabets/spelling_alphabets_crypt/widget/spelling_alphabets_crypt.dart';
import 'package:gc_wizard/tools/science_and_technology/spelling_alphabets/spelling_alphabets_list/widget/spelling_alphabets_list.dart';
import 'package:gc_wizard/tools/science_and_technology/telegraphs/chappe/widget/chappe.dart';
import 'package:gc_wizard/tools/science_and_technology/telegraphs/edelcrantz/widget/edelcrantz.dart';
import 'package:gc_wizard/tools/science_and_technology/telegraphs/gauss_weber_telegraph/widget/gauss_weber_telegraph.dart';
import 'package:gc_wizard/tools/science_and_technology/telegraphs/murray/widget/murray.dart';
import 'package:gc_wizard/tools/science_and_technology/telegraphs/ohlsen_telegraph/widget/ohlsen_telegraph.dart';
import 'package:gc_wizard/tools/science_and_technology/telegraphs/pasley_telegraph/widget/pasley_telegraph.dart';
import 'package:gc_wizard/tools/science_and_technology/telegraphs/popham_telegraph/widget/popham_telegraph.dart';
import 'package:gc_wizard/tools/science_and_technology/telegraphs/prussia_telegraph/widget/prussia_telegraph.dart';
import 'package:gc_wizard/tools/science_and_technology/telegraphs/schilling_canstatt_telegraph/widget/schilling_canstatt_telegraph.dart';
import 'package:gc_wizard/tools/science_and_technology/telegraphs/semaphore/widget/semaphore.dart';
import 'package:gc_wizard/tools/science_and_technology/telegraphs/steinheil/widget/steinheil.dart';
import 'package:gc_wizard/tools/science_and_technology/telegraphs/wheatstone_cooke_5_needles/widget/wheatstone_cooke_5_needles.dart';
import 'package:gc_wizard/tools/science_and_technology/telegraphs/wigwag/widget/wigwag.dart';
import 'package:gc_wizard/tools/science_and_technology/teletypewriter/algol/widget/algol.dart';
import 'package:gc_wizard/tools/science_and_technology/teletypewriter/ancient_teletypewriter/widget/ancient_teletypewriter.dart';
import 'package:gc_wizard/tools/science_and_technology/teletypewriter/ccitt1/widget/ccitt1.dart';
import 'package:gc_wizard/tools/science_and_technology/teletypewriter/ccitt2/widget/ccitt2.dart';
import 'package:gc_wizard/tools/science_and_technology/teletypewriter/ccitt3/widget/ccitt3.dart';
import 'package:gc_wizard/tools/science_and_technology/teletypewriter/ccitt4/widget/ccitt4.dart';
import 'package:gc_wizard/tools/science_and_technology/teletypewriter/ccitt5/widget/ccitt5.dart';
import 'package:gc_wizard/tools/science_and_technology/teletypewriter/ccitt_ccir476/widget/ccitt_ccir476.dart';
import 'package:gc_wizard/tools/science_and_technology/teletypewriter/ccitt_teletypewriter/widget/ccitt_teletypewriter.dart';
import 'package:gc_wizard/tools/science_and_technology/teletypewriter/illiac/widget/illiac.dart';
import 'package:gc_wizard/tools/science_and_technology/teletypewriter/other_teletypewriter/widget/other_teletypewriter.dart';
import 'package:gc_wizard/tools/science_and_technology/teletypewriter/punchtape/widget/punchtape.dart';
import 'package:gc_wizard/tools/science_and_technology/teletypewriter/tts/widget/tts.dart';
import 'package:gc_wizard/tools/science_and_technology/teletypewriter/z22/widget/z22.dart';
import 'package:gc_wizard/tools/science_and_technology/teletypewriter/zc1/widget/zc1.dart';
import 'package:gc_wizard/tools/science_and_technology/triangle/widget/triangle.dart';
import 'package:gc_wizard/tools/science_and_technology/ufi/widget/ufi.dart';
import 'package:gc_wizard/tools/science_and_technology/uic_wagoncode/widget/uic_wagoncode.dart';
import 'package:gc_wizard/tools/science_and_technology/uic_wagoncode/widget/uic_wagoncode_countrycodes.dart';
import 'package:gc_wizard/tools/science_and_technology/uic_wagoncode/widget/uic_wagoncode_freight_classifications.dart';
import 'package:gc_wizard/tools/science_and_technology/uic_wagoncode/widget/uic_wagoncode_passenger_lettercodes.dart';
import 'package:gc_wizard/tools/science_and_technology/uic_wagoncode/widget/uic_wagoncode_vkm.dart';
import 'package:gc_wizard/tools/science_and_technology/unit_converter/widget/unit_converter.dart';
import 'package:gc_wizard/tools/science_and_technology/vanity/vanity_multitap/widget/vanity_multitap.dart';
import 'package:gc_wizard/tools/science_and_technology/vanity/vanity_singletap/widget/vanity_singletap.dart';
import 'package:gc_wizard/tools/science_and_technology/vanity/vanity_words_list/widget/vanity_words_list.dart';
import 'package:gc_wizard/tools/science_and_technology/vanity/vanity_words_search/widget/vanity_words_search.dart';
import 'package:gc_wizard/tools/science_and_technology/velocity_acceleration/widget/velocity_acceleration.dart';
import 'package:gc_wizard/tools/science_and_technology/weather_symbols/widget/weather_symbols.dart';
import 'package:gc_wizard/tools/symbol_tables/_common/widget/gcw_symbol_table_tool.dart';
import 'package:gc_wizard/tools/symbol_tables/symbol_replacer/widget/symbol_replacer.dart';
import 'package:gc_wizard/tools/symbol_tables/symbol_tables_examples_select/widget/symbol_tables_examples_select.dart';
import 'package:gc_wizard/tools/uncategorized/wedding_anniversaries/widget/wedding_anniversaries.dart';
import 'package:gc_wizard/tools/uncategorized/zodiac/widget/zodiac.dart';
import 'package:gc_wizard/tools/wherigo/earwigo_text_deobfuscation/widget/earwigo_text_deobfuscation.dart';
import 'package:gc_wizard/tools/wherigo/urwigo_hashbreaker/widget/urwigo_hashbreaker.dart';
import 'package:gc_wizard/tools/wherigo/urwigo_text_deobfuscation/widget/urwigo_text_deobfuscation.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/widget/wherigo_analyze.dart';

part 'package:gc_wizard/application/tools/tool_licenses/specific_tool_licenses.dart';

List<GCWTool> registeredTools = [];

void initializeRegistry(BuildContext context) {
  registeredTools = [
    //MainSelection
    GCWTool(tool: const Abaddon(), id: 'abaddon', categories: const [
      ToolCategory.CRYPTOGRAPHY
    ], searchKeys: const [
      'abaddon',
    ]),
    GCWTool(tool: const ADFGVX(), id: 'adfgvx', categories: const [
      ToolCategory.CRYPTOGRAPHY
    ], searchKeys: const [
      'adfgvx',
    ]),
    GCWTool(tool: const Affine(), id: 'affine', categories: const [
      ToolCategory.CRYPTOGRAPHY
    ], searchKeys: const [
      'affine',
    ]),
    GCWTool(tool: const AlcoholMass(), id: 'alcoholmass', categories: const [
      ToolCategory.SCIENCE_AND_TECHNOLOGY
    ], searchKeys: const [
      'alcoholmass',
    ]),
    GCWTool(tool: const ALGOL(), id: 'algol', categories: const [
      ToolCategory.SCIENCE_AND_TECHNOLOGY
    ], searchKeys: const [
      'algol',
    ]),
    GCWTool(tool: AlphabetValues(), id: 'alphabetvalues', categories: const [
      ToolCategory.CRYPTOGRAPHY
    ], searchKeys: const [
      'alphabetvalues',
    ], deeplinkAlias: const [
      'alphabet_values',
      'av',
      'buchstabenwerte',
      'bww'
    ]),
    GCWTool(tool: const Amsco(), id: 'amsco', categories: const [
      ToolCategory.CRYPTOGRAPHY
    ], searchKeys: const [
      'amsco',
    ]),
    GCWTool(
        tool: const AnimatedImage(),
        id: 'animated_image',
        isBeta: true,
        categories: const [
          ToolCategory.IMAGES_AND_FILES
        ],
        searchKeys: const [
          'animated_images',
        ]),
    GCWTool(
        tool: const AnimatedImageMorseCode(),
        id: 'animated_image_morse_code',
        isBeta: true,
        categories: const [
          ToolCategory.IMAGES_AND_FILES
        ],
        searchKeys: const [
          'animated_images_morse_code',
          'animated_images',
        ]),
    GCWTool(
        tool: const ApparentTemperatureSelection(),
        id: 'apparenttemperature_selection',
        categories: const [ToolCategory.SCIENCE_AND_TECHNOLOGY],
        searchKeys: const []),
    GCWTool(tool: const ASCIIValues(), id: 'asciivalues', categories: const [
      ToolCategory.CRYPTOGRAPHY
    ], searchKeys: const [
      'asciivalues',
      'binary',
    ]),
    GCWTool(
        tool: const AstronomySelection(),
        id: 'astronomy_selection',
        categories: const [
          ToolCategory.SCIENCE_AND_TECHNOLOGY
        ],
        searchKeys: const [
          'astronomy',
        ]),
    GCWTool(
      tool: Atbash(),
      id: 'atbash',
      categories: const [ToolCategory.CRYPTOGRAPHY],
      searchKeys: const [
        'atbash',
      ],
      deeplinkAlias: const ['atbasch'],
    ),
    GCWTool(tool: const AveMaria(), id: 'avemaria', categories: const [
      ToolCategory.CRYPTOGRAPHY
    ], searchKeys: const [
      'avemaria',
    ]),
    GCWTool(
        tool: const BabylonNumbersSelection(),
        id: 'babylonnumbers_selection',
        categories: const [ToolCategory.CRYPTOGRAPHY],
        searchKeys: const []),
    GCWTool(tool: const Bacon(), id: 'bacon', categories: const [
      ToolCategory.CRYPTOGRAPHY
    ], searchKeys: const [
      'bacon',
      'binary',
    ]),
    GCWTool(tool: const Ballistics(), id: 'ballistics', categories: const [
      ToolCategory.SCIENCE_AND_TECHNOLOGY
    ], searchKeys: const [
      'ballistics',
    ]),
    GCWTool(
        tool: const BaseSelection(),
        id: 'base_selection',
        categories: const [ToolCategory.CRYPTOGRAPHY],
        searchKeys: const []),
    GCWTool(tool: const BCDSelection(), id: 'bcd_selection', categories: const [
      ToolCategory.CRYPTOGRAPHY
    ], searchKeys: const [
      'binary',
    ]),
    GCWTool(tool: const Battleship(), id: 'battleship', categories: const [
      ToolCategory.CRYPTOGRAPHY
    ], searchKeys: const [
      'battleship',
    ]),
    GCWTool(
        tool: const BloodAlcoholContent(),
        id: 'bloodalcoholcontent',
        categories: const [
          ToolCategory.SCIENCE_AND_TECHNOLOGY
        ],
        searchKeys: const [
          'alcoholmass',
          'bloodalcoholcontent',
        ]),
    GCWTool(
        tool: const BrailleSelection(),
        id: 'braille_selection',
        categories: const [ToolCategory.CRYPTOGRAPHY],
        searchKeys: const []),
    GCWTool(
        tool: const BeaufortSelection(),
        id: 'beaufort_selection',
        categories: const [ToolCategory.SCIENCE_AND_TECHNOLOGY],
        searchKeys: const []),
    GCWTool(tool: const Beghilos(), id: 'beghilos', categories: const [
      ToolCategory.CRYPTOGRAPHY
    ], searchKeys: const [
      'beghilos',
      'segments',
      'segements_seven',
    ]),
    GCWTool(tool: const Bifid(), id: 'bifid', categories: const [
      ToolCategory.CRYPTOGRAPHY
    ], searchKeys: const [
      'bifid',
    ]),
    GCWTool(tool: const Binary(), id: 'binary', categories: const [
      ToolCategory.SCIENCE_AND_TECHNOLOGY
    ], searchKeys: const [
      'binary',
    ]),
    GCWTool(tool: const Binary2Image(), id: 'binary2image', categories: const [
      ToolCategory.IMAGES_AND_FILES
    ], searchKeys: const [
      'binary',
      'barcodes',
      'images',
    ]),
    GCWTool(tool: const BookCipher(), id: 'book_cipher', categories: const [
      ToolCategory.CRYPTOGRAPHY
    ], searchKeys: const [
      'bookcipher',
    ]),
    GCWTool(tool: const Bowling(), id: 'bowling', categories: const [
      ToolCategory.GAMES
    ], searchKeys: const [
      'bowling',
    ]),
    GCWTool(
        tool: const BundeswehrTalkingBoardSelection(),
        id: 'bundeswehr_talkingboard_selection',
        categories: const [ToolCategory.CRYPTOGRAPHY],
        searchKeys: const []),
    GCWTool(
        tool: const BurrowsWheeler(),
        id: 'burrowswheeler',
        categories: const [
          ToolCategory.CRYPTOGRAPHY
        ],
        searchKeys: const [
          'burroeswheeler',
        ]),
    GCWTool(tool: Caesar(), id: 'caesar', categories: const [
      ToolCategory.CRYPTOGRAPHY
    ], searchKeys: const [
      'rotation',
      'caesar',
    ]),
    GCWTool(tool: const Catan(), id: 'catan', categories: const [
      ToolCategory.GAMES
    ], searchKeys: const [
      'catan',
    ]),
    GCWTool(
        tool: const CCITTSelection(),
        id: 'ccitt_selection',
        categories: const [ToolCategory.CRYPTOGRAPHY],
        searchKeys: const []),
    GCWTool(tool: const Chao(), id: 'chao', categories: const [
      ToolCategory.CRYPTOGRAPHY
    ], searchKeys: const [
      'chao',
    ]),
    GCWTool(tool: const CipherWheel(), id: 'cipherwheel', categories: const [
      ToolCategory.CRYPTOGRAPHY
    ], searchKeys: const [
      'cipherwheel',
    ]),
    GCWTool(
        tool: const CheckDigitsSelection(),
        id: 'checkdigits_selection',
        categories: const [ToolCategory.SCIENCE_AND_TECHNOLOGY],
        searchKeys: const []),
    GCWTool(
        tool: const CistercianNumbersSelection(),
        id: 'cistercian_selection',
        categories: const [ToolCategory.CRYPTOGRAPHY],
        searchKeys: const []),
    GCWTool(
        tool: const ColorsSelection(),
        id: 'colors_selection',
        categories: const [ToolCategory.SCIENCE_AND_TECHNOLOGY],
        searchKeys: const []),
    GCWTool(
        tool: const CombinatoricsSelection(),
        id: 'combinatorics_selection',
        categories: const [ToolCategory.SCIENCE_AND_TECHNOLOGY],
        searchKeys: const []),
    GCWTool(
        tool: const ComplexNumbers(),
        id: 'complex_numbers',
        categories: const [
          ToolCategory.SCIENCE_AND_TECHNOLOGY
        ],
        searchKeys: const [
          'complexnumbers',
        ]),
    GCWTool(
        tool: const CompoundInterest(),
        id: 'compoundinterest',
        categories: const [
          ToolCategory.SCIENCE_AND_TECHNOLOGY
        ],
        searchKeys: const [
          'compoundinterest',
        ]),
    GCWTool(
        tool: const CoordsSelection(),
        id: 'coords_selection',
        searchKeys: const [
          'coordinates',
        ]),
    GCWTool(
        tool: const CountriesSelection(),
        id: 'countries_selection',
        categories: const [ToolCategory.SCIENCE_AND_TECHNOLOGY],
        searchKeys: const []),
    GCWTool(
        tool: const CrossSumSelection(),
        id: 'crosssum_selection',
        categories: const [ToolCategory.SCIENCE_AND_TECHNOLOGY],
        searchKeys: const []),
    GCWTool(
        tool: const CryptographySelection(),
        id: 'cryptography_selection',
        searchKeys: const [
          'cryptographyselection',
        ]),
    GCWTool(
        tool: const DatesSelection(),
        id: 'dates_selection',
        categories: const [
          ToolCategory.SCIENCE_AND_TECHNOLOGY
        ],
        searchKeys: const [
          'dates',
        ]),
    GCWTool(tool: const Decabit(), id: 'decabit', categories: const [
      ToolCategory.SCIENCE_AND_TECHNOLOGY
    ], searchKeys: const [
      'decabit',
    ]),
    GCWTool(tool: const Divisor(), id: 'divisor', categories: const [
      ToolCategory.SCIENCE_AND_TECHNOLOGY
    ], searchKeys: const [
      'divisor',
    ]),
    GCWTool(
        tool: const DNASelection(),
        id: 'dna_selection',
        categories: const [ToolCategory.SCIENCE_AND_TECHNOLOGY],
        searchKeys: const []),
    GCWTool(tool: const DTMF(), id: 'dtmf', categories: const [
      ToolCategory.SCIENCE_AND_TECHNOLOGY
    ], searchKeys: const [
      'dtmf',
    ]),
    GCWTool(
        tool: const EnclosedAreas(),
        id: 'enclosedareas',
        categories: const [
          ToolCategory.CRYPTOGRAPHY
        ],
        searchKeys: const [
          'enclosedareas',
        ]),
    GCWTool(tool: const ESelection(), id: 'e_selection', categories: const [
      ToolCategory.SCIENCE_AND_TECHNOLOGY
    ], searchKeys: const [
      'e',
      'irrationalnumbers',
    ]),
    GCWTool(tool: const Enigma(), id: 'enigma', categories: const [
      ToolCategory.CRYPTOGRAPHY
    ], searchKeys: const [
      'enigma',
    ], licenses: [
      ToolLicense(
          credit: 'en.wikipedia.org',
          licenseType: 'CC BY-SA 4.0',
          url:
              'https://en.wikipedia.org/w/index.php?title=Enigma_machine&oldid=1226502398'),
      ToolLicense(
          credit: 'de.wikipedia.org',
          licenseType: 'CC BY-SA 4.0',
          url:
              'https://de.wikipedia.org/w/index.php?title=Enigma_(Maschine)&oldid=245365474'),
      ToolLicense(
          credit:
              'Dominik Oepen, Sebastian Höfer\n(Humboldt Universität zu Berlin)',
          licenseType: 'Article: Die Enigma',
          url:
              'https://web.archive.org/web/20240613212151/https://www2.informatik.hu-berlin.de/~oependox/files/Ausarbeitung-Enigma.pdf'),
    ]),
    GCWTool(
        tool: const EsotericProgrammingLanguageSelection(),
        id: 'esotericprogramminglanguages_selection',
        categories: const [
          ToolCategory.CRYPTOGRAPHY
        ],
        searchKeys: const [
          'esotericprogramminglanguage',
        ]),
    GCWTool(tool: const ExifReader(), id: 'exif', categories: const [
      ToolCategory.IMAGES_AND_FILES
    ], searchKeys: const [
      'exif',
    ]),
    GCWTool(
      tool: const FormulaSolverFormulaGroups(),
      id: 'formulasolver',
      searchKeys: const [
        'formulasolver',
      ],
    ),
    GCWTool(tool: const Fox(), id: 'fox', categories: const [
      ToolCategory.CRYPTOGRAPHY
    ], searchKeys: const [
      'fox',
    ]),
    GCWTool(tool: const Gade(), id: 'gade', categories: const [
      ToolCategory.CRYPTOGRAPHY
    ], searchKeys: const [
      'gade',
    ]),
    GCWTool(
      tool: const GamesSelection(),
      id: 'games_selection',
      searchKeys: const [
        'games',
      ],
    ),
    GCWTool(tool: const GameOfLife(), id: 'gameoflife', categories: const [
      ToolCategory.GAMES
    ], searchKeys: const [
      'gameoflife',
    ], licenses: [
      ToolLicense(
          credit: 'de.wikipedia.org',
          licenseType: 'CC BY-SA 4.0',
          url:
              'https://de.wikipedia.org/w/index.php?title=Conways_Spiel_des_Lebens&oldid=246560171')
    ]),

    //GCC Selection **************************************************************************************
    GCWTool(
        tool: const GCCTableSelection(),
        id: 'gcc_tables',
        searchKeys: const []),
    GCWTool(
        tool: const GCCTableASCIISet(),
        id: 'gcc_tables_ascii',
        searchKeys: const []),
    GCWTool(
        tool: const GCCTableMorse(),
        id: 'gcc_tables_morse',
        searchKeys: const []),
    GCWTool(
        tool: const GCCTableNumeralBasesNames(),
        id: 'gcc_tables_numeralbases',
        searchKeys: const []),
    GCWTool(
        tool: const GCCTableResistor4(),
        id: 'gcc_tables_resistor4',
        searchKeys: const []),
    GCWTool(
        tool: const GCCTableResistor5(),
        id: 'gcc_tables_resistor5',
        searchKeys: const []),
    GCWTool(
        tool: const GCCTableRoman(),
        id: 'gcc_tables_roman',
        searchKeys: const []),
    GCWTool(
        tool: const GCCSymbolsSelection(),
        id: 'gcc_symbols',
        searchKeys: const []),

    GCWTool(tool: const GCCode(), id: 'gccode', categories: const [
      ToolCategory.CRYPTOGRAPHY
    ], searchKeys: const [
      'gccode',
    ]),
    GCWTool(tool: const GCD(), id: 'gcd', categories: const [
      ToolCategory.SCIENCE_AND_TECHNOLOGY
    ], searchKeys: const [
      'gcd',
    ]),
    GCWTool(
        tool: const GeneralCodebreakersSelection(),
        id: 'generalcodebreakers_selection',
        searchKeys: const [
          'codebreaker',
        ]),
    GCWTool(tool: const Geohashing(), id: 'geohashing', categories: const [
      ToolCategory.CRYPTOGRAPHY
    ], searchKeys: const [
      'geohashing',
    ], licenses: [
      ToolLicense(
          credit: 'Randall Munroe\nxkcd.com',
          licenseType: 'CC NC 2.5',
          url:
              'https://web.archive.org/web/20240715180948/https://xkcd.com/426/'),
      ToolLicense(
          credit: 'crox.net\n(geo.crox.net/djia)',
          licenseType: 'DowJones API',
          url:
              'https://web.archive.org/web/20130624044036/http://geo.crox.net/djia/')
    ]),
    GCWTool(tool: const Gray(), id: 'gray', categories: const [
      ToolCategory.CRYPTOGRAPHY
    ], searchKeys: const [
      'binary',
      'gray',
    ]),
    GCWTool(tool: const Grid(), id: 'grid', categories: const [
      ToolCategory.GAMES
    ], searchKeys: const [
      'grid',
    ]),
    GCWTool(
        tool: const GuitarStrings(),
        id: 'guitarstrings',
        categories: const [
          ToolCategory.SCIENCE_AND_TECHNOLOGY
        ],
        searchKeys: const [
          'music',
          'guitar',
        ]),
    GCWTool(
        tool: const HashSelection(),
        id: 'hashes_selection',
        categories: const [ToolCategory.CRYPTOGRAPHY],
        searchKeys: const []),
    GCWTool(
        tool: const HebrewNumberSystem(),
        id: 'hebrew_numbers',
        categories: const [
          ToolCategory.SCIENCE_AND_TECHNOLOGY
        ],
        searchKeys: const [
          'hebrew_numbers',
        ]),
    GCWTool(tool: const Hexadecimal(), id: 'hexadecimal', categories: const [
      ToolCategory.SCIENCE_AND_TECHNOLOGY
    ], searchKeys: const [
      'hexadecimal',
    ]),
    GCWTool(
        tool: const HexString2File(),
        id: 'hexstring2file',
        categories: const [
          ToolCategory.IMAGES_AND_FILES
        ],
        searchKeys: const [
          'hexadecimal',
          'hexstring2file',
        ]),
    GCWTool(tool: const HexViewer(), id: 'hexviewer', categories: const [
      ToolCategory.IMAGES_AND_FILES
    ], searchKeys: const [
      'hexadecimal',
      'hexviewer',
    ]),
    GCWTool(
        tool: const HiddenData(),
        id: 'hiddendata',
        isBeta: true,
        categories: const [
          ToolCategory.IMAGES_AND_FILES
        ],
        searchKeys: const [
          'hiddendata',
        ]),
    GCWTool(tool: const Homophone(), id: 'homophone', categories: const [
      ToolCategory.CRYPTOGRAPHY
    ], searchKeys: const [
      'homophone',
    ]),
    GCWTool(tool: const Houdini(), id: 'houdini', categories: const [
      ToolCategory.CRYPTOGRAPHY
    ], searchKeys: const [
      'houdini',
    ]),
    GCWTool(
      tool: const IATAICAOSearch(),
      id: 'iataicao',
      categories: const [ToolCategory.SCIENCE_AND_TECHNOLOGY],
      searchKeys: const [
        'iataicao',
      ],
    ),
    GCWTool(
      tool: const IceCodesSelection(),
      id: 'icecodes_selection',
      categories: const [ToolCategory.SCIENCE_AND_TECHNOLOGY],
      searchKeys: const [],
    ),
    GCWTool(tool: const IEEE754(), id: 'ieee754', categories: const [
      ToolCategory.SCIENCE_AND_TECHNOLOGY
    ], searchKeys: const [
      'binary',
      'ieee754',
    ]),
    GCWTool(tool: const ILLIAC(), id: 'illiac', categories: const [
      ToolCategory.SCIENCE_AND_TECHNOLOGY
    ], searchKeys: const [
      'illiac',
    ]),
    GCWTool(
        tool: const ImagesAndFilesSelection(),
        id: 'imagesandfiles_selection',
        isBeta: true,
        searchKeys: const [
          'images',
          'imagesandfilesselection',
        ]),
    GCWTool(
        tool: const ImageColorCorrections(),
        autoScroll: false,
        categories: const [ToolCategory.IMAGES_AND_FILES],
        id: 'image_colorcorrections',
        searchKeys: const [
          'images',
          'color',
          'image_colorcorrections',
        ]),
    GCWTool(
        tool: const ImageFlipRotate(),
        categories: const [ToolCategory.IMAGES_AND_FILES],
        id: 'image_fliprotate',
        searchKeys: const [
          'images',
          'image_fliprotate',
        ]),
    GCWTool(
        tool: const ImageStretchShrink(),
        categories: const [ToolCategory.IMAGES_AND_FILES],
        id: 'image_stretchshrink',
        searchKeys: const [
          'images',
          'image_stretchshrink',
        ]),
    GCWTool(
        tool: const IPCodes(),
        id: 'ipcodes',
        categories: const [ToolCategory.SCIENCE_AND_TECHNOLOGY],
        searchKeys: const ['ipcodes']),
    GCWTool(tool: const Judoon(), id: 'judoon', categories: const [
      ToolCategory.CRYPTOGRAPHY
    ], searchKeys: const [
      'judoon',
    ]),
    GCWTool(tool: const Kamasutra(), id: 'kamasutra', categories: const [
      ToolCategory.CRYPTOGRAPHY
    ], searchKeys: const [
      'rotation',
      'kamasutra',
    ]),
    GCWTool(tool: const Kenny(), id: 'kenny', categories: const [
      ToolCategory.CRYPTOGRAPHY
    ], searchKeys: const [
      'kenny',
    ]),
    GCWTool(
        tool: const KeyboardLayout(),
        id: 'keyboard_layout',
        searchKeys: const [
          'keyboard',
        ]),
    GCWTool(
        tool: const KeyboardNumbers(),
        id: 'keyboard_numbers',
        searchKeys: const ['keyboard', 'keyboard_numbers']),
    GCWTool(
        tool: const KeyboardSelection(),
        id: 'keyboard_selection',
        categories: const [ToolCategory.SCIENCE_AND_TECHNOLOGY],
        searchKeys: const []),
    GCWTool(tool: const LCM(), id: 'lcm', categories: const [
      ToolCategory.SCIENCE_AND_TECHNOLOGY
    ], searchKeys: const [
      'lcm',
    ]),
    GCWTool(
        tool: const LanguageGamesSelection(),
        id: 'languagegames_selection',
        categories: const [ToolCategory.CRYPTOGRAPHY],
        searchKeys: const []),
    GCWTool(
      tool: const LogicalSolver(),
      id: 'logicalsolver',
      categories: const [ToolCategory.GAMES],
      searchKeys: const [
        'games',
        'games_logicalsolver',
      ],
    ),
    GCWTool(tool: const LeetSpeak(), id: 'leetspeak', categories: const [
      ToolCategory.CRYPTOGRAPHY
    ], searchKeys: const [
      'leetspeak',
    ]),
    GCWTool(
        tool: const MagicEyeSolver(),
        id: 'magic_eye',
        isBeta: true,
        categories: const [ToolCategory.IMAGES_AND_FILES],
        searchKeys: const ['magic_eye', 'images']),
    GCWTool(
        tool: const MathematicalConstants(),
        id: 'mathematical_constants',
        categories: const [
          ToolCategory.SCIENCE_AND_TECHNOLOGY
        ],
        searchKeys: const [
          'mathematical_constants',
        ]),
    GCWTool(
        tool: const MayaCalendarSelection(),
        categories: const [ToolCategory.CRYPTOGRAPHY],
        id: 'mayacalendar_selection',
        searchKeys: const []),
    GCWTool(
        tool: const MayaNumbersSelection(),
        id: 'mayanumbers_selection',
        categories: const [ToolCategory.CRYPTOGRAPHY],
        searchKeys: const []),
    GCWTool(
        tool: const MexicanArmyCipherWheel(),
        id: 'mexicanarmycipherwheel',
        categories: const [
          ToolCategory.CRYPTOGRAPHY
        ],
        searchKeys: const [
          'cipherwheel',
          'mexicanarmycipherwheel',
        ]),
    GCWTool(
        tool: const MilesianNumberSystem(),
        id: 'milesian_numbers',
        categories: const [
          ToolCategory.SCIENCE_AND_TECHNOLOGY
        ],
        searchKeys: const [
          'milesian_numbers',
        ]),
    GCWTool(
        tool: const Morbit(),
        id: 'morbit',
        categories: const [ToolCategory.CRYPTOGRAPHY],
        searchKeys: const ['morbit', 'numbers']),
    GCWTool(
        tool: const MorseSelection(),
        id: 'morse_selection',
        categories: const [ToolCategory.CRYPTOGRAPHY],
        searchKeys: const []),
    GCWTool(
      tool: MultiDecoder(),
      id: 'multidecoder',
      categories: const [ToolCategory.GENERAL_CODEBREAKERS],
      searchKeys: const [
        'multidecoder',
      ],
      deeplinkAlias: const ['multitool'],
    ),
    GCWTool(
        tool: const MusicNotes(),
        id: 'music_notes',
        categories: const [ToolCategory.SCIENCE_AND_TECHNOLOGY],
        searchKeys: const ['music', 'music_notes']),
    GCWTool(tool: const Navajo(), id: 'navajo', categories: const [
      ToolCategory.CRYPTOGRAPHY
    ], searchKeys: const [
      'navajo',
    ]),
    GCWTool(
        tool: const NonogramSolver(),
        id: 'nonogramsolver',
        categories: const [ToolCategory.GAMES],
        searchKeys: const ['games', 'nonogramsolver', 'grid', 'images']),
    GCWTool(
        tool: const NumberPyramidSolver(),
        id: 'numberpyramidsolver',
        categories: const [
          ToolCategory.GAMES,
          ToolCategory.CRYPTOGRAPHY
        ],
        searchKeys: const [
          'games',
          'games_numberpyramidsolver',
        ]),
    GCWTool(
        tool: const NumberSequenceSelection(),
        id: 'numbersequence',
        categories: const [ToolCategory.SCIENCE_AND_TECHNOLOGY],
        searchKeys: const []),
    GCWTool(tool: const NumeralBases(), id: 'numeralbases', categories: const [
      ToolCategory.SCIENCE_AND_TECHNOLOGY
    ], searchKeys: const [
      'binary',
      'numeralbases',
    ]),
    GCWTool(
        tool: const NumeralWordsSelection(),
        id: 'numeralwords_selection',
        categories: const [ToolCategory.CRYPTOGRAPHY],
        searchKeys: const []),
    GCWTool(
        tool: OneTimePad(),
        id: 'onetimepad',
        categories: const [ToolCategory.CRYPTOGRAPHY],
        searchKeys: const ['onetimepad', 'numbers'],
        deeplinkAlias: const ['otp', 'one_time_pad']),

    GCWTool(
        tool: const PeriodicTableSelection(),
        id: 'periodictable_selection',
        categories: const [
          ToolCategory.SCIENCE_AND_TECHNOLOGY
        ],
        searchKeys: const [
          'periodictable',
        ]),

    GCWTool(tool: const PaperFormats(), id: 'paperformat', categories: const [
      ToolCategory.SCIENCE_AND_TECHNOLOGY
    ], searchKeys: const [
      'paperformat',
    ]),

    GCWTool(
        tool: const PeriodicTableSelection(),
        id: 'periodictable_selection',
        categories: const [
          ToolCategory.SCIENCE_AND_TECHNOLOGY
        ],
        searchKeys: const [
          'periodictable',
        ]),
    GCWTool(
        tool: const PeriodicTableSelection(),
        id: 'periodictable_selection',
        categories: const [
          ToolCategory.SCIENCE_AND_TECHNOLOGY
        ],
        searchKeys: const [
          'periodictable',
        ]),
    GCWTool(tool: const PhiSelection(), id: 'phi_selection', categories: const [
      ToolCategory.SCIENCE_AND_TECHNOLOGY
    ], searchKeys: const [
      'phi',
      'irrationalnumbers',
    ]),
    GCWTool(tool: const Piano(), id: 'piano', categories: const [
      ToolCategory.SCIENCE_AND_TECHNOLOGY
    ], searchKeys: const [
      'music'
          'music_notes',
      'piano',
    ]),
    GCWTool(tool: const PiSelection(), id: 'pi_selection', categories: const [
      ToolCategory.SCIENCE_AND_TECHNOLOGY
    ], searchKeys: const [
      'pi',
      'irrationalnumbers',
    ]),
    GCWTool(
        tool: const PhysicalConstants(),
        id: 'physical_constants',
        categories: const [
          ToolCategory.SCIENCE_AND_TECHNOLOGY
        ],
        searchKeys: const [
          'physical_constants',
        ]),
    GCWTool(tool: Playfair(), id: 'playfair', categories: const [
      ToolCategory.CRYPTOGRAPHY
    ], searchKeys: const [
      'playfair',
    ]),
    GCWTool(tool: const Pokemon(), id: 'pokemon_code', categories: const [
      ToolCategory.CRYPTOGRAPHY
    ], searchKeys: const [
      'pokemon',
    ]),
    GCWTool(
        tool: const Pollux(),
        id: 'pollux',
        categories: const [ToolCategory.CRYPTOGRAPHY],
        searchKeys: const ['pollux', 'numbers']),
    GCWTool(tool: const Polybios(), id: 'polybios', categories: const [
      ToolCategory.CRYPTOGRAPHY
    ], searchKeys: const [
      'polybios',
    ]),
    GCWTool(
        tool: const PredatorSelection(),
        id: 'predator_selection',
        categories: const [ToolCategory.CRYPTOGRAPHY],
        searchKeys: const []),
    GCWTool(
        tool: const PrimeAlphabet(),
        id: 'primealphabet',
        categories: const [
          ToolCategory.CRYPTOGRAPHY
        ],
        searchKeys: const [
          'primes',
          'primealphabet',
        ]),
    GCWTool(
        tool: const PrimesSelection(),
        id: 'primes_selection',
        categories: const [ToolCategory.SCIENCE_AND_TECHNOLOGY],
        searchKeys: const []),
    GCWTool(tool: const Projectiles(), id: 'projectiles', categories: const [
      ToolCategory.SCIENCE_AND_TECHNOLOGY
    ], searchKeys: const [
      'projectiles',
    ]),
    GCWTool(
        tool: const QrCode(),
        id: 'qr_code',
        isBeta: true,
        categories: const [
          ToolCategory.IMAGES_AND_FILES
        ],
        searchKeys: const [
          'qrcode',
        ]),
    GCWTool(
        tool: const QuadraticEquation(),
        id: 'quadratic_equation',
        categories: const [
          ToolCategory.SCIENCE_AND_TECHNOLOGY
        ],
        searchKeys: const [
          'quadraticequation',
        ]),
    GCWTool(tool: const Rabbit(), id: 'rabbit', categories: const [
      ToolCategory.CRYPTOGRAPHY
    ], searchKeys: const [
      'rabbit',
    ]),
    GCWTool(tool: const Ragbaby(), id: 'ragbaby', categories: const [
      ToolCategory.CRYPTOGRAPHY
    ], searchKeys: const [
      'ragbaby',
    ]),
    GCWTool(tool: const RailFence(), id: 'railfence', categories: const [
      ToolCategory.CRYPTOGRAPHY
    ], searchKeys: const [
      'railfence',
    ]),
    GCWTool(tool: const RC4(), id: 'rc4', categories: const [
      ToolCategory.CRYPTOGRAPHY
    ], searchKeys: const [
      'rc4',
    ]),
    GCWTool(tool: const Recycling(), id: 'recycling', categories: const [
      ToolCategory.SCIENCE_AND_TECHNOLOGY
    ], searchKeys: const [
      'recycling',
    ]),
    GCWTool(
        tool: const ResistorSelection(),
        id: 'resistor_selection',
        categories: const [ToolCategory.SCIENCE_AND_TECHNOLOGY],
        searchKeys: const []),
    GCWTool(tool: const Reverse(), id: 'reverse', categories: const [
      ToolCategory.CRYPTOGRAPHY
    ], searchKeys: const [
      'reverse',
    ]),
    GCWTool(
        tool: const RomanNumbersSelection(),
        id: 'romannumbers_selection',
        categories: const [ToolCategory.CRYPTOGRAPHY],
        searchKeys: const []),
    GCWTool(
        tool: const RotationSelection(),
        id: 'rotation_selection',
        categories: const [ToolCategory.CRYPTOGRAPHY],
        searchKeys: const []),
    GCWTool(tool: const RSASelection(), id: 'rsa_selection', categories: const [
      ToolCategory.CRYPTOGRAPHY
    ], searchKeys: const [
      'primes',
    ]),
    GCWTool(
        tool: const ScienceAndTechnologySelection(),
        id: 'scienceandtechnology_selection',
        searchKeys: const [
          'scienceandtechnologyselection',
        ]),
    GCWTool(
        tool: const ScrabbleSelection(),
        id: 'scrabble_selection',
        categories: const [ToolCategory.GAMES],
        searchKeys: const ['games']),
    GCWTool(
        tool: const MiscellaneousSelection(),
        id: 'miscellaneous_selection',
        searchKeys: const []),
    GCWTool(
        tool: const SegmentDisplaySelection(),
        id: 'segmentdisplay_selection',
        categories: const [ToolCategory.SCIENCE_AND_TECHNOLOGY],
        searchKeys: const []),
    GCWTool(
        tool: const ShadoksSelection(),
        id: 'shadoks_selection',
        categories: const [ToolCategory.CRYPTOGRAPHY],
        searchKeys: const []),
    GCWTool(
        tool: const SilverRatioSelection(),
        id: 'silverratio_selection',
        categories: const [
          ToolCategory.SCIENCE_AND_TECHNOLOGY
        ],
        searchKeys: const [
          'silverratio',
          'irrationalnumbers',
        ]),
    GCWTool(tool: const Skytale(), id: 'skytale', categories: const [
      ToolCategory.CRYPTOGRAPHY
    ], searchKeys: const [
      'skytale',
    ]),
    GCWTool(
        tool: const SlashAndPipeSelection(),
        id: 'slash_and_pipe_selection',
        categories: const [ToolCategory.CRYPTOGRAPHY],
        searchKeys: const []),
    GCWTool(tool: const Solitaire(), id: 'solitaire', categories: const [
      ToolCategory.CRYPTOGRAPHY
    ], searchKeys: const [
      'solitaire',
    ]),
    GCWTool(
        tool: const Sort(),
        id: 'sort',
        categories: const [ToolCategory.SCIENCE_AND_TECHNOLOGY],
        searchKeys: const ['sort']),
    GCWTool(
        tool: const SpellingAlphabetsSelection(),
        id: 'spelling_alphabets_selection',
        categories: const [ToolCategory.SCIENCE_AND_TECHNOLOGY],
        searchKeys: const []),
    GCWTool(
        tool: const SQRT2Selection(),
        id: 'sqrt2_selection',
        categories: const [
          ToolCategory.SCIENCE_AND_TECHNOLOGY
        ],
        searchKeys: const [
          'sqrt',
          'irrationalnumbers',
        ]),
    GCWTool(
        tool: const SQRT3Selection(),
        id: 'sqrt3_selection',
        categories: const [
          ToolCategory.SCIENCE_AND_TECHNOLOGY
        ],
        searchKeys: const [
          'sqrt',
          'irrationalnumbers',
        ]),
    GCWTool(
        tool: const SQRT5Selection(),
        id: 'sqrt5_selection',
        categories: const [
          ToolCategory.SCIENCE_AND_TECHNOLOGY
        ],
        searchKeys: const [
          'sqrt',
          'irrationalnumbers',
        ]),
    GCWTool(tool: const Stegano(), id: 'stegano', categories: const [
      ToolCategory.IMAGES_AND_FILES
    ], searchKeys: const [
      'stegano',
    ]),
    GCWTool(
        tool: const StraddlingCheckerboard(),
        id: 'straddlingcheckerboard',
        categories: const [
          ToolCategory.CRYPTOGRAPHY
        ],
        searchKeys: const [
          'straddlingcheckerboard',
        ]),
    GCWTool(tool: const Substitution(), id: 'substitution', categories: const [
      ToolCategory.CRYPTOGRAPHY
    ], searchKeys: const [
      'substitution',
    ]),
    GCWTool(
        tool: SubstitutionBreaker(),
        id: 'substitutionbreaker',
        categories: const [
          ToolCategory.GENERAL_CODEBREAKERS
        ],
        searchKeys: const [
          'codebreaker',
          'substitutionbreaker',
        ],
        deeplinkAlias: const [
          'substitution_breaker',
          'substbreaker',
          'substbreak',
          'subst_breaker',
          'subst_break'
        ],
        licenses: [
          ToolLicense(
              credit: 'Jens Guballa\n(guballa.de)',
              licenseType: 'MIT License',
              url:
                  'https://gitlab.com/guballa/SubstitutionBreaker/-/blob/93dcc269efbfe6c62c3a93a6ce66077d6ff335fb/LICENSE')
        ]),
    GCWTool(tool: const SudokuSolver(), id: 'sudokusolver', categories: const [
      ToolCategory.GAMES
    ], searchKeys: const [
      'games',
      'games_sudokusolver',
    ], licenses: [
      ToolLicense(
          credit: 'Demis Bellot, Adam Singer, Matias Meno',
          licenseType: 'Free to use',
          url:
              'https://github.com/S-Man42/sudoku_solver/blob/5f1889ce8f6c4f0eb1f8ec10caa84cc318c827b8/LICENSE')
    ]),
    GCWTool(
      tool: const SymbolTableSelection(),
      toolBarItemList: [symbolTableToolbarMenuItem(context)],
      id: 'symboltables_selection',
      searchKeys: const [],
    ),
    GCWTool(tool: const TapCode(), id: 'tapcode', categories: const [
      ToolCategory.CRYPTOGRAPHY
    ], searchKeys: const [
      'tapcode',
    ]),
    GCWTool(
        tool: Tapir(),
        id: 'tapir',
        categories: const [ToolCategory.CRYPTOGRAPHY],
        searchKeys: const ['tapir', 'numbers']),
    GCWTool(
        tool: const TelegraphSelection(),
        id: 'telegraph_selection',
        categories: const [ToolCategory.SCIENCE_AND_TECHNOLOGY],
        searchKeys: const []),
    GCWTool(
        tool: const TeletypewriterSelection(),
        id: 'teletypewriter_selection',
        categories: const [ToolCategory.SCIENCE_AND_TECHNOLOGY],
        searchKeys: const []),
    GCWTool(
        tool: const TeletypewriterPunchTape(),
        id: 'punchtape',
        categories: const [
          ToolCategory.CRYPTOGRAPHY
        ],
        searchKeys: const [
          'ccitt',
          'ccitt_1',
          'ccitt_2',
          'ccitt_3',
          'ccitt_4',
          'ccitt_5',
          'punchtape',
          'teletypewriter',
          'symbol_siemens',
          'symbol_westernunion',
          'symbol_murraybaudot',
          'symbol_baudot'
        ]),
    GCWTool(
        tool: const TextAnalysis(),
        id: 'textanalysis',
        categories: const [ToolCategory.CRYPTOGRAPHY],
        searchKeys: const ['alphabetvalues', 'asciivalues', 'textanalysis']),
    GCWTool(tool: const Trifid(), id: 'trifid', categories: const [
      ToolCategory.CRYPTOGRAPHY
    ], searchKeys: const [
      'trifid',
    ]),
    GCWTool(
        tool: const TomTomSelection(),
        id: 'tomtom_selection',
        categories: const [ToolCategory.CRYPTOGRAPHY],
        searchKeys: const []),
    GCWTool(tool: const Triangle(), id: 'triangle', categories: const [
      ToolCategory.SCIENCE_AND_TECHNOLOGY
    ], searchKeys: const [
      'triangle',
    ]),
    GCWTool(tool: const TTS(), id: 'tts', categories: const [
      ToolCategory.SCIENCE_AND_TECHNOLOGY
    ], searchKeys: const [
      'tts',
    ]),
    GCWTool(tool: const UFI(), id: 'ufi', categories: const [
      ToolCategory.CRYPTOGRAPHY,
      ToolCategory.SCIENCE_AND_TECHNOLOGY
    ], searchKeys: const [
      'ufi',
    ]),
    GCWTool(
        tool: const UICWagonCodeSelection(),
        id: 'uic_wagoncode_selection',
        categories: const [ToolCategory.SCIENCE_AND_TECHNOLOGY]),
    GCWTool(
        tool: const UnitConverter(),
        id: 'unitconverter',
        categories: const [
          ToolCategory.SCIENCE_AND_TECHNOLOGY
        ],
        searchKeys: const [
          'unitconverter',
        ]),
    GCWTool(
        tool: const UniversalProductCode(),
        id: 'universalproductcode',
        categories: const [
          ToolCategory.CRYPTOGRAPHY
        ],
        searchKeys: const [
          'barcodes',
          'binary',
          'universalproductcode',
        ]),
    GCWTool(
        tool: const VelocityAcceleration(),
        id: 'velocity_acceleration',
        categories: const [ToolCategory.SCIENCE_AND_TECHNOLOGY],
        searchKeys: const ['velocity_acceleration']),
    GCWTool(
        tool: const VanitySelection(),
        id: 'vanity_selection',
        categories: const [ToolCategory.SCIENCE_AND_TECHNOLOGY],
        searchKeys: const []),
    GCWTool(
        tool: const VigenereSelection(),
        id: 'vigenere_selection',
        categories: const [ToolCategory.CRYPTOGRAPHY],
        searchKeys: const []),
    GCWTool(
        tool: const VisualCryptography(),
        id: 'visual_cryptography',
        categories: const [
          ToolCategory.IMAGES_AND_FILES,
          ToolCategory.CRYPTOGRAPHY
        ],
        searchKeys: const [
          'visualcryptography',
          'images'
        ]),
    GCWTool(tool: const WASD(), id: 'wasd', categories: const [
      ToolCategory.CRYPTOGRAPHY
    ], searchKeys: const [
      'wasd',
    ]),
    GCWTool(
        tool: const WherigoSelection(),
        id: 'wherigourwigo_selection',
        categories: const [ToolCategory.CRYPTOGRAPHY],
        searchKeys: const []),
    GCWTool(
        tool: const WeatherSymbols(),
        id: 'weathersymbols',
        categories: const [ToolCategory.SCIENCE_AND_TECHNOLOGY],
        searchKeys: const ['weather', 'weather_clouds', 'weather_a']),
    GCWTool(tool: const Z22(), id: 'z22', categories: const [
      ToolCategory.SCIENCE_AND_TECHNOLOGY
    ], searchKeys: const [
      'z22',
    ]),
    GCWTool(
        tool: const WordSearch(),
        id: 'word_search',
        categories: const [ToolCategory.GAMES],
        searchKeys: const ['word_search', 'grid']),
    GCWTool(
        tool: ZamonianNumbers(),
        autoScroll: false,
        id: 'zamoniannumbers',
        categories: const [
          ToolCategory.CRYPTOGRAPHY
        ],
        searchKeys: const [
          'symbol_zamonian',
        ]),
    GCWTool(tool: const ZC1(), id: 'zc1', categories: const [
      ToolCategory.SCIENCE_AND_TECHNOLOGY
    ], searchKeys: const [
      'zc1',
    ]),
    GCWTool(
        tool: const ZodiacSelection(),
        id: 'zodiac_selection',
        categories: const [ToolCategory.MISCELLANEOUS]),

    //ApparentTemperatureSelection  ********************************************************************************************
    GCWTool(tool: const HeatIndex(), id: 'heatindex', searchKeys: const [
      'apparenttemperature',
      'apparenttemperature_heatindex',
    ]),
    GCWTool(tool: const Humidex(), id: 'humidex', searchKeys: const [
      'apparenttemperature',
      'apparenttemperature_humidex',
    ]),
    GCWTool(
        tool: const SummerSimmerIndex(),
        id: 'summersimmerindex',
        searchKeys: const [
          'apparenttemperature',
          'apparenttemperature_summersimmerindex',
        ]),
    GCWTool(tool: const Windchill(), id: 'windchill', searchKeys: const [
      'apparenttemperature',
      'apparenttemperature_windchill',
    ]),
    GCWTool(
        tool: const WetBulbTemperature(),
        id: 'wet_bulb_temperature',
        searchKeys: const [
          'apparenttemperature',
          'apparenttemperature_wet_bulb_temperature',
        ]),

    //AstronomySelection  ********************************************************************************************
    GCWTool(
        tool: const IAUAllConstellations(),
        id: 'iau_constellation',
        searchKeys: const [
          'astronomy',
          'iau_constellation',
        ]),
    GCWTool(
        tool: const IAUSingleConstellation(ConstellationName: 'Andromeda'),
        id: 'iau_constellation',
        searchKeys: const []),
    GCWTool(
        tool: const SunRiseSet(),
        id: 'astronomy_sunriseset',
        searchKeys: const [
          'astronomy',
          'astronomy_riseset',
          'astronomy_sun',
          'astronomy_sunriseset',
        ],
        licenses: [
          _toolLicensePracticalAstronomy,
          _toolLicenseAstronomieInfo,
          _toolLicenseNASADeltaT
        ]),
    GCWTool(
        tool: const SunPosition(),
        id: 'astronomy_sunposition',
        searchKeys: const [
          'astronomy',
          'astronomy_position',
          'astronomy_sun',
        ],
        licenses: [
          _toolLicensePracticalAstronomy,
          _toolLicenseAstronomieInfo,
          _toolLicenseNASADeltaT
        ]),
    GCWTool(
        tool: const MoonRiseSet(),
        id: 'astronomy_moonriseset',
        searchKeys: const [
          'astronomy',
          'astronomy_riseset',
          'astronomy_moon',
        ],
        licenses: [
          _toolLicensePracticalAstronomy,
          _toolLicenseAstronomieInfo,
          _toolLicenseNASADeltaT
        ]),
    GCWTool(
        tool: const MoonPosition(),
        id: 'astronomy_moonposition',
        searchKeys: const [
          'astronomy',
          'astronomy_position',
          'astronomy_moon',
          'astronomy_moonposition',
        ],
        licenses: [
          _toolLicensePracticalAstronomy,
          _toolLicenseAstronomieInfo,
          _toolLicenseNASADeltaT
        ]),
    GCWTool(
        tool: const EasterSelection(),
        id: 'astronomy_easter_selection',
        searchKeys: const [
          'easter_date',
        ]),
    GCWTool(
        tool: const SunRiseSet(),
        id: 'astronomy_sunriseset',
        searchKeys: const [
          'astronomy',
          'astronomy_riseset',
          'astronomy_sun',
          'astronomy_sunriseset',
        ]),
    GCWTool(
        tool: const SunPosition(),
        id: 'astronomy_sunposition',
        searchKeys: const [
          'astronomy',
          'astronomy_position',
          'astronomy_sun',
        ],
        licenses: [
          ToolLicense(
              credit: 'Helmut Lehmeyer\nastronomie.info',
              licenseType: 'GNU License',
              url:
                  'http://web.archive.org/web/20180502230101/http://lexikon.astronomie.info/java/sunmoon/progs/Astronomy.java')
        ]),
    GCWTool(
        tool: const MoonRiseSet(),
        id: 'astronomy_moonriseset',
        searchKeys: const [
          'astronomy',
          'astronomy_riseset',
          'astronomy_moon',
        ]),
    GCWTool(
        tool: const MoonPosition(),
        id: 'astronomy_moonposition',
        searchKeys: const [
          'astronomy',
          'astronomy_position',
          'astronomy_moon',
          'astronomy_moonposition',
        ]),
    GCWTool(
        tool: const EasterSelection(),
        id: 'astronomy_easter_selection',
        searchKeys: const [
          'easter_date',
        ]),
    GCWTool(tool: const Seasons(), id: 'astronomy_seasons', searchKeys: const [
      'astronomy',
      'astronomy_seasons',
    ], licenses: [
      ToolLicense(
          credit: 'Jean Meeus',
          licenseType: 'Astronomical Algorithms, ISBN 978-0943396613'),
      ToolLicense(
          credit: 'Jürgen Giesen\n(jgiesen.de)',
          licenseType: 'Use permission by e-mail (2020-06-29)',
          url:
              'https://web.archive.org/web/20140805014345/http://www.jgiesen.de/astro/astroJS/seasons2/seasons.js')
    ]),
    GCWTool(tool: const ShadowLength(), id: 'shadowlength', searchKeys: const [
      'astronomy',
      'astronomy_shadow_length',
    ], licenses: [
      _toolLicenseNASADeltaT
    ]),
    GCWTool(
        tool: const RightAscensionToDegree(),
        id: 'right_ascension_to_degree',
        categories: const [],
        searchKeys: const [
          'astronomy',
          'right_ascension_to_degree',
          'coordinates',
        ],
        licenses: [
          ToolLicense(
              credit: 'en.wikipedia.org',
              licenseType: 'CC BY-SA 4.0',
              url:
                  'https://en.wikipedia.org/w/index.php?title=Equatorial_coordinate_system&oldid=1228085432'),
          ToolLicense(
              credit: '@max-mapper',
              licenseType: 'Github default',
              url:
                  'https://github.com/S-Man42/equatorial/commit/f11b2a91be12721d87b108cc495953bc96565fec')
        ]),

    //Babylon Numbers Selection **************************************************************************************
    GCWTool(
        tool: const BabylonNumbers(),
        id: 'babylonnumbers',
        searchKeys: const [
          'babylonian_numerals',
        ]),

    //BaseSelection **************************************************************************************************
    GCWTool(tool: Base16(), id: 'base_base16', searchKeys: const [
      'base',
      'base16',
    ], deeplinkAlias: const [
      'base16'
    ]),
    GCWTool(tool: Base32(), id: 'base_base32', searchKeys: const [
      'base',
      'base32',
    ], deeplinkAlias: const [
      'base32'
    ]),
    GCWTool(tool: Base58(), id: 'base_base58', searchKeys: const [
      'base',
      'base58',
    ], deeplinkAlias: const [
      'base58'
    ]),
    GCWTool(tool: Base64(), id: 'base_base64', searchKeys: const [
      'base',
      'base64',
    ], deeplinkAlias: const [
      'base64'
    ]),
    GCWTool(tool: Base85(), id: 'base_base85', searchKeys: const [
      'base',
      'base85',
    ], deeplinkAlias: const [
      'base85'
    ]),
    GCWTool(tool: Base91(), id: 'base_base91', searchKeys: const [
      'base',
      'base91',
    ], deeplinkAlias: const [
      'base91'
    ]),
    GCWTool(tool: Base122(), id: 'base_base122', searchKeys: const [
      'base',
      'base122',
    ], deeplinkAlias: const [
      'base122'
    ]),

    //BCD selection **************************************************************************************************
    GCWTool(tool: const BCDOriginal(), id: 'bcd_original', searchKeys: const [
      'bcd',
      'bcdoriginal',
    ]),
    GCWTool(tool: const BCDAiken(), id: 'bcd_aiken', searchKeys: const [
      'bcd',
      'bcdaiken',
    ]),
    GCWTool(tool: const BCDGlixon(), id: 'bcd_glixon', searchKeys: const [
      'bcd',
      'bcdglixon',
    ]),
    GCWTool(tool: const BCDGray(), id: 'bcd_gray', searchKeys: const [
      'bcd',
      'bcdgray',
    ]),
    GCWTool(
        tool: const BCDLibawCraig(),
        id: 'bcd_libawcraig',
        searchKeys: const [
          'bcd',
          'bcdlibawcraig',
        ]),
    GCWTool(tool: const BCDOBrien(), id: 'bcd_obrien', searchKeys: const [
      'bcd',
      'bcdobrien',
    ]),
    GCWTool(tool: const BCDPetherick(), id: 'bcd_petherick', searchKeys: const [
      'bcd',
      'bcdpetherick',
    ]),
    GCWTool(tool: const BCDStibitz(), id: 'bcd_stibitz', searchKeys: const [
      'bcd',
      'bcdstibitz',
    ]),
    GCWTool(tool: const BCDTompkins(), id: 'bcd_tompkins', searchKeys: const [
      'bcd',
      'bcdtompkins',
    ]),
    GCWTool(tool: const BCDHamming(), id: 'bcd_hamming', searchKeys: const [
      'bcd',
      'bcdhamming',
    ]),
    GCWTool(tool: const BCDBiquinary(), id: 'bcd_biquinary', searchKeys: const [
      'bcd',
      'bcd2of5',
      'bcdbiquinary',
    ]),
    GCWTool(
        tool: const BCD2of5Planet(),
        id: 'bcd_2of5planet',
        searchKeys: const [
          'bcd',
          'bcd2of5',
          'bcd2of5planet',
        ]),
    GCWTool(
        tool: const BCD2of5Postnet(),
        id: 'bcd_2of5postnet',
        searchKeys: const [
          'bcd',
          'bcd2of5',
          'bcd2of5postnet',
        ]),
    GCWTool(tool: const BCD2of5(), id: 'bcd_2of5', searchKeys: const [
      'bcd',
      'bcd2of5',
    ]),
    GCWTool(tool: const BCD1of10(), id: 'bcd_1of10', searchKeys: const [
      'bcd',
      'bcd1of10',
    ]),
    GCWTool(
        tool: const BCDGrayExcess(),
        id: 'bcd_grayexcess',
        searchKeys: const [
          'bcd',
          'bcdgrayexcess',
        ]),

    // Beaufort Selection *******************************************************************************************
    GCWTool(tool: const Beaufort(), id: 'beaufort', searchKeys: const [
      'beaufort',
    ]),

    // BundeswehrTalkingBoard Selection *******************************************************************************************
    GCWTool(
        tool: const BundeswehrTalkingBoardAuthentification(),
        id: 'bundeswehr_talkingboard_auth',
        categories: const [],
        searchKeys: const [
          'bundeswehr_talkingboard_auth',
          'bundeswehr_talkingboard',
        ]),
    GCWTool(
        tool: const BundeswehrTalkingBoardObfuscation(),
        id: 'bundeswehr_talkingboard_code',
        categories: const [],
        searchKeys: const [
          'bundeswehr_talkingboard',
          'bundeswehr_talkingboard_code',
        ]),

    //Braille Selection ****************************************************************
    GCWTool(tool: const Braille(), id: 'braille', searchKeys: const [
      'braille',
    ]),
    GCWTool(
        tool: const BrailleDotNumbers(),
        id: 'brailledotnumbers',
        searchKeys: const [
          'braille',
        ]),

    //CCITT Selection **********************************************************************************************
    GCWTool(
        tool: const CCITT1(),
        id: 'ccitt_1',
        searchKeys: const ['ccitt', 'ccitt_1', 'symbol_baudot']),
    GCWTool(tool: const CCITT2(), id: 'ccitt_2', searchKeys: const [
      'ccitt',
      'ccitt_2',
      'teletypewriter',
      'symbol_murraybaudot',
    ]),
    GCWTool(tool: const CCITT3(), id: 'ccitt_3', searchKeys: const [
      'ccitt',
      'ccitt_3',
      'teletypewriter',
    ]),
    GCWTool(tool: const CCITT4(), id: 'ccitt_4', searchKeys: const [
      'ccitt',
      'ccitt_4',
      'teletypewriter',
    ]),
    GCWTool(tool: const CCITT5(), id: 'ccitt_5', searchKeys: const [
      'ccitt',
      'ccitt_5',
      'teletypewriter',
    ]),
    GCWTool(tool: const CCIR476(), id: 'ccitt_ccir476', searchKeys: const [
      'ccitt',
      'ccitt_ccir_476',
      'teletypewriter',
    ]),

    //CheckDigitsSelection  ********************************************************************************************
    GCWTool(
        tool: const CheckDigitsCreditCardSelection(),
        id: 'checkdigits_creditcard_selection',
        searchKeys: const ['checkdigits', '']),
    GCWTool(
        tool: const CheckDigitsDETaxIDSelection(),
        id: 'checkdigits_de_taxid_selection',
        searchKeys: const ['checkdigits', 'checkdigits_de_taxid']),
    GCWTool(
        tool: const CheckDigitsEANSelection(),
        id: 'checkdigits_ean_selection',
        searchKeys: const ['checkdigits', 'checkdigits_ean']),
    GCWTool(
        tool: const CheckDigitsIBANSelection(),
        id: 'checkdigits_iban_selection',
        searchKeys: const ['checkdigits', 'checkdigits_iban']),
    GCWTool(
        tool: const CheckDigitsIMEISelection(),
        id: 'checkdigits_imei_selection',
        searchKeys: const ['checkdigits', 'checkdigits_imei']),
    GCWTool(
        tool: const CheckDigitsISBNSelection(),
        id: 'checkdigits_isbn_selection',
        searchKeys: const ['checkdigits', 'checkdigits_isbn']),
    GCWTool(
        tool: const CheckDigitsEUROSelection(),
        id: 'checkdigits_euro_selection',
        searchKeys: const ['checkdigits', 'checkdigits_euro']),
    GCWTool(
        tool: const CheckDigitsUICSelection(),
        id: 'checkdigits_uic_selection',
        searchKeys: const ['checkdigits', 'checkdigits_uic']),

    //CheckDigitsCreditCardSelection  ********************************************************************************************
    GCWTool(
        tool: const CheckDigitsCreditCardCheckNumber(),
        id: 'checkdigits_creditcard_checknumber',
        searchKeys: const []),
    GCWTool(
        tool: const CheckDigitsCreditCardCalculateCheckDigit(),
        id: 'checkdigits_creditcard_calculate_digit',
        searchKeys: const []),
    GCWTool(
        tool: const CheckDigitsCreditCardCalculateMissingDigit(),
        id: 'checkdigits_creditcard_calculate_number',
        searchKeys: const []),

    //CheckDigitsDETINSelection  ********************************************************************************************
    GCWTool(
        tool: const CheckDigitsDETaxIDCheckNumber(),
        id: 'checkdigits_de_taxid_checknumber',
        searchKeys: const []),
    GCWTool(
        tool: const CheckDigitsDETaxIDCalculateCheckDigit(),
        id: 'checkdigits_de_taxid_calculate_digit',
        searchKeys: const []),
    GCWTool(
        tool: const CheckDigitsDETaxIDCalculateMissingDigit(),
        id: 'checkdigits_de_taxid_calculate_number',
        searchKeys: const []),

    //CheckDigitsEANSelection  ********************************************************************************************
    GCWTool(
        tool: const CheckDigitsEANCheckNumber(),
        id: 'checkdigits_ean_checknumber',
        searchKeys: const []),
    GCWTool(
        tool: const CheckDigitsEANCalculateCheckDigit(),
        id: 'checkdigits_ean_calculate_digit',
        searchKeys: const []),
    GCWTool(
        tool: const CheckDigitsEANCalculateMissingDigit(),
        id: 'checkdigits_ean_calculate_number',
        searchKeys: const []),

    //CheckDigitsEUROSelection  ********************************************************************************************
    GCWTool(
        tool: const CheckDigitsEUROCheckNumber(),
        id: 'checkdigits_euro_checknumber',
        searchKeys: const []),
    GCWTool(
        tool: const CheckDigitsEUROCalculateCheckDigit(),
        id: 'checkdigits_euro_calculate_digit',
        searchKeys: const []),
    GCWTool(
        tool: const CheckDigitsEUROCalculateMissingDigit(),
        id: 'checkdigits_euro_calculate_number',
        searchKeys: const []),

    //CheckDigitsIBANSelection  ********************************************************************************************
    GCWTool(
        tool: const CheckDigitsIBANCheckNumber(),
        id: 'checkdigits_iban_checknumber',
        searchKeys: const []),
    GCWTool(
        tool: const CheckDigitsIBANCalculateCheckDigit(),
        id: 'checkdigits_iban_calculate_digit',
        searchKeys: const []),
    GCWTool(
        tool: const CheckDigitsIBANCalculateMissingDigit(),
        id: 'checkdigits_iban_calculate_number',
        searchKeys: const []),

    //CheckDigitsIMEISelection  ********************************************************************************************
    GCWTool(
        tool: const CheckDigitsIMEICheckNumber(),
        id: 'checkdigits_imei_checknumber',
        searchKeys: const []),
    GCWTool(
        tool: const CheckDigitsIMEICalculateCheckDigit(),
        id: 'checkdigits_imei_calculate_digit',
        searchKeys: const []),
    GCWTool(
        tool: const CheckDigitsIMEICalculateMissingDigit(),
        id: 'checkdigits_imei_calculate_number',
        searchKeys: const []),

    //CheckDigitsISBNSelection  ********************************************************************************************
    GCWTool(
        tool: const CheckDigitsISBNCheckNumber(),
        id: 'checkdigits_isbn_checknumber',
        searchKeys: const []),
    GCWTool(
        tool: const CheckDigitsISBNCalculateCheckDigit(),
        id: 'checkdigits_isbn_calculate_digit',
        searchKeys: const []),
    GCWTool(
        tool: const CheckDigitsISBNCalculateMissingDigit(),
        id: 'checkdigits_isbn_calculate_number',
        searchKeys: const []),

    //CheckDigitsUICSelection  ********************************************************************************************
    GCWTool(
        tool: const CheckDigitsUICCheckNumber(),
        id: 'checkdigits_uic_checknumber',
        searchKeys: const []),
    GCWTool(
        tool: const CheckDigitsUICCalculateCheckDigit(),
        id: 'checkdigits_uic_calculate_digit',
        searchKeys: const []),
    GCWTool(
        tool: const CheckDigitsUICCalculateMissingDigit(),
        id: 'checkdigits_uic_calculate_number',
        searchKeys: const []),

    //Cistercian Selection *****************************************************************************************
    GCWTool(
        tool: const CistercianNumbers(),
        id: 'cistercian',
        searchKeys: const [
          'cistercian',
        ]),

    //ColorsSelection **********************************************************************************************
    GCWTool(tool: const ColorTool(), id: 'colors', searchKeys: const [
      'color',
      'colorpicker',
    ]),
    GCWTool(
        tool: const RALColorCodes(),
        id: 'ralcolorcodes',
        searchKeys: const [
          'color',
          'ralcolorcodes',
        ]),
    GCWTool(
        tool: const PantoneColorCodes(),
        id: 'pantonecolorcodes',
        searchKeys: const [
          'color',
          'pantonecolorcodes',
        ]),

    //CombinatoricsSelection ***************************************************************************************
    GCWTool(
        tool: const Combination(),
        id: 'combinatorics_combination',
        searchKeys: const [
          'combinatorics',
          'combinatorics_combination',
        ]),
    GCWTool(
        tool: const Permutation(),
        id: 'combinatorics_permutation',
        searchKeys: const [
          'combinatorics',
          'combinatorics_permutation',
        ]),
    GCWTool(
        tool: const CombinationPermutation(),
        id: 'combinatorics_combinationpermutation',
        searchKeys: const [
          'combinatorics',
          'combinatorics_combination',
          'combinatorics_permutation',
        ]),

    //CoordsSelection **********************************************************************************************
    GCWTool(
        tool: const WaypointProjectionGeodetic(),
        id: 'coords_waypointprojection',
        iconPath:
            'lib/tools/coords/_common/assets/icons/icon_waypoint_projection.png',
        categories: const [
          ToolCategory.COORDINATES
        ],
        searchKeys: const [
          'coordinates',
          'coordinates_compassrose',
          'coordinates_waypointprojection',
          'coordinates_geodetic',
        ],
        licenses: [
          _toolLicenseGeographicLib
        ]),
    GCWTool(
        tool: const DistanceBearingGeodetic(),
        id: 'coords_distancebearing',
        iconPath:
            'lib/tools/coords/_common/assets/icons/icon_distance_and_bearing.png',
        categories: const [
          ToolCategory.COORDINATES
        ],
        searchKeys: const [
          'coordinates',
          'coordinates_distancebearing',
          'coordinates_geodetic',
        ],
        licenses: [
          _toolLicenseGeographicLib
        ]),
    GCWTool(
        tool: const FormatConverter(),
        id: 'coords_formatconverter',
        iconPath:
            'lib/tools/coords/_common/assets/icons/icon_format_converter.png',
        categories: const [
          ToolCategory.COORDINATES
        ],
        searchKeys: const [
          'coordinates',
          'coordinates_formatconverter',
        ],
        licenses: [
          _toolLicenseGeographicLib,
          ToolLicense(
              credit: 'Hartwig Koch, Frank Naberfeld\n(Robert Bosch GmbH)',
              licenseType:
                  'Patent, Deutsches Patent- und Markenamt, 102 39 432.6, 2002-08-28',
              url:
                  'https://web.archive.org/web/20240720180713/https://patentimages.storage.googleapis.com/8c/d1/46/c983120d1aea7b/DE10239432A1.pdf'),
          ToolLicense(
              credit: 'Jan van der Laan',
              licenseType: 'MIT License',
              url:
                  'https://web.archive.org/web/20041206052853/http://www.dekoepel.nl/pdf/Transformatieformules.pdf'),
          ToolLicense(
              credit: 'F.H. Schreutelkamp, Strang van Hees',
              licenseType:
                  'Article: Benaderingsformules voor de transformatie tussen RD- en WGS84-kaartcoördinaten',
              url:
                  'https://github.com/S-Man42/rijksdriehoek/blob/dfea5221b8e3f9f44b6f0102114ab92f36eca5b2/LICENSE'),
          ToolLicense(
              credit: 'en.wikipedia.org',
              licenseType: 'CC BY-SA 4.0',
              url:
                  'https://en.wikipedia.org/w/index.php?title=Global_Area_Reference_System&oldid=1127203453'),
          ToolLicense(
              credit: 'National Geospatial-Intelligence Agency',
              licenseType: 'Article: Global Area Reference System (GARS)',
              url:
                  'https://web.archive.org/web/20061020155156/http://earth-info.nga.mil/GandG/coordsys/grids/gars.html'),
          ToolLicense(
              credit: 'Taisuke Fukuno\n(Geo3x3)',
              licenseType: 'CC0-1.0 License',
              url:
                  'https://github.com/S-Man42/Geo3x3/tree/ca45f4a2c5fcebd806d1dbf615c7a26a8cad1150?tab=License-1-ov-file'),
          ToolLicense(
              credit: '@sa2da\n(geohex.org/)',
              licenseType: 'MIT License',
              url:
                  'https://web.archive.org/web/20240301005527/http://www.geohex.org/'),
          ToolLicense(
              credit: 'Chikura Shinsaku\n(geohex4j)',
              licenseType: 'MIT License',
              url:
                  'https://github.com/S-Man42/geohex4j/tree/464acda075666e0c2cb868935b334371c7f2eb97?tab=readme-ov-file#license'),
          ToolLicense(
              credit: 'makaney.net',
              licenseType: 'Free to use',
              url:
                  'https://web.archive.org/web/20230719211854/http://www.makaney.net/mkc_standard.html'),
          ToolLicense(
              credit: 'Stichting Mapcode Foundation\n(mapcode.com)',
              licenseType: 'Apache 2.0 License',
              url:
                  'https://github.com/S-Man42/mapcode-js/blob/25abcc53f4a15b996810a9d0fd00ff2efd0f2eeb/LICENSE'),
          ToolLicense(
              credit: 'Google',
              licenseType: 'Apache 2.0 License',
              url:
                  'https://github.com/S-Man42/open-location-code/blob/dfcebc905b81c3d9c987f7b3ac6e992f1e8710c6/LICENSE'),
          ToolLicense(
              credit: 'OpenStreetMap.org',
              licenseType: 'CC BY-SA 2.0',
              url:
                  'https://wiki.openstreetmap.org/w/index.php?title=Slippy_map_tilenames&oldid=2689774'),
          ToolLicense(
              credit: 'Bundesamt für Landestopografie Schweiz swisstopo',
              licenseType:
                  'Article: Formeln und Konstanten für die Berechnung der Schweizerischen schiefachsigen Zylinderprojektion und der Transformation zwischen Koordinatensystemen',
              url:
                  'http://web.archive.org/web/20210511074533/https://www.swisstopo.admin.ch/content/swisstopo-internet/de/topics/survey/reference-systems/switzerland/_jcr_content/contentPar/tabs/items/dokumente_publikatio/tabPar/downloadlist/downloadItems/517_1459343190376.download/refsys_d.pdf'),
          ToolLicense(
              credit: 'Thomas \'moenk\' Mönkemeier\n(moenk.de)',
              licenseType: 'Use permission (geoclub.de, 2013)'),
        ]),
    GCWTool(
        tool: const FormatConverterW3W(),
        id: 'coords_formatconverter_w3w',
        iconPath: 'lib/tools/coords/_common/assets/icons/icon_w3w.png',
        categories: const [
          ToolCategory.COORDINATES
        ],
        searchKeys: const [
          'coordinates',
          'coordinates_formatconverter',
          'coordinates_w3w',
        ]),
    GCWTool(
        tool: const MapView(),
        autoScroll: false,
        suppressToolMargin: true,
        id: 'coords_openmap',
        iconPath: 'lib/tools/coords/_common/assets/icons/icon_free_map.png',
        categories: const [
          ToolCategory.COORDINATES
        ],
        searchKeys: const [
          'coordinates',
          'coordinates_mapview',
        ],
        licenses: [
          _toolLicenseFAA8260,
          ToolLicense(
              credit: 'Paul Kohut\n(GeoFormulas)',
              licenseType: 'Apache 2.0 License',
              url:
                  'https://github.com/S-Man42/GeoFormulas/tree/ac40eb5589883999f830908cd1db45c73e1e1267?tab=readme-ov-file#legal-stuff')
        ]),
    GCWTool(
        tool: const VariableCoordinateFormulas(),
        id: 'coords_variablecoordinate',
        iconPath:
            'lib/tools/coords/_common/assets/icons/icon_variable_coordinate.png',
        categories: const [
          ToolCategory.COORDINATES
        ],
        searchKeys: const [
          'coordinates',
          'formulasolver',
          'coordinates_variablecoordinateformulas',
        ]),
    GCWTool(
        tool: const DMMOffset(),
        id: 'coords_dmmoffset',
        iconPath: 'lib/tools/coords/_common/assets/icons/icon_dmm_offset.png',
        categories: const [
          ToolCategory.COORDINATES
        ],
        searchKeys: const [
          'coordinates',
          'coordinates_mapview',
        ]),
    GCWTool(
        tool: const CoordinateAveraging(),
        id: 'coords_averaging',
        iconPath:
            'lib/tools/coords/_common/assets/icons/icon_coordinate_measurement.png',
        categories: const [
          ToolCategory.COORDINATES
        ],
        searchKeys: const [
          'coordinates',
          'coordinates_coordinateaveraging',
        ],
        licenses: [
          ToolLicense(
              credit: 'David Vávra\n(GPS Averaging)',
              licenseType: 'Apache 2.0 License',
              url:
                  'https://github.com/S-Man42/GPS-Averaging/blob/260eb5464d6d1b969c3f30bce42c5cf7848aab93/LICENSE.md')
        ]),
    GCWTool(
        tool: const CenterTwoPoints(),
        id: 'coords_centertwopoints',
        iconPath:
            'lib/tools/coords/_common/assets/icons/icon_center_two_points.png',
        categories: const [
          ToolCategory.COORDINATES
        ],
        searchKeys: const [
          'coordinates',
          'coordinates_centertwopoints',
        ]),
    GCWTool(
        tool: const CentroidArithmeticMean(),
        id: 'coords_centroid',
        iconPath: 'lib/tools/coords/_common/assets/icons/icon_centroid.png',
        categories: const [
          ToolCategory.COORDINATES
        ],
        searchKeys: const [
          'coordinates',
          'coordinates_centroid',
          'coordinates_arithmeticmean',
        ],
        licenses: [
          _toolLicenseGeoMidpoint
        ]),
    GCWTool(
        tool: const CentroidCenterOfGravity(),
        id: 'coords_centroid_centerofgravity',
        iconPath: 'lib/tools/coords/_common/assets/icons/icon_centroid.png',
        categories: const [
          ToolCategory.COORDINATES
        ],
        searchKeys: const [
          'coordinates',
          'coordinates_centroid',
          'coordinates_centerofgravity',
        ],
        licenses: [
          _toolLicenseGeoMidpoint
        ]),
    GCWTool(
        tool: const CenterThreePoints(),
        id: 'coords_centerthreepoints',
        iconPath:
            'lib/tools/coords/_common/assets/icons/icon_center_three_points.png',
        categories: const [
          ToolCategory.COORDINATES
        ],
        searchKeys: const [
          'coordinates',
          'coordinates_centerthreepoints',
        ]),
    GCWTool(
        tool: const SegmentLine(),
        id: 'coords_segmentline',
        iconPath: 'lib/tools/coords/_common/assets/icons/icon_segment_line.png',
        categories: const [
          ToolCategory.COORDINATES
        ],
        searchKeys: const [
          'coordinates',
          'coordinates_segmentline',
        ]),
    GCWTool(
        tool: const SegmentBearings(),
        id: 'coords_segmentbearings',
        iconPath:
            'lib/tools/coords/_common/assets/icons/icon_segment_bearings.png',
        categories: const [
          ToolCategory.COORDINATES
        ],
        searchKeys: const [
          'coordinates',
          'coordinates_segmentbearing',
        ]),
    GCWTool(
        tool: const CrossBearing(),
        id: 'coords_crossbearing',
        iconPath:
            'lib/tools/coords/_common/assets/icons/icon_cross_bearing.png',
        categories: const [
          ToolCategory.COORDINATES
        ],
        searchKeys: const [
          'coordinates',
          'coordinates_crossbearing',
        ]),
    GCWTool(
        tool: const IntersectBearings(),
        id: 'coords_intersectbearings',
        iconPath:
            'lib/tools/coords/_common/assets/icons/icon_intersect_bearings.png',
        categories: const [
          ToolCategory.COORDINATES
        ],
        searchKeys: const [
          'coordinates',
          'coordinates_compassrose',
          'coordinates_intersectbearing',
        ],
        licenses: [
          _toolLicenseGeographicLib
        ]),
    GCWTool(
        tool: const IntersectFourPoints(),
        id: 'coords_intersectfourpoints',
        iconPath:
            'lib/tools/coords/_common/assets/icons/icon_intersect_four_points.png',
        categories: const [
          ToolCategory.COORDINATES
        ],
        searchKeys: const [
          'coordinates',
          'coordinates_intersectfourpoints',
        ],
        licenses: [
          _toolLicenseGeographicLib
        ]),
    GCWTool(
        tool: const IntersectGeodeticAndCircle(),
        id: 'coords_intersectbearingcircle',
        iconPath:
            'lib/tools/coords/_common/assets/icons/icon_intersect_bearing_and_circle.png',
        categories: const [
          ToolCategory.COORDINATES
        ],
        searchKeys: const [
          'coordinates',
          'coordinates_compassrose',
          'coordinates_intersectgeodeticandcircle',
        ],
        licenses: [
          _toolLicenseFAA8260,
          _toolLicenseMitre
        ]),
    GCWTool(
        tool: const IntersectTwoCircles(),
        id: 'coords_intersecttwocircles',
        iconPath:
            'lib/tools/coords/_common/assets/icons/icon_intersect_two_circles.png',
        categories: const [
          ToolCategory.COORDINATES
        ],
        searchKeys: const [
          'coordinates',
          'coordinates_intersecttwocircles',
        ],
        licenses: [
          _toolLicenseFAA8260,
          _toolLicenseMitre
        ]),
    GCWTool(
        tool: const IntersectThreeCircles(),
        id: 'coords_intersectthreecircles',
        iconPath:
            'lib/tools/coords/_common/assets/icons/icon_intersect_three_circles.png',
        categories: const [
          ToolCategory.COORDINATES
        ],
        searchKeys: const [
          'coordinates',
          'coordinates_intersectthreecircles',
        ],
        licenses: [
          _toolLicenseFAA8260,
          _toolLicenseMitre
        ]),
    GCWTool(
        tool: const Antipodes(),
        id: 'coords_antipodes',
        iconPath: 'lib/tools/coords/_common/assets/icons/icon_antipodes.png',
        categories: const [
          ToolCategory.COORDINATES
        ],
        searchKeys: const [
          'coordinates',
          'coordinates_antipodes',
        ]),
    GCWTool(
        tool: const Intersection(),
        id: 'coords_intersection',
        iconPath: 'lib/tools/coords/_common/assets/icons/icon_intersection.png',
        categories: const [
          ToolCategory.COORDINATES
        ],
        searchKeys: const [
          'coordinates',
          'coordinates_intersection',
        ]),
    GCWTool(
        tool: const Resection(),
        id: 'coords_resection',
        iconPath: 'lib/tools/coords/_common/assets/icons/icon_resection.png',
        categories: const [
          ToolCategory.COORDINATES
        ],
        searchKeys: const [
          'coordinates',
          'coordinates_resection',
        ]),
    GCWTool(
        tool: const EquilateralTriangle(),
        id: 'coords_equilateraltriangle',
        iconPath:
            'lib/tools/coords/_common/assets/icons/icon_equilateral_triangle.png',
        categories: const [
          ToolCategory.COORDINATES
        ],
        searchKeys: const [
          'coordinates',
          'coordinates_equilateraltriangle',
        ]),
    GCWTool(
        tool: const WaypointProjectionRhumbline(),
        id: 'coords_rhumbline_projection',
        iconPath:
            'lib/tools/coords/_common/assets/icons/icon_waypoint_projection.png',
        categories: const [
          ToolCategory.COORDINATES
        ],
        searchKeys: const [
          'coordinates',
          'coordinates_waypointprojection',
          'coordinates_rhumbline',
        ],
        licenses: [
          _toolLicenseGeographicLib
        ]),
    GCWTool(
        tool: const DistanceBearingRhumbline(),
        id: 'coords_rhumbline_distancebearing',
        iconPath:
            'lib/tools/coords/_common/assets/icons/icon_distance_and_bearing.png',
        categories: const [
          ToolCategory.COORDINATES
        ],
        searchKeys: const [
          'coordinates',
          'coordinates_distancebearing',
          'coordinates_rhumbline',
        ],
        licenses: [
          _toolLicenseGeographicLib
        ]),
    GCWTool(
        tool: const EllipsoidTransform(),
        id: 'coords_ellipsoidtransform',
        iconPath:
            'lib/tools/coords/_common/assets/icons/icon_ellipsoid_transform.png',
        categories: const [
          ToolCategory.COORDINATES
        ],
        searchKeys: const [
          'coordinates',
          'coordinates_ellipsoidtransform',
        ]),

    //Countries Selection ******************************************************************************************

    GCWTool(
        tool: CountriesCallingCodes(),
        id: 'countries_callingcode',
        searchKeys: const [
          'countries',
          'countries_callingcodes',
        ]),
    GCWTool(
        tool: CountriesIOCCodes(),
        id: 'countries_ioccode',
        searchKeys: const [
          'countries',
          'countries_ioccodes',
        ]),
    GCWTool(
        tool: CountriesISOCodes(),
        id: 'countries_isocode',
        searchKeys: const [
          'countries',
          'countries_isocodes',
        ]),
    GCWTool(
        tool: CountriesVehicleCodes(),
        id: 'countries_vehiclecode',
        searchKeys: const [
          'countries',
          'countries_vehiclecodes',
        ]),
    GCWTool(
        tool: CountriesEmbassyCodesGER(),
        id: 'countries_embassycodes_ger',
        searchKeys: const [
          'countries',
          'countries_embassycodes_ger',
        ]),
    GCWTool(
        tool: const CountriesFlags(),
        id: 'countries_flags',
        searchKeys: const [
          'countries',
          'symbol_flags',
          'countries_flags',
        ]),

    //CrossSumSelection *******************************************************************************************

    GCWTool(tool: const CrossSum(), id: 'crosssum_crosssum', searchKeys: const [
      'crosssums',
    ]),
    GCWTool(
        tool: const CrossSumRange(),
        id: 'crosssum_range',
        searchKeys: const [
          'crosssums',
          'crossumrange',
        ]),
    GCWTool(
        tool: const IteratedCrossSumRange(),
        id: 'crosssum_range_iterated',
        searchKeys: const [
          'crosssums',
          'iteratedcrosssumrange',
        ]),
    GCWTool(
        tool: const CrossSumRangeFrequency(),
        id: 'crosssum_range_frequency',
        searchKeys: const [
          'crosssums',
          'crossumrange',
          'iteratedcrossumrangefrequency',
        ]),
    GCWTool(
        tool: const IteratedCrossSumRangeFrequency(),
        id: 'crosssum_range_iterated_frequency',
        searchKeys: const [
          'crosssums',
          'crossumrange',
          'crosssumrangefrequency',
        ]),

    //DatesSelection **********************************************************************************************
    GCWTool(
        tool: const DayCalculator(),
        id: 'dates_daycalculator',
        searchKeys: const [
          'dates',
          'dates_daycalculator',
        ]),
    GCWTool(
        tool: const TimeCalculator(),
        id: 'dates_timecalculator',
        searchKeys: const [
          'dates',
          'dates_timecalculator',
        ]),
    GCWTool(tool: const Weekday(), id: 'dates_weekday', searchKeys: const [
      'dates',
      'dates_weekday',
    ]),
    GCWTool(
        tool: const CalendarWeek(),
        id: 'dates_calendarweek',
        searchKeys: const [
          'dates',
          'dates_calendarweek',
        ]),
    GCWTool(
        tool: const DayOfTheYear(),
        id: 'dates_day_of_the_year',
        searchKeys: const [
          'dates',
          'dates_day_of_the_year',
        ]),
    GCWTool(tool: const Calendar(), id: 'dates_calendar', searchKeys: const [
      'dates',
      'dates_calendar',
    ]),
    GCWTool(tool: const ExcelTime(), id: 'excel_time', searchKeys: const [
      'dates',
      'excel_time',
    ]),
    GCWTool(tool: const UnixTime(), id: 'unix_time', searchKeys: const [
      'dates',
      'unix_time',
    ]),

    //DNASelection ************************************************************************************************
    GCWTool(
        tool: const DNANucleicAcidSequence(),
        id: 'dna_nucleicacidsequence',
        searchKeys: const [
          'dna',
          'dnanucleicacidsequence',
        ]),
    GCWTool(
        tool: const DNAAminoAcids(),
        id: 'dna_aminoacids',
        searchKeys: const [
          'dna',
          'dnaaminoacids',
        ]),
    GCWTool(
        tool: const DNAAminoAcidsTable(),
        id: 'dna_aminoacids_table',
        searchKeys: const [
          'dna',
          'dnaamonoacidstable',
        ]),

    //E Selection *************************************************************************************************
    GCWTool(
        tool: const ENthDecimal(),
        id: 'irrationalnumbers_nthdecimal',
        id_prefix: 'e_',
        searchKeys: const [
          'enthdecimal',
        ]),
    GCWTool(
        tool: const EDecimalRange(),
        id: 'irrationalnumbers_decimalrange',
        id_prefix: 'e_',
        searchKeys: const [
          'edecimalrange',
        ]),
    GCWTool(
        tool: const ESearch(),
        id: 'irrationalnumbers_search',
        id_prefix: 'e_',
        searchKeys: const [
          'esearch',
        ]),

    //Easter Selection ***************************************************************************************
    GCWTool(
        tool: const EasterDate(),
        id: 'astronomy_easter_easterdate',
        searchKeys: const [
          'easter_date',
        ],
        licenses: [
          ToolLicense(
              credit: 'Jean Meeus',
              licenseType: 'Astronomical Algorithms, ISBN 978-0943396613')
        ]),
    GCWTool(
        tool: const EasterYears(),
        id: 'astronomy_easter_easteryears',
        searchKeys: const [
          'easter_date',
          'easter_years',
        ],
        licenses: [
          ToolLicense(
              credit: 'Jean Meeus',
              licenseType: 'Astronomical Algorithms, ISBN 978-0943396613')
        ]),

    //Esoteric Programming Language Selection ****************************************************************
    GCWTool(tool: const Beatnik(), id: 'beatnik', searchKeys: const [
      'esotericprogramminglanguage',
      'esoteric_beatnik',
    ]),
    GCWTool(
        tool: const Befunge(),
        id: 'befunge',
        isBeta: true,
        searchKeys: const [
          'esotericprogramminglanguage',
          'befunge',
        ]),
    GCWTool(tool: const Brainfk(), id: 'brainfk', searchKeys: const [
      'esotericprogramminglanguage',
      'esoteric_brainfk',
    ]),
    GCWTool(tool: const Cow(), id: 'cow', searchKeys: const [
      'esotericprogramminglanguage',
      'esoteric_cow',
    ]),
    GCWTool(tool: const Chef(), id: 'chef', searchKeys: const [
      'esotericprogramminglanguage',
      'esoteric_chef',
    ]),
    GCWTool(tool: const Deadfish(), id: 'deadfish', searchKeys: const [
      'esotericprogramminglanguage',
      'esoteric_deadfish',
    ]),
    GCWTool(tool: const Hohoho(), id: 'hohoho', searchKeys: const [
      'esotericprogramminglanguage',
      'esoteric_hohoho',
      'christmas'
    ]),
    GCWTool(tool: const KarolRobot(), id: 'karol_robot', searchKeys: const [
      'esoteric_karol_robot',
    ]),
    GCWTool(tool: const Malbolge(), id: 'malbolge', searchKeys: const [
      'esotericprogramminglanguage',
      'esoteric_malbolge',
    ]),
    GCWTool(tool: Ook(), id: 'ook', searchKeys: const [
      'esotericprogramminglanguage',
      'esoteric_brainfk',
      'esoteric_ook',
    ]),
    GCWTool(tool: const Piet(), id: 'piet', isBeta: true, searchKeys: const [
      'esotericprogramminglanguage',
      'esoteric_piet',
      'color',
      'images'
    ]),
    GCWTool(
        tool: const WhitespaceLanguage(),
        id: 'whitespace_language',
        searchKeys: const [
          'esotericprogramminglanguage',
          'esoteric_whitespacelanguage',
        ]),

    //Hash Selection *****************************************************************************************
    GCWTool(
        tool: const HashBreaker(),
        id: 'hashes_hashbreaker',
        categories: const [
          ToolCategory.GENERAL_CODEBREAKERS
        ],
        searchKeys: const [
          'codebreaker',
          'hashes',
          'hashbreaker',
        ],
        licenses: [
          _toolLicensePointyCastle
        ]),
    GCWTool(
        tool: const UrwigoHashBreaker(),
        id: 'urwigo_hashbreaker',
        searchKeys: const [
          'wherigo',
          'urwigo',
          'hashes',
          'hashbreaker',
        ]),
    GCWTool(
        tool: const HashOverview(),
        id: 'hashes_overview',
        searchKeys: const ['hashes', 'hashes_overview'],
        licenses: [_toolLicensePointyCastle]),

    GCWTool(
        tool: const HashIdentification(),
        id: 'hashes_identification',
        searchKeys: const ['hashes', 'hashes_identification'],
        licenses: [_toolLicensePointyCastle]),
    GCWTool(tool: const SHA1(), id: 'hashes_sha1', searchKeys: const [
      'hashes',
      'hashes_sha1',
    ], licenses: [
      _toolLicensePointyCastle
    ]),
    GCWTool(tool: const SHA1HMac(), id: 'hashes_sha1hmac', searchKeys: const [
      'hashes',
      'hashes_sha1',
      'hashes_hmac',
    ], licenses: [
      _toolLicensePointyCastle
    ]),
    GCWTool(tool: const SHA224(), id: 'hashes_sha224', searchKeys: const [
      'hashes',
      'hashes_sha2',
      'hashes_sha224',
    ], licenses: [
      _toolLicensePointyCastle
    ]),
    GCWTool(
        tool: const SHA224HMac(),
        id: 'hashes_sha224hmac',
        searchKeys: const [
          'hashes',
          'hashes_sha2',
          'hashes_sha224',
          'hashes_hmac',
        ],
        licenses: [
          _toolLicensePointyCastle
        ]),
    GCWTool(tool: const SHA256(), id: 'hashes_sha256', searchKeys: const [
      'hashes',
      'hashes_sha2',
      'hashes_sha256',
    ], licenses: [
      _toolLicensePointyCastle
    ]),
    GCWTool(
        tool: const SHA256HMac(),
        id: 'hashes_sha256hmac',
        searchKeys: const [
          'hashes',
          'hashes_sha2',
          'hashes_sha256',
          'hashes_hmac',
        ],
        licenses: [
          _toolLicensePointyCastle
        ]),
    GCWTool(tool: const SHA384(), id: 'hashes_sha384', searchKeys: const [
      'hashes',
      'hashes_sha2',
      'hashes_sha384',
    ], licenses: [
      _toolLicensePointyCastle
    ]),
    GCWTool(
        tool: const SHA384HMac(),
        id: 'hashes_sha384hmac',
        searchKeys: const [
          'hashes',
          'hashes_sha2',
          'hashes_sha384',
          'hashes_hmac',
        ],
        licenses: [
          _toolLicensePointyCastle
        ]),
    GCWTool(tool: const SHA512(), id: 'hashes_sha512', searchKeys: const [
      'hashes',
      'hashes_sha2',
      'hashes_sha512',
    ], licenses: [
      _toolLicensePointyCastle
    ]),
    GCWTool(
        tool: const SHA512HMac(),
        id: 'hashes_sha512hmac',
        searchKeys: const [
          'hashes',
          'hashes_sha2',
          'hashes_sha512',
          'hashes_hmac',
        ],
        licenses: [
          _toolLicensePointyCastle
        ]),
    GCWTool(
        tool: const SHA512_224(),
        id: 'hashes_sha512.224',
        searchKeys: const [
          'hashes',
          'hashes_sha2',
          'hashes_sha512_224',
        ],
        licenses: [
          _toolLicensePointyCastle
        ]),
    GCWTool(
        tool: const SHA512_224HMac(),
        id: 'hashes_sha512.224hmac',
        searchKeys: const [
          'hashes',
          'hashes_sha2',
          'hashes_sha512_224',
          'hashes_hmac',
        ],
        licenses: [
          _toolLicensePointyCastle
        ]),
    GCWTool(
        tool: const SHA512_256(),
        id: 'hashes_sha512.256',
        searchKeys: const [
          'hashes',
          'hashes_sha2',
          'hashes_sha512_256',
        ],
        licenses: [
          _toolLicensePointyCastle
        ]),
    GCWTool(
        tool: const SHA512_256HMac(),
        id: 'hashes_sha512.256hmac',
        searchKeys: const [
          'hashes',
          'hashes_sha2',
          'hashes_sha512_256',
          'hashes_hmac',
        ],
        licenses: [
          _toolLicensePointyCastle
        ]),
    GCWTool(tool: const SHA3_224(), id: 'hashes_sha3.224', searchKeys: const [
      'hashes',
      'hashes_sha3',
      'hashes_sha3_224',
    ], licenses: [
      _toolLicensePointyCastle
    ]),
    GCWTool(
        tool: const SHA3_224HMac(),
        id: 'hashes_sha3.224hmac',
        searchKeys: const [
          'hashes',
          'hashes_sha3',
          'hashes_sha3_224',
          'hashes_hmac',
        ],
        licenses: [
          _toolLicensePointyCastle
        ]),
    GCWTool(tool: const SHA3_256(), id: 'hashes_sha3.256', searchKeys: const [
      'hashes',
      'hashes_sha3',
      'hashes_sha3_256',
    ], licenses: [
      _toolLicensePointyCastle
    ]),
    GCWTool(
        tool: const SHA3_256HMac(),
        id: 'hashes_sha3.256hmac',
        searchKeys: const [
          'hashes',
          'hashes_sha3',
          'hashes_sha3_256',
          'hashes_hmac',
        ],
        licenses: [
          _toolLicensePointyCastle
        ]),
    GCWTool(tool: const SHA3_384(), id: 'hashes_sha3.384', searchKeys: const [
      'hashes',
      'hashes_sha3',
      'hashes_sha3_384',
    ], licenses: [
      _toolLicensePointyCastle
    ]),
    GCWTool(
        tool: const SHA3_384HMac(),
        id: 'hashes_sha3.384hmac',
        searchKeys: const [
          'hashes',
          'hashes_sha3',
          'hashes_sha3_384',
          'hashes_hmac',
        ],
        licenses: [
          _toolLicensePointyCastle
        ]),
    GCWTool(tool: const SHA3_512(), id: 'hashes_sha3.512', searchKeys: const [
      'hashes',
      'hashes_sha3',
      'hashes_sha3_512',
    ], licenses: [
      _toolLicensePointyCastle
    ]),
    GCWTool(
        tool: const SHA3_512HMac(),
        id: 'hashes_sha3.512hmac',
        searchKeys: const [
          'hashes',
          'hashes_sha3',
          'hashes_sha3_512',
          'hashes_hmac',
        ],
        licenses: [
          _toolLicensePointyCastle
        ]),
    GCWTool(
        tool: const Keccak_128(),
        id: 'hashes_keccak128',
        searchKeys: const [
          'hashes',
          'hashes_sha3',
          'hashes_keccak',
          'hashes_keccak_128',
        ],
        licenses: [
          _toolLicensePointyCastle
        ]),
    GCWTool(
        tool: const Keccak_224(),
        id: 'hashes_keccak224',
        searchKeys: const [
          'hashes',
          'hashes_sha3',
          'hashes_keccak',
          'hashes_keccak_224',
        ],
        licenses: [
          _toolLicensePointyCastle
        ]),
    GCWTool(
        tool: const Keccak_256(),
        id: 'hashes_keccak256',
        searchKeys: const [
          'hashes',
          'hashes_sha3',
          'hashes_keccak',
          'hashes_keccak_256',
        ],
        licenses: [
          _toolLicensePointyCastle
        ]),
    GCWTool(
        tool: const Keccak_288(),
        id: 'hashes_keccak288',
        searchKeys: const [
          'hashes',
          'hashes_sha3',
          'hashes_keccak',
          'hashes_keccak_288',
        ],
        licenses: [
          _toolLicensePointyCastle
        ]),
    GCWTool(
        tool: const Keccak_384(),
        id: 'hashes_keccak384',
        searchKeys: const [
          'hashes',
          'hashes_sha3',
          'hashes_keccak',
          'hashes_keccak_384',
        ],
        licenses: [
          _toolLicensePointyCastle
        ]),
    GCWTool(
        tool: const Keccak_512(),
        id: 'hashes_keccak512',
        searchKeys: const [
          'hashes',
          'hashes_sha3',
          'hashes_keccak',
          'hashes_keccak_512',
        ],
        licenses: [
          _toolLicensePointyCastle
        ]),
    GCWTool(
        tool: const RIPEMD_128(),
        id: 'hashes_ripemd128',
        searchKeys: const [
          'hashes',
          'hashes_ripemd',
          'hashes_ripemd_128',
        ],
        licenses: [
          _toolLicensePointyCastle
        ]),
    GCWTool(
        tool: const RIPEMD_128HMac(),
        id: 'hashes_ripemd128hmac',
        searchKeys: const [
          'hashes',
          'hashes_ripemd',
          'hashes_ripemd_128',
          'hashes_hmac',
        ],
        licenses: [
          _toolLicensePointyCastle
        ]),
    GCWTool(
        tool: const RIPEMD_160(),
        id: 'hashes_ripemd160',
        searchKeys: const [
          'hashes',
          'hashes_ripemd',
          'hashes_ripemd_160',
        ],
        licenses: [
          _toolLicensePointyCastle
        ]),
    GCWTool(
        tool: const RIPEMD_160HMac(),
        id: 'hashes_ripemd160hmac',
        searchKeys: const [
          'hashes',
          'hashes_ripemd',
          'hashes_ripemd_160',
          'hashes_hmac',
        ],
        licenses: [
          _toolLicensePointyCastle
        ]),
    GCWTool(
        tool: const RIPEMD_256(),
        id: 'hashes_ripemd256',
        searchKeys: const [
          'hashes',
          'hashes_ripemd',
          'hashes_ripemd_256',
        ],
        licenses: [
          _toolLicensePointyCastle
        ]),
    GCWTool(
        tool: const RIPEMD_256HMac(),
        id: 'hashes_ripemd256hmac',
        searchKeys: const [
          'hashes',
          'hashes_ripemd',
          'hashes_ripemd_256',
          'hashes_hmac',
        ],
        licenses: [
          _toolLicensePointyCastle
        ]),
    GCWTool(
        tool: const RIPEMD_320(),
        id: 'hashes_ripemd320',
        searchKeys: const [
          'hashes',
          'hashes_ripemd',
          'hashes_ripemd_320',
        ],
        licenses: [
          _toolLicensePointyCastle
        ]),
    GCWTool(
        tool: const RIPEMD_320HMac(),
        id: 'hashes_ripemd320hmac',
        searchKeys: const [
          'hashes',
          'hashes_ripemd',
          'hashes_ripemd_320',
          'hashes_hmac',
        ],
        licenses: [
          _toolLicensePointyCastle
        ]),
    GCWTool(tool: const MD2(), id: 'hashes_md2', searchKeys: const [
      'hashes',
      'hashes_md2',
    ], licenses: [
      _toolLicensePointyCastle
    ]),
    GCWTool(tool: const MD2HMac(), id: 'hashes_md2hmac', searchKeys: const [
      'hashes',
      'hashes_md2',
      'hashes_hmac',
    ], licenses: [
      _toolLicensePointyCastle
    ]),
    GCWTool(tool: const MD4(), id: 'hashes_md4', searchKeys: const [
      'hashes',
      'hashes_md4',
    ], licenses: [
      _toolLicensePointyCastle
    ]),
    GCWTool(tool: const MD4HMac(), id: 'hashes_md4hmac', searchKeys: const [
      'hashes',
      'hashes_md4',
      'hashes_hmac',
    ], licenses: [
      _toolLicensePointyCastle
    ]),
    GCWTool(tool: const MD5(), id: 'hashes_md5', searchKeys: const [
      'hashes',
      'hashes_md5',
    ], licenses: [
      _toolLicensePointyCastle
    ]),
    GCWTool(tool: const MD5HMac(), id: 'hashes_md5hmac', searchKeys: const [
      'hashes',
      'hashes_md5',
      'hashes_hmac',
    ], licenses: [
      _toolLicensePointyCastle
    ]),
    GCWTool(tool: const Tiger_192(), id: 'hashes_tiger192', searchKeys: const [
      'hashes',
      'hashes_tiger_192',
    ], licenses: [
      _toolLicensePointyCastle
    ]),
    GCWTool(
        tool: const Tiger_192HMac(),
        id: 'hashes_tiger192hmac',
        searchKeys: const [
          'hashes',
          'hashes_tiger_192',
          'hashes_hmac',
        ],
        licenses: [
          _toolLicensePointyCastle
        ]),
    GCWTool(
        tool: const Whirlpool_512(),
        id: 'hashes_whirlpool512',
        searchKeys: const [
          'hashes',
          'hashes_whirlpool_512',
        ],
        licenses: [
          _toolLicensePointyCastle
        ]),
    GCWTool(
        tool: const Whirlpool_512HMac(),
        id: 'hashes_whirlpool512hmac',
        searchKeys: const [
          'hashes',
          'hashes_whirlpool_512',
          'hashes_hmac',
        ],
        licenses: [
          _toolLicensePointyCastle
        ]),
    GCWTool(
        tool: const BLAKE2b_160(),
        id: 'hashes_blake2b160',
        searchKeys: const [
          'hashes',
          'hashes_blake2b',
          'hashes_blake2b_160',
        ],
        licenses: [
          _toolLicensePointyCastle
        ]),
    GCWTool(
        tool: const BLAKE2b_224(),
        id: 'hashes_blake2b224',
        searchKeys: const [
          'hashes',
          'hashes_blake2b',
          'hashes_blake2b_224',
        ],
        licenses: [
          _toolLicensePointyCastle
        ]),
    GCWTool(
        tool: const BLAKE2b_256(),
        id: 'hashes_blake2b256',
        searchKeys: const [
          'hashes',
          'hashes_blake2b',
          'hashes_blake2b_256',
        ],
        licenses: [
          _toolLicensePointyCastle
        ]),
    GCWTool(
        tool: const BLAKE2b_384(),
        id: 'hashes_blake2b384',
        searchKeys: const [
          'hashes',
          'hashes_blake2b',
          'hashes_blake2b_384',
        ],
        licenses: [
          _toolLicensePointyCastle
        ]),
    GCWTool(
        tool: const BLAKE2b_512(),
        id: 'hashes_blake2b512',
        searchKeys: const [
          'hashes',
          'hashes_blake2b',
          'hashes_blake2b_512',
        ],
        licenses: [
          _toolLicensePointyCastle
        ]),

    // IceCodeSelection *********************************************************************************************
    GCWTool(tool: const IceCodes(), id: 'icecodes', searchKeys: const [
      'icecodes',
    ]),

    //Language Games Selection *******************************************************************************
    GCWTool(
        tool: const ChickenLanguage(),
        id: 'chickenlanguage',
        searchKeys: const [
          'languagegames',
          'languagegames_chickenlanguage',
        ]),
    GCWTool(tool: const DuckSpeak(), id: 'duckspeak', searchKeys: const [
      'languagegames',
      'duckspeak',
    ]),
    GCWTool(tool: const PigLatin(), id: 'piglatin', searchKeys: const [
      'languagegames',
      'languagegames_piglatin',
    ]),
    GCWTool(
        tool: const RobberLanguage(),
        id: 'robberlanguage',
        searchKeys: const [
          'languagegames',
          'languagegames_robberlanguage',
        ]),
    GCWTool(
        tool: const SpoonLanguage(),
        id: 'spoonlanguage',
        searchKeys: const [
          'languagegames',
          'languagegames_spoonlanguage',
        ]),

    //Main Menu **********************************************************************************************
    GCWTool(
        tool: const GeneralSettings(),
        id: 'settings_general',
        searchKeys: const []),
    GCWTool(
        tool: const CoordinatesSettings(),
        id: 'settings_coordinates',
        searchKeys: const []),
    GCWTool(
        tool: const ToolSettings(), id: 'settings_tools', searchKeys: const []),
    GCWTool(
        tool: const SaveRestoreSettings(),
        id: 'settings_saverestore',
        searchKeys: const []),
    GCWTool(
        tool: const Changelog(),
        id: 'mainmenu_changelog',
        suppressHelpButton: true,
        searchKeys: const [
          'changelog',
        ]),
    GCWTool(
        tool: const Nightly(),
        id: 'mainmenu_nightly',
        suppressHelpButton: true,
        searchKeys: const [
          'nightly',
        ]),
    GCWTool(
        tool: const About(),
        id: 'mainmenu_about',
        suppressHelpButton: true,
        searchKeys: const [
          'about',
        ]),
    GCWTool(
        tool: const CallForContribution(),
        id: 'mainmenu_callforcontribution',
        suppressHelpButton: true,
        searchKeys: const [
          'callforcontribution',
        ]),
    GCWTool(
        tool: const Licenses(),
        id: 'licenses',
        suppressHelpButton: true,
        searchKeys: const [
          'licenses',
        ]),

    //MayaCalendar Selection **************************************************************************************
    GCWTool(tool: const MayaCalendar(), id: 'mayacalendar', searchKeys: const [
      'calendar',
      'maya_calendar',
    ]),

    //MayaNumbers Selection **************************************************************************************
    GCWTool(tool: const MayaNumbers(), id: 'mayanumbers', searchKeys: const [
      'mayanumbers',
    ]),

    //Morse Selection ****************************************************************
    GCWTool(tool: Morse(), id: 'morse', searchKeys: const [
      'morse',
    ]),

    //NumeralWordsSelection ****************************************************************************************
    GCWTool(
        tool: const NumeralWordsTextSearch(),
        id: 'numeralwords_textsearch',
        searchKeys: const [
          'numeralwords',
          'numeralwords_lang',
          'numeralwordstextsearch',
        ]),
    GCWTool(
        tool: const NumeralWordsLists(),
        id: 'numeralwords_lists',
        searchKeys: const [
          'numeralwords',
          'numeralwords_lang',
          'numeralwordslists',
        ]),
    GCWTool(
        tool: const NumeralWordsConverter(),
        id: 'numeralwords_converter',
        searchKeys: const [
          'numeralwords',
          'numeralwordsconverter',
        ]),
    GCWTool(
        tool: const NumeralWordsIdentifyLanguages(),
        id: 'numeralwords_identify_languages',
        searchKeys: const [
          'numeralwords',
          'numeralwords_identifylanguages',
        ]),

    //NumberSequenceSelection ****************************************************************************************
    GCWTool(
        tool: const NumberSequenceFactorialSelection(),
        id: 'numbersequence_factorial',
        searchKeys: const [
          'numbersequence',
          'numbersequence_factorialselection',
        ]),
    GCWTool(
        tool: const NumberSequenceFibonacciSelection(),
        id: 'numbersequence_fibonacci',
        searchKeys: const [
          'numbersequence',
          'numbersequence_fibonacciselection',
        ]),
    GCWTool(
        tool: const NumberSequenceMersenneSelection(),
        id: 'numbersequence_mersenne',
        searchKeys: const [
          'numbersequence',
          'numbersequence_mersenneselection',
        ]),
    GCWTool(
        tool: const NumberSequenceMersennePrimesSelection(),
        id: 'numbersequence_mersenneprimes',
        searchKeys: const [
          'numbersequence',
          'primes',
          'numbersequence_mersenneprimesselection',
        ]),
    GCWTool(
        tool: const NumberSequencePrimesSelection(),
        id: 'numbersequence_primes',
        searchKeys: const [
          'numbersequence',
          'primes',
        ]),
    GCWTool(
        tool: const NumberSequenceMersenneExponentsSelection(),
        id: 'numbersequence_mersenneexponents',
        searchKeys: const [
          'numbersequence',
          'numbersequence_mersenneexponentsselection',
        ]),
    GCWTool(
        tool: const NumberSequenceMersenneFermatSelection(),
        id: 'numbersequence_mersennefermat',
        searchKeys: const [
          'numbersequence',
          'numbersequence_mersennefermatselection',
        ]),
    GCWTool(
        tool: const NumberSequenceFermatSelection(),
        id: 'numbersequence_fermat',
        searchKeys: const [
          'numbersequence',
          'numbersequence_fermatselection',
        ]),
    GCWTool(
        tool: const NumberSequencePerfectNumbersSelection(),
        id: 'numbersequence_perfectnumbers',
        searchKeys: const [
          'numbersequence',
          'numbersequence_perfectnumbersselection',
        ]),
    GCWTool(
        tool: const NumberSequenceSuperPerfectNumbersSelection(),
        id: 'numbersequence_superperfectnumbers',
        searchKeys: const [
          'numbersequence',
          'numbersequence_superperfectnumbersselection',
        ]),
    GCWTool(
        tool: const NumberSequencePrimaryPseudoPerfectNumbersSelection(),
        id: 'numbersequence_primarypseudoperfectnumbers',
        searchKeys: const [
          'numbersequence',
          'numbersequence_primarypseudoperfectnumbersselection',
        ]),
    GCWTool(
        tool: const NumberSequenceWeirdNumbersSelection(),
        id: 'numbersequence_weirdnumbers',
        searchKeys: const [
          'numbersequence',
          'numbersequence_weirdnumbersselection',
        ]),
    GCWTool(
        tool: const NumberSequenceSublimeNumbersSelection(),
        id: 'numbersequence_sublimenumbers',
        searchKeys: const [
          'numbersequence',
          'numbersequence_sublimenumbersselection',
        ]),
    GCWTool(
        tool: const NumberSequencePermutablePrimesSelection(),
        id: 'numbersequence_permutableprimes',
        searchKeys: const [
          'numbersequence',
          'primes',
          'numbersequence_permutableprimesselection',
        ]),
    GCWTool(
        tool: const NumberSequenceLuckyNumbersSelection(),
        id: 'numbersequence_luckynumbers',
        searchKeys: const [
          'numbersequence',
          'numbersequence_luckynumbersselection',
        ]),
    GCWTool(
        tool: const NumberSequenceHappyNumbersSelection(),
        id: 'numbersequence_happynumbers',
        searchKeys: const [
          'numbersequence',
          'numbersequence_happynumbersselection',
        ]),
    GCWTool(
        tool: const NumberSequenceBellSelection(),
        id: 'numbersequence_bell',
        searchKeys: const [
          'numbersequence',
          'numbersequence_bellselection',
        ]),
    GCWTool(
        tool: const NumberSequencePellSelection(),
        id: 'numbersequence_pell',
        searchKeys: const [
          'numbersequence',
          'numbersequence_pellselection',
        ]),
    GCWTool(
        tool: const NumberSequenceLucasSelection(),
        id: 'numbersequence_lucas',
        searchKeys: const [
          'numbersequence',
          'numbersequence_lucasselection',
        ]),
    GCWTool(
        tool: const NumberSequencePellLucasSelection(),
        id: 'numbersequence_pelllucas',
        searchKeys: const [
          'numbersequence',
          'numbersequence_pelllucasselection',
        ]),
    GCWTool(
        tool: const NumberSequenceJacobsthalSelection(),
        id: 'numbersequence_jacobsthal',
        searchKeys: const [
          'numbersequence',
          'numbersequence_jacobsthalselection',
        ]),
    GCWTool(
        tool: const NumberSequenceJacobsthalLucasSelection(),
        id: 'numbersequence_jacobsthallucas',
        searchKeys: const [
          'numbersequence',
          'numbersequence_jacobsthallucasselection',
        ]),
    GCWTool(
        tool: const NumberSequenceJacobsthalOblongSelection(),
        id: 'numbersequence_jacobsthaloblong',
        searchKeys: const [
          'numbersequence',
          'numbersequence_jacobsthaloblongselection',
        ]),

    GCWTool(
        tool: const NumberSequenceCatalanSelection(),
        id: 'numbersequence_catalan',
        searchKeys: const [
          'numbersequence',
          'numbersequence_catalanselection',
        ]),
    GCWTool(
        tool: const NumberSequenceRecamanSelection(),
        id: 'numbersequence_recaman',
        searchKeys: const [
          'numbersequence',
          'numbersequence_recamanselection',
        ]),
    GCWTool(
        tool: const NumberSequenceLychrelSelection(),
        id: 'numbersequence_lychrel',
        searchKeys: const [
          'numbersequence',
          'numbersequence_lychrelselection',
        ]),

    GCWTool(
        tool: const NumberSequenceBusyBeaverSelection(),
        id: 'numbersequence_busy_beaver',
        searchKeys: const [
          'numbersequence',
          'numbersequence_busy_beavernumbersselection',
        ]),

    GCWTool(
        tool: const NumberSequenceCatalanSelection(),
        id: 'numbersequence_catalan',
        searchKeys: const [
          'numbersequence',
          'numbersequence_catalanselection',
        ]),
    GCWTool(
        tool: const NumberSequenceRecamanSelection(),
        id: 'numbersequence_recaman',
        searchKeys: const [
          'numbersequence',
          'numbersequence_recamanselection',
        ]),
    GCWTool(
        tool: const NumberSequenceLychrelSelection(),
        id: 'numbersequence_lychrel',
        searchKeys: const [
          'numbersequence',
          'numbersequence_lychrelselection',
        ]),
    GCWTool(
        tool: const NumberSequenceBusyBeaverSelection(),
        id: 'numbersequence_busy_beaver',
        searchKeys: const [
          'numbersequence',
          'numbersequence_busy_beavernumbersselection',
        ]),

    //NumberSequenceSelection BusyBeaver ****************************************************************************************
    GCWTool(
        tool: const NumberSequenceBusyBeaverNthNumber(),
        id: 'numbersequence_nth',
        id_prefix: 'busy_beaver_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequenceBusyBeaverRange(),
        id: 'numbersequence_range',
        id_prefix: 'busy_beaver_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequenceBusyBeaverCheckNumber(),
        id: 'numbersequence_check',
        id_prefix: 'busy_beaver_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequenceBusyBeaverDigits(),
        id: 'numbersequence_digits',
        id_prefix: 'busy_beaver_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequenceBusyBeaverContainsDigits(),
        id: 'numbersequence_containsdigits',
        id_prefix: 'busy_beaver_',
        searchKeys: const []),

    //NumberSequenceSelection Factorial ****************************************************************************************
    GCWTool(
        tool: const NumberSequenceFactorialNthNumber(),
        id: 'numbersequence_nth',
        id_prefix: 'factorial_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequenceFactorialRange(),
        id: 'numbersequence_range',
        id_prefix: 'factorial_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequenceFactorialCheckNumber(),
        id: 'numbersequence_check',
        id_prefix: 'factorial_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequenceFactorialDigits(),
        id: 'numbersequence_digits',
        id_prefix: 'factorial_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequenceFactorialContainsDigits(),
        id: 'numbersequence_containsdigits',
        id_prefix: 'factorial_',
        searchKeys: const []),

    //NumberSequenceSelection Mersenne-Fermat ****************************************************************************************
    GCWTool(
        tool: const NumberSequenceMersenneFermatNthNumber(),
        id: 'numbersequence_nth',
        id_prefix: 'mersenne-fermat_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequenceMersenneFermatRange(),
        id: 'numbersequence_range',
        id_prefix: 'mersenne-fermat_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequenceMersenneFermatCheckNumber(),
        id: 'numbersequence_check',
        id_prefix: 'mersenne-fermat_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequenceMersenneFermatDigits(),
        id: 'numbersequence_digits',
        id_prefix: 'mersenne-fermat_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequenceMersenneFermatContainsDigits(),
        id: 'numbersequence_containsdigits',
        id_prefix: 'mersenne-fermat_',
        searchKeys: const []),

    //NumberSequenceSelection Fermat ****************************************************************************************
    GCWTool(
        tool: const NumberSequenceFermatNthNumber(),
        id: 'numbersequence_nth',
        id_prefix: 'fermat_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequenceFermatRange(),
        id: 'numbersequence_range',
        id_prefix: 'fermat_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequenceFermatCheckNumber(),
        id: 'numbersequence_check',
        id_prefix: 'fermat_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequenceFermatDigits(),
        id: 'numbersequence_digits',
        id_prefix: 'fermat_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequenceFermatContainsDigits(),
        id: 'numbersequence_containsdigits',
        id_prefix: 'fermat_',
        searchKeys: const []),

    //NumberSequenceSelection Lucas ****************************************************************************************
    GCWTool(
        tool: const NumberSequenceLucasNthNumber(),
        id: 'numbersequence_nth',
        id_prefix: 'lucas_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequenceLucasRange(),
        id: 'numbersequence_range',
        id_prefix: 'lucas_',
        searchKeys: const [
          'numbersequence_lucasselection',
        ]),
    GCWTool(
        tool: const NumberSequenceLucasCheckNumber(),
        id: 'numbersequence_check',
        id_prefix: 'lucas_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequenceLucasDigits(),
        id: 'numbersequence_digits',
        id_prefix: 'lucas_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequenceLucasContainsDigits(),
        id: 'numbersequence_containsdigits',
        id_prefix: 'lucas_',
        searchKeys: const []),

    //NumberSequenceSelection Fibonacci ****************************************************************************************
    GCWTool(
        tool: const NumberSequenceFibonacciNthNumber(),
        id: 'numbersequence_nth',
        id_prefix: 'fibonacci_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequenceFibonacciRange(),
        id: 'numbersequence_range',
        id_prefix: 'fibonacci_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequenceFibonacciCheckNumber(),
        id: 'numbersequence_check',
        id_prefix: 'fibonacci_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequenceFibonacciDigits(),
        id: 'numbersequence_digits',
        id_prefix: 'fibonacci_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequenceFibonacciContainsDigits(),
        id: 'numbersequence_containsdigits',
        id_prefix: 'fibonacci_',
        searchKeys: const []),

    //NumberSequenceSelection Mersenne ****************************************************************************************
    GCWTool(
        tool: const NumberSequenceMersenneNthNumber(),
        id: 'numbersequence_nth',
        id_prefix: 'mersenne_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequenceMersenneRange(),
        id: 'numbersequence_range',
        id_prefix: 'mersenne_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequenceMersenneCheckNumber(),
        id: 'numbersequence_check',
        id_prefix: 'mersenne_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequenceMersenneDigits(),
        id: 'numbersequence_digits',
        id_prefix: 'mersenne_',
        searchKeys: const [
          'numbersequence_mersenneselection',
        ]),
    GCWTool(
        tool: const NumberSequenceMersenneContainsDigits(),
        id: 'numbersequence_containsdigits',
        id_prefix: 'mersenne_',
        searchKeys: const []),

    //NumberSequenceSelection Bell ****************************************************************************************
    GCWTool(
        tool: const NumberSequenceBellNthNumber(),
        id: 'numbersequence_nth',
        id_prefix: 'bell_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequenceBellRange(),
        id: 'numbersequence_range',
        id_prefix: 'bell_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequenceBellCheckNumber(),
        id: 'numbersequence_check',
        id_prefix: 'bell_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequenceBellDigits(),
        id: 'numbersequence_digits',
        id_prefix: 'bell_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequenceBellContainsDigits(),
        id: 'numbersequence_containsdigits',
        id_prefix: 'bell_',
        searchKeys: const []),

    //NumberSequenceSelection Pell ****************************************************************************************
    GCWTool(
        tool: const NumberSequencePellNthNumber(),
        id: 'numbersequence_nth',
        id_prefix: 'pell_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequencePellRange(),
        id: 'numbersequence_range',
        id_prefix: 'pell_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequencePellCheckNumber(),
        id: 'numbersequence_check',
        id_prefix: 'pell_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequencePellDigits(),
        id: 'numbersequence_digits',
        id_prefix: 'pell_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequencePellContainsDigits(),
        id: 'numbersequence_containsdigits',
        id_prefix: 'pell_',
        searchKeys: const []),

    //NumberSequenceSelection Pell-Lucas ****************************************************************************************
    GCWTool(
        tool: const NumberSequencePellLucasNthNumber(),
        id: 'numbersequence_nth',
        id_prefix: 'pell_lucas_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequencePellLucasRange(),
        id: 'numbersequence_range',
        id_prefix: 'pell_lucas_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequencePellLucasCheckNumber(),
        id: 'numbersequence_check',
        id_prefix: 'pell_lucas_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequencePellLucasDigits(),
        id: 'numbersequence_digits',
        id_prefix: 'pell_lucas_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequencePellLucasContainsDigits(),
        id: 'numbersequence_containsdigits',
        id_prefix: 'pell_lucas_',
        searchKeys: const []),

    //NumberSequenceSelection Jacobsthal ****************************************************************************************
    GCWTool(
        tool: const NumberSequenceJacobsthalNthNumber(),
        id: 'numbersequence_nth',
        id_prefix: 'jacobsthal_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequenceJacobsthalRange(),
        id: 'numbersequence_range',
        id_prefix: 'jacobsthal_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequenceJacobsthalCheckNumber(),
        id: 'numbersequence_check',
        id_prefix: 'jacobsthal_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequenceJacobsthalDigits(),
        id: 'numbersequence_digits',
        id_prefix: 'jacobsthal_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequenceJacobsthalContainsDigits(),
        id: 'numbersequence_containsdigits',
        id_prefix: 'jacobsthal_',
        searchKeys: const []),

    //NumberSequenceSelection Jacobsthal-Lucas ****************************************************************************************
    GCWTool(
        tool: const NumberSequenceJacobsthalLucasNthNumber(),
        id: 'numbersequence_nth',
        id_prefix: 'jacobsthal_lucas_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequenceJacobsthalLucasRange(),
        id: 'numbersequence_range',
        id_prefix: 'jacobsthal_lucas_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequenceJacobsthalLucasCheckNumber(),
        id: 'numbersequence_check',
        id_prefix: 'jacobsthal_lucas_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequenceJacobsthalLucasDigits(),
        id: 'numbersequence_digits',
        id_prefix: 'jacobsthal_lucas_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequenceJacobsthalLucasContainsDigits(),
        id: 'numbersequence_containsdigits',
        id_prefix: 'jacobsthal_lucas_',
        searchKeys: const []),

    //NumberSequenceSelection Jacobsthal Oblong ****************************************************************************************
    GCWTool(
        tool: const NumberSequenceJacobsthalOblongNthNumber(),
        id: 'numbersequence_nth',
        id_prefix: 'jacobsthal_oblong_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequenceJacobsthalOblongRange(),
        id: 'numbersequence_range',
        id_prefix: 'jacobsthal_oblong_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequenceJacobsthalOblongCheckNumber(),
        id: 'numbersequence_check',
        id_prefix: 'jacobsthal_oblong_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequenceJacobsthalOblongDigits(),
        id: 'numbersequence_digits',
        id_prefix: 'jacobsthal_oblong_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequenceJacobsthalOblongContainsDigits(),
        id: 'numbersequence_containsdigits',
        id_prefix: 'jacobsthal_oblong_',
        searchKeys: const []),

    //NumberSequenceSelection Catalan ****************************************************************************************
    GCWTool(
        tool: const NumberSequenceCatalanNthNumber(),
        id: 'numbersequence_nth',
        id_prefix: 'catalan_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequenceCatalanRange(),
        id: 'numbersequence_range',
        id_prefix: 'catalan_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequenceCatalanCheckNumber(),
        id: 'numbersequence_check',
        id_prefix: 'catalan_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequenceCatalanDigits(),
        id: 'numbersequence_digits',
        id_prefix: 'catalan_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequenceCatalanContainsDigits(),
        id: 'numbersequence_containsdigits',
        id_prefix: 'catalan_',
        searchKeys: const []),

    //NumberSequenceSelection Recaman ****************************************************************************************
    GCWTool(
        tool: const NumberSequenceRecamanNthNumber(),
        id: 'numbersequence_nth',
        id_prefix: 'recaman_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequenceRecamanRange(),
        id: 'numbersequence_range',
        id_prefix: 'recaman_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequenceRecamanCheckNumber(),
        id: 'numbersequence_check',
        id_prefix: 'recaman_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequenceRecamanDigits(),
        id: 'numbersequence_digits',
        id_prefix: 'recaman_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequenceRecamanContainsDigits(),
        id: 'numbersequence_containsdigits',
        id_prefix: 'recaman_',
        searchKeys: const []),

    //NumberSequenceSelection Mersenne Primes ****************************************************************************************
    GCWTool(
        tool: const NumberSequenceMersennePrimesNthNumber(),
        id: 'numbersequence_nth',
        id_prefix: 'mersenne_primes_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequenceMersennePrimesRange(),
        id: 'numbersequence_range',
        id_prefix: 'mersenne_primes_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequenceMersennePrimesCheckNumber(),
        id: 'numbersequence_check',
        id_prefix: 'mersenne_primes_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequenceMersennePrimesDigits(),
        id: 'numbersequence_digits',
        id_prefix: 'mersenne_primes_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequenceMersennePrimesContainsDigits(),
        id: 'numbersequence_containsdigits',
        id_prefix: 'mersenne_primes_',
        searchKeys: const []),

    //NumberSequenceSelection Mersenne Exponents ****************************************************************************************
    GCWTool(
        tool: const NumberSequenceMersenneExponentsNthNumber(),
        id: 'numbersequence_nth',
        id_prefix: 'mersenne_exponents_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequenceMersenneExponentsRange(),
        id: 'numbersequence_range',
        id_prefix: 'mersenne_exponents_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequenceMersenneExponentsCheckNumber(),
        id: 'numbersequence_check',
        id_prefix: 'mersenne_exponents_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequenceMersenneExponentsDigits(),
        id: 'numbersequence_digits',
        id_prefix: 'mersenne_exponents_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequenceMersenneExponentsContainsDigits(),
        id: 'numbersequence_containsdigits',
        id_prefix: 'mersenne_exponents_',
        searchKeys: const []),

    //NumberSequenceSelection Perfect numbers ****************************************************************************************
    GCWTool(
        tool: const NumberSequencePerfectNumbersNthNumber(),
        id: 'numbersequence_nth',
        id_prefix: 'perfect_numbers_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequencePerfectNumbersRange(),
        id: 'numbersequence_range',
        id_prefix: 'perfect_numbers_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequencePerfectNumbersCheckNumber(),
        id: 'numbersequence_check',
        id_prefix: 'perfect_numbers_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequencePerfectNumbersDigits(),
        id: 'numbersequence_digits',
        id_prefix: 'perfect_numbers_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequencePerfectNumbersContainsDigits(),
        id: 'numbersequence_containsdigits',
        id_prefix: 'perfect_numbers_',
        searchKeys: const []),

    //NumberSequenceSelection SuperPerfect numbers ****************************************************************************************
    GCWTool(
        tool: const NumberSequenceSuperPerfectNumbersNthNumber(),
        id: 'numbersequence_nth',
        id_prefix: 'superperfect_numbers_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequenceSuperPerfectNumbersRange(),
        id: 'numbersequence_range',
        id_prefix: 'superperfect_numbers_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequenceSuperPerfectNumbersCheckNumber(),
        id: 'numbersequence_check',
        id_prefix: 'superperfect_numbers_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequenceSuperPerfectNumbersDigits(),
        id: 'numbersequence_digits',
        id_prefix: 'superperfect_numbers_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequenceSuperPerfectNumbersContainsDigits(),
        id: 'numbersequence_containsdigits',
        id_prefix: 'superperfect_numbers_',
        searchKeys: const []),

    //NumberSequenceSelection Weird numbers ****************************************************************************************
    GCWTool(
        tool: const NumberSequenceWeirdNumbersNthNumber(),
        id: 'numbersequence_nth',
        id_prefix: 'weird_numbers_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequenceWeirdNumbersRange(),
        id: 'numbersequence_range',
        id_prefix: 'weird_numbers_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequenceWeirdNumbersCheckNumber(),
        id: 'numbersequence_check',
        id_prefix: 'weird_numbers_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequenceWeirdNumbersDigits(),
        id: 'numbersequence_digits',
        id_prefix: 'weird_numbers_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequenceWeirdNumbersContainsDigits(),
        id: 'numbersequence_containsdigits',
        id_prefix: 'weird_numbers_',
        searchKeys: const []),

    //NumberSequenceSelection Sublime numbers ****************************************************************************************
    GCWTool(
        tool: const NumberSequenceSublimeNumbersNthNumber(),
        id: 'numbersequence_nth',
        id_prefix: 'sublime_numbers_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequenceSublimeNumbersRange(),
        id: 'numbersequence_range',
        id_prefix: 'sublime_numbers_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequenceSublimeNumbersCheckNumber(),
        id: 'numbersequence_check',
        id_prefix: 'sublime_numbers_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequenceSublimeNumbersDigits(),
        id: 'numbersequence_digits',
        id_prefix: 'sublime_numbers_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequenceSublimeNumbersContainsDigits(),
        id: 'numbersequence_containsdigits',
        id_prefix: 'sublime_numbers_',
        searchKeys: const []),

    //NumberSequenceSelection Lucky numbers ****************************************************************************************
    GCWTool(
        tool: const NumberSequenceLuckyNumbersNthNumber(),
        id: 'numbersequence_nth',
        id_prefix: 'lucky_numbers_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequenceLuckyNumbersRange(),
        id: 'numbersequence_range',
        id_prefix: 'lucky_numbers_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequenceLuckyNumbersCheckNumber(),
        id: 'numbersequence_check',
        id_prefix: 'lucky_numbers_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequenceLuckyNumbersDigits(),
        id: 'numbersequence_digits',
        id_prefix: 'lucky_numbers_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequenceLuckyNumbersContainsDigits(),
        id: 'numbersequence_containsdigits',
        id_prefix: 'lucky_numbers_',
        searchKeys: const []),

    //NumberSequenceSelection Happy numbers ****************************************************************************************
    GCWTool(
        tool: const NumberSequenceHappyNumbersNthNumber(),
        id: 'numbersequence_nth',
        id_prefix: 'happy_numbers_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequenceHappyNumbersRange(),
        id: 'numbersequence_range',
        id_prefix: 'happy_numbers_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequenceHappyNumbersCheckNumber(),
        id: 'numbersequence_check',
        id_prefix: 'happy_numbers_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequenceHappyNumbersDigits(),
        id: 'numbersequence_digits',
        id_prefix: 'happy_numbers_',
        searchKeys: const []),

    GCWTool(
        tool: const NumberSequenceHappyNumbersContainsDigits(),
        id: 'numbersequence_containsdigits',
        id_prefix: 'happy_numbers_',
        searchKeys: const []),

    //NumberSequenceSelection PseudoPerfect numbers ****************************************************************************************
    GCWTool(
        tool: const NumberSequencePrimaryPseudoPerfectNumbersNthNumber(),
        id: 'numbersequence_nth',
        id_prefix: 'pseudoperfect_numbers_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequencePrimaryPseudoPerfectNumbersRange(),
        id: 'numbersequence_range',
        id_prefix: 'pseudoperfect_numbers_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequencePrimaryPseudoPerfectNumbersCheckNumber(),
        id: 'numbersequence_check',
        id_prefix: 'pseudoperfect_numbers_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequencePrimaryPseudoPerfectNumbersDigits(),
        id: 'numbersequence_digits',
        id_prefix: 'pseudoperfect_numbers_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequencePrimaryPseudoPerfectNumbersContainsDigits(),
        id: 'numbersequence_containsdigits',
        id_prefix: 'pseudoperfect_numbers_',
        searchKeys: const []),

    //NumberSequenceSelection Lychrel numbers ****************************************************************************************
    GCWTool(
        tool: const NumberSequenceLychrelNthNumber(),
        id: 'numbersequence_nth',
        id_prefix: 'lychrel_numbers_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequenceLychrelRange(),
        id: 'numbersequence_range',
        id_prefix: 'lychrel_numbers_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequenceLychrelCheckNumber(),
        id: 'numbersequence_check',
        id_prefix: 'lychrel_numbers_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequenceLychrelDigits(),
        id: 'numbersequence_digits',
        id_prefix: 'lychrel_numbers_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequenceLychrelContainsDigits(),
        id: 'numbersequence_containsdigits',
        id_prefix: 'lychrel_numbers_',
        searchKeys: const []),

    //NumberSequenceSelection Mersenne Primes ****************************************************************************************
    GCWTool(
        tool: const NumberSequencePermutablePrimesNthNumber(),
        id: 'numbersequence_nth',
        id_prefix: 'mersenne_primes_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequencePermutablePrimesRange(),
        id: 'numbersequence_range',
        id_prefix: 'mersenne_primes_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequencePermutablePrimesCheckNumber(),
        id: 'numbersequence_check',
        id_prefix: 'mersenne_primes_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequencePermutablePrimesDigits(),
        id: 'numbersequence_digits',
        id_prefix: 'mersenne_primes_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequencePermutablePrimesContainsDigits(),
        id: 'numbersequence_containsdigits',
        id_prefix: 'mersenne_primes_',
        searchKeys: const []),

    //NumberSequenceSelection  Primes ****************************************************************************************
    GCWTool(
        tool: const NumberSequencePrimesNthNumber(),
        id: 'numbersequence_nth',
        id_prefix: 'primes_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequencePrimesRange(),
        id: 'numbersequence_range',
        id_prefix: 'primes_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequencePrimesCheckNumber(),
        id: 'numbersequence_check',
        id_prefix: 'primes_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequencePrimesDigits(),
        id: 'numbersequence_digits',
        id_prefix: 'primes_',
        searchKeys: const []),
    GCWTool(
        tool: const NumberSequencePrimesContainsDigits(),
        id: 'numbersequence_containsdigits',
        id_prefix: 'primes_',
        searchKeys: const []),

    //PeriodicTableSelection ***************************************************************************************
    GCWTool(
        tool: const PeriodicTable(), id: 'periodictable', searchKeys: const []),
    GCWTool(
        tool: const PeriodicTableDataView(
          atomicNumber: 1,
        ),
        id: 'periodictable_dataview',
        searchKeys: const [
          'periodictabledataview',
        ]),
    GCWTool(
        tool: const AtomicNumbersToText(),
        id: 'atomicnumberstotext',
        searchKeys: const [
          'periodictable_atomicnumbers',
        ]),

    //Phi Selection **********************************************************************************************
    GCWTool(
        tool: const PhiNthDecimal(),
        id: 'irrationalnumbers_nthdecimal',
        id_prefix: 'phi_',
        searchKeys: const [
          'irrationalnumbers',
          'phidecimalrange',
        ]),
    GCWTool(
        tool: const PhiDecimalRange(),
        id: 'irrationalnumbers_decimalrange',
        id_prefix: 'phi_',
        searchKeys: const [
          'irrationalnumbers',
          'phidecimalrange',
        ]),
    GCWTool(
        tool: const PhiSearch(),
        id: 'irrationalnumbers_search',
        id_prefix: 'phi_',
        searchKeys: const [
          'irrationalnumbers',
          'phisearch',
        ]),

    //Pi Selection **********************************************************************************************
    GCWTool(
        tool: const PiNthDecimal(),
        id: 'irrationalnumbers_nthdecimal',
        id_prefix: 'pi_',
        searchKeys: const [
          'irrationalnumbers',
          'pinthdecimal',
        ]),
    GCWTool(
        tool: const PiDecimalRange(),
        id: 'irrationalnumbers_decimalrange',
        id_prefix: 'pi_',
        searchKeys: const [
          'irrationalnumbers',
          'pidecimalrange',
        ]),
    GCWTool(
        tool: const PiSearch(),
        id: 'irrationalnumbers_search',
        id_prefix: 'pi_',
        searchKeys: const [
          'irrationalnumbers',
          'pisearch',
        ]),

    //Predator Selection **************************************************************************************
    GCWTool(tool: const Predator(), id: 'predator', searchKeys: const [
      'predator',
    ]),

    //PrimesSelection **********************************************************************************************
    GCWTool(tool: const NthPrime(), id: 'primes_nthprime', searchKeys: const [
      'primes',
      'primes_nthprime',
    ]),
    GCWTool(tool: const IsPrime(), id: 'primes_isprime', searchKeys: const [
      'primes',
      'primes_isprime',
    ]),
    GCWTool(
        tool: const NearestPrime(),
        id: 'primes_nearestprime',
        searchKeys: const [
          'primes',
          'primes_nearestprime',
        ]),
    GCWTool(
        tool: const PrimeIndex(),
        id: 'primes_primeindex',
        searchKeys: const [
          'primes',
          'primes_primeindex',
        ]),
    GCWTool(
        tool: const IntegerFactorization(),
        id: 'primes_integerfactorization',
        searchKeys: const [
          'primes',
          'primes_integerfactorization',
        ]),

    //ResistorSelection **********************************************************************************************
    GCWTool(
        tool: const ResistorColorCodeCalculator(),
        id: 'resistor_colorcodecalculator',
        searchKeys: const [
          'resistor',
          'color',
          'resistor_colorcode',
        ]),
    GCWTool(
        tool: const ResistorEIA96(),
        id: 'resistor_eia96',
        searchKeys: const [
          'resistor',
          'resistoreia96',
        ]),

    //RomanNumbersSelection **********************************************************************************************
    GCWTool(
      tool: RomanNumbers(),
      id: 'romannumbers',
      searchKeys: const [
        'roman_numbers',
      ],
      deeplinkAlias: const ['roman'],
    ),
    GCWTool(tool: const Chronogram(), id: 'chronogram', searchKeys: const [
      'roman_numbers',
      'chronogram',
    ]),

    //RotationSelection **********************************************************************************************
    GCWTool(tool: Rot13(), id: 'rotation_rot13', searchKeys: const [
      'rotation',
      'rotation_rot13',
    ], deeplinkAlias: const [
      'rot13'
    ]),
    GCWTool(tool: Rot5(), id: 'rotation_rot5', searchKeys: const [
      'rotation',
      'rotation_rot5',
    ], deeplinkAlias: const [
      'rot5'
    ]),
    GCWTool(tool: Rot18(), id: 'rotation_rot18', searchKeys: const [
      'rotation',
      'rotation_rot18',
    ], deeplinkAlias: const [
      'rot18'
    ]),
    GCWTool(tool: Rot47(), id: 'rotation_rot47', searchKeys: const [
      'rotation',
      'rotation_rot47',
    ], deeplinkAlias: const [
      'rot47'
    ]),
    GCWTool(tool: const Rot123(), id: 'rotation_rot123', searchKeys: const [
      'rotation',
      'rotation_rot123',
    ]),
    GCWTool(tool: RotationGeneral(), id: 'rotation_general', searchKeys: const [
      'rotation',
    ], deeplinkAlias: const [
      'rotation',
      'rot',
      'rotx'
    ]),
    GCWTool(tool: RotationWeird(), id: 'rotation_weird', searchKeys: const [
      'rotation',
    ], deeplinkAlias: const [
      'rotationweird',
      'rotweird',
      'rot?'
    ]),

    // RSA *******************************************************************************************************
    GCWTool(tool: const RSA(), id: 'rsa_rsa', searchKeys: const [
      'rsa',
    ]),
    GCWTool(tool: const RSAEChecker(), id: 'rsa_e.checker', searchKeys: const [
      'rsa',
      'rsa_echecker',
    ]),
    GCWTool(tool: const RSADChecker(), id: 'rsa_d.checker', searchKeys: const [
      'rsa',
      'rsa_dchecker',
    ]),
    GCWTool(
        tool: const RSADCalculator(),
        id: 'rsa_d.calculator',
        searchKeys: const [
          'rsa',
          'rsa_dcalculator',
        ]),
    GCWTool(
        tool: const RSANCalculator(),
        id: 'rsa_n.calculator',
        searchKeys: const [
          'rsa',
          'rsa_ncalculator',
        ]),
    GCWTool(
        tool: const RSAPhiCalculator(),
        id: 'rsa_phi.calculator',
        searchKeys: const ['rsa']),
    GCWTool(
        tool: const RSAPrimesCalculator(),
        id: 'rsa_primes.calculator',
        searchKeys: const ['rsa', 'primes']),

    //Scrabble Selection *****************************************************************************************

    GCWTool(tool: const Scrabble(), id: 'scrabble', searchKeys: const [
      'games_scrabble',
    ], licenses: [
      ToolLicense(
          credit: 'en.wikipedia.org',
          licenseType: 'CC BY-SA 4.0',
          url:
              'https://en.wikipedia.org/w/index.php?title=Scrabble_letter_distributions&oldid=1231431837'),
      ToolLicense(
          credit: 'de.wikipedia.org',
          licenseType: 'CC BY-SA 4.0',
          url:
              'https://de.wikipedia.org/w/index.php?title=Scrabble&oldid=245686434'),
    ]),
    GCWTool(
        tool: const ScrabbleOverview(),
        id: 'scrabbleoverview',
        searchKeys: const [
          'games_scrabble',
        ],
        licenses: [
          ToolLicense(
              credit: 'en.wikipedia.org',
              licenseType: 'CC BY-SA 4.0',
              url:
                  'https://en.wikipedia.org/w/index.php?title=Scrabble_letter_distributions&oldid=1231431837'),
          ToolLicense(
              credit: 'de.wikipedia.org',
              licenseType: 'CC BY-SA 4.0',
              url:
                  'https://de.wikipedia.org/w/index.php?title=Scrabble&oldid=245686434'),
        ]),

    //Miscellaneous Selection *****************************************************************************************

    GCWTool(
        tool: const GCWizardScript(),
        id: 'gcwizard_script',
        isBeta: true,
        categories: const [
          ToolCategory.MISCELLANEOUS
        ],
        searchKeys: const [
          'gcwizard_script',
        ]),

    GCWTool(
        tool: const OpenAI(),
        id: 'openai',
        isBeta: true,
        categories: const [
          ToolCategory.MISCELLANEOUS
        ],
        searchKeys: const [
          'openai',
        ]),

    //Segments Display *******************************************************************************************
    GCWTool(
        tool: const SevenSegments(),
        id: 'segmentdisplay_7segments',
        iconPath:
            'lib/tools/science_and_technology/segment_display/7_segment_display/assets/icon_7segment_display.png',
        searchKeys: const [
          'segments',
          'segments_seven',
        ]),
    GCWTool(
        tool: const FourteenSegments(),
        id: 'segmentdisplay_14segments',
        iconPath:
            'lib/tools/science_and_technology/segment_display/14_segment_display/assets/icon_14segment_display.png',
        searchKeys: const [
          'segments',
          'segments_fourteen',
        ]),
    GCWTool(
        tool: const SixteenSegments(),
        id: 'segmentdisplay_16segments',
        iconPath:
            'lib/tools/science_and_technology/segment_display/16_segment_display/assets/icon_16segment_display.png',
        searchKeys: const [
          'segments',
          'segments_sixteen',
        ]),

    //Shadoks Selection ******************************************************************************************
    GCWTool(
        tool: const ShadoksNumbers(),
        id: 'shadoksnumbers',
        searchKeys: const [
          'shadoksnumbers',
        ]),

    //Silver Ratio Selection **********************************************************************************************
    GCWTool(
        tool: const SilverRatioNthDecimal(),
        id: 'irrationalnumbers_nthdecimal',
        id_prefix: 'silver_ration_',
        searchKeys: const [
          'silverratiodecimalrange',
        ]),
    GCWTool(
        tool: const SilverRatioDecimalRange(),
        id: 'irrationalnumbers_decimalrange',
        id_prefix: 'silver_ration_',
        searchKeys: const [
          'silverratiodecimalrange',
        ]),
    GCWTool(
        tool: const SilverRatioSearch(),
        id: 'irrationalnumbers_search',
        id_prefix: 'silver_ration_',
        searchKeys: const [
          'silverratiosearch',
        ]),

    // SlashAndPipeSelection *********************************************************************************************
    GCWTool(tool: const SlashAndPipe(), id: 'slash_and_pipe', searchKeys: const [
      'slash_and_pipe',
    ]),

    //SQRT 2 Selection **********************************************************************************************
    GCWTool(
        tool: const SQRT2NthDecimal(),
        id: 'irrationalnumbers_nthdecimal',
        id_prefix: 'sqrt_2_',
        searchKeys: const [
          '',
        ]),
    GCWTool(
        tool: const SQRT2DecimalRange(),
        id: 'irrationalnumbers_decimalrange',
        id_prefix: 'sqrt_2_',
        searchKeys: const [
          '',
        ]),
    GCWTool(
        tool: const SQRT2Search(),
        id: 'irrationalnumbers_search',
        id_prefix: 'sqrt_2_',
        searchKeys: const [
          '',
        ]),

    //SQRT 3 Selection **********************************************************************************************
    GCWTool(
        tool: const SQRT3NthDecimal(),
        id: 'irrationalnumbers_nthdecimal',
        id_prefix: 'sqrt_3_',
        searchKeys: const [
          '',
        ]),
    GCWTool(
        tool: const SQRT3DecimalRange(),
        id: 'irrationalnumbers_decimalrange',
        id_prefix: 'sqrt_3_',
        searchKeys: const [
          '',
        ]),
    GCWTool(
        tool: const SQRT3Search(),
        id: 'irrationalnumbers_search',
        id_prefix: 'sqrt_3_',
        searchKeys: const [
          '',
        ]),

    //SQRT 5 Selection **********************************************************************************************
    GCWTool(
        tool: const SQRT5NthDecimal(),
        id: 'irrationalnumbers_nthdecimal',
        id_prefix: 'sqrt_5_',
        searchKeys: const [
          '',
        ]),
    GCWTool(
        tool: const SQRT5DecimalRange(),
        id: 'irrationalnumbers_decimalrange',
        id_prefix: 'sqrt_5_',
        searchKeys: const [
          '',
        ]),
    GCWTool(
        tool: const SQRT5Search(),
        id: 'irrationalnumbers_search',
        id_prefix: 'sqrt_5_',
        searchKeys: const [
          '',
        ]),

    //Spelling Alphabets Selection **********************************************************************************************
    GCWTool(
        tool: const SpellingAlphabetsCrypt(),
        id: 'spelling_alphabets_crypt',
        searchKeys: const [
          'spelling_alphabets',
        ]),
    GCWTool(
        tool: const SpellingAlphabetsList(),
        id: 'spelling_alphabets_list',
        searchKeys: const [
          'spelling_alphabets',
        ]),

    //Symbol Tables **********************************************************************************************
    GCWTool(
        tool: const SymbolTableExamplesSelect(),
        autoScroll: false,
        id: 'symboltablesexamples',
        searchKeys: const [
          'symbol',
          'symboltablesexamples',
        ]),
    GCWTool(
      tool: const SymbolReplacer(),
      id: 'symbol_replacer',
      isBeta: true,
      searchKeys: const [
        'symbol_replacer',
      ],
      categories: const [ToolCategory.GENERAL_CODEBREAKERS],
    ),

    GCWSymbolTableTool(symbolKey: 'adlam', symbolSearchStrings: const [
      'symbol_adlam',
    ]),
    GCWSymbolTableTool(symbolKey: 'albhed', symbolSearchStrings: const [
      'symbol_albhed',
    ]),
    GCWSymbolTableTool(symbolKey: 'alchemy', symbolSearchStrings: const [
      'symbol_alchemy',
    ]),
    GCWSymbolTableTool(
        symbolKey: 'alchemy_alphabet',
        symbolSearchStrings: const [
          'symbol_alchemy_alphabet',
        ]),
    GCWSymbolTableTool(
        symbolKey: 'alien_mushrooms',
        symbolSearchStrings: const [
          'symbol_alien_mushrooms',
        ]),
    GCWSymbolTableTool(
        symbolKey: 'angerthas_cirth',
        symbolSearchStrings: const [
          'symbol_lordoftherings',
          'symbol_runes',
          'symbol_angerthas_cirth',
        ]),
    GCWSymbolTableTool(
        symbolKey: 'alphabetum_arabum',
        symbolSearchStrings: const [
          'symbol_alphabetum_arabum',
        ]),
    GCWSymbolTableTool(
        symbolKey: 'alphabetum_egiptiorum',
        symbolSearchStrings: const [
          'symbol_alphabetum_egiptiorum',
        ]),
    GCWSymbolTableTool(
        symbolKey: 'alphabetum_gothicum',
        symbolSearchStrings: const [
          'symbol_alphabetum_gothicum',
        ]),
    GCWSymbolTableTool(symbolKey: 'antiker', symbolSearchStrings: const [
      'symbol_antiker',
    ]),
    GCWSymbolTableTool(
        symbolKey: 'arabic_indian_numerals',
        symbolSearchStrings: const [
          'symbol_arabic_indian_numerals',
        ]),
    GCWSymbolTableTool(symbolKey: 'arcadian', symbolSearchStrings: const [
      'symbol_arcadian',
    ]),
    GCWSymbolTableTool(symbolKey: 'ath', symbolSearchStrings: const [
      'symbol_ath',
    ]),
    GCWSymbolTableTool(symbolKey: 'atlantean', symbolSearchStrings: const [
      'symbol_atlantean',
    ]),
    GCWSymbolTableTool(symbolKey: 'aurebesh', symbolSearchStrings: const [
      'symbol_aurebesh',
    ]),
    GCWSymbolTableTool(
        symbolKey: 'australian_sign_language',
        symbolSearchStrings: const [
          'symbol_signlanguage',
          'symbol_australian_sign_language',
        ]),
    GCWSymbolTableTool(
        symbolKey: 'babylonian_numerals',
        symbolSearchStrings: const [
          'babylonian_numerals',
        ]),
    GCWSymbolTableTool(symbolKey: 'ballet', symbolSearchStrings: const [
      'symbol_ballet',
    ]),
    GCWSymbolTableTool(symbolKey: 'barbier', symbolSearchStrings: const [
      'braille',
      'symbol_barbier',
    ]),
    GCWSymbolTableTool(symbolKey: 'barcode39', symbolSearchStrings: const [
      'barcodes',
      'barcode39',
    ]),
    GCWSymbolTableTool(symbolKey: 'base16_02', symbolSearchStrings: const [
      'symbol_base16_02',
    ]),
    GCWSymbolTableTool(
        symbolKey: 'base16', symbolSearchStrings: const ['base16']),
    GCWSymbolTableTool(symbolKey: 'baudot_1888', symbolSearchStrings: const [
      'ccitt',
      'symbol_baudot',
      'teletypewriter'
    ]),
    GCWSymbolTableTool(symbolKey: 'baudot_54123', symbolSearchStrings: const [
      'ccitt',
      'symbol_baudot',
      'teletypewriter'
    ]),
    GCWSymbolTableTool(
        symbolKey: 'bibibinary', symbolSearchStrings: const ['bibibinary']),
    GCWSymbolTableTool(
        symbolKey: 'birds_on_a_wire',
        symbolSearchStrings: const [
          'symbol_birds_on_a_wire',
        ]),
    GCWSymbolTableTool(symbolKey: 'blox', symbolSearchStrings: const [
      'symbol_blox',
    ]),
    GCWSymbolTableTool(symbolKey: 'blue_monday', symbolSearchStrings: const [
      'symbol_blue_monday',
    ]),
    GCWSymbolTableTool(
        symbolKey: 'brahmi_numerals',
        symbolSearchStrings: const [
          'symbol_brahmi_numerals',
        ]),
    GCWSymbolTableTool(symbolKey: 'braille_de', symbolSearchStrings: const [
      'braille',
    ]),
    GCWSymbolTableTool(symbolKey: 'braille_en', symbolSearchStrings: const [
      'braille',
    ]),
    GCWSymbolTableTool(symbolKey: 'braille_eu', symbolSearchStrings: const [
      'braille',
      'braille_euro',
    ]),
    GCWSymbolTableTool(symbolKey: 'braille_fr', symbolSearchStrings: const [
      'braille',
    ]),
    GCWSymbolTableTool(
        symbolKey: 'british_sign_language',
        symbolSearchStrings: const [
          'symbol_signlanguage',
          'symbol_british_sign_language',
        ]),
    GCWSymbolTableTool(
        symbolKey: 'chain_of_death_direction',
        symbolSearchStrings: const [
          'symbol_chain_of_death_direction',
        ]),
    GCWSymbolTableTool(
        symbolKey: 'chain_of_death_pairs',
        symbolSearchStrings: const [
          'symbol_chain_of_death_pairs',
        ]),
    GCWSymbolTableTool(symbolKey: 'chappe_1794', symbolSearchStrings: const [
      'telegraph',
      'symbol_chappe',
      'symbol_chappe_1794',
    ]),
    GCWSymbolTableTool(symbolKey: 'chappe_1809', symbolSearchStrings: const [
      'telegraph',
      'symbol_chappe',
      'symbol_chappe_1809',
      'zigzag'
    ]),
    GCWSymbolTableTool(symbolKey: 'chappe_v1', symbolSearchStrings: const [
      'telegraph',
      'symbol_chappe',
      'symbol_chappe_v1',
    ]),
    GCWSymbolTableTool(symbolKey: 'cherokee', symbolSearchStrings: const [
      'symbol_cherokee',
    ]),
    GCWSymbolTableTool(
        symbolKey: 'chinese_numerals',
        symbolSearchStrings: const [
          'symbol_chinese_numerals',
        ]),
    GCWSymbolTableTool(symbolKey: 'christmas', symbolSearchStrings: const [
      'christmas',
    ]),
    GCWSymbolTableTool(symbolKey: 'cirth_erebor', symbolSearchStrings: const [
      'symbol_runes',
      'symbol_lordoftherings',
      'symbol_cirtherebor',
    ]),
    GCWSymbolTableTool(symbolKey: 'cistercian', symbolSearchStrings: const [
      'cistercian',
    ]),
    GCWSymbolTableTool(symbolKey: 'clocks_1', symbolSearchStrings: const [
      'symbol_clocks',
    ]),
    GCWSymbolTableTool(symbolKey: 'clocks_2_1', symbolSearchStrings: const [
      'symbol_clocks',
    ]),
    GCWSymbolTableTool(symbolKey: 'clocks_2_2', symbolSearchStrings: const [
      'symbol_clocks',
    ]),
    GCWSymbolTableTool(symbolKey: 'clocks_3', symbolSearchStrings: const [
      'symbol_clocks',
    ]),
    GCWSymbolTableTool(symbolKey: 'color_add', symbolSearchStrings: const [
      'color',
      'symbol_color_add',
    ]),
    GCWSymbolTableTool(symbolKey: 'color_code', symbolSearchStrings: const [
      'color',
      'symbol_color_code',
    ]),
    GCWSymbolTableTool(symbolKey: 'color_honey', symbolSearchStrings: const [
      'color',
      'symbol_color_honey',
    ]),
    GCWSymbolTableTool(symbolKey: 'color_tokki', symbolSearchStrings: const [
      'color',
      'symbol_color_tokki',
    ]),
    GCWSymbolTableTool(
        symbolKey: 'cookewheatstone_1',
        symbolSearchStrings: const [
          'telegraph',
          'symbol_cookewheatstone',
          'symbol_cookewheatstone_1',
        ]),
    GCWSymbolTableTool(
        symbolKey: 'cookewheatstone_2',
        symbolSearchStrings: const [
          'telegraph',
          'symbol_cookewheatstone',
          'symbol_cookewheatstone_2',
        ]),
    GCWSymbolTableTool(
        symbolKey: 'cookewheatstone_5',
        symbolSearchStrings: const [
          'telegraph',
          'symbol_cookewheatstone',
          'symbol_cookewheatstone_5',
        ]),
    GCWSymbolTableTool(symbolKey: 'cosmic', symbolSearchStrings: const [
      'symbol_cosmic',
    ]),
    GCWSymbolTableTool(symbolKey: 'country_flags', symbolSearchStrings: const [
      'countries',
      'symbol_flags',
      'countries_flags',
    ]),
    GCWSymbolTableTool(symbolKey: 'covenant', symbolSearchStrings: const [
      'symbol_covenant',
    ]),
    GCWSymbolTableTool(symbolKey: 'crystal', symbolSearchStrings: const [
      'symbol_crystal',
    ]),
    GCWSymbolTableTool(symbolKey: 'cyrillic', symbolSearchStrings: const [
      'symbol_cyrillic',
    ]),
    GCWSymbolTableTool(
        symbolKey: 'cyrillic_numbers',
        symbolSearchStrings: const [
          'symbol_cyrillic_numbers',
        ]),
    GCWSymbolTableTool(symbolKey: 'daedric', symbolSearchStrings: const [
      'symbol_daedric',
    ]),
    GCWSymbolTableTool(symbolKey: 'dagger', symbolSearchStrings: const [
      'symbol_dagger',
    ]),
    GCWSymbolTableTool(symbolKey: 'dancing_men', symbolSearchStrings: const [
      'symbol_dancing_men',
    ]),
    GCWSymbolTableTool(symbolKey: 'deafblind', symbolSearchStrings: const [
      'symbol_signlanguage',
      'symbol_deafblind',
    ]),
    GCWSymbolTableTool(
        symbolKey: 'devanagari_numerals',
        symbolSearchStrings: const [
          'symbol_devanagari_numerals',
        ]),
    GCWSymbolTableTool(symbolKey: 'dinotopia', symbolSearchStrings: const [
      'symbol_dinotopia',
    ]),
    GCWSymbolTableTool(symbolKey: 'dni', symbolSearchStrings: const [
      'symbol_dni',
    ]),
    GCWSymbolTableTool(symbolKey: 'dni_colors', symbolSearchStrings: const [
      'color',
      'symbol_dni_colors',
    ]),
    GCWSymbolTableTool(symbolKey: 'dni_numbers', symbolSearchStrings: const [
      'symbol_dni_numbers',
    ]),
    GCWSymbolTableTool(symbolKey: 'doop_speak', symbolSearchStrings: const [
      'symbol_doop',
    ]),
    GCWSymbolTableTool(symbolKey: 'dorabella', symbolSearchStrings: const [
      'symbol_dorabella',
    ]),
    GCWSymbolTableTool(symbolKey: 'doremi', symbolSearchStrings: const [
      'symbol_doremi',
    ]),
    GCWSymbolTableTool(
        symbolKey: 'dragon_language',
        symbolSearchStrings: const [
          'symbol_dragon_language',
        ]),
    GCWSymbolTableTool(symbolKey: 'dragon_runes', symbolSearchStrings: const [
      'symbol_dragon_runes',
    ]),
    GCWSymbolTableTool(
        symbolKey: 'eastern_arabic_indian_numerals',
        symbolSearchStrings: const [
          'symbol_eastern_arabic_indian_numerals',
        ]),
    GCWSymbolTableTool(
        symbolKey: 'egyptian_numerals',
        symbolSearchStrings: const [
          'symbol_egyptian_numerals',
        ]),
    GCWSymbolTableTool(symbolKey: 'elia', symbolSearchStrings: const [
      'elia',
    ]),
    GCWSymbolTableTool(symbolKey: 'enochian', symbolSearchStrings: const [
      'symbol_enochian',
    ]),
    GCWSymbolTableTool(symbolKey: 'eternity_code', symbolSearchStrings: const [
      'symbol_eternity_code',
    ]),
    GCWSymbolTableTool(symbolKey: 'eurythmy', symbolSearchStrings: const [
      'symbol_eurythmy',
    ]),
    GCWSymbolTableTool(symbolKey: 'face_it', symbolSearchStrings: const [
      'symbol_face_it',
    ]),
    GCWSymbolTableTool(symbolKey: 'fakoo', symbolSearchStrings: const [
      'symbol_fakoo',
    ]),
    GCWSymbolTableTool(symbolKey: 'fantastic', symbolSearchStrings: const [
      'symbol_fantastic',
    ]),
    GCWSymbolTableTool(symbolKey: 'fez', symbolSearchStrings: const [
      'symbol_fez',
    ]),
    GCWSymbolTableTool(symbolKey: 'finger', symbolSearchStrings: const [
      'symbol_signlanguage',
      'symbol_finger',
    ]),
    GCWSymbolTableTool(symbolKey: 'finger_numbers', symbolSearchStrings: const [
      'symbol_signlanguage',
      'symbol_finger_numbers',
    ]),
    GCWSymbolTableTool(symbolKey: 'flags', symbolSearchStrings: const [
      'symbol_flags',
    ]),
    GCWSymbolTableTool(
        symbolKey: 'flags_german_kriegsmarine',
        symbolSearchStrings: const [
          'symbol_flags',
          'symbol_flags_german_kriegsmarine',
        ]),
    GCWSymbolTableTool(symbolKey: 'flags_nato', symbolSearchStrings: const [
      'symbol_flags',
      'symbol_flags_nato',
    ]),
    GCWSymbolTableTool(symbolKey: 'flags_rn_howe', symbolSearchStrings: const [
      'symbol_flags',
      'symbol_flags_rn_howe',
    ]),
    GCWSymbolTableTool(
        symbolKey: 'flags_rn_marryat',
        symbolSearchStrings: const [
          'symbol_flags',
          'symbol_flags_rn_marryat',
        ]),
    GCWSymbolTableTool(
        symbolKey: 'flags_rn_popham',
        symbolSearchStrings: const [
          'symbol_flags',
          'symbol_flags_rn_popham',
        ]),
    GCWSymbolTableTool(symbolKey: 'fonic', symbolSearchStrings: const [
      'symbol_fonic',
    ]),
    GCWSymbolTableTool(symbolKey: 'four_triangles', symbolSearchStrings: const [
      'symbol_four_triangles',
    ]),
    GCWSymbolTableTool(symbolKey: 'freemason', symbolSearchStrings: const [
      'symbol_freemason',
    ]),
    GCWSymbolTableTool(
        symbolKey: 'freemason_v2',
        symbolSearchStrings: const ['symbol_freemason']),
    GCWSymbolTableTool(
        symbolKey: 'futhark_elder',
        symbolSearchStrings: const ['symbol_runes', 'symbol_futhark']),
    GCWSymbolTableTool(
        symbolKey: 'futhark_younger',
        symbolSearchStrings: const ['symbol_runes', 'symbol_futhark']),
    GCWSymbolTableTool(symbolKey: 'futhorc', symbolSearchStrings: const [
      'symbol_runes',
      'symbol_futhark',
      'symbol_futhorc'
    ]),
    GCWSymbolTableTool(symbolKey: 'futurama', symbolSearchStrings: const [
      'symbol_futurama',
    ]),
    GCWSymbolTableTool(symbolKey: 'futurama_2', symbolSearchStrings: const [
      'symbol_futurama_2',
    ]),
    GCWSymbolTableTool(symbolKey: 'gallifreyan', symbolSearchStrings: const [
      'symbol_gallifreyan',
    ]),
    GCWSymbolTableTool(symbolKey: 'gargish', symbolSearchStrings: const [
      'symbol_gargish',
    ]),
    GCWSymbolTableTool(
        symbolKey: 'gc_attributes_ids',
        symbolSearchStrings: const [
          'symbol_gc_attributes',
        ]),
    GCWSymbolTableTool(
        symbolKey: 'gc_attributes_meaning',
        symbolSearchStrings: const [
          'symbol_gc_attributes',
        ]),
    GCWSymbolTableTool(symbolKey: 'geovlog', symbolSearchStrings: const [
      'symbol_geovlog',
    ]),
    GCWSymbolTableTool(symbolKey: 'gernreich', symbolSearchStrings: const [
      'symbol_gernreich',
    ]),
    GCWSymbolTableTool(symbolKey: 'gerudo', symbolSearchStrings: const [
      'zelda',
      'symbol_gerudo',
    ]),
    GCWSymbolTableTool(symbolKey: 'glagolitic', symbolSearchStrings: const [
      'symbol_gnommish',
    ]),
    GCWSymbolTableTool(symbolKey: 'gnommish', symbolSearchStrings: const []),
    GCWSymbolTableTool(symbolKey: 'greek_numerals', symbolSearchStrings: const [
      'symbol_greek_numerals',
    ]),
    GCWSymbolTableTool(symbolKey: 'hanja', symbolSearchStrings: const [
      'symbol_hanja',
      'symbol_sino_korean',
    ]),
    GCWSymbolTableTool(symbolKey: 'hangul_korean', symbolSearchStrings: const [
      'symbol_hangul',
    ]),
    GCWSymbolTableTool(
        symbolKey: 'hangul_sino_korean',
        symbolSearchStrings: const [
          'symbol_hangul',
          'symbol_sino_korean',
        ]),
    GCWSymbolTableTool(symbolKey: 'hazard', symbolSearchStrings: const [
      'symbol_hazard',
    ]),
    GCWSymbolTableTool(symbolKey: 'hebrew', symbolSearchStrings: const [
      'symbol_hebrew',
    ]),
    GCWSymbolTableTool(symbolKey: 'hebrew_v2', symbolSearchStrings: const [
      'symbol_hebrew_v2',
    ]),
    GCWSymbolTableTool(symbolKey: 'hexahue', symbolSearchStrings: const [
      'color',
      'symbol_hexahue',
    ]),
    GCWSymbolTableTool(
        symbolKey: 'hieratic_numerals',
        symbolSearchStrings: const [
          'symbol_hieratic_numerals',
        ]),
    GCWSymbolTableTool(symbolKey: 'hieroglyphs', symbolSearchStrings: const [
      'symbol_hieroglyphs',
    ]),
    GCWSymbolTableTool(symbolKey: 'hieroglyphs_v2', symbolSearchStrings: const [
      'symbol_hieroglyphs',
    ]),
    GCWSymbolTableTool(symbolKey: 'hobbit_runes', symbolSearchStrings: const [
      'symbol_lordoftherings',
      'symbol_runes',
      'symbol_hobbit_runes',
    ]),
    GCWSymbolTableTool(symbolKey: 'hvd', symbolSearchStrings: const [
      'symbol_hvd',
    ]),
    GCWSymbolTableTool(symbolKey: 'hylian_64', symbolSearchStrings: const [
      'zelda',
      'symbol_hylian_64',
    ]),
    GCWSymbolTableTool(
        symbolKey: 'hylian_albw_botw',
        symbolSearchStrings: const [
          'zelda',
          'symbol_hylian_albw_botw',
        ]),
    GCWSymbolTableTool(
        symbolKey: 'hylian_skyward_sword',
        symbolSearchStrings: const [
          'zelda',
          'symbol_hylian_skywardsword',
        ]),
    GCWSymbolTableTool(symbolKey: 'hylian_symbols', symbolSearchStrings: const [
      'zelda',
      'symbol_hylian_symbols',
    ]),
    GCWSymbolTableTool(
        symbolKey: 'hylian_twilight_princess_gcn',
        symbolSearchStrings: const [
          'zelda',
          'symbol_hylian_twilightprincess_gcn',
        ]),
    GCWSymbolTableTool(
        symbolKey: 'hylian_twilight_princess_wii',
        symbolSearchStrings: const [
          'zelda',
          'symbol_hylian_twilightprincess_wii',
        ]),
    GCWSymbolTableTool(
        symbolKey: 'hylian_wind_waker',
        symbolSearchStrings: const [
          'zelda',
          'symbol_hylian_windwaker',
        ]),
    GCWSymbolTableTool(symbolKey: 'hymmnos', symbolSearchStrings: const [
      'symbol_hymmnos',
    ]),
    GCWSymbolTableTool(symbolKey: 'ice_lolly_ding', symbolSearchStrings: const [
      'symbol_ice_lolly_ding',
    ]),
    GCWSymbolTableTool(symbolKey: 'icecodes', symbolSearchStrings: const [
      'icecodes',
    ]),
    GCWSymbolTableTool(symbolKey: 'iching', symbolSearchStrings: const [
      'symbol_iching',
    ]),
    GCWSymbolTableTool(symbolKey: 'illuminati_v1', symbolSearchStrings: const [
      'symbol_illuminati',
      'symbol_illuminati_v1',
    ]),
    GCWSymbolTableTool(symbolKey: 'illuminati_v2', symbolSearchStrings: const [
      'symbol_illuminati',
      'symbol_illuminati_v2',
    ]),
    GCWSymbolTableTool(symbolKey: 'intergalactic', symbolSearchStrings: const [
      'symbol_intergalactic',
    ]),
    GCWSymbolTableTool(symbolKey: 'interlac', symbolSearchStrings: const [
      'symbol_interlac',
    ]),
    GCWSymbolTableTool(symbolKey: 'iokharic', symbolSearchStrings: const [
      'symbol_iokharic',
    ]),
    GCWSymbolTableTool(
        symbolKey: 'iso7010_firesafety',
        symbolSearchStrings: const ['iso7010', 'iso7010_firesafety']),
    GCWSymbolTableTool(
        symbolKey: 'iso7010_mandatory',
        symbolSearchStrings: const ['iso7010', 'iso7010_mandatory']),
    GCWSymbolTableTool(
        symbolKey: 'iso7010_prohibition',
        symbolSearchStrings: const ['iso7010', 'iso7010_prohibition']),
    GCWSymbolTableTool(
        symbolKey: 'iso7010_safecondition',
        symbolSearchStrings: const ['iso7010', 'iso7010_safecondition']),
    GCWSymbolTableTool(
        symbolKey: 'iso7010_warning',
        symbolSearchStrings: const ['iso7010', 'iso7010_warning']),
    GCWSymbolTableTool(symbolKey: 'ita1_1926', symbolSearchStrings: const [
      'ccitt',
      'symbol_baudot',
      'teletypewriter'
    ]),
    GCWSymbolTableTool(symbolKey: 'ita1_1929', symbolSearchStrings: const [
      'ccitt',
      'symbol_baudot',
      'teletypewriter'
    ]),
    GCWSymbolTableTool(symbolKey: 'ita2_1929', symbolSearchStrings: const [
      'ccitt',
      'symbol_murray',
      'teletypewriter'
    ]),
    GCWSymbolTableTool(symbolKey: 'ita2_1931', symbolSearchStrings: const [
      'ccitt',
      'symbol_murray',
      'teletypewriter'
    ]),
    GCWSymbolTableTool(
        symbolKey: 'japanese_numerals',
        symbolSearchStrings: const [
          'japanese_numerals',
        ]),
    GCWSymbolTableTool(symbolKey: 'kabouter_abc', symbolSearchStrings: const [
      'symbol_kabouter_abc',
    ]),
    GCWSymbolTableTool(
        symbolKey: 'kabouter_abc_1947',
        symbolSearchStrings: const [
          'symbol_kabouter_abc_1947',
        ]),
    GCWSymbolTableTool(symbolKey: 'kartrak', symbolSearchStrings: const [
      'color',
      'barcodes',
      'railways',
      'symbol_kartrak',
    ]),
    GCWSymbolTableTool(
        symbolKey: 'kaktovik',
        symbolSearchStrings: const ['symbol_kaktovik', 'zigzag']),
    GCWSymbolTableTool(symbolKey: 'kharoshthi', symbolSearchStrings: const [
      'symbol_kharoshthi',
    ]),
    GCWSymbolTableTool(symbolKey: 'klingon', symbolSearchStrings: const [
      'symbol_klingon',
    ]),
    GCWSymbolTableTool(
        symbolKey: 'klingon_klinzhai',
        symbolSearchStrings: const [
          'symbol_klingon',
          'symbol_klingon_klinzhai',
        ]),
    GCWSymbolTableTool(symbolKey: 'krempel', symbolSearchStrings: const [
      'color',
      'symbol_krempel',
    ]),
    GCWSymbolTableTool(symbolKey: 'krypton', symbolSearchStrings: const [
      'symbol_krypton',
    ]),
    GCWSymbolTableTool(symbolKey: 'kurrent', symbolSearchStrings: const [
      'symbol_kurrent',
    ]),
    GCWSymbolTableTool(symbolKey: 'la_buse', symbolSearchStrings: const [
      'symbol_freemason',
      'symbol_la_buse',
    ]),
    GCWSymbolTableTool(symbolKey: 'linear_b', symbolSearchStrings: const [
      'symbol_linear_b',
    ]),
    GCWSymbolTableTool(symbolKey: 'lorm', symbolSearchStrings: const [
      'symbol_signlanguage',
      'symbol_lorm',
    ]),
    GCWSymbolTableTool(symbolKey: 'magicode', symbolSearchStrings: const [
      'symbol_magicode',
    ]),
    GCWSymbolTableTool(symbolKey: 'malachim', symbolSearchStrings: const [
      'symbol_malachim',
    ]),
    GCWSymbolTableTool(symbolKey: 'mandalorian', symbolSearchStrings: const [
      'symbol_mandalorian',
    ]),
    GCWSymbolTableTool(symbolKey: 'marain', symbolSearchStrings: const [
      'symbol_marain',
    ]),
    GCWSymbolTableTool(symbolKey: 'marain_v2', symbolSearchStrings: const [
      'symbol_marain_v2',
    ]),
    GCWSymbolTableTool(symbolKey: 'matoran', symbolSearchStrings: const [
      'symbol_matoran',
    ]),
    GCWSymbolTableTool(
        symbolKey: 'maya_calendar_longcount',
        symbolSearchStrings: const [
          'calendar',
          'symbol_maya_calendar_longcount',
        ]),
    GCWSymbolTableTool(
        symbolKey: 'maya_calendar_haab_codices',
        symbolSearchStrings: const [
          'calendar',
          'symbol_maya_calendar_haab',
        ]),
    GCWSymbolTableTool(
        symbolKey: 'maya_calendar_haab_inscripts',
        symbolSearchStrings: const [
          'calendar',
          'symbol_maya_calendar_haab',
        ]),
    GCWSymbolTableTool(
        symbolKey: 'maya_calendar_tzolkin_codices',
        symbolSearchStrings: const [
          'calendar',
          'symbol_maya_calendar_tzolkin',
        ]),
    GCWSymbolTableTool(
        symbolKey: 'maya_calendar_tzolkin_inscripts',
        symbolSearchStrings: const [
          'calendar',
          'symbol_maya_calendar_tzolkin',
        ]),
    GCWSymbolTableTool(
        symbolKey: 'maya_numbers_glyphs',
        symbolSearchStrings: const [
          'mayanumbers',
        ]),
    GCWSymbolTableTool(symbolKey: 'maya_numerals', symbolSearchStrings: const [
      'mayanumbers',
      'symbol_maya_number_glyphys',
    ]),
    GCWSymbolTableTool(symbolKey: 'maze', symbolSearchStrings: const [
      'symbol_maze',
    ]),
    GCWSymbolTableTool(
        symbolKey: 'medieval_runes',
        symbolSearchStrings: const ['symbol_runes', 'symbol_futhark']),
    GCWSymbolTableTool(symbolKey: 'minimoys', symbolSearchStrings: const [
      'symbol_minimoys',
    ]),
    GCWSymbolTableTool(symbolKey: 'moon', symbolSearchStrings: const [
      'symbol_moon',
    ]),
    GCWSymbolTableTool(symbolKey: 'moon_phases', symbolSearchStrings: const [
      'symbol_moon_phases',
    ]),
    GCWSymbolTableTool(symbolKey: 'morse', symbolSearchStrings: const [
      'morse',
    ]),
    GCWSymbolTableTool(symbolKey: 'morse_gerke', symbolSearchStrings: const [
      'morse',
    ]),
    GCWSymbolTableTool(
        symbolKey: 'morse_1838_patent',
        symbolSearchStrings: const [
          'morse',
        ]),
    GCWSymbolTableTool(
        symbolKey: 'morse_1844_vail',
        symbolSearchStrings: const [
          'morse',
        ]),
    GCWSymbolTableTool(
        symbolKey: 'morse_steinheil',
        symbolSearchStrings: const [
          'morse',
        ]),
    GCWSymbolTableTool(symbolKey: 'murray', symbolSearchStrings: const [
      'symbol_murray',
    ]),
    GCWSymbolTableTool(symbolKey: 'murraybaudot', symbolSearchStrings: const [
      'ccitt',
      'symbol_murraybaudot',
      'teletypewriter'
    ]),
    GCWSymbolTableTool(symbolKey: 'musica', symbolSearchStrings: const [
      'music_notes',
      'symbol_musica',
    ]),
    GCWSymbolTableTool(symbolKey: 'nazcaan', symbolSearchStrings: const [
      'symbol_nazcaan',
    ]),
    GCWSymbolTableTool(
        symbolKey: 'new_zealand_sign_language',
        symbolSearchStrings: const [
          'symbol_signlanguage',
          'symbol_new_zealand_sign_language',
        ]),
    GCWSymbolTableTool(symbolKey: 'niessen', symbolSearchStrings: const [
      'symbol_signlanguage',
      'symbol_niessen',
    ]),
    GCWSymbolTableTool(symbolKey: 'ninjargon', symbolSearchStrings: const [
      'symbol_ninjargon',
    ]),
    GCWSymbolTableTool(symbolKey: 'notes_doremi', symbolSearchStrings: const [
      'music',
      'music_notes',
      'symbol_notes_doremi',
    ]),
    GCWSymbolTableTool(
        symbolKey: 'notes_names_altoclef',
        symbolSearchStrings: const [
          'music',
          'music_notes',
          'symbol_notes_names_altoclef',
        ]),
    GCWSymbolTableTool(
        symbolKey: 'notes_names_bassclef',
        symbolSearchStrings: const [
          'music',
          'music_notes',
          'symbol_notes_names_bassclef',
        ]),
    GCWSymbolTableTool(
        symbolKey: 'notes_names_trebleclef',
        symbolSearchStrings: const [
          'music',
          'music_notes',
          'symbol_notes_names_trebleclef',
        ]),
    GCWSymbolTableTool(
        symbolKey: 'notes_notevalues',
        symbolSearchStrings: const [
          'music',
          'music_notes',
          'symbol_notes_notevalues',
        ]),
    GCWSymbolTableTool(
        symbolKey: 'notes_restvalues',
        symbolSearchStrings: const [
          'music',
          'music_notes',
          'symbol_notes_restvalues',
        ]),
    GCWSymbolTableTool(symbolKey: 'nyctography', symbolSearchStrings: const [
      'symbol_nyctography',
    ]),
    GCWSymbolTableTool(
        symbolKey: 'oak_island_money_pit',
        symbolSearchStrings: const [
          'symbol_oak_island_money_pit',
          'oak_island'
        ]),
    GCWSymbolTableTool(
        symbolKey: 'oak_island_money_pit_extended',
        symbolSearchStrings: const [
          'symbol_oak_island_money_extended',
          'oak_island'
        ]),
    GCWSymbolTableTool(
        symbolKey: 'oak_island_money_pit_libyan',
        symbolSearchStrings: const [
          'symbol_oak_island_money_pit_libyan',
          'oak_island'
        ]),
    GCWSymbolTableTool(symbolKey: 'ogham', symbolSearchStrings: const [
      'symbol_ogham',
    ]),
    GCWSymbolTableTool(
        symbolKey: 'optical_fiber_fotag',
        symbolSearchStrings: const [
          'color',
          'symbol_opticalfiber',
          'symbol_optical_fiber_fotag',
        ]),
    GCWSymbolTableTool(
        symbolKey: 'optical_fiber_iec60304',
        symbolSearchStrings: const [
          'color',
          'symbol_opticalfiber',
          'symbol_optical_fiber_iec60304',
        ]),
    GCWSymbolTableTool(
        symbolKey: 'optical_fiber_swisscom',
        symbolSearchStrings: const [
          'color',
          'symbol_opticalfiber',
          'optical_fiber_swisscom',
        ]),
    GCWSymbolTableTool(
        symbolKey: 'phoenician',
        symbolSearchStrings: const ['symbol_phoenician', 'zigzag']),
    GCWSymbolTableTool(symbolKey: 'pipeline', symbolSearchStrings: const [
      'symbol_pipeline',
    ]),
    GCWSymbolTableTool(
        symbolKey: 'pipeline_din2403',
        symbolSearchStrings: const [
          'color',
          'symbol_pipeline_din2403',
        ]),
    GCWSymbolTableTool(symbolKey: 'pixel', symbolSearchStrings: const [
      'symbol_pixel',
    ]),
    GCWSymbolTableTool(symbolKey: 'planet', symbolSearchStrings: const [
      'barcodes',
      'symbol_planet',
    ]),
    GCWSymbolTableTool(symbolKey: 'planets', symbolSearchStrings: const [
      'symbol_planets',
    ]),
    GCWSymbolTableTool(symbolKey: 'pleiadian', symbolSearchStrings: const [
      'symbol_pleiadian',
    ]),
    GCWSymbolTableTool(symbolKey: 'pokemon_unown', symbolSearchStrings: const [
      'pokemon',
      'symbol_pokemon_unown',
    ]),
    GCWSymbolTableTool(symbolKey: 'postcode_01247', symbolSearchStrings: const [
      'barcodes',
      'symbol_postcode01247',
    ]),
    GCWSymbolTableTool(symbolKey: 'postcode_8421', symbolSearchStrings: const [
      'barcodes',
      'symbol_postcode8421',
    ]),
    GCWSymbolTableTool(symbolKey: 'postnet', symbolSearchStrings: const [
      'barcodes',
      'symbol_postnet',
    ]),
    GCWSymbolTableTool(symbolKey: 'predator', symbolSearchStrings: const [
      'predator',
    ]),
    GCWSymbolTableTool(symbolKey: 'prosyl', symbolSearchStrings: const [
      'symbol_prosyl',
    ]),
    GCWSymbolTableTool(symbolKey: 'puzzle', symbolSearchStrings: const [
      'symbol_puzzle',
    ]),
    GCWSymbolTableTool(symbolKey: 'puzzle_2', symbolSearchStrings: const [
      'symbol_puzzle',
    ]),
    GCWSymbolTableTool(
        symbolKey: 'prussian_colors_artillery',
        symbolSearchStrings: const [
          'symbol_prussian_colors_artillery',
        ]),
    GCWSymbolTableTool(
        symbolKey: 'prussian_colors_infantery',
        symbolSearchStrings: const [
          'symbol_prussian_colors_infantery',
        ]),
    GCWSymbolTableTool(symbolKey: 'quadoo', symbolSearchStrings: const [
      'symbol_quadoo',
    ]),
    GCWSymbolTableTool(symbolKey: 'ravkan', symbolSearchStrings: const [
      'symbol_ravkan',
    ]),
    GCWSymbolTableTool(
        symbolKey: 'ravkan_extended',
        symbolSearchStrings: const [
          'symbol_ravkan_extended',
        ]),
    GCWSymbolTableTool(symbolKey: 'reality', symbolSearchStrings: const [
      'symbol_reality',
    ]),
    GCWSymbolTableTool(symbolKey: 'red_herring', symbolSearchStrings: const [
      'symbol_red_herring',
    ]),
    GCWSymbolTableTool(symbolKey: 'resistor', symbolSearchStrings: const [
      'color',
      'resistor_colorcode',
    ]),
    GCWSymbolTableTool(symbolKey: 'rhesus_a', symbolSearchStrings: const [
      'symbol_rhesus',
    ]),
    GCWSymbolTableTool(symbolKey: 'rhesus_b', symbolSearchStrings: const [
      'symbol_rhesus',
    ]),
    GCWSymbolTableTool(symbolKey: 'rhesus_c1', symbolSearchStrings: const [
      'symbol_rhesus',
    ]),
    GCWSymbolTableTool(symbolKey: 'rhesus_c2', symbolSearchStrings: const [
      'symbol_rhesus',
    ]),
    GCWSymbolTableTool(symbolKey: 'rm4scc', symbolSearchStrings: const [
      'barcodes',
      'symbol_rm4scc',
    ]),
    GCWSymbolTableTool(symbolKey: 'robots', symbolSearchStrings: const [
      'symbol_robots',
    ]),
    GCWSymbolTableTool(symbolKey: 'romulan', symbolSearchStrings: const [
      'symbol_romulan',
    ]),
    GCWSymbolTableTool(symbolKey: 'sanluca', symbolSearchStrings: const [
      'symbol_sanluca',
    ]),
    GCWSymbolTableTool(symbolKey: 'sarati', symbolSearchStrings: const [
      'symbol_sarati',
    ]),
    GCWSymbolTableTool(symbolKey: 'semaphore', symbolSearchStrings: const [
      'symbol_semaphore',
    ]),
    GCWSymbolTableTool(symbolKey: 'shadoks', symbolSearchStrings: const [
      'shadoksnumbers',
    ]),
    GCWSymbolTableTool(symbolKey: 'sheikah', symbolSearchStrings: const [
      'zelda',
      'symbol_sheikah',
    ]),
    GCWSymbolTableTool(symbolKey: 'shoes', symbolSearchStrings: const [
      'symbol_shoes',
    ]),
    GCWSymbolTableTool(
        symbolKey: 'siemens',
        symbolSearchStrings: const ['symbol_siemens', 'teletypewriter']),
    GCWSymbolTableTool(
        symbolKey: 'sign', symbolSearchStrings: const ['symbol_signlanguage']),
    GCWSymbolTableTool(
        symbolKey: 'sith', symbolSearchStrings: const ['symbol_sith']),
    GCWSymbolTableTool(symbolKey: 'skullz', symbolSearchStrings: const [
      'symbol_skullz',
    ]),
    GCWSymbolTableTool(symbolKey: 'slash_and_pipe', symbolSearchStrings: const [
      'symbol_slash_and_pipe',
    ]),
    GCWSymbolTableTool(symbolKey: 'solmisation', symbolSearchStrings: const [
      'symbol_solmisation',
    ]),
    GCWSymbolTableTool(symbolKey: 'space_invaders', symbolSearchStrings: const [
      'symbol_space_invaders',
    ]),
    GCWSymbolTableTool(symbolKey: 'spintype', symbolSearchStrings: const [
      'symbol_spintype',
    ]),
    GCWSymbolTableTool(symbolKey: 'sprykski', symbolSearchStrings: const [
      'symbol_sprykski',
    ]),
    GCWSymbolTableTool(symbolKey: 'steinheil', symbolSearchStrings: const [
      'symbol_steinheil',
      'telegraph',
    ]),
    GCWSymbolTableTool(symbolKey: 'stenography', symbolSearchStrings: const [
      'symbol_stenography',
    ]),
    GCWSymbolTableTool(symbolKey: 'stippelcode', symbolSearchStrings: const [
      'symbol_stippelcode',
    ]),
    GCWSymbolTableTool(symbolKey: 'suetterlin', symbolSearchStrings: const [
      'symbol_suetterlin',
    ]),
    GCWSymbolTableTool(symbolKey: 'sunuz', symbolSearchStrings: const [
      'symbol_sunuz',
    ]),
    GCWSymbolTableTool(symbolKey: 'surf', symbolSearchStrings: const [
      'symbol_surf',
    ]),
    GCWSymbolTableTool(symbolKey: 'tae', symbolSearchStrings: const [
      'symbol_tae',
    ]),
    GCWSymbolTableTool(symbolKey: 'tamil_numerals', symbolSearchStrings: const [
      'symbol_tamil_numerals',
    ]),
    GCWSymbolTableTool(
        symbolKey: 'telegraph_pasley',
        symbolSearchStrings: const [
          'telegraph',
          'symbol_pasley_telegraph',
        ]),
    GCWSymbolTableTool(
        symbolKey: 'telegraph_popham',
        symbolSearchStrings: const [
          'telegraph',
          'symbol_popham_telegraph',
        ]),
    GCWSymbolTableTool(
        symbolKey: 'telegraph_prussia',
        symbolSearchStrings: const [
          'telegraph',
          'telegraph_prussia',
        ]),
    GCWSymbolTableTool(
        symbolKey: 'telegraph_schmidt',
        symbolSearchStrings: const [
          'telegraph',
          'telegraph_schmidt',
        ]),
    GCWSymbolTableTool(symbolKey: 'templers', symbolSearchStrings: const [
      'symbol_templers',
    ]),
    GCWSymbolTableTool(
        symbolKey: 'tenctonese_cursive',
        symbolSearchStrings: const [
          'symbol_tenctonese',
        ]),
    GCWSymbolTableTool(
        symbolKey: 'tenctonese_printed',
        symbolSearchStrings: const [
          'symbol_tenctonese',
        ]),
    GCWSymbolTableTool(
        symbolKey: 'tengwar_beleriand',
        symbolSearchStrings: const [
          'symbol_lordoftherings',
          'symbol_tengwar_beleriand',
        ]),
    GCWSymbolTableTool(
        symbolKey: 'tengwar_classic',
        symbolSearchStrings: const [
          'symbol_lordoftherings',
          'symbol_tengwar_classic',
        ]),
    GCWSymbolTableTool(
        symbolKey: 'tengwar_general',
        symbolSearchStrings: const [
          'symbol_lordoftherings',
          'symbol_tengwar_general',
        ]),
    GCWSymbolTableTool(symbolKey: 'terzi', symbolSearchStrings: const [
      'symbol_terzi',
    ]),
    GCWSymbolTableTool(symbolKey: 'thai_numerals', symbolSearchStrings: const [
      'symbol_thai_numerals',
    ]),
    GCWSymbolTableTool(symbolKey: 'theban', symbolSearchStrings: const [
      'symbol_theban',
    ]),
    GCWSymbolTableTool(symbolKey: 'three_squares', symbolSearchStrings: const [
      'symbol_three_squares',
    ]),
    GCWSymbolTableTool(symbolKey: 'tifinagh', symbolSearchStrings: const [
      'symbol_tifinagh',
    ]),
    GCWSymbolTableTool(symbolKey: 'tines', symbolSearchStrings: const [
      'symbol_tines',
    ]),
    GCWSymbolTableTool(symbolKey: 'tll', symbolSearchStrings: const [
      'symbol_tll',
    ]),
    GCWSymbolTableTool(symbolKey: 'tomtom', symbolSearchStrings: const [
      'tomtom',
    ]),
    GCWSymbolTableTool(
        symbolKey: 'trafficsigns_germany',
        symbolSearchStrings: const [
          'symbol_trafficsigns_germany',
        ]),
    GCWSymbolTableTool(symbolKey: 'ulog', symbolSearchStrings: const [
      'symbol_ulog',
    ]),
    GCWSymbolTableTool(symbolKey: 'unitology', symbolSearchStrings: const [
      'symbol_unitology',
    ]),
    GCWSymbolTableTool(symbolKey: 'utopian', symbolSearchStrings: const [
      'symbol_utopian',
    ]),
    GCWSymbolTableTool(symbolKey: 'visitor_1984', symbolSearchStrings: const [
      'symbol_visitor_1984',
    ]),
    GCWSymbolTableTool(symbolKey: 'visitor_2009', symbolSearchStrings: const [
      'symbol_visitor_2009',
    ]),
    GCWSymbolTableTool(symbolKey: 'voynich', symbolSearchStrings: const [
      'symbol_voynich',
    ]),
    GCWSymbolTableTool(symbolKey: 'vulcanian', symbolSearchStrings: const [
      'symbol_vulcanian',
    ]),
    GCWSymbolTableTool(symbolKey: 'wakandan', symbolSearchStrings: const [
      'symbol_wakandan',
    ]),
    GCWSymbolTableTool(
        symbolKey: 'weather_a',
        symbolSearchStrings: const ['weather', 'weather_a']),
    GCWSymbolTableTool(
        symbolKey: 'weather_c',
        symbolSearchStrings: const ['weather', 'weather_c', 'weather_clouds']),
    GCWSymbolTableTool(
        symbolKey: 'weather_cl',
        symbolSearchStrings: const ['weather', 'weather_cl', 'weather_clouds']),
    GCWSymbolTableTool(
        symbolKey: 'weather_cm',
        symbolSearchStrings: const ['weather', 'weather_cm', 'weather_clouds']),
    GCWSymbolTableTool(
        symbolKey: 'weather_ch',
        symbolSearchStrings: const ['weather', 'weather_ch', 'weather_clouds']),
    GCWSymbolTableTool(
        symbolKey: 'weather_n',
        symbolSearchStrings: const ['weather', 'weather_n', 'weather_clouds']),
    GCWSymbolTableTool(
        symbolKey: 'weather_w',
        symbolSearchStrings: const ['weather', 'weather_w']),
    GCWSymbolTableTool(
        symbolKey: 'weather_ww',
        symbolSearchStrings: const ['weather', 'weather_ww']),
    GCWSymbolTableTool(symbolKey: 'webdings', symbolSearchStrings: const [
      'symbol_webdings',
    ]),
    GCWSymbolTableTool(
        symbolKey: 'westernunion',
        symbolSearchStrings: const ['symbol_westernunion', 'teletypewriter']),
    GCWSymbolTableTool(
        symbolKey: 'windforce_beaufort',
        symbolSearchStrings: const [
          'beaufort',
          'symbol_windforce_beaufort',
        ]),
    GCWSymbolTableTool(
        symbolKey: 'windforce_knots',
        symbolSearchStrings: const [
          'beaufort',
          'symbol_windforce_knots',
        ]),
    GCWSymbolTableTool(symbolKey: 'window', symbolSearchStrings: const [
      'window',
    ]),
    GCWSymbolTableTool(symbolKey: 'wingdings', symbolSearchStrings: const [
      'symbol_wingdings',
    ]),
    GCWSymbolTableTool(symbolKey: 'wingdings2', symbolSearchStrings: const [
      'symbol_wingdings2',
    ]),
    GCWSymbolTableTool(symbolKey: 'wingdings3', symbolSearchStrings: const [
      'symbol_wingdings3',
    ]),
    GCWSymbolTableTool(symbolKey: 'yan_koryani', symbolSearchStrings: const [
      'symbol_yan_koryani',
    ]),
    GCWSymbolTableTool(symbolKey: 'yinyang', symbolSearchStrings: const [
      'symbol_yinyang',
    ]),
    GCWSymbolTableTool(symbolKey: 'zamonian', symbolSearchStrings: const [
      'symbol_zamonian',
    ]),
    GCWSymbolTableTool(symbolKey: 'zentradi', symbolSearchStrings: const [
      'symbol_zentradi',
    ]),
    GCWSymbolTableTool(symbolKey: 'zodiac_signs', symbolSearchStrings: const [
      'symbol_zodiacsigns',
    ]),
    GCWSymbolTableTool(
        symbolKey: 'zodiac_signs_latin',
        symbolSearchStrings: const [
          'symbol_zodiacsigns',
          'symbol_zodiacsigns_latin',
        ]),
    GCWSymbolTableTool(symbolKey: 'zodiac_z340', symbolSearchStrings: const [
      'symbol_zodiac_z340',
    ]),
    GCWSymbolTableTool(symbolKey: 'zodiac_z408', symbolSearchStrings: const [
      'symbol_zodiac_z408',
    ]),

    // TelegraphSelection *********************************************************************************************
    GCWTool(tool: const ChappeTelegraph(), id: 'telegraph_chappe', searchKeys: const [
      'telegraph',
      'telegraph_chappe',
    ]),
    GCWTool(tool: const EdelcrantzTelegraph(), id: 'telegraph_edelcrantz', searchKeys: const [
      'telegraph',
      'telegraph_edelcrantz',
    ]),
    GCWTool(tool: const MurrayTelegraph(), id: 'telegraph_murray', searchKeys: const [
      'telegraph',
      'telegraph_murray',
    ]),
    GCWTool(tool: const OhlsenTelegraph(), id: 'telegraph_ohlsen', searchKeys: const [
      'telegraph',
      'telegraph_ohlsen',
    ]),
    GCWTool(tool: const PasleyTelegraph(), id: 'telegraph_pasley', searchKeys: const [
      'telegraph',
      'telegraph_pasley',
    ]),
    GCWTool(tool: const PophamTelegraph(), id: 'telegraph_popham', searchKeys: const [
      'telegraph',
      'telegraph_popham',
    ]),
    GCWTool(tool: const PrussiaTelegraph(), id: 'telegraph_prussia', searchKeys: const [
      'telegraph',
      'telegraph_prussia',
    ]),
    GCWTool(tool: const SemaphoreTelegraph(), id: 'symboltables_semaphore', searchKeys: const [
      'telegraph',
      'telegraph_semaphore',
    ]),
    GCWTool(tool: const SteinheilTelegraph(), id: 'telegraph_steinheil', searchKeys: const [
      'telegraph',
      'telegraph_steinheil',
    ]),
    GCWTool(tool: const WigWagSemaphoreTelegraph(), id: 'telegraph_wigwag', searchKeys: const [
      'telegraph',
      'telegraph_wigwag',
    ]),
    GCWTool(tool: const GaussWeberTelegraph(), id: 'telegraph_gausswebertelegraph', searchKeys: const [
      'telegraph',
      'telegraph_gaussweber',
    ]),
    GCWTool(tool: const SchillingCanstattTelegraph(), id: 'telegraph_schillingcanstatt', searchKeys: const [
      'telegraph',
      'telegraph_schillingcanstatt',
    ]),
    GCWTool(tool: const WheatstoneCookeNeedleTelegraph(), id: 'telegraph_wheatstonecooke_needle', searchKeys: const [
      'telegraph',
      'telegraph_wheatstonecooke_needle',
    ]),

    //Teletypewriter Selection **********************************************************************************************
    GCWTool(
        tool: const AncientTeletypewriter(),
        id: 'ccitt_ancient',
        searchKeys: const [
          'ccitt',
          'ccitt_ancient',
          'teletypewriter',
          'symbol_siemens',
          'symbol_westernunion',
          'symbol_murraybaudot',
          'symbol_baudot'
        ]),
    GCWTool(tool: const CCITTTeletypewriter(), id: 'ccitt', searchKeys: const [
      'ccitt',
      'ccitt_1',
      'ccitt_2',
      'ccitt_3',
      'ccitt_4',
      'ccitt_5',
      'ccitt_ccir_476',
      'teletypewriter',
      'symbol_baudot'
          'symbol_murraybaudot',
    ]),
    GCWTool(
        tool: const OtherTeletypewriter(),
        id: 'ccitt_other',
        searchKeys: const [
          'teletypewriter',
          'z22',
          'zc1',
          'illiac',
          'algol',
          'tts'
        ]),

    // TomTomSelection *********************************************************************************************
    GCWTool(tool: const TomTom(), id: 'tomtom', searchKeys: const [
      'tomtom',
    ]),

    // UICWagonCodeSelection ***************************************************************************************
    GCWTool(tool: const UICWagonCode(), id: 'uic_wagoncode', searchKeys: const [
      'railways',
      'uic',
      'uic_wagoncode',
    ]),
    GCWTool(
        tool: const UICWagonCodeVKM(),
        id: 'uic_wagoncode_vkm',
        searchKeys: const [
          'railways',
          'uic',
          'uic_wagoncode',
          'uic_wagoncode_vkm',
        ]),
    GCWTool(
        tool: const UICWagonCodeCountryCodes(),
        id: 'uic_wagoncode_countrycodes',
        searchKeys: const [
          'railways',
          'uic',
          'uic_wagoncode',
          'countries',
        ]),
    GCWTool(
        tool: const UICWagonCodeFreightClassifications(),
        id: 'uic_wagoncode_freight_classification',
        searchKeys: const [
          'railways',
          'uic',
          'uic_wagoncode',
        ]),
    GCWTool(
        tool: const UICWagonCodePassengerLettercodes(),
        id: 'uic_wagoncode_passenger_lettercodes',
        searchKeys: const [
          'railways',
          'uic',
          'uic_wagoncode',
        ]),

    //VanitySelection **********************************************************************************************
    GCWTool(
        tool: const VanitySingletap(),
        id: 'vanity_singletap',
        searchKeys: const [
          'vanity',
          'vanitysingletap',
        ]),
    GCWTool(
        tool: const VanityMultitap(),
        id: 'vanity_multitap',
        searchKeys: const [
          'vanity',
          'vanitymultitap',
        ]),
    GCWTool(
        tool: const VanityWordsList(),
        id: 'vanity_words_list',
        searchKeys: const [
          'vanity',
          'vanitywordslist',
        ]),
    GCWTool(
        tool: const VanityWordsTextSearch(),
        id: 'vanity_words_search',
        searchKeys: const [
          'vanity',
          'vanitytextsearch',
        ]),

    //VigenereSelection *******************************************************************************************
    GCWTool(
        tool: const VigenereBreaker(),
        id: 'vigenerebreaker',
        categories: const [
          ToolCategory.GENERAL_CODEBREAKERS
        ],
        searchKeys: const [
          'codebreaker',
          'vigenerebreaker',
          'vigenere',
          'rotation',
        ]),
    GCWTool(tool: Vigenere(), id: 'vigenere', searchKeys: const [
      'vigenere',
      'rotation',
    ]),
    GCWTool(tool: const Gronsfeld(), id: 'gronsfeld', searchKeys: const [
      'vigenere',
      'rotation',
      'gronsfeld',
    ]),
    GCWTool(tool: const Trithemius(), id: 'trithemius', searchKeys: const [
      'vigenere',
      'rotation',
      'trithemius',
    ]),
    GCWTool(
        tool: const WeddingAnniversaries(),
        id: 'wedding_anniversaries',
        categories: const [ToolCategory.MISCELLANEOUS],
        searchKeys: const ['weddinganniversaries']),

    // WherigoUrwigoSelection ************************************************************************************
    GCWTool(tool: const WherigoAnalyze(), id: 'wherigo', categories: const [
      ToolCategory.IMAGES_AND_FILES,
      ToolCategory.GENERAL_CODEBREAKERS
    ], searchKeys: const [
      'wherigo',
      'wherigourwigo',
    ]),
    //UrwigoHashBreaker already inserted in section "Hashes"
    GCWTool(
        tool: const UrwigoTextDeobfuscation(),
        id: 'urwigo_textdeobfuscation',
        searchKeys: const ['wherigo', 'urwigo', 'urwigo_textdeobfuscation']),
    GCWTool(
        tool: const EarwigoTextDeobfuscation(),
        id: 'earwigo_textdeobfuscation',
        searchKeys: const ['wherigo', 'earwigo', 'urwigo_textdeobfuscation']),

    // ZodiacSelection ******************************************************************************************
    GCWTool(tool: const Zodiac(), id: 'zodiac', searchKeys: const [
      'symbol_alchemy',
      'symbol_planets',
      'symbol_zodiacsigns',
      'symbol_zodiacsigns_latin',
    ]),
  ].map((toolWidget) {
    toolWidget.toolName = i18n(context, toolWidget.id + '_title');
    toolWidget.defaultLanguageToolName =
        i18n(context, toolWidget.id + '_title', useDefaultLanguage: true);

    try {
      toolWidget.description = i18n(context, toolWidget.id + '_description');
    } catch (e) {}

    try {
      toolWidget.example = i18n(context, toolWidget.id + '_example');
    } catch (e) {}

    return toolWidget;
  }).toList();

  createIndexedSearchStrings();
}

void refreshRegistry() {
  registeredTools = [];
}
