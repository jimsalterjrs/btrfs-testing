# btrfs-testing
scriptable tests of reliability / performance of btrfs

#WARNING: 
much of this is "glue" that may not be applicable to any system other than the one it was built on / to anyone other than someone who's trying to run many, many instances of the same tests as repeatably as possible.

The major components most people will want to look at are the fio control file fio-test-ratelimited.fio, the (very simple) replication orchestrator btrfs-replicate, the (very simple) replication orchestrator zfs-replicate, and the two scripts which manage the multiple tasks necessary for the test: btrfs-repl-test-ratelimited and zfs-repl-test-ratelimited.

those who want to run tons of these tests may be interested in the initialization scripts, which repeatably build the base arrays for btrfs and zfs from raw drives. however, those scripts are **extremely dangerous** and should not be used by anyone unwilling to examine them carefully, adapt them to their own system specifics, and be **certain** that they will not accidentally wipe out production data.

In a more controlled publishing environment, I'd have removed most of the glue and the dangerous bits and _only_ published the safest bits of the code. As things stand, I'm just taking this repo from private to public to allow access by btrfs developers, but I need to reiterate once more: the initialize scripts especially are very, very potentially dangerous, and tailored very, very specifically to just the specific system and drives I was using for this test.

#DO NOT RUN THE INITIALIZATION SCRIPTS BLINDLY. CONSIDER MANUALLY SETTING UP YOUR ZFS OR BTRFS POOLS/ARRAYS INSTEAD. YOU HAVE BEEN WARNED.
