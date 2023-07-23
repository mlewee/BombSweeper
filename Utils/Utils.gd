extends Node
class_name Global


func dir_contents(path):
	var files = []
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				print("Found directory: " + file_name)
			else:
				if not file_name.contains(".import"):
					files.append(path + file_name)
				file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
	return files
