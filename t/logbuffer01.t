
BEGIN {				# Magic Perl CORE pragma
    if ($ENV{PERL_CORE}) {
        chdir 't' if -d 't';
        @INC = '../lib';
    }
}

my @level;
BEGIN {
    @level = qw(
     debug
     info
     notice
     warning
     error
     critical
     alert
     emergency
    );
}

use Test::More tests => 5 + @level + 2*(1 + (2 * @level)) + 1;
use strict;
use warnings;

use_ok( 'Log::Dispatch::Buffer' );
can_ok( 'Log::Dispatch::Buffer',qw(
 fetch
 flush
 new
 log_message
) );

my $dispatcher = Log::Dispatch->new;
isa_ok( $dispatcher,'Log::Dispatch' );

my $channel = Log::Dispatch::Buffer->new( qw(name default min_level debug) );
isa_ok( $channel,'Log::Dispatch::Buffer' );

$dispatcher->add( $channel );
is( $dispatcher->output( 'default' ),$channel,'Check if channel activated' );

foreach my $method (@level) {
    eval { $dispatcher->$method( "This is a '$method' action" ) };
    ok( !$@,qq{Check if dispatcher method '$method' ok} );
}

foreach my $method (qw(fetch flush)) {
    my $messages = $channel->$method;
    is( scalar @{$messages},scalar @level,
     qq{Check if right number of messages for "$method"} );

    foreach my $i (0..$#$messages) {
        my $message = $messages->[$i];
        is( $message->{'level'},$level[$i],
         qq{Check if right level of message $i for "$method"} );
        is( $message->{'message'},"This is a '$level[$i]' action",
         qq{Check if right contenct of message $i for "$method"} );
    }
}

is( scalar( @{$channel->fetch} ),0,"Check if no messages left" );
