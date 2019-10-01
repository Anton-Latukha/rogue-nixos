#!/run/current-system/sw/bin/bash

###
### Description
###

# This script does a rollback of Nix/NixOS. It is designed to be triggered multiple times. Every time it would rollback one step further until generation that is set in file would become currently running one, or if system meets one of the special checks.

###
### Declaration
###

BIN_PATH='/run/current-system/sw/bin'

# Dictionary ISO date RegEx
ISO_DATE_REGEX='(([1-9][0-9]*)?[0-9]{4})-(1[0-2]|0[1-9])-(3[01]|0[1-9]|[12][0-9])\s*(T)?(2[0-3]|[01][0-9]):([0-5][0-9]):([0-5][0-9])(\\.[0-9]+)?(Z)?'

# CERRENT_GENERATION_REGEX matches the form of GENERATIONS_LIST: generation, ISO date, (current). But selects to output only a generation number.
CERRENT_GENERATION_REGEX='([0-9]+)(?=\s*'"$ISO_DATE_REGEX"'\s*\(current\))'

ROLLBACK_TOWARDS_GENERATION_FILE='/nix/var/nix/rollback-version'


###
### Evaluations
###


# Get a list of Nix generations
## `su` is used to overcome Nix bug #224
GENERATIONS_LIST="$(/run/wrappers/bin/su - -c "$BIN_PATH/nix-env --list-generations -p /nix/var/nix/profiles/system")"
## GENERATIONS_LIST has form of:
##
##  95   2017-11-23 07:09:36   
##  96   2017-11-26 23:44:26   
##  97   2017-11-27 17:24:15   (current)
##


# Using RegEx get current generation number from a list of generations
CURRENT_GENERATION="$("$BIN_PATH"/echo "$GENERATIONS_LIST" | "$BIN_PATH"/grep -Po "$CERRENT_GENERATION_REGEX")"

ROLLBACK_TOWARDS_GENERATION="$("$BIN_PATH"/cat "$ROLLBACK_TOWARDS_GENERATION_FILE")"


###
### Main
###


## If file that controls rollback version does not exist - save curent generation as one to rollback towards, and exit
if [ ! -f "$ROLLBACK_TOWARDS_GENERATION_FILE" ] ; then

  "$BIN_PATH"/echo "BECAUSE THERE IS NO $ROLLBACK_TOWARDS_GENERATION_FILE SAVING CURRENT STATE AS ROLLBACK THERE"
  exit 0

fi

## If generation list have less than 2 versions - we have nowhere to rollback.
if [ "$("$BIN_PATH"/echo "$GENERATIONS_LIST" | "$BIN_PATH"/wc -l)" -lt 2 ] ; then
  "$BIN_PATH"/echo "WE HAVE NOWHERE TO ROLLBACK"
  exit 0
fi


## This does the rollback itself.
if [ "$CURRENT_GENERATION" -gt "$ROLLBACK_TOWARDS_GENERATION" ] ; then
    "$BIN_PATH"/echo "ROLLING BACK FROM $CURRENT_GENERATION TOWARDS $ROLLBACK_TOWARDS_GENERATION"
    ## `su` is used to overcome Nix bug #224
    /run/wrappers/bin/su - -c "$BIN_PATH/nixos-rebuild switch --rollback"
    exit 0
fi

