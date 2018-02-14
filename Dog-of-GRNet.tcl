###########################################################
##							 ##
##		(GRNet's) Spam Hunter			 ## 
##		 for eggdrop v1.6.19			 ##
##							 ##
##    @2005 written by awyeah for DALNet (v 3.92.b)	 ##
##    @2009 modified by Frozen for GRNet (v 0.1a)	 ##
##							 ##
##							 ##
###########################################################
##							 ##
## The original idea was a Channel Advertise/Spam	 ## 
## Kicker script for eggdrops, and was firstly		 ##
## implemented on 06/07/2004 by awyeah for DALNet and	 ##
## each needs.						 ##
##							 ##
## Part of the code was erased/replaced and/or		 ##
## modified or even re-written by me (Frozen) in order	 ##
## to cover the needs of the GREEK IRC Network (irc.gr)	 ##
## known as GRNet.					 ##
##							 ##
## The purpose of this .tcl script is to make an eggdrop ##
## to work as a detective (while being with a +o/+O flag ##
## and has the ability to be in more than 10 channels)	 ##
## and whenever it finds an abuser of the policy as	 ##
## spammers and/or flooders will report them (same as	 ##
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
##							 ##
## Example:						 ##
## http://www.youtube.com/watch?v=5di5EhZshdQ		 ##
##							 ##
## Youtube links contain the "*.com" that the eggdrop	 ##
## has as a "Spam trigger", but youtube links aren't	 ##
## a kind of spam that deserves to be punished so those	 ##
## kind of "Spam" should be automatically ignored.	 ##
## Same as the urls for the ShoutCast Radios..		 ##
##							 ##
## This way, it becomes easier for the IRC Operators	 ##
## to monitor many channels on the same time for any	 ##
## kind of spam abuse by avoiding on the same time	 ##
## useless "Spam Reports" from the eggdrop due to it's	 ##
## triggers.						 ##
##			------				 ##
##							 ##
## Credits goes to awyeah for the basic/most part of the ##
## code and keramida for the help and the time he spent	 ##
## with me while i was debugging & fixing the original	 ##
## code that i received from awyeah's tcl script.	 ##
## All the Additions were done by me, and half of the	 ##
## source got re-written for improvement reasons.	 ##
##							 ##
###########################################################
## Contact:						 ##
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


#----------------------------------------#
#    SETUP CHANNEL ACTIVATION OPTIONS    #
#----------------------------------------#

#Set the Report Channel.
set reportchan "#myReportChannel"


#Set the type of channels you would like this script to work on.
#USAGE: [1/2] (1=USER DEFINED CHANNELS, 2=ALL CHANNELS) (You can only enable ONE setting!)
#Use '1' for 'user defined channels' (Will detect/punish the user only in the channels defined for the script)
#Use '2' for 'all the channels' the bot is on. (Will detect/punish the user on any channel where he/she advertised)
set advertisetype "2"


#Set this if you have set the previous setting to '1' for user defined channels, if not then please
#leave this as it is or leave this as empty/blank. (Set the channels on which this script would work)
#USAGE: set advertisechans "#channel1 #channel2 #channel3 #mychannel #yourchannel"
set advertisechans ""


#---------------------------------------#
#    SETUP CHANNEL INTERFACE OPTIONS    #
#---------------------------------------#

#Set the type of channel interface to enable. (MESSAGE, ACTION, NOTICE)
#USAGE: [1/2/3/4] (1=CHANNEL TEXTS, 2=CHANNEL ACTIONS, 3=CHANNEL NOTICES, 4=ALL)
#Use '1' for detecting advertisments from CHANNEL TEXTS. (Will only detect channel texts: /msg #channel)
#Use '2' for detecting advertisments from CHANNEL ACTIONS. (Will only detect channel actions: /me #channel)
#Use '3' for detecting advertisments from CHANNEL NOTICES. (Will only detect channel notices: /notice #channel)
#Use '4' for detecting advertisements from CHANNEL TEXTS, ACTIONS and NOTICES (ALL). (Will detect all channel texts, actions and notices)
set advertiseactivate "4"


