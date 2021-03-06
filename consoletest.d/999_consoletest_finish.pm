use base "basetest";
use bmwqemu;

sub run() {
    my $self = shift;

    # cleanup
    script_sudo_logout;
    sleep 2;
    type_string "loginctl --no-pager\n";
    sleep 2;
    save_screenshot();

    send_key "ctrl-c";
    sleep 1;
    send_key "ctrl-d";    # logout
    sleep 2;

    save_screenshot();

    if ( check_var( "DESKTOP", "textmode" ) ) {
        send_key "ctrl-alt-f1";    # go back to first console
    }
    else {
        send_key "ctrl-alt-f7";    # go back to X11
        sleep 2;
        send_key "backspace";      # deactivate blanking
        if ( check_screen("screenlock") ) {
            if ( check_var( "DESKTOP", "gnome" ) ) {
                send_key "esc";
                assert_screen "gnome-screenlock-password";
            }
            sendpassword;
            send_key "ret";
        }

        # workaround for bug 834165. Apper should not try to
        # refresh repos when the console is not active:
        if ( check_screen "apper-refresh-popup-bnc834165" ) {
            ++$self->{dents};
            send_key 'alt-c';
            sleep 30;
        }
        mouse_hide(1);
    }
    wait_idle;
    assert_screen 'test-consoletest_finish-1', 3;
}

sub test_flags() {
    return { 'milestone' => 1, 'fatal' => 1, 'important' => 1 };
}

1;
# vim: set sw=4 et:
