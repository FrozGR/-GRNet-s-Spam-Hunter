###########################################################
##                                                       ##
##                   Dog of GRNet v2                     ##
##              (Incognito Spam Hunter)                  ##
##               for eggdrop v1.6.20                     ##
##                                                       ##
##    @2009 written by Frozen for GRNet (version 0.1a)	 ##
##    @2010 modified (version 2)                         ##
##                                                       ##
##                                                       ##
###########################################################
##                                                       ##
## The purpose of this .tcl script is to make an eggdrop ##
## to work as a detective and whenever it finds abusers  ##
## as spammers and/or flooders will report them (same as ##
## what was the spam they did) in your report channel.	 ##
## Further than that,it also forwards every private	 ##
## message it receives as well.				 ##
##							 ##
## The Biggest Advantage of this .tcl 'Spam Hunting'	 ##
## script is that further than the "advertise list"	 ##
## which contains the 'triggers' that we need the bot to ##
## look for, it has an "exception list" of the same kind ##
## that even if it sees a trigger, if there is something ##
## from the "exception list" on the same message, it	 ##
## will ignore it, considering it as an exception.	 ##
##                                                       ##
## Example:                                              ##
##      http://www.youtube.com/watch?v=AHTNgJftbLA       ##
##                                                       ##
## Youtube links contain the "*.com" that the eggdrop	 ##
## has as a "Spam trigger", but youtube links aren't	 ##
## a kind of spam that deserves to be punished so those	 ##
## kind of "Spam" should be automatically ignored.	 ##
## Same as the urls for the ShoutCast Radios..           ##
##                                                       ##
## This way, it becomes easier for the IRC Operators	 ##
## to monitor many channels on the same time for any	 ##
## kind of spam abuse by avoiding on the same time	 ##
## useless "Spam Reports" from the eggdrop due to it's	 ##
## triggers.                                             ##
##                                                       ##
## The Last addition to this project, was the ability of ##
## the reporter to switch nicks/idents/opermasks and     ##
## real names every 3 hours, and rejoin "Incognito" it's ##
## channels.                                             ##
##                      ------                           ##
##                                                       ##
## Credits goes to keramidas for the help and the time   ##
## he spent with me while i was debugging & fixing the   ##
## code on the beta testing period of 2009.              ##
##                                                       ##
###########################################################
## Contact Info:                                         ##
##							 ##
##	Email:	Frozen@nightmare.gr			 ##
##	URL:	http://Nightmare.gr/			 ##
##	IRC:	Frozen @ darkness.irc.gr		 ##
##							 ##
##	proudly representing darkness.irc.gr		 ##
##	 and the GREEK IRC Network (IRC.gr)		 ##
##							 ##
###########################################################


##########################################
### Start editing variables from here. ###
##########################################

#Set the Report Channel.
set reportchan "#myReportChannel"

#Set the Reporter's list of Nicknames.
set nicknames "nick1 nick2 nick3 nick4 nick5 nick6 nick7 nick8 nick9 nick10 etc"
#Don't touch the following line, it selects a random nick from the list of nicks above.
set x 0; foreach nickname [split $nicknames " "] {set randnicks($x)  $nickname; incr x;}


#Set the Reporter's list of fake hosts (opermasks).
set servlist {
		"server operport serverpass:opernick:operpass:FAKEHOST"
		"server operport serverpass:opernick:operpass:FAKEHOST2"
		"server operport serverpass:opernick:operpass:FAKEHOST3"
		"etc"
}
#Don't touch the following line, it selects a random fakemask from the list above.
set y 0; foreach serv $servlist {set randservers($y) $serv; incr y;}


#Set the Reporter's list of Idents.
set idents {
		"ident1"
		"ident2"
		"ident3"
		"etc"
}
#Don't touch the following line, it selects a random ident from the list above.
set i 0; foreach ident $idents {set randidents($i) $ident; incr i;}