#------------------------------------------------------#
#    SETUP ADVERTISEMENT EXCEPTION WORD/PHRASE LIST    #
#------------------------------------------------------#

#Set the exception list of the words and/or phrases that you would like to be ignored.
#It can be either urls or phrases that are commonly used on spam such spam occations 
#Wildcards as * or ? can be used.
#
#(eg: For Shoutcast Radios -> <spammer> http://RADIO-URL-HERE.com/player.php for the BEST RADIO on $Network )
#
#On such case you can just put "*radio*" and every spam that contains the "RADIO" word in it will be 
#automatically ignored due to be an exception.


set advertiseexceptions {
	"*youtube.*"
	"*youporn.*"
	"*metacafe.com*"
	"*veoh.com*"
	"*dailymotion.com*"
	"*.pls*"
	"*radio*"
	"*irc.gr*"
	"*greek-video.net*"
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
	"*ela ston*"
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
	"*.ru*"
	"*.tr*"
	"69????????"
}


#------------------------------------#
#    SETUP USER PUNISHMENT METHOD    #
#------------------------------------#

#Set the type of punishment to declare for the user.
#USAGE: [1/2/3/4] (1=KICK, 2=KICK/BAN, 3=STICKY KICK/BAN, 4=GLOBAL KICK/BAN)
#Use '1' to 'kick' that user from the channel. (Minimal punishment)
#Use '2' to 'kick and ban' that user from the channel. (Moderate punishment)
#Use '3' to 'kick ban' that user using a sticky ban from the bots ban list. (Extreme punishment)
#Use '4' to 'kick ban' that user from all channels the user is found on matching with the bot. (Maximum punishment)
#Use '5' to REPORT only.
set advertisepunish "5"


#-------------------------#
#    SETUP BAN OPTIONS    #
#-------------------------#

#Select the type of banmask to use when banning the advertiser.
# 1 - *!*@some.host.com
# 2 - *!*@*.host.com
# 3 - *!*ident@some.domain.com
# 4 - *!*ident@*.host.com
# 5 - *!*ident*@*.host.com
# 6 - *!*ident*@some.host.com
# 7 - nick*!*@*.host.com
# 8 - *nick*!*@*.host.com
# 9 - nick*!*@some.host.com
# 10 - *nick*!*@some.host.com
# 11 - nick!ident@some.host.com
# 12 - nick!ident@*.host.com
# 13 - *nick*!*ident@some.host.com
# 14 - nick*!*ident*@some.host.com
# 15 - *nick*!*ident*@some.host.com
# 16 - nick!*ident*@some.host.com
# 17 - nick*!*ident@*.host.com
# 18 - nick*!*ident*@*.host.com
# 19 - *nick*!*ident@*.host.com
# 20 - *nick*!*ident*@*.host.com
set advbanmask "6"

#Set the amount of time in minutes to ban the user for. (in mins)
#(By default if you don't set a value the script will assume it to be 60 minutes)
set advertisebantime "30"


#-------------------------------#
#    SETUP KICK MESSAGE TYPE    #
#-------------------------------#

#Set this if you would like to use your own KICK message for kicking the advertiser.
#If you set this OFF then the scripts default kick message will be used.
#USAGE: [0/1] (O=OFF, 1=ON)
set advkickswitch "1"

#Set this if to your customizable KICK message if you have enabled to use your own custom KICK message.
#By Default this is set to the scripts default kick message. (You will need to change this)
set advkickmsg "Advertise/Invite word detected. Mass Advertising/Inviting/Spamming in is not tolerated on this channel. Failing to comply with these rules will result into a permanent ban."


#-----------------------------------#
#    SETUP USER EXEMPTION OPTIONS   #
#-----------------------------------#

