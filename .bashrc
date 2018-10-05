#Custom PS1 used in Zach's WSL

#time color: 31 => red
#user color 34 => blue
#$ color: 35 => purple
#         33 => yellow
#         36 => cyan
#         37 => white
#\d = date
#\t = time (24 hr clock)
#PS1="\[\033[31m\\][\d \t] \[\033[34m\]\u@\h\[\033[35m\]\w(\$(git branch 2>/dev/null | grep '^*' | colrm 1 2))\$ "

PS1="\[\033[1;35m\\][\d \t] \[\033[1;36m\]\u \[\033[1;37m\]\w\$ "