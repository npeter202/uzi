; // vim: set ft=tf:

/if (criticalbeep=~'') /set criticalbeep=1%;/endif
/if (logondeath=~'') /set logondeath=1%;/endif

/def -p3 -aBCmagenta -t'You are dead!  Sorry...*' reneter = \
    /if (logondeath=1) \
        /log %{uzidirectory}/logs/%{char}.txt%;/recall /200%;/log off%;\
    /endif%;\
    /set death=1%;\
    /set protectee=%;\
    /set aura=%;\
    1%;\
    aff%;\
    /set oldweapon=%{weapon}%;\
    /repeat -0:00:10 1 /spellup%;\
    /repeat -0:00:20 1 /buycorpse%;\
    /resetdamage%;\
    /reset_affects

/def buycorpse = \
    /if ({hometown} =/ 'Karandras') \
        s%;\
        /if (autobuy) \
            s%;s%;w%;w%;w%;buy corpse%;\
        /endif%;\
    /elseif ({hometown} =/ 'Myrridon') \
        w%;w%;\
        /if (autobuy) \
            e%;e%;n%;n%;buy corpse%;\
        /endif%;\
    /endif%;\

/def -p3 -mregexp -t'^\[INFO\] ([A-z]+) (killed by|was|died|committed|cunningly|bled)' tank_killed= \
    /if ({P1}=~tank & oldtank=~char) \
        /echo -aBCcyan *** DOH DOH DOH DOH DOH DOH DOH DOH %;\
        /set oldtank=%{tank}%;\
        /set tankdied=1%;\
        /if (criticalbeep=1) \
            /beeper%;\
        /endif%;\
        /set wimpylevel2=%{wimpylevel}%;\
        /set wimpylevel=$[{wimpylevel}+{wimpyplus}]%;\
    /endif
