#!/usr/bin/env python

# THE ALL-IN-ONE CHROME SETTINGS SCRIPT
#
# This script will change the chrome settings to:
# 1. Accept cookies
# 2. Accept popups
# 3. Accept running the javaplugin on any site (user still needs to verify unsigned code)
# 4. Turn back on the home button for chrome

# BY ROBOTTO




import sys
import json

chrome_preferences = '/home/.skjult/.config/google-chrome/Default/Preferences'

#chrome_preferences = '/home/robotto/.config/google-chrome/Default/Preferences'
#download_directory = '/home/robotto/Desktop'


#Open the chrome settings file, and read the contents into a json structure:
try:

            #OPEN THE CHROME PREFERENCES FILE AS JSON:

    print
    print "Opening Crome preferences file: %s" %chrome_preferences

    with open(chrome_preferences, 'r') as chrome_file:

        data = json.load(chrome_file)



            #1 - ALLOW COOKIES:

    print "1: Allowing cookies..."

    try:
        print "Trying to remove blocking of third party cookies..."
        del data['profile']['block_third_party_cookies']
    except Exception as e:
        print "Nothing to remove... Block third party cookies not set: " + str(e)

    try:
        del data['profile']['default_content_settings']
        print "Done - cookies allowed"
        print
    except Exception as e:
        print "It looks like cookies are already allowed: " + str(e)
        print

            #3 - ALLOW POPUPS:
			# Bibsdb - default_content_settings changed to default_content_setting_values
			
    print "2: Allowing popups..."

    try:
        print "Trying to remove old popup settings..."
        del data['profile']['default_content_setting_values']
        print "Done."
    except Exception as e:
        print "Nothing to remove.. Maybe popups are disabled? .. this was kind of expected...: " + str(e)

    try:
        print "Creating popup-allow entry..."
        new_entry = dict(default_content_setting_values=dict(popups=1))
        data['profile'].update(new_entry)
        print "Done - popups allowed."
        print

    except Exception as e:
        print "Error setting allow popups. Aborting. Nothing has been changed! Error msg: " + str(e)
        sys.exit(1)


            #WRITE THE JSON FILE:

    with open(chrome_preferences, 'w') as chrome_file:
        json.dump(data, chrome_file)



            #4 - ALLOW JAVA:

    print "3: Allowing Java..."

    #heres some needed strings:
    middle_part='''"pref_version": 1'''
    magic_string= '''"pattern_pairs": { "*,*": {"per_plugin": {"java-runtime-environment": 1}}},"plugin_whitelist": {"java-runtime-environment": true},'''

    #OPEN THE FILE AS STRING, INSTEAD OF JSON:

    with open(chrome_preferences, 'r') as chrome_file:
        contents = chrome_file.read()


    try:

        #CHECK IF LINES EXISTS:
        print "Checking if java-allow data exists in chrome settings file.."

        #This line will fail if the data does not exist. This fail is used as an indicator for the existence of the data. :)
        test = contents.split('''"pattern_pairs"''')[1]

        print "It does. Removing.."

        first_part = contents.split('''"pattern_pairs"''')[0]

        last_part = contents.split(middle_part)[1]

        modified_contents = first_part+middle_part+last_part

        #print modified_contents

        with open(chrome_preferences, 'w') as chrome_file:
            chrome_file.write(modified_contents)

    except:
        print "it did not..."

    try:


        print 'Inserting the java-allow data...'


        with open(chrome_preferences, 'r') as chrome_file:
            contents = chrome_file.read()

        split = contents.split(middle_part)

        #inserting magic_string AFTER '''"clear_on_exit_migrated": true,''' here:
        modified_contents=split[0]+ magic_string + middle_part + split[1]

        #WRITE DATA BACK TO THE CHROME PREFERENCES FILE:

        with open(chrome_preferences, 'w') as chrome_file:
            chrome_file.write(modified_contents)

        print "Done - Java allowed"
        print

    except Exception as e:
        print "An error occurred trying to do the java thing.. maybe this can help?: " + str(e)
        sys.exit(1)

    try:

        print 'Turning on the home button...'

        with open(chrome_preferences, 'r') as chrome_file:
            contents = chrome_file.read()

        try:
            print "Removing current entry.. if any."
            del data['browser']['show_home_button']
            print "current entry removed"
        except Exception as e:
         print "No home button entry, this is to be expected.: " + str(e)


        show_home_button = dict(show_home_button=True)

        data['browser'].update(show_home_button)

        with open(chrome_preferences, 'w') as chrome_file:
            json.dump(data, chrome_file)

        print "Home button added.."

    except Exception as e:
        print "An error occurred trying to do the home button thing.. maybe this can help?: " + str(e)
        sys.exit(1)

    print "All the things are done! yay!"
    print
except Exception as e:
    print "An error occurred, probably unable to open Chrome Preferences file: " + str(e)
    print
