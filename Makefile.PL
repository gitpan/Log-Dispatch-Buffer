require 5.006;

use strict;
use ExtUtils::MakeMaker;
eval "use Devel::Required";

WriteMakefile (
 NAME		=> "Log::Dispatch::Buffer",
 AUTHOR		=> 'Elizabeth Mattijsen (liz@dijkmat.nl)',
 ABSTRACT	=> 'Log::Dispatch::Buffer - Base class for collecting logged messages',
 VERSION_FROM	=> 'lib/Log/Dispatch/Buffer.pm',

 PREREQ_PM	=> {qw(
		    Log::Dispatch	1.16
                   )},
);
