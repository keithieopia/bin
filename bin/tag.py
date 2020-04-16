#!/usr/bin/env python3

import sqlite3
import hashlib
import sys
import os
import glob
from pathlib import Path

BLOCKSIZE=65536 # 64kb
cwd = os.getcwd()


def find_db_path():
	db = None

	if cwd.find("/run/media/") == 0:
		parts = cwd.split('/')
		if len(parts) > 4:
			db = "/run/media/" + parts[3] + "/" + parts[4] + "/.files.db3"
	if db is None:
		db = str(Path.home()) + "/.local/share/files.db3"

	return db

def hash_file(f):
	if os.path.isfile(f):

		# https://stackoverflow.com/a/44873382
		h = hashlib.sha1()
		b = bytearray(128*1024)
		mv = memoryview(b)
		with open(f, 'rb', buffering=0) as f:
			for n in iter(lambda : f.readinto(mv), 0):
				h.update(mv[:n])
		return h.hexdigest()
	
	else:
		sys.exit("Error: \"" + f + "\" is not a file")

def hash_str(s):
	h = hashlib.sha1()
	h.update( s.encode('UTF-8') )
	return h.hexdigest()

#def test():
#	for f in glob.iglob(os.getcwd() + '/**/*', recursive=True):
#		if os.path.isfile(f):
#			print(sha1sum(f) + "  " + f)
#
#def hash_dir():
#	(_, _, files) = next( os.walk( os.getcwd() ) )
#	for f in files:
#		f = os.getcwd() + '/' + f
#		print( hash_file(f) + "  " + os.path.basename(f) )


def show_help():
	print(os.path.basename(__file__) + " [OPTIONS]")
	print("  hash [FILENAME]   SHA1 sum a specific file in the directory")
	print("  hashdir           SHA1 sum all files in the current directory")

def get_files_in_dir():
	nodirs = []
	(_, _, files) = next( os.walk( os.getcwd() ) )
	for f in files:
		if os.path.isfile(f):
			nodirs.append(f)
	
	return nodirs

def show_tags_dir():
	files = get_tags_dir()

	longest = 0
	for f in files:
		length = len( f[0] )
		if longest < length:
			longest = length
	
	print(" FILE " + "|".rjust(longest - 4, ' ') + " TAGS" )
	print("".rjust(longest+10, '='))

	for f in files:
		pad = longest + 2 - len(f[0])
		print(f[0] + " |".rjust(pad, ' '), end=" ") 
		
		if f[1] is False:
			print("[none]")
		else:
			print(", ".join(map(str, f[1])) )

def show_untagged_files():
	files = get_tags_dir()

	for f in files:
		if f[1] is False:
			print(f[0])

def get_tags_dir():
	results = []
	files = get_files_in_dir()
	
	total = len(files)
	count = 0	

	for f in files:
		percent = int(100 * (count / total))
		print("Hashing directory... " + str(count) + "/" + str(total) + ": " + str(percent) + "%", end='\r', flush=True)

		results.append([f, show_tags(f)])
		count += 1

	print()
	return results

def show_tags(f):
	fid = get_fid(f)
	c.execute('SELECT name FROM tags LEFT JOIN file_tags ON file_tags.tid=tags.tid WHERE file_tags.fid=? ORDER BY tags.name', (fid,))

	results = c.fetchall()

	if len(results) == 0:
		return False
	else:
		return results

def get_fid(f):
	pathhash = hash_str(os.getcwd())
	namehash = hash_str(f)

	c.execute('SELECT fid FROM files WHERE pathhash=? AND namehash=?', (pathhash, namehash,))
	fid = c.fetchone()

	if fid is None:
		h = hash_file(f)
		c.execute('SELECT fid FROM files WHERE hash=?', (h,))
		fid = c.fetchone()

		if fid is None:
			c.execute('INSERT INTO files (hash, pathhash, namehash) VALUES (?, ?, ?)', (h, pathhash, namehash))
			fid = c.lastrowid
		else:
			c.execute('UPDATE files SET pathhash=?, namehash=? WHERE fid=?', (pathhash, namehash, fid,))

	conn.commit()
	return fid
	