### IMPORTANT NOTE ###
#For all of the exemption settings below please *DO NOT* use wildcards
#such as: (*, !, *!*, *@*, *!*@*, @*.host.com, *@127.0.0.* etc as they maybe risky)
#(If you do not have any ident, userhost, or ip to enter then please leave the field "")


#### EXEMPT CHANNEL OPERATORS ####
#Set this if you want the bot to exempt all channel operators - ops (@'s) even though if the
#bot has detected an advertise matching word from them. (This is a useful setting for not punishing ops)
#USAGE: [0/1] (0=OFF, 1=ON) - (0=WILL NOT EXEMPT OPS, 1=WILL EXEMPT OPS)
#If set to '0' channel ops will be punished if the bot detects an advertise word from them
#If set to '1' channel ops will be exempted even if the bot detects an advertise word from them
set advexopswitch "0"

#### EXEMPT CHANNEL VOICES ####
#Set this if you want the bot to exempt all channel voices (+v's) even though if the bot has
#detected an advertise matching word from them. (This is a useful setting for not punishing voices)
#USAGE: [0/1] (0=OFF, 1=ON) - (0=WILL NOT EXEMPT VOICES, 1=WILL EXEMPT VOICES)
#If set to '0' channel voices will be punished if the bot detects an advertise word from them
#If set to '1' channel voices will be exempted even if the bot detects an advertise word from them
set advexvoiceswitch "0"


#### EXEMPT SPECIFIC USER FLAGS ####
#Set this if you want the bot to exempt user flags on the bots user list. Users with certain specific or all
#flags would be exempted by the bot and will not be punished, even if the bot detects an advertise word from them.
#USAGE: [0/1] (0=OFF, 1=ON) - (0=WILL NOT EXEMPT USERFLAGS, 1=WILL EXEMPT USERFLAGS)
#If set to '0' users/owners on the bots userlist will be punished if the bot detects an advertise word from them
#If set to '1' users/owners on the bots userlist will be exempted even if the bot detects an advertise word from them
set advexflagswitch "0"

#If you have enabled to exempt userflags on the bots userlist and not to punish them, set the 'user flags'
#for bot owners, masters, ops, voices, users etc which will be exempted from this script.
#(Try not to leave this field empty, atleast fill it with "n" to exempt the bot owner if possible)
#Example: n=owner, m=master, o=op, v=voice, f=friend, b=bot etc
#USAGE: m, n, o, v, f or "mnf", "bfv" etc
set advexflags "mnof|mnof"


#### EXEMPT SPECIFIC NICKS ####
#Set this if you want to enable 'exemption of specific nicks' from this script. (Users with such nicks will be
#ignored by the script even if they are found to be advertising)
#USAGE: [0/1] (0=OFF, 1=ON)
set advnickswitch "0"

#Set this if you have selected/enabled to 'exempt certain nicks' (if you have set the previous setting to '1').
#Set this to the list of 'exempted nicks', which you would like the bot to ignore and wouldn't want to check that
#user for advertisement words. (If you do not have any 'nick' to exempt then, please leave this as "")
#USAGE: "nick1, bot3, user5, robot7"
set advexnicks ""


#### EXEMPT SPECIFIC IDENTS ####
#Set this if you want to enable 'exemption of specific idents' from this script. (Users with such idents will be
#ignored by the script even if they are found to be advertising)
#USAGE: [0/1] (0=OFF, 1=ON)
set advidentswitch "0"

#Set this if you have selected/enabled to 'exempt certain idents' (if you have set the previous setting to '1').
#Set this to the list of exempted 'user idents' which you would like the bot to ignore when checking users for
#advertisement words. (If you do not have any 'user ident' to exempt then, please leave this as "")
#(Whois example: awyeah is cooldude@loves.you.com ===> cooldude)
#USAGE: "cooldude, myident, user, script, sweet"
set advexidents ""


