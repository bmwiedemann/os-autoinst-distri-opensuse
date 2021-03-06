#!/usr/bin/perl -w

##################################################
# Written by:    Xudong Zhang <xdzhang@suse.com>
# Case:        1248989
##################################################

use strict;
use base "basetest";
use bmwqemu;

sub run() {
    my $self = shift;
    mouse_hide();
    x11_start_program("firefox");
    assert_screen "start-firefox", 5;
    if ( $vars{UPGRADE} ) { send_key "alt-d"; wait_idle; }    # dont check for updated plugins
    if ( $vars{DESKTOP} =~ /xfce|lxde/i ) {
        send_key "ret";                                      # confirm default browser setting popup
        wait_idle;
    }

    send_key "ctrl-l";
    sleep 1;
    type_string "http://www.baidu.com\n";
    sleep 3;
    check_screen "firefox_page-baidu", 3;
    send_key "ctrl-l";
    sleep 1;
    type_string "https://en.mail.qq.com\n";
    sleep 3;
    check_screen "firefox_page-qqmail", 3;
    send_key "ctrl-l";
    sleep 1;
    type_string "ftp://download.nvidia.com/novell\n";
    sleep 3;
    check_screen "firefox_page-ftpnvidia", 3;

    send_key "alt-f4";
    sleep 2;
    send_key "ret";
    sleep 2;    # confirm "save&quit"
}

1;
# vim: set sw=4 et:
