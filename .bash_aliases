alias ls="ls --color"
alias ll="ls -l"
alias ltr="ls -ltr"
alias l="ls"
alias addkeys="ssh-add -t `echo 6*3600 | bc` ~/.ssh/home ~/.ssh/id_rsa"
alias dquilt="quilt --quiltrc=${HOME}/.quiltrc-dpkg"
#alias pbuilder="sudo DIST=trusty pbuilder --distribution trusty --architecture amd64 --configfile ~/.pbuilderrc --binary-arch amd64 --pbuilderroot sudo"
#alias pdebuild="sudo DIST=trusty pdebuild --architecture amd64 --configfile ~/.pbuilderrc --pbuilderroot sudo"
alias pycreate='virtualenv --no-site-packages .venv'
alias pyactivate='. ./.venv/bin/activate'
<<<<<<< HEAD
alias pyserve='python -m SimpleHTTPServer 8080'
alias ipcalc='ipcalc -n'
=======
alias pyserve='python3 -m http.server 8080 || python2 -m SimpleHTTPServer 8080'
alias ipcalc='ipcalc -n'
alias wttr-s='curl https://wttr.in/?m0pqF'
alias wttr='curl https://wttr.in/?m1pqF'
alias wttr-f='curl https://wttr.in/?mpqF'
>>>>>>> 3b38ce153d33872ca518fb292e0865ea7c5c39ec