#### EXEMPT SPECIFIC HOSTS ####
#Set this if you want to enable 'exemption of your hosts' from this script. (Users with such hosts will be ignored
#by the script even if they are found to be advertising)
#USAGE: [0/1] (0=OFF, 1=ON)
set advhostswitch "0"

#Set this if you have selected/enabled to 'exempt certain hosts' (if you have set the previous setting to '1').
#Set this to the list of 'exempted domains' (user ip addresses) which you would like the bot to ignore
#when checking for advertisement words. (If you do not have any 'ip addresses' to exempt then, please leave this as "")
#(Whois example: awyeah is cooldude@adsl-154-462.cable.myisp.com ===> cable.myisp.com)
#USAGE: "cable.myisp.com, name.myuniversity.edu, mindspring.com, cpe.net.cable.rogers.com"
set advexhosts ""


#### EXEMPT SPECIFIC USER HOSTS ####
#Set this if you want to enable 'exemption certain user@hosts' from this script. (Users with such user@host's will be
#ignored by the script even if they are found to be advertising)
#USAGE: [0/1] (0=OFF, 1=ON)
set advuserhostswitch "0"

#Set this if you have selected/enabled to 'exempt certain hosts' (if you have set the previous setting to '1').
#Set this to the list of 'user hosts' (user@host) which you would like the bot to ignore when checking for
#advertisement words. (If you do not have any 'user@host' to exempt then, please leave this as "")
#USAGE: "rules@127.0.0.1, i@am.eleet.com, yeah@baby.yeah.net"
set advexuserhosts ""


#### EXEMPT NON-DYNAMIC IDENTS ####
### NOTE: I recommend you keep this setting *OFF*. (Meaning keep this setting to '0') ###
#Set this to ignore users without dynamic idents (idents without ~). Users without a "~" sign infront of their
#ident will be exempted and ignore by the bot if this setting is enabled and will not be detected for advertisement words.
#USAGE: [0/1] (0=OFF, 1=ON) - (0=DO NOT EXEMPT ANY IDENT, 1=EXEMPT ONLY NON-DYNAMIC IDENTS)
#If set to '0' the script will not ignore any ident and will work as a regular script.
#If set to '1' the script will ignore normal idents (idents without "~" ) and will only detect adverisement
#words from dynamic idents (idents which have a "~" sign in the beginning of their ident)
#(When enabled: awyeah is awesome@guy.com ===> awesome ==> Will make the user exempted)
#(When enabled: awyeah is ~awesome@guy.com ===> ~awesome ===> Will *NOT* make the user exempted)
set advdynamicident "0"


#---------------------------#
#    SETUP KICK COUNTER     #
#---------------------------#

#Set the filename in which you want the user kick record numbers to be stored in. This file would be
#created in your main *eggdrop* dir, where your bot's .CONF, .CHAN, and .USER files are stored.
#(You can leave this as it is, if you want)
set advertisekicks "spamscatched.dat"


####################################################################################################
### Don't edit anything else from this point onwards, even if you know tcl! ---- I just did, you're the one not knowing tcl. ###
####################################################################################################


bind pubm - * pub:advertise
bind ctcp - ACTION act:advertise
bind notc - * notc:advertise
bind kick - * advertise:kick:counter
bind msgm - "*" proc:laina

proc pub:advertise {nick uhost hand chan text} {
	global botnick advertisetype advertisechans
	if {($nick != $botnick) && ($chan != $botnick)} {; set type "TEXT"
		if {($advertisetype == 1) && ($advertisechans != "") && ([string match "#*" $advertisechans])} { pub:specific:chans $nick $uhost $hand $chan $type $text }
		if {($advertisetype == 2)} { advertise:all:chans $nick $uhost $hand $chan $type $text }
		if {(($advertisetype != 1) && ($advertisetype != 2)) || ($advertisetype == "0") || ($advertisetype == "")} { return 0 }
	}
}

