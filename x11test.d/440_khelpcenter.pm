use base "basetest";
use bmwqemu;

sub is_applicable() {
    return $vars{DESKTOP} eq "kde";
}

sub run() {
    my $self = shift;
    x11_start_program("khelpcenter");
    assert_screen 'test-khelpcenter-1', 3;
    send_key "alt-f4";
    sleep 2;
}

1;
# vim: set sw=4 et:
