dir=$(dirname $0)
if [[ "$TERM_PROGRAM" == "iTerm.app" || ( -z "$TERM_PROGRAM" && $dir/it2check ) ]]; then
    source $dir/shell_integration.zsh
fi

UTILITIES=(imgcat imgls it2api it2attention it2check it2copy it2dl it2getvar it2git it2profile it2setcolor it2setkeylabel it2tip it2ul it2universion)
for U in "${UTILITIES[@]}" ;do
    alias $U=$dir/$U
done