#Set the Reporter's list of Real Names.
set names {
		"my real name 1"
		"my real name 2"
		"my real name 3"
		"etc"
}
#Don't touch the following line, it selects a random real name from the list above.
set n 0; foreach name $names {set randnames($n) $name; incr n;}

#------------------------------------------------------#
#    SETUP ADVERTISEMENT EXCEPTION WORD/PHRASE LIST    #
#------------------------------------------------------#

#Set the exception list of the words and/or phrases that you would like to be ignored.
#It can be either urls or phrases that are commonly used on spam or whatever the scripts 'catches' by a wrong trigger. 
#Wildcards as * or ? can be used.
#
#(eg: For Shoutcast Radios smam line would be something like->    <nick> http://RADIO-URL-HERE.com/player.php for the BEST RADIO on $Network 
#On such case you can just put "*radio*" and every spam that contains the "RADIO" word in it will be automatically ignored due to be an exception.)

set advertiseexceptions {
	"*youtube.*"
	"*youporn.*"
	"*youjizz.*"
	"*metacafe.com*"
	"*wikipedia.org*"
	"*greek-video.net*"
	"*veoh.com*"
	"*vimeo.com*"
	"*facebook.com*"
	"*dailymotion.com*"
	"*.pls*"
	"*radio*"
	"*irc.gr*"
	"*@@*"
	"*sets mode:*"
	"*has left*"
	"*was last seen*"
	"*teleutaia fora ton eida na apoxwrei*"
	"*Added * to ignore list*"
	"*livestream.com*"
}


#----------------------------------------------#
#    SETUP ADVERTISEMENT DETECTION WORDLIST    #
#----------------------------------------------#

#Set the *advertise words* for the script to react on. (wildcards such as "*" are accepted)
#Already have pre-added all kinds of combinations, normally you would'nt need to edit these.
#People only edit would need to edit if their language or channel not english.

set advertisewords {
	"*/server*"
	"*/s *"
	"*/s -m*"
	"#*"
	"#*#*"
	"*#*#*"
	"#*#*#*"
	"*#*#*#*"
	"#* #*"
	"*#* #*"
	"#* #* #*"
	"*#* #* #*"
	"#* *#*"
	"*#* *#*"
	"#* *#* *#*"
	"*#* *#* *#*"
	"#* * #*"
	"#* * *#*"
	"*#* * #*"
	"*#* * *#*"
	"#* * #* * #*"
	"#* * *#* *#*"
	"*#* * #* * #*"
	"*#* * *#* *#*"
	"*/join #*"
	"*join #*"
	"*join* #*"
	"*/join"
	"*/join*"
	"*/j0in #*"
	"*j0in #*"
	"*/j0in"
	"*/j0in*"
	"*/j #*"
	"*/j* #*"
	"*/j *"
	"*join#*"
	"*join*#*"
	"*j0|n#*"
	"*j0|n*#*"
	"*j0in#*"
	"*j0in*#*"
	"*jo|n#*"
	"*jo|n*#*"
	"*join to * * #*"
	"*join to your #*"
	"*join to your * #*"
	"*ela sto*"
	"*ela sth*"
	"*ela sti*"
	"*@*.*"
	"*http://*"
	"* www.*"
	"www.*"
	"*ftp://*"
	"*.com*"
	"*.net*"
	"*.org*"
	"*.gr*"
	"*.tk*"
	"*.info*"
	"*.us*"
	"*.tv*"
	"*.ru*"
	"69????????"
	"* 69????????"
}


################################################################################################################
###                     *************************************************                                    ###
###                                    For your own safety,                                                  ###
###                        Don't edit anything else from this point.                                         ###
###                     *************************************************                                    ###
################################################################################################################


bind pubm - * pub:advertise
bind ctcp - ACTION act:advertise
bind notc - * notc:advertise
bind msgm - "*" proc:private


# Cronjob (CyclePart)