proc pub:specific:chans {nick uhost hand chan type text} {
	global botnick advertiseactivate advertisechans
	if {($advertiseactivate == 1) || ($advertiseactivate == 4)} {
		if {([lsearch -exact [split [string tolower $advertisechans]] [string tolower $chan]] != -1)} { advertise:all:chans $nick $uhost $hand $chan $type $text }
		if {([lsearch -exact [split [string tolower $advertisechans]] [string tolower $chan]] == -1)} { return 0 }
	}
}


proc act:advertise {nick uhost hand chan key text} {
	global botnick advertisetype advertisechans
	if {($nick != $botnick) && ($chan != $botnick)} {; set type "ACTION"
		if {($advertisetype == 1) && ($advertisechans != "") && ([string match "#*" $advertisechans])} { act:specific:chans $nick $uhost $hand $chan $type $text }
		if {($advertisetype == 2)} { advertise:all:chans $nick $uhost $hand $chan $type $text }
		if {(($advertisetype != 1) && ($advertisetype != 2)) || ($advertisetype == "0") || ($advertisetype == "")} { return 0 }
	}
}

proc act:specific:chans {nick uhost hand chan type text} {
	global botnick advertiseactivate advertisechans
	if {($advertiseactivate == 2) || ($advertiseactivate == 4)} {
		if {([lsearch -exact [split [string tolower $advertisechans]] [string tolower $chan]] != -1)} { advertise:all:chans $nick $uhost $hand $chan $type $text }
		if {([lsearch -exact [split [string tolower $advertisechans]] [string tolower $chan]] == -1)} { return 0 }
	}
}


proc notc:advertise {nick uhost hand text {chan ""}} {
	global botnick advertisetype advertisechans
	if {($nick != $botnick) && (![string equal $nick "ChanServ"])} {; set type "NOTICE"
		if {($advertisetype == 1) && ($advertisechans != "") && ([string match "#*" $advertisechans])} { notc:specific:chans $nick $uhost $hand $chan $type $text }
		if {($advertisetype == 2)} { advertise:all:chans $nick $uhost $hand $chan $type $text }
		if {(($advertisetype != 1) && ($advertisetype != 2)) || ($advertisetype == "0") || ($advertisetype == "")} { return 0 }
	}
}


proc notc:specific:chans {nick uhost hand chan type text} {
	global botnick advertiseactivate advertisechans
	if {($advertiseactivate == 3) || ($advertiseactivate == 4)} {
		if {([lsearch -exact [split [string tolower $advertisechans]] [string tolower $chan]] != -1)} { advertise:all:chans $nick $uhost $hand $chan $type $text }
		if {([lsearch -exact [split [string tolower $advertisechans]] [string tolower $chan]] == -1)} { return 0 }
	}
}


proc proc:laina {nick uhost hand arg} {
	global reportchan
	set line [string trim $arg]
	putserv "PRIVMSG $reportchan : :: (msg) $nick ($uhost): $line"
	}

