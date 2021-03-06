use base "basetest";
use bmwqemu;

sub run() {
    my $self = shift;
    mouse_hide(1);
    x11_start_program("firefox");
    assert_screen 'test-firefox-1', 3;
    if ( $vars{UPGRADE} ) { send_key "alt-d"; wait_idle; }    # dont check for updated plugins
    if (0) {                                                # 4.0b10 changed default value - b12 has showQuitWarning
        send_key "ctrl-t";
        sleep 1;
        type_string "about:config\n";
        sleep 1;
        send_key "ret";
        wait_idle;
        type_string "showQuit\n\t";
        sleep 1;
        send_key "ret";
        wait_idle;
        send_key "ctrl-w";
        sleep 1;
    }

    # just leave it here, then don't need modify test-firefox-2 and test-firefox-3
    # tag in all related needles
    assert_screen 'test-firefox-2', 3;
    send_key "alt-h";
    sleep 2;    # Help
    send_key "a";
    sleep 2;    # About
    assert_screen 'test-firefox-3', 3;
    send_key "alt-f4";
    sleep 2;    # close About
    send_key "alt-f4";
    sleep 2;
    send_key "ret";    # confirm "save&quit"
}

1;
# vim: set sw=4 et:
