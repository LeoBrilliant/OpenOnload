#!/bin/bash

# Find the libc which is really used.  Usually, it is one of
# /lib/libc.so.6, /lib32/libc.so.6, /lib64/libc.so.6.
# Debian-derivative name conventions differ from other linuxes.
# So, we do not try to guess and ask the system.
find_libc()
{
    local dir=$(mktemp -d)
    cat >$dir/hello.c <<EOF
int main(int argc, char ** argv) {return 0;}
EOF
    $CC $CFLAGS $dir/hello.c -o $dir/hello >/dev/null
    if [[ $? != 0 ]] ; then
	echo "-1"
	exit
    fi
    ldd $dir/hello |egrep '^[[:space:]]*libc.so.6[[:space:]]' \
        |awk '{print $3}'
    rm -rf $dir
}

# Check if the library has the given symbol.
find_sym()
{
    local lib="$1"
    local sym="$2"
    local header="$3"

    echo -n "#define CI_LIBC_HAS_$sym " >>$header
    if nm -D "$lib" |grep -q "$sym"; then
        echo "1" >>$header
    else
        echo "0" >>$header
    fi
}

libc_path=$(find_libc)
header="$1"

if [[ $libc_path == "-1" ]] ; then
    exit -1
fi

cat >"$header" <<EOF
/* This header is generated by scripts/libc_compat.sh */
EOF

for sym in __read_chk __recv_chk __recvfrom_chk __poll_chk \
           accept4 pipe2 dup3  epoll_pwait ppoll sendmmsg splice; do
    find_sym "$libc_path" "$sym" "$header"
done

{
echo -n "#define CI_HAVE_PCAP "
check_library_presence pcap.h pcap
echo -n "#define CI_HAVE_SPLICE_RETURNS_INT "
check_prototype fcntl.h splice \
    "int (*foo)(int, loff_t*, int, loff_t*, size_t, unsigned int)"
echo -n "#define CI_HAVE_SPLICE_RETURNS_SSIZE_T "
check_prototype fcntl.h splice \
    "ssize_t (*foo)(int, loff_t*, int, loff_t*, size_t, unsigned int)"
# Some Ubuntus (1504) have timespec parameter in recvmmsg without
# "const" keyword.  We assume normal definition of recvmmsg if it is not
# present in libc.
echo -n "#define CI_HAVE_RECVMMSG_NOCONST_TIMESPEC "
check_prototype sys/socket.h recvmmsg \
    "int (*foo)(int, struct mmsghdr*, unsigned int, int,
                struct timespec*)"
echo -n "#define CI_HAVE_NET_TSTAMP "
check_header_presence linux/net_tstamp.h
} >> $header