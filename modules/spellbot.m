;// vim: set ft=tf:

;===============================
;   Tell botter
;===============================
/def -mregexp -t'^([^ ]*) tells the group, \'(imp|fly) ([^ ]*)\'' tellbot = \
    /if (((warlock|magician)>0 & {P2} =/ 'imp') | magician>0) \
        /if ({P1}=~tank & {P3}!/'me') \
            %{P2} %{P3}%;\
        /elseif ({P3}=/'me') \
            /ismember %{P1} %{gplist}%;\
            /if (inlist=1) \
                %{P2} %{P1}%;\
            /endif%;\
        /endif%;\
    /endif

/def -mregexp -t'^([^ ]*) tells the group, \'cop\'' tellbot2 = \
    /if ({P1}=~tank & magician>0 & cop=0) \
        cop%;\
    /endif

/def -mregexp -t'^([^ ]*) tells you \'dd\'' tellbot3 = \
    /if ((magician)>0 & ({P1}=~tank)) \
        dd %{tank}%;\
    /endif

/def -mregexp -t'tells the group, \'dd cop ([^\']+)\'' tellbotcop = \
    /if (ismember({1},gplist) = 1) \
        /if (magician > 0 & copbot=1) \
            dd %P1%;\
            /repeat -0:00:03 1 cop%;\
        /endif%;\
    /endif

/def -mregexp -t'tells the group, \'dd cop\'' tellbotcop2 = \
    /if (ismember({1},gplist) = 1) \
        /if (magician > 0 & copbot=1) \
            dd %1%;\
            /repeat -0:00:03 1 cop%;\
        /endif%;\
    /endif


;===============================
;   Spell Bot
;===============================
/def bot= \
    /if ({1}=/'a*') \
        /set botall=1%;/bot%;\ \
    /elseif ({1}=/'g') \
        /set botgroup=1%;/set botall=0%;/bot%; \
    /elseif ({1}=/'o') \
        /set botall=0%;/set botgroup=0%;/bot%; \
    /else \
        /ecko Botall: %{htxt2}%{botall} %{ntxt}Botgroup: %{htxt2}%{botgroup}%{ntxt}...%;\
    /endif

/def -p999 -mregexp -t'^([A-Za-z]+) asks you \'([^\']*)\'' spellbot = \
    /let _spelltocast=$[replace("'", "", {4})]%;\
    /let _spelltocast2=%{P2}%;\
    /let _persontocast=%{P1}%;\
    /let charbot=ps report info%;\
    /let warlockbot=inv arm str%;\
    /let magicianbot=inv arm str fly%;\
    /let magicianbot2=pblind cop%;\
    /let magician2bot2=gimp ginv gfly%;\
    /let priestbot=heal pow rc cb rp arm bless rev revit regen sanc cc%;\
    /let priestbot2=holy%;\
    /let priest2bot=true%;\
    /let priest2bot2=gpow gheal mira gbless garm%;\
    /let fighterbot=tipi%;\
    /let templarbot=heal rc rp arm bless cc sanc str lay%;\
    /let templar2bot2=mira%;\
    /let nightbladebot=arm%;\
    /let animistbot=sat cc gb%;\
    /let animist2bot=burst%;\
    /let animist2bot2=cos tranq%;\
    /if (_persontocast=~'Elaxer') \
        /set inlist=0%;\
    /elseif (ismember(_persontocast, userlist)) \
        /set inlist=1%;\
    /elseif (botgroup=0 & botall=0) \
        /set inlist=0%;\
    /elseif (botall=1) \
        /set inlist=1%;\
    /elseif (botgroup=1) \
        /ismember %_persontocast %{gplist} %{leader} %{tank}%;\
    /elseif (botgroup=0) \
        /set inlist=0%;\
    /endif%;\
    /if (inlist=1) \
        /if (warlock>0) \
            /let charbot=%{warlockbot} %{charbot}%;\
            /let leadbot=%{warlockbot2} %{leadbot}%;\
        /endif%;\
        /if (magician>0) \
            /let charbot=%{magicianbot} %{charbot}%;\
            /let leadbot=%{magicianbot2} %{leadbot}%;\
        /endif%;\
        /if (magician>1) \
            /let charbot=%{magician2bot} %{charbot}%;\
            /let leadbot=%{magician2bot2} %{leadbot}%;\
        /endif%;\
        /if (priest>0) \
            /let charbot=%{priestbot} %{charbot}%;\
            /let leadbot=%{priestbot2} %{leadbot}%;\
        /endif%;\
        /if (priest>1) \
            /let charbot=%{priest2bot} %{charbot}%;\
            /let leadbot=%{priest2bot2} %{leadbot}%;\
        /endif%;\
        /if (fighter>0) \
            /let charbot=%{fighterbot} %{charbot}%;\
            /let leadbot=%{fighterbot2} %{leadbot}%;\
        /endif%;\
        /if (templar>0) \
            /let charbot=%{templarbot} %{charbot}%;\
            /let leadbot=%{templarbot2} %{leadbot}%;\
        /endif%;\
        /if (templar>1) \
            /let charbot=%{templar2bot} %{charbot}%;\
            /let leadbot=%{templar2bot2} %{leadbot}%;\
        /endif%;\
        /if (nightblade>0) \
            /let charbot=%nightbladebot} %{charbot}%;\
        /endif%;\
        /if (animist>0) \
            /let charbot=%{animistbot} %{charbot}%;\
        /endif%;\
        /if (animist>1) \
            /let charbot=%{animist2bot} %{charbot}%;\
            /let leadbot=%{animist2bot2} %{leadbot}%;\
        /endif%;\
        /if ({P2}=/'info') \
            /let charbot=$(/unique %{charbot})%;\
            /let leadbot=$(/unique %{leadbot})%;\
            /let charbot=$[replace(" ", "&+L, &+W", replace("  ", " ", {charbot}))]%;\
            /let leadbot=$[replace(" ", "&+R, &+W", replace("  ", " ", {leadbot}))]%;\
            tell %{P1} &+LKeywords: &+W%{charbot}%;\
            /if ({P1}=~tank) \
                tell %{P1} &+RLeader only: &+W%{leadbot}%;\
            /endif%;\
        /else \
            /if ({P1}=~tank) \
                /let leadbot=%{leadbot} %{charbot}%;\
                /ismember %_spelltocast %{leadbot}%;\
            /else \
                /ismember %_spelltocast %{charbot}%;\
            /endif%;\
            /if (inlist=1) \
                /if ({5}!~'') \
                    %_spelltocast2%;\
                /else \
                    %_spelltocast2 %_persontocast%;\
                /endif%;\
            /endif%;\
        /endif%;\
    /endif

/if (botall=~'' & botgroup=~'') \
    /bot g%;\
/endif

;;;
