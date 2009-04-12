package HTML::EmbedVideo;
use warnings;
use strict;
use version; our $VERSION = qv('0.0.3');

# The simple version
sub html {
	my ($url, $title) = @_;
	$title ||= $url;

	my $out = "";

	my $type;

	# Is it a Google URL
	#       e.g. http://video.google.com/videoplay?docid=7868758765944044541&q=Gliding+Australia&hl=en
	if ($url =~ /docid=([+\-0-9]+)/i) {
		$url = $1;
		$type = 'google';
	}

	# Is it a YouTube URL
	#       e.g. http://www.youtube.com/watch?v=AmoCNV0KUU8
	elsif ($url =~ /watch.+v=([_a-z0-9]+)/cgi) {
		$url = $1;
		$type = 'youtube';
	}

	# Is it a Google ID
	elsif ($url =~ /^([+\-0-9]+)$/) {
		$type = 'google';
	}

	# Is it a YouTube ID
	elsif ($url =~ /^([+\-0-9A-Za-z_]+)$/) {
		$type = 'youtube';
	}

	# Locally supported format ! - Not yet supported !

	# Unknown
	else {
	}

	if ($type eq 'youtube') {
		$out .= qq{
			<object width="425" height="350">
				<param name="movie" value="http://www.youtube.com/v/$url"></param>
				<param name="wmode" value="transparent"></param>
				<embed src="http://www.youtube.com/v/$url" type="application/x-shockwave-flash" wmode="transparent" width="425" height="350"></embed>
			</object>
		};
	}

	elsif ($type eq 'google') {
		$out .= qq{
			<embed 
				style="width:400px; height:326px;" 
				id="VideoPlayback" 
				type="application/x-shockwave-flash" 
				src="http://video.google.com/googleplayer.swf?docId=$url&amp;hl=en"
			> 
			</embed>
		};
	}

	else {
		$out .= qq{
			<a href="$url">$title</a>
		};
	}


}

1; # Magic true value required at end of module
__END__

=head1 NAME

HTML::EmbedVideo - Convert URL or ID into Embedded player


=head1 VERSION

This document describes HTML::EmbedVideo version 0.0.1


=head1 SYNOPSIS

    use HTML::EmbedVideo;

 	print HTML::EmbedVideo::html(
		'http://www.youtube.com/watch?v=7_GS07484AE&feature=dir',
		'Puppies',
	);
  
=head1 DESCRIPTION

This module generated the necessary embed flash player HTML
when presented with a ULR and optional Title.

Currently supported: Google Video, You Tube

TODO: Support for other video systems

=head1 INTERFACE 



=head1 DIAGNOSTICS


=back


=head1 CONFIGURATION AND ENVIRONMENT

HTML::EmbedVideo requires no configuration files or environment variables.


=head1 DEPENDENCIES

None.


=head1 INCOMPATIBILITIES

None reported.


=head1 BUGS AND LIMITATIONS

No bugs have been reported.

Please report any bugs or feature requests to
C<bug-html-embedvideo@rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org>.


=head1 AUTHOR

Scott Penrose  C<< <scott@cpan.org> >>


=head1 LICENCE AND COPYRIGHT

Copyright (c) 2008,2009, Scott Penrose C<< <scott@cpan.org> >>. All rights reserved.

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself. See L<perlartistic>.


=head1 DISCLAIMER OF WARRANTY

BECAUSE THIS SOFTWARE IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
FOR THE SOFTWARE, TO THE EXTENT PERMITTED BY APPLICABLE LAW. EXCEPT WHEN
OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES
PROVIDE THE SOFTWARE "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER
EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE
ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE SOFTWARE IS WITH
YOU. SHOULD THE SOFTWARE PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL
NECESSARY SERVICING, REPAIR, OR CORRECTION.

IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY AND/OR
REDISTRIBUTE THE SOFTWARE AS PERMITTED BY THE ABOVE LICENCE, BE
LIABLE TO YOU FOR DAMAGES, INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL,
OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR INABILITY TO USE
THE SOFTWARE (INCLUDING BUT NOT LIMITED TO LOSS OF DATA OR DATA BEING
RENDERED INACCURATE OR LOSSES SUSTAINED BY YOU OR THIRD PARTIES OR A
FAILURE OF THE SOFTWARE TO OPERATE WITH ANY OTHER SOFTWARE), EVEN IF
SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF
SUCH DAMAGES.
