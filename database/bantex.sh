#!/bin/bash

SEP=:
TEMP=temp.$$
MASK=ä

[ "$DB_TXT" ] || {
	echo "Database not informed. Use the variable DB_TXT."
	return 1
}

[ -r "$DB_TXT" -a -w "$DB_TXT" ] || {
	echo "Database locked, check read and write permissions"
	return 1
}

has_key() {
	grep -i -q "^$1$SEP" "$DB_TXT"
}

fields() {
	head -n 1 "$DB_TXT" | tr $SEP \\n
}

delete_row() {
	has_key "$1" || return
	grep -i -v "^$1$SEP" "$DB_TXT" >"$TEMP"
	mv "$TEMP" "$DB_TXT"
	echo "Row '$1' was deleted"
}

insert_row() {
	local key=$(echo "$1" | cut -d $SEP -f1)

	if has_key "$key"; then
		echo "Key '$key' already is in the database"
		return 1
	else
		echo "$*" >>"$DB_TXT"
		echo "Row of '$key' inserted successfully"
	fi
	return 0
}

show_row() {
	local data=$(grep -i "^$1$SEP" "$DB_TXT")
	local i=0

	[ "$data" ] || return

	fields | while read field; do
		i=$((i + 1))
		echo -n "$field: "
		echo "$data" | cut -d $SEP -f $i
	done
}
