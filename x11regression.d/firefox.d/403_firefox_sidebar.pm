#!/usr/bin/perl -w

##################################################
# Written by:    Xudong Zhang <xdzhang@suse.com>
# Case:        1248980
#Description:    Firefox Sidebar
#
#1.Click View from Firefox menu and click Sidebar.
#2.Select Bookmarks from Sidebar submenu.
#3.Click any bookmark
#4.Select History from Sidebar submenu.
#5.Click any history
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
    send_key "ctrl-b";
    sleep 1;                                                #open the bookmark sidebar
    send_key "tab";
    sleep 1;
    send_key "ret";
    sleep 1;                                                #unfold the "Bookmarks Toolbar"
    send_key "down";
    sleep 1;                                                #down twice to select the "openSUSE" folder
    send_key "down";
    sleep 1;
    send_key "ret";
    sleep 1;                                                #open the "openSUSE" folder
    send_key "down";
    sleep 1;                                                #down twice to select the "openSUSE Documentation"
    send_key "down";
    sleep 1;
    send_key "ret";
    sleep 5;                                                #open the selected bookmark
    check_screen "firefox_sidebar-bookmark", 5;
    send_key "ctrl-b";
    sleep 1;                                                #close the "Bookmark sidebar"

    #begin to test the history sidebar
    send_key "ctrl-h";
    sleep 1;
    send_key "tab";
    sleep 1;                                                #twice tab to select the "Today"
    send_key "tab";
    sleep 1;
    send_key "ret";
    sleep 1;                                                #unfold the "Today"
    send_key "down";
    sleep 1;                                                #select the first history
    send_key "down";
    sleep 1;
    send_key "ret";
    sleep 5;
    check_screen "firefox_sidebar-history", 5;
    send_key "ctrl-h";
    sleep 1;

    #recover all the changes
    send_key "ctrl-b";
    sleep 1;
    send_key "tab";
    sleep 1;
    send_key "down";
    sleep 1;    #down twice to select the "openSUSE" folder
    send_key "down";
    sleep 1;
    send_key "ret";
    sleep 1;    #close the "openSUSE" folder
    send_key "up";
    sleep 1;
    send_key "up";
    sleep 1;
    send_key "ret";
    sleep 1;    #close the "Bookmark Toolbar"
    send_key "ctrl-b";
    sleep 1;    #close the bookmark sidebar

    send_key "ctrl-h";
    sleep 1;
    send_key "tab";
    sleep 1;    #twice tab to select the "Today"
    send_key "tab";
    sleep 1;
    send_key "ret";
    sleep 1;    #close the "Today"
    send_key "ctrl-h";
    sleep 1;

    send_key "alt-f4";
    sleep 2;
    send_key "ret";
    sleep 2;    # confirm "save&quit"
}

1;
# vim: set sw=4 et:
