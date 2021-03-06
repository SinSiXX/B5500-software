R/C (Remote/Card) Interactive Source Editor for Burroughs B5500

R/C was written in the late 1960s by Ron Brody at Burroughs Defense,
Space, and Special Systems Group in Paoli, Pennsylvania, US. It had some
of the functionality of a timesharing system, but was not one. Unlike
CANDE, which had to run under the Timesharing MPC (TSMCP), R/C was
designed to run under the B5500 Data Communications MCP (DCMCP)
operating system. The datacom facilities of DCMCP were oriented towards
on-line transaction processing (OLTP) rather than multi-user
timesharing.

R/C provided for the remote preparation and maintenance of card-image
files, submission of card image files as batch jobs to the B5500 host,
and some remote control of those jobs. In that sense, it was more like a
Remote Job Entry (RJE) system, but one in which the card decks were
maintained on the central host rather than at the remote site. Output
from programs was generally printed or punched at the host, although
printer and punch files could be file-equated to disk and listed by R/C
from disk to the remote terminal.

The program source and documentation were available to B5500 sites on
the CUBE Library tapes, maintained and distributed by the Cooperating
Users of Burroughs Equipment user organization. An earlier, single-user
version of the program (RCSY75-Z100004.alg, TEACHER-0000075.dat) is also
available on the CUBEB13 tape.

Before the CUBE Library tapes became available to this project in May
2018, the source and documentation files for R/C were transcribed from
portions of
http://bitsavers.org/pdf/burroughs/B5000_5500_5700/listing/
B5700_Text_Editors_Sep76.pdf
by Rich Cornwell of Durham, North Carolina, US. Proofing and correction
of the source was done by Paul Kimpel.

The transcriptions have now been renamed and moved under the respective
files extracted from the CUBEB13 tape so that they will appear in the
versioned history of those files:

    RCSY94.RON.alg_m to      CUBE-Library-13/Files/RCSY94.Z100006.alg
    TEACHER.0000094.txt_m to CUBE-Library-13/Files/TEACHER-0000094.dat


RC-Compile.card
    A card deck that can be used to compile R/C from the RCSY94/RON
    source file.

RC-Reference.card
    A card deck that can be used to generate the R/C Reference Manual
    from TEACHER/0000094 using XREF/JONES.

RC-Reference.txt
    A text file of the output generated by XREF/JONES from
    TEACHER/0000094. This file contains ASCII form-feed (hex 0C)
    characters to mark page breaks.

RCIXGEN.PAUL.alg_m
    B5500 Algol program to scan the TEACHER/0000094 source file for
    *RCTEACH and *RCEND dummy control records that delimit the sections
    of text for the R/C TEACH command and rebuild the TEACH index
    records at the front of that file. The regenration of the index
    records is done in place using Algol update I/O.

RCSY94.RON.alg_m
    Source for the R/C program. Moved to the versioned history of
    /CUBE-Library-13/Files/RCSY94-Z100006.alg in this repository.

RCSY94.PATCH.alg
    Patch to modify MAXUSERS configuration parameter for the program.
    This is a difference between the source transcribed from the listing
    and the version on the CUBEB13 tape.

TEACHER.0000094.txt_m
    The markup for the R/C Reference Manual. Moved to the versioned
    history of /CUBE-Library-13/Files/TEACHER-0000094.dat in this
    repository.

    This file is coded in the markup notation used by the XREF/JONES
    utility, available on the Mark XIII SYSTEM tape. This file was not
    originally transcribed from markup -- Rich Cornwell reverse-
    engineered the markup for the first several sections from the
    formatted document in B5700_Text_Editors_Sep76.pdf; Paul Kimpel
    completed the reconstruction and indexing for use by R/C's TEACH
    command. Note that if lines are inserted or deleted in this source,
    the TEACH command index records in the front of the source will need
    to be regenerated on the B5500 by running the RCIXGEN/PAUL utility.

__________
2016-05-13 Paul Kimpel
    Completed proofing and correction of RCSY94/RON source.
2016-05-21 Paul Kimpel
    Completed and proofed TEACHER/0000094 and generated Reference Manual
    text file.
2018-05-26 Paul Kimpel
    Rename and move transcribed files under /CUBE-Library-13.
