update-plugins:
	for dir in pack/manual/start/*; do \
		git -C "$dir" pull; \
	done