def rm_tag(f):
	fid = get_fid(f)
	
	if len(sys.argv) == 0:
		sys.exit("You must provide at least one tag to remove")

	c.execute('DELETE FROM file_tags WHERE fid=? AND tid IN (SELECT tid FROM tags WHERE name=?)', (fid, sys.argv[0]))
	conn.commit()

def add_tags(f):
	fid = get_fid(f)
	
	if len(sys.argv) == 0:
		sys.exit("You must provide at least one tag to add")

	for tag in sys.argv:
		c.execute('SELECT tid FROM tags WHERE name=?', (tag,))
			
		tid = c.fetchone()
		if tid is None:
			c.execute('INSERT INTO tags (name) VALUES (?)', (tag,))
			tid = c.lastrowid

		c.execute('SELECT * FROM file_tags WHERE fid=? AND tid = ?', (fid,tid,))
		if c.fetchone() is None:
			c.execute('INSERT INTO file_tags (fid, tid) VALUES (?, ?)', (fid,tid,))

	conn.commit()

##################################################

db = find_db_path()
createSchema = False
if not os.path.isfile(db):
	createSchema = True

conn = sqlite3.connect(db)
conn.row_factory = lambda cursor, row: row[0]
c = conn.cursor()

if createSchema:
	c.execute("CREATE TABLE \"files\" (\"hash\" TEXT NOT NULL UNIQUE, \"fid\" INTEGER PRIMARY KEY AUTOINCREMENT, \"pathhash\" TEXT, \"namehash\" TEXT, \"mtime\" INTEGER)")
	c.execute("CREATE TABLE \"tags\" (\"tid\" INTEGER PRIMARY KEY AUTOINCREMENT, \"name\" TEXT NOT NULL)")
	c.execute("CREATE TABLE \"file_tags\" (\"fid\" INTEGER, \"tid\" INTEGER)")

if len(sys.argv) >= 2:
	sys.argv.pop(0) # filename of script
	action = sys.argv.pop(0)
	
	
	if action == "tag" or action == "add":
		f = sys.argv.pop(0)

		if f == "{}":
			files = get_files_in_dir()

			for f in files:
				add_tags(f)
		else:
			add_tags(f)
		
		print( "Added tags: " + ", ".join(map(str, sys.argv)) )
	
	elif action == "rm":
		f = sys.argv.pop(0)

		if f == "{}":
			files = get_files_in_dir()

			for f in files:
				rm_tag(f)
		else:
			rm_tag(f)
		
		print( "Removed tag: " + sys.argv[0] )
	
	elif action == "untagged":
		show_untagged_files()

	elif action == "list" or action == "ls":
		show_tags_dir()

	elif action == "debug":
		print("PATH HASH: " + hash_str(os.getcwd()) + " str( " + os.getcwd() + " )")
		print("NAME HASH: " + hash_str(sys.argv[0]) + " str( " + sys.argv[0] + " )" )
		print("FILE HASH: " + hash_file(os.getcwd() +"/"+ sys.argv[0]))

	elif action == "show":
		tags = show_tags( sys.argv[0] )
		if tags is False:
			print("No tags for this file!")
		else:
			print("Tags: " + ", ".join(map(str, tags)) )

	else:
		print("Usage: " + os.path.basename(__file__) + " [OPTIONS]")
		print()
		print(" OPTIONS:")
		print("  add|tag [FILE|{}] [TAGS...]  add any number of tags to a file (space separated list)")
		print("  rm [FILE|{}] [TAG]           remove a tag from a file")
		print("  show [FILE]                  shows all tags for a file")
		print("  debug [FILE]                 print all hashes used for file IDing in DB")
		print("  untagged                     list all files in directory without a tag")
		print("  ls|list                      list all files and their tags in directory")
		print()
		print(" NOTES:")
		print("  {}                           expands to all files in directory")