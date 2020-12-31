#!/usr/bin/perl

# in my test server, the source pool is the four drives in the middle hotswap cage
# and the target pool is the four drives in the right-most hotswap cage.

my @sourcedisks;
push @sourcedisks, "/dev/disk/by-id/scsi-SATA_ST12000VN0007-2G_ZCH0BSCK";
push @sourcedisks, "/dev/disk/by-id/scsi-SATA_ST12000VN0007-2G_ZCH0BSFQ";
push @sourcedisks, "/dev/disk/by-id/scsi-SATA_ST12000VN0007-2G_ZCH0BSN1";
push @sourcedisks, "/dev/disk/by-id/scsi-SATA_ST12000VN0007-2G_ZCH0C0K9";

my @targetdisks;
push @targetdisks, "/dev/disk/by-id/scsi-SATA_ST12000VN0007-2G_ZCH0BSSK";
push @targetdisks, "/dev/disk/by-id/scsi-SATA_ST12000VN0007-2G_ZCH0BSTZ";
push @targetdisks, "/dev/disk/by-id/scsi-SATA_ST12000VN0007-2G_ZCH0BSFK";
push @targetdisks, "/dev/disk/by-id/scsi-SATA_ST12000VN0007-2G_ZCH0BSY0";

print "Validating disks and wiping labels... ";
my $sourcedisksstring;
my $targetdisksstring;
foreach my $disk (@sourcedisks) {
	if (! -e $disk) { print "WARNING: source $disk is not present in /dev/disk/by-id!\n"; exit 1; }
	system ("wipefs -qa $disk");
	$sourcedisksstring .= "$disk ";
}
foreach my $disk (@targetdisks) {
	if (! -e $disk) { print "WARNING: target $disk is not present in /dev/disk/by-id!\n"; exit 1; }
	system ("wipefs -qa $disk");
	$targetdisksstring .= "$disk ";
}
print "all disks are present in /dev/disk/by-id and clean.\n\n";

# create source and target arrays
my $btrfslevel = "raid1";
my $initcmd = "mkfs.btrfs -q -d $btrfslevel";
print "Creating arrays... ";
system("$initcmd -L source $sourcedisksstring");
system("$initcmd -L target $targetdisksstring");
print "source and target arrays created.\n\n";

# mount and display arrays
mkdir "/mnt/source";
mkdir "/mnt/target";
system ("mount $sourcedisks[0] /mnt/source");
system ("btrfs filesystem show /mnt/source");
system ("mount $targetdisks[0] /mnt/target");
system ("btrfs filesystem show /mnt/target");

# unmount arrays and exit
system ("umount /mnt/source");
system ("umount /mnt/target");
