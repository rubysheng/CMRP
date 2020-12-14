#!/bin/bash

######## blastdbcmd -help ##############
# USAGE
#   blastdbcmd [-h] [-help] [-db dbname] [-dbtype molecule_type]
#     [-entry sequence_identifier] [-entry_batch input_file] [-ipg IPG]
#     [-ipg_batch input_file] [-taxids taxonomy_ids] [-taxidlist input_file]
#     [-info] [-tax_info] [-range numbers] [-strand strand]
#     [-mask_sequence_with mask_algo_id] [-out output_file] [-outfmt format]
#     [-target_only] [-get_dups] [-line_length number] [-ctrl_a]
#     [-show_blastdb_search_path] [-list directory] [-remove_redundant_dbs]
#     [-recursive] [-list_outfmt format] [-exact_length] [-long_seqids]
#     [-logfile File_Name] [-version]
#
# DESCRIPTION
#    BLAST database client, version 2.9.0+
#
# OPTIONAL ARGUMENTS
#  -h
#    Print USAGE and DESCRIPTION;  ignore all other parameters
#  -help
#    Print USAGE, DESCRIPTION and ARGUMENTS; ignore all other parameters
#  -version
#    Print version number;  ignore other arguments
#
#  *** BLAST database options
#  -db <String>
#    BLAST database name
#    Default = `nr'
#     * Incompatible with:  list, recursive, remove_redundant_dbs, list_outfmt,
#    show_blastdb_search_path
#  -dbtype <String, `guess', `nucl', `prot'>
#    Molecule type stored in BLAST database
#    Default = `guess'
#
#  *** Retrieval options
#  -entry <String>
#    Comma-delimited search string(s) of sequence identifiers:
#    	e.g.: 555, AC147927, 'gnl|dbname|tag', or 'all' to select all
#    	sequences in the database
#     * Incompatible with:  entry_batch, ipg, ipg_batch, taxids, taxidlist,
#    info, tax_info, list, recursive, remove_redundant_dbs, list_outfmt,
#    show_blastdb_search_path
#  -entry_batch <File_In>
#    Input file for batch processing (Format: one entry per line, seq id
#    followed by optional space-delimited specifier(s)
#    [range|strand|mask_algo_id]
#     * Incompatible with:  entry, range, strand, mask_sequence_with, ipg,
#    ipg_batch, taxids, taxidlist, info, tax_info, list, recursive,
#    remove_redundant_dbs, list_outfmt, show_blastdb_search_path
#  -ipg <Integer, >=0>
#    IPG to retrieve
#     * Incompatible with:  entry, entry_batch, target_only, ipg_batch
#  -ipg_batch <File_In>
#    Input file for batch processing (Format: one entry per line, IPG
#    followed by optional space-delimited specifier(s)
#    [range|strand|mask_algo_id]
#     * Incompatible with:  ipg, entry, entry_batch, range, strand,
#    mask_sequence_with
#  -taxids <String>
#    Comma-delimited taxonomy identifiers
#     * Incompatible with:  entry, entry_batch, pig, taxidlist, info, tax_info
#  -taxidlist <File_In>
#    Input file for taxonomy identifiers
#     * Incompatible with:  entry, entry_batch, pig, taxids, info, tax_info
#  -info
#    Print BLAST database information
#     * Incompatible with:  entry, entry_batch, outfmt, strand, target_only,
#    ctrl_a, get_dups, pig, range, mask_sequence, list, remove_redundant_dbs,
#    recursive, list_outfmt, taxidlist, taxids, tax_info, list, recursive,
#    remove_redundant_dbs, list_outfmt, show_blastdb_search_path, long_seqids
#  -tax_info
#    Print taxonomic information contained in this BLAST database.
#    Use -outfmt to customize output. Format specifiers supported are:
#    		%T means taxid
#    		%L means common taxonomic name
#    		%S means scientific name
#    		%K means taxonomic super kingdom
#    		%B means BLAST name
#    By default it prints: '%T %S %L %K %B'
#     * Incompatible with:  info, entry, entry_batch, strand, target_only,
#    ctrl_a, get_dups, pig, range, mask_sequence, list, remove_redundant_dbs,
#    recursive, list_outfmt, taxidlist, taxids
#
#  *** Sequence retrieval configuration options
#  -range <String>
#    Range of sequence to extract in 1-based offsets (Format: start-stop, for
#    start to end of sequence use start - )
#     * Incompatible with:  entry_batch, ipg_batch, info, tax_info, list,
#    recursive, remove_redundant_dbs, list_outfmt, show_blastdb_search_path
#  -strand <String, `minus', `plus'>
#    Strand of nucleotide sequence to extract
#    Default = `plus'
#     * Incompatible with:  entry_batch, ipg_batch, info, tax_info, list,
#    recursive, remove_redundant_dbs, list_outfmt, show_blastdb_search_path
#  -mask_sequence_with <String>
#    Produce lower-case masked FASTA using the algorithm ID specified
#     * Incompatible with:  entry_batch, ipg_batch
#
#  *** Output configuration options
#  -out <File_Out>
#    Output file name
#    Default = `-'
#  -outfmt <String>
#    Output format, where the available format specifiers are:
#    		%f means sequence in FASTA format
#    		%s means sequence data (without defline)
#    		%a means accession
#    		%g means gi
#    		%o means ordinal id (OID)
#    		%i means sequence id
#    		%t means sequence title
#    		%l means sequence length
#    		%h means sequence hash value
#    		%T means taxid
#    		%X means leaf-node taxids
#    		%e means membership integer
#    		%L means common taxonomic name
#    		%C means common taxonomic names for leaf-node taxids
#    		%S means scientific name
#    		%N means scientific names for leaf-node taxids
#    		%B means BLAST name
#    		%K means taxonomic super kingdom
#    		%P means PIG
#    		%m means sequence masking data.
#    		   Masking data will be displayed as a series of 'N-M' values
#    		   separated by ';' or the word 'none' if none are available.
#    	If '%f' is specified, all other format specifiers are ignored.
#    	For every format except '%f', each line of output will correspond
#    	to a sequence.
#    Default = `%f'
#     * Incompatible with:  info, list, recursive, remove_redundant_dbs,
#    list_outfmt, show_blastdb_search_path
#  -target_only
#    Definition line should contain target entry only
#     * Incompatible with:  ipg, info, tax_info, get_dups, list, recursive,
#    remove_redundant_dbs, list_outfmt, show_blastdb_search_path
#  -get_dups
#    Retrieve duplicate accessions
#     * Incompatible with:  info, tax_info, target_only, list, recursive,
#    remove_redundant_dbs, list_outfmt, show_blastdb_search_path
#
#  *** Output configuration options for FASTA format
#  -line_length <Integer, >=1>
#    Line length for output
#    Default = `80'
#     * Incompatible with:  list, recursive, remove_redundant_dbs, list_outfmt,
#    show_blastdb_search_path
#  -ctrl_a
#    Use Ctrl-A as the non-redundant defline separator
#     * Incompatible with:  info, tax_info, list, recursive,
#    remove_redundant_dbs, list_outfmt, show_blastdb_search_path
#
#  *** BLAST database configuration and discovery options
#  -show_blastdb_search_path
#    Displays the default BLAST database search paths
#     * Incompatible with:  entry, entry_batch, outfmt, strand, target_only,
#    ctrl_a, get_dups, pig, range, db, info, mask_sequence, line_length, list,
#    recursive, list_outfmt, remove_redundant_dbs
#  -list <String>
#    List BLAST databases in the specified directory
#     * Incompatible with:  info, tax_info, entry, entry_batch, outfmt, strand,
#    target_only, ctrl_a, get_dups, pig, range, db, info, mask_sequence,
#    line_length, show_blastdb_search_path
#  -remove_redundant_dbs
#    Remove the databases that are referenced by another alias file in the
#    directory in question
#     * Incompatible with:  info, tax_info, entry, entry_batch, outfmt, strand,
#    target_only, ctrl_a, get_dups, pig, range, db, info, mask_sequence,
#    line_length, show_blastdb_search_path
#  -recursive
#    Recursively traverse the directory structure to list available BLAST
#    databases
#     * Incompatible with:  info, tax_info, entry, entry_batch, outfmt, strand,
#    target_only, ctrl_a, get_dups, pig, range, db, info, mask_sequence,
#    line_length, show_blastdb_search_path
#  -list_outfmt <String>
#    Output format for the list option, where the available format specifiers
#    are:
#    		%f means the BLAST database absolute file name path
#    		%p means the BLAST database molecule type
#    		%t means the BLAST database title
#    		%d means the date of last update of the BLAST database
#    		%l means the number of bases/residues in the BLAST database
#    		%n means the number of sequences in the BLAST database
#    		%U means the number of bytes used by the BLAST database
#    	For every format each line of output will correspond to a BLAST database.
#    Default = `%f %p'
#     * Incompatible with:  info, tax_info, entry, entry_batch, outfmt, strand,
#    target_only, ctrl_a, get_dups, pig, range, db, info, mask_sequence,
#    line_length, show_blastdb_search_path
#  -exact_length
#    Get exact length for db info
#     * Requires:  info
#  -long_seqids
#    Use long seq id for fasta deflines
#     * Incompatible with:  info
#  -logfile <File_Out>
#    File to which the program log should be redirected


###########################################