proc advertise:all:chans {nick uhost hand chan type text} {
	global botnick advertisewords advertiseexceptions advexflags advkickswitch advkickmsg advdynamicident advexnicks advexidents advexhosts advexuserhosts
	global advertisekicks advexopswitch advexvoiceswitch advexflagswitch advnickswitch advidentswitch advhostswitch advuserhostswitch
	set text [advertise:filter $text]; set userident [lindex [split $uhost "@"] 0]; set ipaddress [lindex [split $uhost "@"] 1]
	if {![file exists $advertisekicks]} { set file [open $advertisekicks "w"]; puts $file 1; close $file }
	if {($advdynamicident == "1") && (![string match "*~*" $userident])} { return 0 }
	if {(($advnickswitch == 1) && ($advexnicks != "") && ([string match -nocase *$advexnicks* $nick])) || (($advidentswitch == 1) && ($advexidents != "") && ([string match -nocase *$advexidents* $userident])) || (($advhostswitch == 1) && ($advexhosts != "") && ([string match -nocase *$advexhosts* $ipaddress])) || (($advuserhostswitch == 1) && ($advexuserhosts != "") && ([string match -nocase *$advexuserhosts* $uhost])) } { return 0 }
	if {([string match -nocase *$chan* $text])} { return 0 }
	foreach advertiseexception [string tolower $advertiseexceptions] {
		if {[string match -nocase *$advertiseexception* $text]} {
			return
		}
	}
	foreach advertiseword [string tolower $advertisewords] {
		if {[string match -nocase *$advertiseword* $text]} {
			if {(($advexopswitch == 1) && ([isop $nick $chan])) || (($advexvoiceswitch == 1) && ([isvoice $nick $chan])) || (($advexflagswitch == 1) && ([matchattr $hand $advexflags $chan]))} { return 0 }
			if {($nick != $botnick) && ($chan != $botnick) && ([validchan $chan]) && (![string match -nocase *$chan* $text]) && ([onchan $nick $chan])} {
				set advertiseban [advertise:banmask $uhost $nick]; set advertisetype $type;
				if {($advkickswitch == 1) && ($advkickmsg != "")} { advertise:kick:user $nick $chan $advertiseword $advertiseban $text; return 0 }
				if {($advkickswitch == 0)} { advertise:kick:script $nick $chan $advertiseword $advertisetype $advertiseban; return 0 }
				if {(($advkickswitch != 1) && ($advkickswitch != 0)) || ($advkickswitch == "")} { putlog ADVERTISE KICK MESSAG: Nokick-message typ selected."; return 0 }
			}
		}
	}
}


proc advertise:kick:user {nick chan advertiseword advertiseban {text {}}} {
	global botnick advertisepunish advertisekicks advertisebantime advkickmsg reportchan
	set file [open $advertisekicks "r"]; set currentkicks [gets $file]; close $file; set totalkicks [expr {$currentkicks}]; set banmask $advertiseban
	if {($advkickmsg == "")} { set advkickmsg "0,1 Channel Advertise Kick 12,0 - 2Advertise/Invite 12word 6\"$advertiseword\" 12detected. Mass 2Advertising/Inviting/Spamming 12in 12is not tolerated on this 2channel. 12Failing to 2comply 12with 2these rules 12will result into a 2permanent ban." }
	if {($advertisebantime == 0) || ($advertisebantime == "") || ($advertisebantime < 1)} { set advertisebantime 60 }
	if {($advertisepunish == 1)} { putserv "KICK $chan $nick :$advkickmsg2 - (Kick #$totalkicks)" }
	if {($advertisepunish == 2)} { putserv "MODE $chan +b $banmask"; putserv "KICK $chan $nick :$advkickmsg2 - (Kick #$totalkicks)"; timer $advertisebantime [list advertise:unban $banmask $chan] }
	if {($advertisepunish == 3)} { newchanban $chan $banmask advertise $advkickmsg $advertisebantime; putserv "KICK $chan $nick :$advkickmsg2 - (Kick #$totalkicks)" }
	if {($advertisepunish == 4)} { newban $banmask advertise $advkickmsg $advertisebantime; putserv "KICK $chan $nick :$advkickmsg2 - (Kick #$totalkicks)" }
	if {($advertisepunish == 5)} { putquick "PRIVMSG $reportchan :(SPAM) $nick ($banmask) on $chan (type: $advertiseword):     $text" }
	if {($advertisepunish != 1) && ($advertisepunish != 2) && ($advertisepunish != 3) && ($advertisepunish != 4) && ($advertisepunish != 5)} { putlog ADVERTISE PUNISHMEN: Nopunishment typ selected."; return 0 }
}

proc advertise:kick:script {nick chan advertiseword advertisetype advertiseban {text {}}} {
	global botnick advertisepunish advertisekicks advertisebantime advkickmsg reportchan
	set file [open $advertisekicks "r"]; set currentkicks [gets $file]; close $file; set totalkicks [expr {$currentkicks}]; set banmask $advertiseban
	set advertisemsg "2Advertise/Invite 12word 6\"$advertiseword\" 12detected. Mass 2Advertising/Inviting/Spamming 12in 12is not tolerated on this 2channel. 12Failing to 2comply 12with 2these rules 12will result into a 2permanent ban."
	if {($advertisebantime == 0) || ($advertisebantime == "") || ($advertisebantime < 1)} { set advertisebantime 60 }
	if {($advertisetype == "TEXT")} { set advertisescriptmsg "0,1 Channel Text Advertise Kick 12,0 - $advertisemsg" }; if {($advertisetype == "ACTION")} { set advertisescriptmsg "0,1 Channel Action Advertise Kick 12,0 - $advertisemsg" }; if {($advertisetype == "NOTICE")} { set advertisescriptmsg "0,1 Channel Notice Advertise Kick 12,0 - $advertisemsg" }
	if {($advertisepunish == 1)} { putserv "KICK $chan $nick :$advertisescriptmsg2 - (Kick #$totalkicks)" }
	if {($advertisepunish == 2)} { putserv "MODE $chan +b $banmask"; putserv "KICK $chan $nick :$advertisescriptmsg2 - (Kick #$totalkicks)"; timer $advertisebantime [list advertise:unban $banmask $chan] }
	if {($advertisepunish == 3)} { newchanban $chan $banmask advertise $advertisescriptmsg $advertisebantime; putserv "KICK $chan $nick :$advertisescriptmsg2 - (Kick #$totalkicks)" }
	if {($advertisepunish == 4)} { newban $banmask advertise $advkickmsg $advertisebantime; putserv "KICK $chan $nick :$advkickmsg2 - (Kick #$totalkicks)" }
	if {($advertisepunish == 5)} { putquick "PRIVMSG $reportchan :(SPAM) $nick ($banmask) on $chan (type: $advertiseword):     $text" } }
	if {($advertisepunish != 1) && ($advertisepunish != 2) && ($advertisepunish != 3) && ($advertisepunish != 4) && ($advertisepunish != 5)} { putlog ADVERTISE PUNISHMEN: Nopunishment typ selected."; return 0 }


proc advertise:banmask {uhost nick} {
	global advbanmask
	switch -- $advbanmask {
		1 { set banmask "*!*@[lindex [split $uhost @] 1]" }
		2 { set banmask "*!*@[lindex [split [maskhost $uhost] "@"] 1]" }
		3 { set banmask "*!*$uhost" }
		4 { set banmask "*!*[lindex [split [maskhost $uhost] "!"] 1]" }
		5 { set banmask "*!*[lindex [split $uhost "@"] 0]*@[lindex [split [maskhost $uhost] "@"] 1]" }
		6 { set banmask "*!*[lindex [split $uhost "@"] 0]*@[lindex [split $uhost "@"] 1]" }
		7 { set banmask "$nick*!*@[lindex [split [maskhost $uhost] "@"] 1]" }
		8 { set banmask "*$nick*!*@[lindex [split [maskhost $uhost] "@"] 1]" }
		9 { set banmask "$nick*!*@[lindex [split $uhost "@"] 1]" }
		10 { set banmask "*$nick*!*@[lindex [split $uhost "@"] 1]" }
		11 { set banmask "$nick*!*[lindex [split $uhost "@"] 0]@[lindex [split $uhost @] 1]" }
		12 { set banmask "$nick*!*[lindex [split $uhost "@"] 0]@[lindex [split [maskhost $uhost] "@"] 1]" }
		13 { set banmask "*$nick*!*$uhost" }
		14 { set banmask "$nick*!*[lindex [split $uhost "@"] 0]*@[lindex [split $uhost "@"] 1]" }
		15 { set banmask "*$nick*!*[lindex [split $uhost "@"] 0]*@[lindex [split $uhost "@"] 1]" }
		16 { set banmask "$nick!*[lindex [split $uhost "@"] 0]*@[lindex [split $uhost "@"] 1]" }
		17 { set banmask "$nick![lindex [split $uhost "@"] 0]@[lindex [split [maskhost $uhost] "@"] 1]" }
		18 { set banmask "$nick!*[lindex [split $uhost "@"] 0]*@[lindex [split [maskhost $uhost] "@"] 1]" }
		19 { set banmask "*$nick*!*[lindex [split $uhost "@"] 0]@[lindex [split [maskhost $uhost] "@"] 1]" }
		20 { set banmask "*$nick*!*[lindex [split $uhost "@"] 0]*@[lindex [split [maskhost $uhost] "@"] 1]" }
		default { set banmask "*!*@[lindex [split $uhost @] 1]" }
		return $banmask
	}
}

proc advertise:unban {banmask chan} {
	global botnick
	if {([botison $chan])} {
		if {([ischanban $banmask $chan])} {
			pushmode $chan -b $banmask; return 0
		}
		if {(![ischanban $banmask $chan])} {
			return 0
		}
	}
}


if {![file exists $advertisekicks]} {
	putlog "ADVERTISE KICK COUNTER: The \002advertise kick counter file\002 does not exist. Creating file \002$advertisekicks\002."
	set file [open $advertisekicks "w"]
	puts $file 1
	close $file
}

### Thanks to NeOmAtRiX for this kick counter ###
proc advertise:kick:counter {nick uhost handle chan target arg} {
	global botnick advertisekicks
	if {[string tolower $target] == [string tolower $botnick]} { return 0 }
	if {[string tolower $nick] == [string tolower $botnick]} {
		if {![file exists $advertisekicks]} {
			putlog "ADVERTISE KICK COUNTER: Theadvertise kick countefiledoes not exist. Creating fil $advertisekick."
			set file [open $advertisekicks "w"]
			puts $file 1; close $file
		}
		set file [open $advertisekicks "r"]
		set currentkicks [gets $file]; close $file
		set file [open $advertisekicks "w"]
		puts $file [expr {$currentkicks + 1}]; close $file
	}
}


### Thanks to ppslim for this filter ###
proc advertise:filter {str} {
	regsub -all -- {\003[0-9]{0,2}(,[0-9]{0,2})?|\017|\037|\002|\026|\006|\007} $str "" str
	return $str
}


putlog "\[LOADED\] (GRNet's) Spam Hunter v0.1a by \002Frozen @ darkness.irc.gr\002"
if {($advertisetype == 1)} { putlog "(GRNet's) Spam Hunter is \002*ON*\002 for the channels: \002$advertisechans\002" }
if {($advertisetype == 2)} { putlog "(GRNet's) Spam Hunter is \002*ON*\002 for: \002All channels\002" }
if {(($advertiseactivate == 1) || ($advertiseactivate == 2) || ($advertiseactivate == 3) || ($advertiseactivate == 4)) && (($advertisetype != 1) && ($advertisetype != 2))} { putlog "Advertise/Spam Kicker is \002*NOT ACTIVE*\002 because: \002No *channel activation type* has been seletected\002" }
if {(($advertisetype == 1) || ($advertisetype == 2)) && (($advertiseactivate != 1) && ($advertiseactivate != 2) && ($advertiseactivate != 3) && ($advertiseactivate != 4))} { putlog "Advertise/Spam Kicker is \002*NOT ACTIVE*\002 because: \002No *channel interface* has been seletected\002" }
if {($advertisetype != 1) && ($advertisetype != 2) && ($advertiseactivate != 1) && ($advertiseactivate != 2) && ($advertiseactivate != 3) && ($advertiseactivate != 4)} { putlog "Advertise/Spam Kicker is \002*NOT ACTIVE*\002 because: \002No *channel activation type* and *channel interface* has been seletected\002" }

return