if {[timerexists cyclepart] eq "" && [utimerexists cyclejoin] eq "" && [utimerexists cycleserver] eq ""} {
	timer 1 cyclepart
}
# End of Cronjob

proc pub:advertise {nick uhost hand chan text} {
	global botnick
	if {($nick != $botnick) && ($chan != $botnick)} {
		advertise:chans $nick $uhost $hand $chan $text
		
	}
}

proc act:advertise {nick uhost hand chan key text} {
	global botnick
	if {($nick != $botnick) && ($chan != $botnick)} {
		advertise:chans $nick $uhost $hand $chan $text
	}
}

proc notc:advertise {nick uhost hand text {chan ""}} {
	global botnick
	if {($nick != $botnick) && (![string equal $nick "ChanServ"])} {
		advertise:chans $nick $uhost $hand $chan $text
	}
}

proc proc:private {nick uhost hand arg} {
	global reportchan
	set line [string trim $arg]
	if {([string match -nocase *auth* $line]) || ([string match -nocase *pass* $line]) || ([string match -nocase *login* $line])} { return 0 }
	putserv "PRIVMSG $reportchan : :: (msg) $nick ($uhost): $line"
	}

proc advertise:chans {nick uhost hand chan text} {
	global botnick advertisewords advertiseexceptions
	set text [advertise:filter $text];
	if {([string match -nocase *$chan* $text])} { return 0 }
	foreach advertiseexception [string tolower $advertiseexceptions] {
		if {[string match -nocase *$advertiseexception* $text]} {
			return
		}
	}
	foreach advertiseword [string tolower $advertisewords] {
		if {[string match -nocase *$advertiseword* $text]} {
			if {($nick != $botnick) && ($chan != $botnick) && ([validchan $chan]) && (![string match -nocase *$chan* $text]) && ([onchan $nick $chan])} {
				set advertiseban [advertise:banmask $uhost $nick];
				advertise:report $nick $chan $advertiseword $advertiseban $text; return 0

			}
		}
	}
}


proc advertise:report {nick chan advertiseword advertiseban {text {}}} {
	global botnick reportchan
	set banmask $advertiseban
	putquick "PRIVMSG $reportchan :(SPAM) $nick ( $banmask ) on $chan :     $text"
	return 0
}

proc advertise:banmask {uhost nick} {
	set banmask "[lindex [split $uhost @] 1]"
}
### Thanks to ppslim for this filter ###
proc advertise:filter {str} {
	regsub -all -- {\003[0-9]{0,2}(,[0-9]{0,2})?|\017|\037|\002|\026|\006|\007} $str "" str
	return $str
}

#################################################################################################
################### Bot Masking Part  ###########################################################
#################################################################################################


# Parting all Channels #

proc cyclepart {} {
	foreach c [channels] {
		channel set $c +inactive
	}
	utimer 60 cycleserver
}


# Changing info & switching servers for a different opermask #

proc cycleserver {} {
	####### Change identd #################################
	set randval [rand [array size ::randidents]];
	set ::username "$::randidents($randval)";

	####### Change Real Name ##############################
        set randval [rand [array size ::randnames]];
        set ::realname "$::randnames($randval)";

	####### Change Nick Name ##############################
	set randval [rand [array size ::randnicks]];
        putserv "NICK $::randnicks($randval)";
        set ::nick $::randnicks($randval)";

	####### Change Opermask
	set randval [rand [array size ::randservers]];
	foreach {a b} [array get ::randservers] { putlog "$a->$b" }
	putlog "Jumping: jump [split $::randservers($randval)]"
	eval jump [split $::randservers($randval)]

	####### Double Check that we are OUT of Channels ######
	foreach c [channels] {
                channel set $c +inactive
        }
        utimer 60 cyclejoin
}


### Re-Joining all Channels #

proc cyclejoin {} {
	foreach c [channels] {
		channel set $c -inactive
	}
	timer 180 cyclepart
}


putlog "Dog of GRNet v2 by Frozen loaded."

return
