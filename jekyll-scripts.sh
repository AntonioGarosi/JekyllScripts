# Scripts to handle my goddam portfolio
# ./jekyll-scripts.sh build - Exports site and updates GithubPages
# ./jekyll-scripts.sh build locale - Exports site with local dependencies
# ./jekyll-scripts.sh serve - Mounts site locally and opens it in the browse (firefox). --livereload active by default
# ./jekyll-scripts.sh new - Makes a new post page and opens it in the editor //NOT IMPLEMENTED YET
# ./jekyll-scripts.sh new *template* - Makes a new project of the chosen template and opens it in the editor //NOT IMPLEMENTED YET

#Build location - _site by Jekyll default, change it in case of different destination
REPO="_site"

case $1 in
build)
    if [ -z $2 ]
    then
        JEKYLL_ENV=production jekyll build
        cd $REPO
        git add .
        printf "\n"
        read -p "Please, write a message for the commit: " MSG
        git commit -m "$MSG"
        git push
        GITMSG=" and uploaded"
    else
        if [ $2 == "local" ]
        then
            jekyll build
        else
            ERROR_DUMP="Wait! You building against what?"
        fi
    fi
    if [ -z "$ERROR_DUMP" ]
    then
        printf "\nBuild done$GITMSG, thank you!\n\n"
    fi
;;
serve)
    #Understand how to optimize this function
    firefox http://127.0.0.1:4000/ & jekyll serve --livereload
;;
new)
    if [ -e scripts/new.sh ]
    then
        TYPE=""
        #change check to an array of strings according to templates
        if [ $2 == "template" ]
        then
            $TYPE=$2
        fi
        #Not implemented yet
        ./scripts/new.sh $TYPE
    else
        ERROR_DUMP="ERROR!!! scripts/new.sh not found!!!"
    fi
;;
*)
    printf "Invalid input\n"
esac

if [ -n "$ERROR_DUMP" ]
then
    printf "\n$ERROR_DUMP\n\n"
fi