web:
	flutter build web --no-tree-shake-icons
deploy:
	 rsync --human-readable --progress --stats --verbose --chmod=+rx --recursive --delete --force --checksum --itemize-changes build/web/ devclub@devclub.iitd.ac.in:/var/www/html/townsquare
