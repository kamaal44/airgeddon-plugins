#!/usr/bin/env bash

# UI-Boost airgeddon plugin

# Version:    0.0.1
# Author:     KeyofBlueS
# Repository: https://github.com/KeyofBlueS/airgeddon-plugins
# License:    GNU General Public License v3.0, https://opensource.org/licenses/GPL-3.0

# airgeddon Repository: https://github.com/v1s1t0r1sh3r3/airgeddon

#Global shellcheck disabled warnings
#shellcheck disable=SC2034

plugin_name="UI-Boost"
plugin_description="Speed up user interface by making a specifc language strings file"
plugin_author="KeyofBlueS"

plugin_enabled=1

plugin_minimum_ag_affected_version="10.0"
plugin_maximum_ag_affected_version=""
plugin_distros_supported=("*")

#Posthook for make specifc language strings file
# THIS WILL NOT WORK
#function ui_boost_posthook_check_language_strings() {

function ui_boost_posthook_remap_colors() {

	# languages supported by airgeddon
	languages="ENGLISH SPANISH FRENCH CATALAN PORTUGUESE RUSSIAN GREEK ITALIAN POLISH GERMAN TURKISH"

	# detect languages to be excluded
	for language_to_exclude in $languages; do
		if [ "$language_to_exclude" = "$language" ]; then
			true
		else
			if [ -z "$languages_to_exclude" ]; then
				languages_to_exclude=$language_to_exclude
			else
				languages_to_exclude="$languages_to_exclude|$language_to_exclude"
			fi
		fi
	done
	
	# detect scriptfolder if needed
	if [ -z "${scriptfolder}" ]; then
		scriptfolder=${0}

		if ! [[ ${0} =~ ^/.*$ ]]; then
			if ! [[ ${0} =~ ^.*/.*$ ]]; then
				scriptfolder="./"
			fi
		fi
		scriptfolder="${scriptfolder%/*}/"
	fi
	
	# make specifc language strings file
	touch ${scriptfolder}/language_strings_${language}.sh
	cat ${scriptfolder}/language_strings.sh | grep -Ev "$languages_to_exclude" > ${scriptfolder}/language_strings_${language}.sh
	
	# setting new language_strings_file variable
	language_strings_file="language_strings_${language}.sh"
	source "${scriptfolder}${language_strings_file}"
}