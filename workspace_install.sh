#git 
ruby publish4rails.rb ./WebAnnotationToolForBirds/public/load.html > ./app/views/workspaces/show.html.erb
#cp ./WebAnnotationToolForBirds/public/load.html
cp ./WebAnnotationToolForBirds/public/*.js ./public/
cp ./WebAnnotationToolForBirds/public/*.gif ./public/
rm -rf ./WebAnnotationToolForBirds/audio
