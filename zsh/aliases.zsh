alias zr="source ~/.zshrc"
alias als="alias"

TELEPORT_USERNAME=tunacuma

# connecting to servers
alias udemy-tsh-check='tsh status &>/dev/null && echo tsh already connected || tsh login --login $TELEPORT_USERNAME --proxy teleport.udsrvs.net >/dev/null'
alias udemy-tunnel='udemy-tsh-check && ssh -Tg legacy-dev'
alias udemy-release-monolith="udemy-tsh-check && tsh ssh $TELEPORT_USERNAME@infra001-va2.udsrvs.net"
alias udemy-release-service="udemy-tsh-check &&tsh ssh $TELEPORT_USERNAME@infra001-useast1.plt.udsrvs.net"

# for local development on monolith, presuming you are in the monorepo dir
alias udemy-activate='source ~/.virtualenvs/udemy/bin/activate'
alias udemy-test-unit='./manage.py test --settings=udemy.settings.test_unit'
alias udemy-test-unit-with-stdout='./manage.py test --settings=udemy.settings.test_unit -s'  # Useful when you need to run pdb.
alias udemy-test-integration='./manage.py test --settings=udemy.settings.test_integration'
alias udemy-test-integration-with-stdout='./manage.py test --settings=udemy.settings.test_integration -s'  # Useful when you need to run pdb.
alias udemy-test-recreate-db='REUSE_DB=0 ./manage.py test --settings=udemy.settings.test_integration --noinput udemy/code_checks && REUSE_DB=0 ./manage.py test --settings=udemy.settings.test_integration --noinput --keepdb udemy/code_checks'
alias udemy-test-coverage='./manage.py test --settings=udemy.settings.test_coverage'
alias udemy-shell-plus='./manage.py shell_plus --settings=udemy.settings.local'
alias udemy-runserver='./manage.py runserver 8000'
alias udemy-killserver='kill $(sudo lsof -t -i:8000)'
alias udemy-buildfrontend='./manage.py buildfrontend --steps main iso'
alias udemy-webpack-dev-server='./manage.py webpackdevserver'
alias udemy-icomoon-update='./manage.py icomoon --settings=udemy.settings.local'
alias udemy-its-not-my-fault-tests-are-failing='git fetch && git rebase origin/master && echo "When it is safe to do so, please run: git push -f"'
