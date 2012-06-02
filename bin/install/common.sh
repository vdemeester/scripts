# Common shell function used in local_install scripts
# {{{ download_file
download_file() {
    url=$1
    shift
    output=$1
    shift
    response="$(curl --write-out %{http_code} --output ${output} $url)"
    case $response in
        404 )
            echo "$(basename $0): Version not found (HTTP code ${response})"
            rm $output
            exit 1
            ;;
        200)
            ;;
        * )
            echo "$(basename $0): Unknown problem (HTTP code ${response})"
            rm $output
            exit 2
            ;;
    esac
}
# }}}
# {{{ link_lib
link_lib() {
    libname=$1
    shift
    version=$1
    echo "Linking $libname $version..."
    if test -L $HOME/lib/$libname; then
        echo "$(basename $0): A $libname installation is already present. Change the linking using local_alternative command (if present)."
    else
        ln -s $HOME/lib/$libname-$version $HOME/lib/$libname
    fi
}
# }}}
# {{{ link_binary
link_binary() {
    libname=$1
    shift
    binname=$1
    shift
    version=$1
    echo "Checking $binname bin link..."
    if ! test -L $HOME/bin/$binname-$version; then
        ln -s $HOME/lib/$libname-$version/bin/$binname $HOME/bin/$binname-$version
    fi
    if ! test -L $HOME/bin/$binname; then
        ln -s $HOME/lib/$libname/bin/$binname $HOME/bin/$binname
    fi
}
# }}}

if ! test -d $HOME/lib; then
    echo "$(basename $0): $HOME/lib does not exists, creating it."
    mkdir -p $HOME/lib
fi
