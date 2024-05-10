#!/bin/bash

SEP=:
TEMP=temp.$$

[ "$DB_TXT" ] || {
	echo "Database not informed. Use the variable DB_TXT."
	return 1
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

has_key() {
	grep -i -q "^$1$SEP" "$DB_TXT"
}
