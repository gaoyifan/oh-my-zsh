dir=$(dirname $0)
source $dir/shell_integration.zsh

function imgcat() {
    $dir/imgcat.zsh "$@"
}

function imgls() {
    $dir/imgls.zsh "$@"
}

function download() {
    $dir/download.zsh "$@"
}
