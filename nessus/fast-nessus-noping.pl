#!/bin/perl

print "Using target IP file $ARGV[0]\n";
$rate="--max-rate 1000 --min-rate 800 --max-retries 1";
$infile=$ARGV[0];

if (! -f $infile)
{
    die "File $infile not found\n";
} 

if (! -f "$infile-tcp-nmap.nmap") {
    print "TCP scanning...\n";
    print "nmap -Pn -r -n -iL $infile -oA $infile-tcp-nmap $rate -p1-65535\n";
    $nmap=`nmap -Pn -r -n -iL $infile -oA $infile-tcp-nmap $rate -p1-65535`;
  
}
else
{
    print "Using cached TCP scan $infile-udp-nmap.nmap and $infile-udp-nmap.gnmap\n";
}

if (! -f "$infile-udp-nmap.nmap") {
    print "UDP scanning...\n";
    print "nmap -Pn -r -n -sU -iL $infile -oA $infile-udp-nmap $rate\n"; 
    $nmap=`nmap -Pn -r -n -sU -iL $infile -oA $infile-udp-nmap $rate`;
}
else 
{
    print "Using cached UDP scan $infile-udp-nmap.nmap \n";
}

$cmd=`cat $infile-tcp-nmap.gnmap | grep Up | cut -f 2 -d' ' | sort -u > live-hosts.txt`;
$cmd=`cat live-hosts.txt`;
print "#paste into nessus hosts field, or use 'live-hosts.txt' as input file for scan\n$cmd\n\n";

$cmd1=`cat $infile-tcp-nmap.nmap | grep open | cut -f 1 -d' ' | cut -f 1 -d'/' | sort -u > live-tcp-ports.txt`;
$cmd2=`cat $infile-udp-nmap.nmap | grep open | cut -f 1 -d' ' | cut -f 1 -d'/' | sort -u > live-udp-ports.txt`;

$cmd3=`cat live-udp-ports.txt live-tcp-ports.txt | tr "\n" "," > live-ports.txt`;

$cmd=`cat live-ports.txt`;
$cmd=~s/,$//;
$cmd=~s/All,//;
$cmd=~s/None,//;
$cmd=~s/Not,//;
$cmd=~s/,Warning://;
$cmd=~s/,\|_http-open-proxy://;

if ($cmd=~m/4786/) {
  print "WARNING - nessus of port 4786 can cause certain Cisco switches to reload their config!\n";
}
$cmd=~s/,4786//;
print "#paste this into nessus ports field for scan policy\n$cmd\n";

