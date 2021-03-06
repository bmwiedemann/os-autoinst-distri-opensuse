use base "yasttest";
use bmwqemu;

# test yast2 lan functionality
# https://bugzilla.novell.com/show_bug.cgi?id=600576

sub run() {
    my $self = shift;
    script_sudo("/sbin/yast2 lan");
    waitstillimage();

    # FIXME: add assert_screen here
    save_screenshot;
    if ( $vars{LIVETEST} || $vars{DISTRI} eq "sled-11" || $vars{LAPTOP} ) {
        send_key "ret";      # confirm networkmanager popup
        sleep 1;
        send_key "alt-t";    # traditional ifup
        sleep 1;
    }

    my $hostname = "susetest";
    my $domain   = "zq1.de";

    send_key "alt-s";       # open hostname tab
    sleep 2;
    send_key "tab";
    for ( 1 .. 15 ) { send_key "backspace" }
    type_string $hostname;
    send_key "tab";
    for ( 1 .. 15 ) { send_key "backspace" }
    type_string $domain;
    sleep 5;
    assert_screen 'test-yast2_lan-1', 3;
    send_key "alt-o";       # confirm possible network manager warning
    send_key "alt-o";       # OK=>Save&Exit
    sleep 20;
    wait_idle;
    wait_idle 180;

    send_key "ret";
    send_key "ctrl-l";      # clear screen
    script_run('echo $?');
    script_run('hostname');
    assert_screen 'test-yast2_lan-2', 3;
}

sub test_flags() {
    return { 'milestone' => 1, 'fatal' => 1 };
}

1;

# vim: set sw=4 et:
