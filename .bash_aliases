alias ls="ls --color"
alias ll="ls -l"
alias ltr="ls -ltr"
alias l="ls"
alias addkeys="ssh-add -t `echo 6*3600 | bc` ~/.ssh/home ~/.ssh/id_rsa"
alias dquilt="quilt --quiltrc=${HOME}/.quiltrc-dpkg"
#alias pbuilder="sudo DIST=trusty pbuilder --distribution trusty --architecture amd64 --configfile ~/.pbuilderrc --binary-arch amd64 --pbuilderroot sudo"
#alias pdebuild="sudo DIST=trusty pdebuild --architecture amd64 --configfile ~/.pbuilderrc --pbuilderroot sudo"
alias pyactivate='. ./.venv/bin/activate'
alias pyserve='python -m SimpleHTTPServer 8080'
