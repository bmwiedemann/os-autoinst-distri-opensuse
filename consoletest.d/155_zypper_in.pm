use base "basetest";
use bmwqemu;

sub run() {
    my $self = shift;
    become_root();

    script_run("zypper lr -d > /dev/$serialdev");
    script_run("killall packagekitd");

    script_run("zypper --gpg-auto-import-keys -n in screen xdelta && echo 'installed' > /dev/$serialdev");
    wait_serial "installed", 200  || die "zypper install failed";
    wait_idle 5;
    script_run('echo $?');
    assert_screen 'test-zypper_in-1', 3;
    sleep 5;
    send_key "ctrl-l";    # clear screen to see that second update does not do any more
    my $pkgname = "xdelta";
    script_run("rpm -e $pkgname && echo 'package_removed' > /dev/$serialdev");
    wait_serial "package_removed" || die "package remove failed";
    script_run("rpm -q $pkgname");
    script_run('exit');
    assert_screen 'test-zypper_in-2', 3;
}

1;
# vim: set sw=4 et:
