# ============================================================
#
#  vnc-list.pl
#
#  This script lists the current active vnc sessions. 
#  Please note that this was not written by me and is taken from 
#  this thread: 
#  http://www.realvnc.com/pipermail/vnc-list/2003-May/039052.html
#  
#
# ============================================================

$vncUserDir = "$ENV{HOME}/.vnc";

$NUMSESS=0;
undef @SESS_DESC;
$AUTO_CLEAN_STALE_SESSIONS = 0;
$DBG=0;

sub ListActiveSessions { # -> $NUMSESS, @SESS_DESC, 
    my $HOST;
    chop($HOST = `uname -n`);

    opendir(DIR, $vncUserDir) || do { 
    print STDERR  "Error: No such directory: $vncUserDir\n";
    return undef;
    };
    @files = readdir(DIR);
    closedir DIR;

    @pidfiles = grep  { /:\d+.pid$/ } @files;
    @this_host_pidfiles = grep  { /^$HOST:\d+.pid$/ } @pidfiles;

    foreach $pidfileLastName ( @this_host_pidfiles ) {
    $pidfile = $pidfileLastName;
    $pidpath = "$vncUserDir/$pidfile";

    $pid = SlurpFile( $pidpath );
    chomp( $pid ); $pid =~ s/(\r|\n)*$//;

    print "# processing $pidpath ..\n" if($DBG);

    # check if pidilfe belongs to this host -- (duplicate)
    ($pidhost = $pidfile) =~ s/:.*$//;
    if( $pidhost ne $HOST ) {
        print "# skipping $pidfile, not from this host($HOST)\n" if($DBG);
    } else {
        if(kill(0,$pid)<=0) {
        if($AUTO_CLEAN_STALE_SESSIONS) {
            print "# cleaning stale session ~/.vnc/$pidfile ..\n" if($DBG);
            unlink("$vncUserDir/$pidfile");

            # now remove logilfe
            ($LogFileBase = $pidfile) =~ s/\.pid$/.log/;
            unlink("$vncUserDir/$LogFileBase");
        
        } else {
            print "# stale session: ~/.vnc/$pidfile ..\n" if ($DBG);
        }
        } else {
        print "** Active session: $pidfile \n" if($DBG);

        ($host_and_disp = $pidfile) =~ s/\.pid$//;

        # get starting time
        @stat = stat($pidpath);
        $mtime = $stat[9];
        $asctime = localtime($mtime);

        $SESS_DESC[$NUMSESS] = "$host_and_disp  pid=$pid  started($asctime)";
        $NUMSESS ++;
        }
    }
    }
} #  ListActiveSessions

sub SlurpFile {
    my $rv;
    undef $/;
    open( FILE, $_[0]) || return undef;
    $rv = <FILE>;
    close FILE;
    return $rv;
}

# begin main
if( ($ARGV[0]||"") eq "-D") { $DBG=1; shift @ARGV; }
    if(($ARGV[0]||"") eq "-d") {
        $AUTO_CLEAN_STALE_SESSIONS=1;
    } elsif (  ($ARGV[0]||"") eq "-x") {
        print '$HOME/.vnc/*.pid'. "\n";
        print '$HOME/.vnc/*.log'. "\n";
        exit;
    } elsif (@ARGV != 0) { die "$USAGE\n"; 
}

ListActiveSessions(); # -> $NUMSESS, @SESS_DESC
print STDERR "No active sessions found\n" if($NUMSESS == 0);
for($k=0; $k < $NUMSESS; $k++) {
    print "Active vnc server:  ", $SESS_DESC[$k], "\n";
}
