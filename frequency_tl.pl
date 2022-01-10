# This program prints a frequency list of all words in a folder of srt files

#!/usr/bin/perl
use strict;
use warnings;
#use Class::CSV;

my $dirname = 'subs';
my @words; 
my %count;

opendir(DIR, $dirname) or die "Could not open dirname\n";

while (my $filename = readdir(DIR)) {
  open(my $in,  "<",  $dirname . '/' . $filename)  or die "Can't open $filename: $!";
  while (<$in>) {     # assigns each line in turn to $_
    if (/^[a-zA-ZäÄöÖåÅ\[\]]+/){ # checks if 
      my @words = split / /, $_;
      foreach (@words){
        $_ =~ s/[^a-zA-ZäÄöÖåÅ]//g; 
        $_ = lc $_;
        
        $count{$_}++;

      }
    }
  }
  close($in);
}

foreach my $word (sort { $count{$a} <=> $count{$b} } keys %count) {
    print $word . " " . $count{$word} . "\n";
}

closedir(DIR);