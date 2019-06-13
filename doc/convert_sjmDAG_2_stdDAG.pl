use strict;
use warnings;
use feature 'say';
use Data::Dumper;
$Data::Dumper::Sortkeys = 1;

#===================================================

# Convert SJM DAG script to STANDARD DAG script.

# yangh3857\@berryoncology.com

# 2019/06/13

#===================================================


my $sjm_dot = shift;

die "perl $0 <sjm.original.dot> \n\n" unless $sjm_dot;

my (%h,%name2order,$i,$content);

$content =<<EOF;
digraph standard_dag {
    graph[bgcolor=white, margin=0];
    node[shape=box, style=rounded, fontname=sans,                 fontsize=10, penwidth=2];
    edge[penwidth=2, color=grey];
EOF


#=================================
# GET ALL NODES
#=================================
open F,"sed 1d $sjm_dot|sed \\\$d|grep color|";
while(<F>){
	chomp;
	s/^\s+//;
	if(/^(.*)\[color=/){
		#aln_Z18W03723-T_1[color=gray];
		#1[label = "trimming\nSAMPLES: 0004", color = "0.33 0.6 0.85", style="rounded"];
		my $node_name = $1;
		$i ++;
		@{$h{$i}} = ($node_name,"$i\[label = \"$node_name\", color = \"0.33 0.6 0.85\", style=\"rounded\"\];");
		$name2order{$node_name} = $i;
	}
}
close F;

for my $k (sort {$a <=> $b} keys %h){
	$content .= "@{$h{$k}}[-1]\n";
}

#=================================
# GET THE ORDER OF ALL NODES
#=================================
open F,"sed 1d $sjm_dot|sed \\\$d|grep -v color|";
while(<F>){
    chomp;
    s/^\s+//;
	my ($nodeA,$nodeB) = $_ =~ m|(\S+) -> (\S+);|;
	$content .= "$name2order{$nodeA} -> $name2order{$nodeB}\n";
}
close F;

$content .= "\n}\n";
say $content;
